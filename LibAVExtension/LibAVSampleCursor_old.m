//
//  LibAVSampleCursor.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVSampleCursor.h"
#import "LibAVTrackReader.h"
#import "LibAVFormatReader.h"

#import <libavformat/avformat.h>
#import <libavcodec/avcodec.h>
#import <libavformat/avio.h>
#import <libavutil/file.h>

@interface LibAVSampleCursor ()
{
    const AVPacket* currentPacket;
}
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
        
        self.presentationTimeStamp = kCMTimeZero;
        self.decodeTimeStamp = kCMTimeZero;
        self.currentSampleDuration = kCMTimeInvalid;
        
        // TODO: Check assumption - Im assuming we wont have formats change mid stream?
        self.currentSampleFormatDescription = [trackReader formatDescription];
        
        self.sampleSize = 0;
        self.sampleOffset = 0;
        
        self->currentPacket = NULL;
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

// MARK: - Step

- (void)stepByDecodeTime:(CMTime)deltaDecodeTime
       completionHandler:(nonnull void (^)(CMTime, BOOL, NSError * _Nullable))completionHandler
{
    CMTime targetDTS = CMTimeAdd(self.decodeTimeStamp, deltaDecodeTime);
    
    // TODO: This seems wrong
    int ret = [self seekToPTS:targetDTS];

    if (ret < 0)
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:ret userInfo:nil];
        completionHandler(CMTimeMake(0, 1), NO, error);
        return;
    }
    
    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
    {
        if ([self isTime:self.decodeTimeStamp greaterThanOrEqualTo:targetDTS fromPacket:&packet])
        {
            break;
        }
        av_packet_unref(&packet);
    }
    
    completionHandler(self.decodeTimeStamp, YES, nil);
    
}

- (void)stepByPresentationTime:(CMTime)deltaPresentationTime
             completionHandler:(nonnull void (^)(CMTime, BOOL, NSError * _Nullable))completionHandler
{
    CMTime targetPTS = CMTimeAdd(self.presentationTimeStamp, deltaPresentationTime);

    int ret = [self seekToPTS:targetPTS];
    
    if (ret < 0)
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:ret userInfo:nil];
        completionHandler(CMTimeMake(0, 1), NO, error);
        return;
    }
    
    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
    {
        if ([self isTime:self.presentationTimeStamp greaterThanOrEqualTo:targetPTS fromPacket:&packet])
        {
            break;
        }
        av_packet_unref(&packet);
    }
    
    completionHandler(self.presentationTimeStamp, YES, nil);
}

- (void)stepInDecodeOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    
    // Determine the direction
    CMTime targetTime = [self estimateTargetTimeUsingCurrentDurationForSteps:stepCount relativeToReferenceTime:self.decodeTimeStamp];

//    // TODO: This seems wrong
//    [self seekToPTS:targetTime];

    int64_t framesStepped = 0;

    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
    {
        if (packet.stream_index == self.trackReader.streamIndex - 1)
        {
            [self updateStateForPacket:&packet];

            framesStepped++;
            if (framesStepped >= stepCount)
            {
                break;
            }
        }
        av_packet_unref(&packet);
    }
    
    if (framesStepped < stepCount)
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:-1 userInfo:nil];
        completionHandler(framesStepped, error);
    }
    else
    {
        completionHandler(framesStepped, nil);
    }
}

// TODO: needs work
- (void)stepInPresentationOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    NSLog(@"stepInPresentationOrderByCount %lli", stepCount);
    
    // Early bail - if we are at PTS of kCMTimeZero, and asked to step backwards - we cant
    // So we dont.
    if ( stepCount < 0 )
    {
        if (CMTIME_COMPARE_INLINE(self.presentationTimeStamp, ==, kCMTimeZero) )
        {
            completionHandler(0, nil);
            return;
        }
        
        // If we are asked to step backwards, we actually have to seekd
        CMTime targetTime = [self estimateTargetTimeUsingCurrentDurationForSteps:stepCount relativeToReferenceTime:self.presentationTimeStamp];
        
        NSLog(@"stepInPresentationOrderByCount: %lli - esimated target time: %@", stepCount, CMTimeCopyDescription(kCFAllocatorDefault, targetTime));

        [self seekToPTS:targetTime];
    }
   
    int64_t framesStepped = 0;

    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
    {
        if ( packet.stream_index == self.trackReader.streamIndex - 1 )
        {
            framesStepped++;

            [self updateStateForPacket:&packet];

            if (framesStepped >= llabs(stepCount) )
            {
                break;
            }
        }
    
        av_packet_unref(&packet);
    }
    
    if (framesStepped < llabs(stepCount) )
    {
        NSError *error = [NSError errorWithDomain:@"com.example" code:-1 userInfo:nil];
        completionHandler(framesStepped, error);
    }
    else
    {
        completionHandler(framesStepped, nil);
    }
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

- (MESampleLocation * _Nullable) sampleLocationReturningError:(NSError *__autoreleasing _Nullable * _Nullable) error
{
 
    if ( self.currentSampleDependencyInfo.sampleDependsOnOthers)
    {
        NSLog(@"sampleLocationReturningError - have sampleDependsOnOthers - returning MEErrorLocationNotAvailable ");
        *error = [NSError errorWithDomain:@"sampleLocationReturningError" code:MEErrorLocationNotAvailable userInfo:nil];
        return NULL;
    }
    
    NSLog(@"sampleLocationReturningError");

    AVSampleCursorStorageRange range;
    range.offset = self.sampleOffset;
    range.length = self.sampleSize;
    
    MESampleLocation* location = [[MESampleLocation alloc] initWithByteSource:self.trackReader.formatReader.byteSource sampleLocation:range];
    
    return location;
}

- (MESampleCursorChunk * _Nullable) chunkDetailsReturningError:(NSError *__autoreleasing _Nullable * _Nullable) error
{

    if ( self.currentSampleDependencyInfo.sampleDependsOnOthers)
    {
        NSLog(@"chunkDetailsReturningError - have sampleDependsOnOthers - returning MEErrorLocationNotAvailable ");
        *error = [NSError errorWithDomain:@"sampleLocationReturningError" code:MEErrorLocationNotAvailable userInfo:nil];
        return NULL;
    }

    NSLog(@"chunkDetailsReturningError");

    AVSampleCursorStorageRange range;
    range.offset = self.sampleOffset;
    range.length = self.sampleSize;

    AVSampleCursorChunkInfo info;
    info.chunkSampleCount = 1; // NO IDEA LOLZ
    info.chunkHasUniformSampleSizes = false;
    info.chunkHasUniformSampleDurations = false;
    info.chunkHasUniformFormatDescriptions = true;
    
    MESampleCursorChunk* chunk = [[MESampleCursorChunk alloc] initWithByteSource:self.trackReader.formatReader.byteSource
                                                               chunkStorageRange:range
                                                                       chunkInfo:info
                                                          sampleIndexWithinChunk:0];
    
    return chunk;
}


//// Lets try a new strategy - simply implement this method and provide fully decoded frames to Core Media?
//- (void)loadSampleBufferContainingSamplesToEndCursor:(nullable id<MESampleCursor>)endSampleCursor completionHandler:(void (^)(CMSampleBufferRef _Nullable newSampleBuffer, NSError * _Nullable error))completionHandler
//{
//    
//    NSLog(@"LibAVSampleCursor: loadSampleBufferContainingSamplesToEndCursor endCursor%@", endSampleCursor);
//    
//        // This is probably wrong, since we are frame stepping again
//    // but lets just see whats what
////    AVPacket packet;
////    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0)
////    {
////        if ( packet.stream_index == self.trackReader.streamIndex - 1 )
////        {
////
////            [self updateStateForPacket:&packet];
//
//    CMSampleBufferRef sampleBuffer = [self createSampleBufferFromAVPacketWithoutDecoding:self->currentPacket];
//            
//            NSLog(@"LibAVSampleCursor: loadSampleBufferContainingSamplesToEndCursor Got Sample Buffer %@", sampleBuffer);
//            
//            completionHandler(sampleBuffer, nil);
////        }
//    
////        av_packet_unref(&packet);
////    }
//    
//}


// MARK: - Optional Sync Methods
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
                                                         0,
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
    status = CMSampleBufferCreate(kCFAllocatorDefault,
                                  blockBuffer,
                                  TRUE,
                                  NULL,
                                  NULL,
                                  self.currentSampleFormatDescription,
                                  1,
                                  1,
                                  &timingInfo,
                                  0,
                                  NULL,
                                  &sampleBuffer
                                  );
      
//      CFRelease(blockBuffer);
      
      if (status != noErr) {
          NSLog(@"Failed to create sample buffer");
          return NULL;
      }
      
      return sampleBuffer;
}

// MARK: - Helper Methods

- (void) readCurrentPacketWithoutIncrement
{
    
}


- (void) setAVPacket:(const AVPacket*)packet
{
    self->currentPacket = packet;
}

- (void) seekToBeginningOfFile
{
    NSLog(@"seekToBeginningOfFile Not implemented");
}

- (void) seekToEndOfFile
{
    NSLog(@"seekToEndOfFile Not implemented");
}

// TODO: - Confirm Seek is generally PTS based?
- (int) seekToPTS:(CMTime)time
{
    
    if (CMTIME_COMPARE_INLINE(time, ==, self.presentationTimeStamp))
    {
        return 1;
    }
    
    CMTime timeInStreamUnits = CMTimeConvertScale(time, self.trackReader->stream->time_base.den, kCMTimeRoundingMethod_Default);
    
    int flags = ( CMTIME_COMPARE_INLINE(self.currentSampleDuration, >=, time) ) ?  0 : AVSEEK_FLAG_BACKWARD;
    
    int ret =  av_seek_frame(self.trackReader.formatReader->format_ctx,
                         self.trackReader.streamIndex - 1,
                         timeInStreamUnits.value,
                         flags);
    
    [self updateOffsetUsingCurrentFilePosition];
    
    return ret;
}

// Reference time should be PTS or DTS - step count
- (CMTime) estimateTargetTimeUsingCurrentDurationForSteps:(int64_t)stepCount relativeToReferenceTime:(CMTime)referenceTime
{
//    // Determine the direction
//    BOOL steppingBackward = (stepCount < 0);
//    int64_t absStepCount = ABS(stepCount);

    CMTime stepCountAsCMTime = CMTimeMultiply(self.currentSampleDuration, stepCount);

    return CMTimeAdd(referenceTime, stepCountAsCMTime);
}

// Use this before reading
- (void) updateOffsetUsingCurrentFilePosition
{
    self.sampleOffset = avio_tell(self.trackReader.formatReader->format_ctx->pb); ///packet->pos;
}

// Use this after we reading vents a packet
- (void) updateStateForPacket:(const AVPacket*)packet
{
    [self updateOffsetUsingCurrentFilePosition];
    
    [self setAVPacket:packet];
    
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
    
    NSLog(@"Decode Timestamp %@", CMTimeCopyDescription(kCFAllocatorDefault, self.decodeTimeStamp));
    NSLog(@"Presentation Timestamp %@", CMTimeCopyDescription(kCFAllocatorDefault, self.presentationTimeStamp));
    NSLog(@"Duration %@", CMTimeCopyDescription(kCFAllocatorDefault, self.currentSampleDuration));
}


// Function to convert FFmpeg PTS/DTS to CMTime
- (CMTime) convertToCMTime:(int64_t)ptsOrDts timebase:(AVRational)timeBase
{
//    NSLog(@"convertToCMTime %lli to timeBase %i/%i", ptsOrDts, timeBase.num, timeBase.den);
    
    if (ptsOrDts == AV_NOPTS_VALUE)
    {
        NSLog(@"Recieved Invalid timestamp AV_NOPTS_VALUE - returning kCMTimeInvalid");
        return kCMTimeInvalid;
    }
    
    if (ptsOrDts == INT64_MAX)
    {
        NSLog(@"Recieved Invalid timestamp INT64_MAX - returning kCMTimeInvalid");
        return kCMTimeInvalid;
    }
    else if (ptsOrDts == INT64_MIN)
    {
        NSLog(@"Recieved Invalid timestamp INT64_MIN - returning kCMTimeNegativeInfinity");
        return kCMTimeNegativeInfinity;
    }
        
    // Convert to seconds using the time base
    double seconds = (double)ptsOrDts * av_q2d(timeBase);
    
    // CMTime uses an int64 value to represent time, with a timescale to denote fractional seconds
    CMTime time = CMTimeMakeWithSeconds(seconds, timeBase.den);
    
    NSLog(@"Converted %@", CMTimeCopyDescription(kCFAllocatorDefault, time));
    
    return time;
}

- (BOOL) isTime:(CMTime)time greaterThanOrEqualTo:(CMTime)target fromPacket:(const AVPacket*)packet
{
    if ( packet->stream_index == self.trackReader.streamIndex - 1 )
    {
        
        if ( CMTIME_COMPARE_INLINE(time, >=, target) )
        {

            return true;
        }
    }
    
    return false;
}

- (BOOL) isTime:(CMTime)time lessThanOrEqualTo:(CMTime)target fromPacket:(const AVPacket*)packet
{
    if ( packet->stream_index == self.trackReader.streamIndex - 1 )
    {
        if ( CMTIME_COMPARE_INLINE(time, <=, target) )
        {
            [self updateStateForPacket:packet];
            return true;
        }
    }
    
    return false;
}


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

//    depInfo.sampleIndicatesWhetherItDependsOnOthers = NO;
//    depInfo.sampleDependsOnOthers = NO; // Keyframes don't depend on others
//
//    // Determine if there are dependent samples
//    depInfo.sampleIndicatesWhetherItHasDependentSamples = NO;
//    depInfo.sampleHasDependentSamples = NO; // Keyframes typically have dependents
//
//    // Redundant coding is codec-specific and often not directly exposed in FFmpeg
//    depInfo.sampleIndicatesWhetherItHasRedundantCoding = NO;
//    depInfo.sampleHasRedundantCoding = NO; // Defaulting to NO, th
    return depInfo;
}
@end
