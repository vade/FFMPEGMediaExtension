//
//  LibAVSampleCursor.m
//  LibAVExtensionHost
//
//  Created by Anton Marini on 7/31/24.
//

#import "LibAVSampleCursor.h"
#import "LibAVTrackReader.h"
#import "LibAVFormatReader.h"

#import <libavformat/avformat.h>
#import <libavcodec/avcodec.h>
#import <libavformat/avio.h>
#import <libavutil/file.h>

typedef struct  {
    int successOrFail;
    CMTime packetPTS;
    CMTime packetDTS;
    CMTime packetDuration;
} LibAVSampleCursorReadResults;


@interface LibAVSampleCursor ()
@property (readwrite, strong) LibAVTrackReader* trackReader;

// Required Private Setters
@property (nonatomic, readwrite) CMTime presentationTimeStamp;
@property (nonatomic, readwrite) CMTime decodeTimeStamp;
@property (nonatomic, readwrite) CMTime currentSampleDuration;
@property (nonatomic, readwrite, nullable) __attribute__((NSObject)) CMFormatDescriptionRef currentSampleFormatDescription;

// Optional Sync Private Setters
@property (nonatomic, readwrite) AVSampleCursorSyncInfo syncInfo;
@property (nonatomic, readwrite) AVSampleCursorDependencyInfo currentSampleDependencyInfo;

// private
@property (nonatomic, readwrite, assign) NSUInteger sampleOffset;
@property (nonatomic, readwrite, assign) NSUInteger sampleSize;

@end

@implementation LibAVSampleCursor

- (instancetype) initWithTrackReader:(LibAVTrackReader*)trackReader;
{
    self = [super init];
    if (self)
    {
        self.trackReader = trackReader;
        
        self.presentationTimeStamp = kCMTimeInvalid;
        self.decodeTimeStamp = kCMTimeInvalid;
        self.currentSampleDuration = kCMTimeInvalid;
        
        // TODO: Check assumption - Im assuming we wont have formats change mid stream?
        self.currentSampleFormatDescription = [trackReader formatDescription];
        
        self.sampleSize = 0;
        self.sampleOffset = 0;
        
        // Populate some of our properties off of the first packet and reset
        [self seekToBeginningOfFile];
        [self readAPacket];
        [self seekToBeginningOfFile];
    }
    
    return self;
}

// MARK: - MESampleCursor Protocol Requirements


- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    LibAVSampleCursor* copy = [[LibAVSampleCursor alloc] initWithTrackReader:self.trackReader];
    
    // Reuquired
    copy.presentationTimeStamp = self.presentationTimeStamp;
    copy.decodeTimeStamp = self.decodeTimeStamp;
    copy.currentSampleDuration = self.currentSampleDuration;
    copy.currentSampleFormatDescription = self.currentSampleFormatDescription;

    // Optional
    copy.syncInfo = self.syncInfo;
    copy.currentSampleDependencyInfo = self.currentSampleDependencyInfo;
    
    // Private
    copy.sampleSize = self.sampleSize;
    copy.sampleOffset = self.sampleOffset;

    return copy;
}

// MARK: - Step By Time

- (void)stepByDecodeTime:(CMTime)deltaDecodeTime
       completionHandler:(nonnull void (^)(CMTime, BOOL, NSError * _Nullable))completionHandler
{
    CMTime targetDTS = CMTimeAdd(self.decodeTimeStamp, deltaDecodeTime);

    [self seekToDTS:targetDTS];
    
    // TODO: Fix Pinning
    BOOL wasPinned = false;
    int ret = [self readPacketsUntilTargetDTSIsGreaterThanOrEqualToCurrentDTS:targetDTS];
    
    if ( ret >= 0 )
    {
        completionHandler(self.decodeTimeStamp, wasPinned, nil);
    }
    else
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:ret userInfo:nil];
        completionHandler(self.decodeTimeStamp, wasPinned, error);
    }
}

- (void)stepByPresentationTime:(CMTime)deltaPresentationTime
             completionHandler:(nonnull void (^)(CMTime, BOOL, NSError * _Nullable))completionHandler
{
    NSLog(@"LibAVSampleCursor stepByPresentationTime delta PTS %@", CMTimeCopyDescription(kCFAllocatorDefault, deltaPresentationTime));
    CMTime targetPTS = CMTimeAdd(self.presentationTimeStamp, deltaPresentationTime);

    CMTimeRange trackTimeRange = CMTimeRangeMake(kCMTimeZero, self.trackReader.formatReader.duration);

    // TODO: Fix Pinning
    BOOL wasPinned = false;

    if ( !CMTimeRangeContainsTime(trackTimeRange, targetPTS) )
    {
        targetPTS = CMTimeClampToRange(targetPTS, trackTimeRange);
        wasPinned = TRUE;
    }
    
    [self seekToPTS:targetPTS];
    
    int ret = [self readPacketsUntilTargetPTSIsGreaterThanOrEqualToCurrentPTS:targetPTS];
    
    if ( ret >= 0 )
    {
        completionHandler(self.presentationTimeStamp, wasPinned, nil);
    }
    else
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:ret userInfo:nil];
        completionHandler(self.presentationTimeStamp, wasPinned, error);
    }
}

// MARK: - Step By Frame

- (void)stepInDecodeOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    NSLog(@"LibAVSampleCursor stepInDecodeOrderByCount  %lli", stepCount);
    
    if (stepCount < 0)
    {
        // STEPPING BACKWARD
    }
    
    for (int64_t stepsCompleted = 0; stepsCompleted < labs(stepCount); )
    {
        if ( [self readAPacket] > 0)
        {
            stepsCompleted++;
        }
        else
        {
            // Something went wrong
            NSLog(@"LibAVSampleCursor stepInDecodeOrderByCount got bad step");
            NSError *error = [NSError errorWithDomain:@"com.example" code:0 userInfo:nil];

            completionHandler(stepCount,error);

        }
    }
    
    completionHandler(stepCount,nil);

}

- (void)stepInPresentationOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    NSLog(@"LibAVSampleCursor stepInPresentationOrderByCount  %lli", stepCount);

    if (stepCount < 0)
    {
        // STEPPING BACKWARD
    }
    
    for (int64_t stepsCompleted = 0; stepsCompleted < labs(stepCount); )
    {
        if ( [self readAPacket] > 0)
        {
            stepsCompleted++;
        }
        else
        {
            // Something went wrong
            NSLog(@"LibAVSampleCursor stepInPresentationOrderByCount got bad step");
            NSError *error = [NSError errorWithDomain:@"com.example" code:0 userInfo:nil];

            completionHandler(stepCount,error);

        }
    }
    
    completionHandler(stepCount,nil);
}

// MARK: - Sample Location & Delivery

//-(BOOL)samplesWithEarlierDTSsMayHaveLaterPTSsThanCursor:(id<MESampleCursor>)cursor
//
//{
//    return YES;
//}
//
//-(BOOL)samplesWithLaterDTSsMayHaveEarlierPTSsThanCursor:(id<MESampleCursor>)cursor
//{
//    return YES;
//}

//- (MESampleLocation * _Nullable) sampleLocationReturningError:(NSError *__autoreleasing _Nullable * _Nullable) error
//{
//    if ( self.currentSampleDependencyInfo.sampleDependsOnOthers)
//    {
//        NSLog(@"sampleLocationReturningError - have sampleDependsOnOthers - returning MEErrorLocationNotAvailable ");
//        *error = [NSError errorWithDomain:@"sampleLocationReturningError" code:MEErrorLocationNotAvailable userInfo:nil];
//        return NULL;
//    }
//    
//    NSLog(@"sampleLocationReturningError");
//
//    AVSampleCursorStorageRange range;
//    range.offset = self.sampleOffset;
//    range.length = self.sampleSize;
//    
//    MESampleLocation* location = [[MESampleLocation alloc] initWithByteSource:self.trackReader.formatReader.byteSource sampleLocation:range];
//    
//    return location;
//}
//
//- (MESampleCursorChunk * _Nullable) chunkDetailsReturningError:(NSError *__autoreleasing _Nullable * _Nullable) error
//{
//    if ( self.currentSampleDependencyInfo.sampleDependsOnOthers)
//    {
//        NSLog(@"chunkDetailsReturningError - have sampleDependsOnOthers - returning MEErrorLocationNotAvailable ");
//        *error = [NSError errorWithDomain:@"sampleLocationReturningError" code:MEErrorLocationNotAvailable userInfo:nil];
//        return NULL;
//    }
//
//    NSLog(@"chunkDetailsReturningError");
//
//    AVSampleCursorStorageRange range;
//    range.offset = self.sampleOffset;
//    range.length = self.sampleSize;
//
//    AVSampleCursorChunkInfo info;
//    info.chunkSampleCount = 1; // NO IDEA LOLZ
//    info.chunkHasUniformSampleSizes = false;
//    info.chunkHasUniformSampleDurations = false;
//    info.chunkHasUniformFormatDescriptions = true;
//    
//    MESampleCursorChunk* chunk = [[MESampleCursorChunk alloc] initWithByteSource:self.trackReader.formatReader.byteSource
//                                                               chunkStorageRange:range
//                                                                       chunkInfo:info
//                                                          sampleIndexWithinChunk:0];
//    
//    return chunk;
//}

// Lets try a new strategy - simply implement this method and provide fully decoded frames to Core Media?
- (void)loadSampleBufferContainingSamplesToEndCursor:(nullable id<MESampleCursor>)endSampleCursor completionHandler:(void (^)(CMSampleBufferRef _Nullable newSampleBuffer, NSError * _Nullable error))completionHandler
{
    NSLog(@"LibAVSampleCursor: loadSampleBufferContainingSamplesToEndCursor endCursor%@", endSampleCursor);

        // This is probably wrong, since we are frame stepping again
    // but lets just see whats what
//    AVPacket packet;
//    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
//    {
//        if ( packet.stream_index == self.trackReader.streamIndex - 1 )
//        {
//
//            [self updateStateForPacket:&packet];

    const AVPacket* packet = [self copyNextAVPacket];
    CMSampleBufferRef sampleBuffer = [self createSampleBufferFromAVPacketWithoutDecoding:packet];

//    av_packet_free(&packet);
    
            NSLog(@"LibAVSampleCursor: loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer %@", sampleBuffer);

            completionHandler(sampleBuffer, nil);
//        }

//        av_packet_unref(&packet);
//    }

}

// MARK: - NO PROTOCOL REQUIREMENTS BELOW -

// MARK: Sample Buffer Helper

- (nullable CMSampleBufferRef)createSampleBufferFromAVPacketWithoutDecoding:(const AVPacket *)packet
{
    CMSampleBufferRef sampleBuffer = NULL;

    // Create a CMBlockBuffer from the packet data
    CMBlockBufferRef blockBuffer = NULL;
    
    OSStatus status = CMBlockBufferCreateWithMemoryBlock(kCFAllocatorDefault,
                                                         (void *)packet->data,
                                                         packet->size,
                                                         kCFAllocatorNull,
                                                         NULL,
                                                         0,
                                                         packet->size,
                                                         kCMBlockBufferAlwaysCopyDataFlag,
                                                         &blockBuffer
                                                         );
    
    if (status != kCMBlockBufferNoErr)
    {
        NSLog(@"Failed to create CMBlockBuffer");
        return NULL;
    }

    
    CMSampleTimingInfo timingInfo;
    timingInfo.duration = self.currentSampleDuration;
    timingInfo.presentationTimeStamp = self.presentationTimeStamp;
    timingInfo.decodeTimeStamp = self.decodeTimeStamp;
    
    // Create the sample buffer
    status = CMSampleBufferCreateReady(kCFAllocatorDefault,
                                       blockBuffer,
                                       self.currentSampleFormatDescription,
                                       1,
                                       1,
                                       &timingInfo,
                                       0,
                                       NULL,
                                       &sampleBuffer);
    
//    status = CMSampleBufferCreate(kCFAllocatorDefault,
//                                  blockBuffer,
//                                  TRUE,
//                                  NULL,
//                                  NULL,
//                                  self.currentSampleFormatDescription,
//                                  1,
//                                  1,
//                                  &timingInfo,
//                                  0,
//                                  NULL,
//                                  &sampleBuffer
//                                  );
      
//      CFRelease(blockBuffer);
      
      if (status != noErr) {
          NSLog(@"Failed to create sample buffer");
          return NULL;
      }
      
      return sampleBuffer;
}



// MARK: - Step Helper Functions

- (void) seekToBeginningOfFile
{
    // TODO: Not technically correct
    [self seekToPTS:kCMTimeZero];
}

- (void) seekToEndOfFile
{
    // TODO: Not technically correct
    [self seekToPTS:self.trackReader.formatReader.duration];
}

- (int) seekToPTS:(CMTime)time
{
    NSLog(@"LibAVSampleCursor seekToPTS PTS %@", CMTimeCopyDescription(kCFAllocatorDefault, time));

    // If we are at our current time, no need to seek
    if (CMTIME_COMPARE_INLINE(time, ==, self.presentationTimeStamp))
    {
        return 1;
    }
    
    // Configure our seek flag
    int flags = (CMTIME_COMPARE_INLINE(self.presentationTimeStamp, <, time)) ? 0 : AVSEEK_FLAG_BACKWARD;

    // We want to seek to any time stamp, not just a key frame
    flags |= AVSEEK_FLAG_ANY;

    return [self seekToTime:time flags:flags];
}

- (int) seekToDTS:(CMTime)time
{
    // If we are at our current time, no need to seek
    if (CMTIME_COMPARE_INLINE(time, ==, self.decodeTimeStamp))
    {
        return 1;
    }
    
    // Configure our seek flag
    int flags = (CMTIME_COMPARE_INLINE(self.decodeTimeStamp, <, time)) ? 0 : AVSEEK_FLAG_BACKWARD;

    // We want to seek to any time stamp, not just a key frame
    flags |= AVSEEK_FLAG_ANY;

    return [self seekToTime:time flags:flags];
}


- (int) seekToTime:(CMTime)time flags:(int)flags
{
    CMTime timeInStreamUnits = CMTimeConvertScale(time, self.trackReader->stream->time_base.den, kCMTimeRoundingMethod_Default);

    int ret =  av_seek_frame(self.trackReader.formatReader->format_ctx,
                         self.trackReader.streamIndex - 1,
                         timeInStreamUnits.value,
                         flags);
    
    [self updateOffsetUsingCurrentFilePosition];
    
    return ret;
}

// MARK: - Read

- (int) readPacketsUntilTargetPTSIsGreaterThanOrEqualToCurrentPTS:(CMTime)targetPTS
{
    NSLog(@"LibAVSampleCursor readPacketsUntilTargetPTSIsGreaterThanOrEqualToCurrentPTS %@", CMTimeCopyDescription(kCFAllocatorDefault, targetPTS));

    return [self readPacketsUntilTargetTime:targetPTS IsGreaterThanOrEqualToReferenceTime:self.presentationTimeStamp];
}

- (int) readPacketsUntilTargetDTSIsGreaterThanOrEqualToCurrentDTS:(CMTime)targetDTS
{
    return [self readPacketsUntilTargetTime:targetDTS IsGreaterThanOrEqualToReferenceTime:self.decodeTimeStamp];
}

- (int) readPacketsUntilTargetTime:(CMTime)targetTime IsGreaterThanOrEqualToReferenceTime:(CMTime)referenceTime
{
    while ( [self readAPacket] >= 0 )
    {
        if ( CMTIME_COMPARE_INLINE(referenceTime, >=, targetTime) )
        {
            return 1;
        }
    }
    
    return -1;
}

// Reciever must call av_packet_unref on this packer
- (int) readAPacket
{
    AVPacket packet;

    while ( av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0 )
    {
        if ( packet.stream_index == self.trackReader.streamIndex - 1 )
        {
            [self updateOffsetUsingCurrentFilePosition];

            [self updateStateForPacket:&packet];
            
            av_packet_unref(&packet);

            return 1;
        }

        av_packet_unref(&packet);
    }
    

    return -1;
}

- (const AVPacket *) copyNextAVPacket;
{
   AVPacket *packet = av_packet_alloc();
   if (!packet)
   {
       // Allocation failed
       return NULL;
   }

   while (av_read_frame(self.trackReader.formatReader->format_ctx, packet) >= 0)
   {
       if (packet->stream_index == self.trackReader.streamIndex - 1)
       {
           [self updateOffsetUsingCurrentFilePosition];
           [self updateStateForPacket:packet];

           return packet;
       }

       av_packet_unref(packet);
   }

   // Clean up if no packet was returned
   av_packet_free(&packet);
   return NULL;
}



// MARK: - State

// Use this before reading
- (void) updateOffsetUsingCurrentFilePosition
{
    self.sampleOffset = avio_tell(self.trackReader.formatReader->format_ctx->pb); ///packet->pos;
}

// Use this after we reading vents a packet
- (void) updateStateForPacket:(const AVPacket*)packet
{
    // Update currentDTS based on the packet's DTS
    self.decodeTimeStamp = [self convertToCMTime:packet->dts timebase:self.trackReader->stream->time_base];
    self.presentationTimeStamp = [self convertToCMTime:packet->pts timebase:self.trackReader->stream->time_base];
    self.currentSampleDuration = [self convertToCMTime:packet->duration timebase:self.trackReader->stream->time_base];
    
    // We may have gotten some bad time stamps above
    
    // FFMPEG will more likely give us valid PTS than DTS
    // So lets compare DTS - if its invalid, check PTS and assign
    // if both are invalid we're fucked.
    if (CMTIME_IS_INVALID(self.decodeTimeStamp))
    {
        if (CMTIME_IS_VALID(self.presentationTimeStamp))
        {
            self.decodeTimeStamp = self.presentationTimeStamp;
        }
    }
    
    self.syncInfo = [self extractSyncInfoFrom:packet];
    self.currentSampleDependencyInfo = [self extractDependencyInfoFromPacket:packet codecParameters:self.trackReader->stream->codecpar];
    
    self.sampleSize = packet->size;
    
    NSLog(@"LibAVSampleCursor updateStateForPacket Presentation Timestamp %@", CMTimeCopyDescription(kCFAllocatorDefault, self.presentationTimeStamp));
    NSLog(@"LibAVSampleCursor updateStateForPacket Decode Timestamp %@", CMTimeCopyDescription(kCFAllocatorDefault, self.decodeTimeStamp));
    NSLog(@"LibAVSampleCursor updateStateForPacket Duration %@", CMTimeCopyDescription(kCFAllocatorDefault, self.currentSampleDuration));
    NSLog(@"LibAVSampleCursor updateStateForPacket sampleOffset %lu", (unsigned long)self.sampleOffset);
    NSLog(@"LibAVSampleCursor updateStateForPacket sampleSize %lu", (unsigned long)self.sampleSize);
}

// MARK: - Sync Utility


- (AVSampleCursorSyncInfo) extractSyncInfoFrom:(const AVPacket*)packet
{
    AVSampleCursorSyncInfo syncInfo = {0};

    // Check if the packet is a keyframe (full sync)
    if (packet->flags & AV_PKT_FLAG_KEY)
    {
        syncInfo.sampleIsFullSync = YES;
    }
    else
    {
        syncInfo.sampleIsFullSync = NO;
    }

    // Partial sync determination is codec-specific and may not always be available
    syncInfo.sampleIsPartialSync = NO; // Defaulting to NO

    // Check if the packet is droppable (disposable or discardable)
    if (packet->flags & (AV_PKT_FLAG_DISPOSABLE | AV_PKT_FLAG_DISCARD))
    {
        syncInfo.sampleIsDroppable = YES;
    }
    else
    {
        syncInfo.sampleIsDroppable = NO;
    }

    return syncInfo;
}

- (AVSampleCursorDependencyInfo) extractDependencyInfoFromPacket:(const AVPacket*)packet codecParameters:(const AVCodecParameters*) codecpar
{
    AVSampleCursorDependencyInfo depInfo = {0};

    // Check if the packet is a keyframe
    BOOL isKeyframe = packet->flags & AV_PKT_FLAG_KEY;
    
    // Determine if the sample depends on others
    depInfo.sampleIndicatesWhetherItDependsOnOthers = YES;
    depInfo.sampleDependsOnOthers = !isKeyframe; // Keyframes don't depend on others

    // Determine if there are dependent samples
    depInfo.sampleIndicatesWhetherItHasDependentSamples = YES;
    depInfo.sampleHasDependentSamples = isKeyframe; // Keyframes typically have dependents

    // Redundant coding is codec-specific and often not directly exposed in FFmpeg
    depInfo.sampleIndicatesWhetherItHasRedundantCoding = NO;
    depInfo.sampleHasRedundantCoding = NO; // Defaulting to NO, this would require codec-specific logic

    return depInfo;
}

// MARK: - Utility

// Function to convert FFmpeg PTS/DTS to CMTime
- (CMTime) convertToCMTime:(int64_t)ptsOrDts timebase:(AVRational)timeBase
{
    if (ptsOrDts == AV_NOPTS_VALUE)
    {
        NSLog(@"LibAVSampleCursor Recieved Invalid timestamp AV_NOPTS_VALUE - returning kCMTimeInvalid");
        return kCMTimeInvalid;
    }
    
    if (ptsOrDts == INT64_MAX)
    {
        NSLog(@"LibAVSampleCursor Recieved Invalid timestamp INT64_MAX - returning kCMTimeInvalid");
        return kCMTimeInvalid;
    }
    else if (ptsOrDts == INT64_MIN)
    {
        NSLog(@"LibAVSampleCursor Recieved Invalid timestamp INT64_MIN - returning kCMTimeNegativeInfinity");
        return kCMTimeNegativeInfinity;
    }
        
    // Convert to seconds using the time base
    double seconds = (double)ptsOrDts * av_q2d(timeBase);
    
    // CMTime uses an int64 value to represent time, with a timescale to denote fractional seconds
    CMTime time = CMTimeMakeWithSeconds(seconds, timeBase.den);
    
//    NSLog(@"LibAVSampleCursor Converted %@", CMTimeCopyDescription(kCFAllocatorDefault, time));
    
    return time;
}

@end
