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
@property (readwrite, strong) LibAVTrackReader* trackReader;

@property (nonatomic, readwrite) CMTime presentationTimeStamp;
@property (nonatomic, readwrite) CMTime decodeTimeStamp;
@property (nonatomic, readwrite) CMTime currentSampleDuration;
@property (nonatomic, readwrite, nullable) __attribute__((NSObject)) CMFormatDescriptionRef currentSampleFormatDescription;

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
    }
    
    return self;
}


- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    LibAVSampleCursor* copy = [[LibAVSampleCursor alloc] initWithTrackReader:self.trackReader];
    
    copy.presentationTimeStamp = self.presentationTimeStamp;
    copy.decodeTimeStamp = self.decodeTimeStamp;
    copy.currentSampleDuration = self.currentSampleDuration;
    copy.currentSampleFormatDescription = self.currentSampleFormatDescription;
    
    return copy;
}

- (void)stepByDecodeTime:(CMTime)deltaDecodeTime
       completionHandler:(nonnull void (^)(CMTime, BOOL, NSError * _Nullable))completionHandler
{
    CMTime targetDTS = CMTimeAdd(self.decodeTimeStamp, deltaDecodeTime);
    
    int ret = av_seek_frame(self.trackReader.formatReader->format_ctx,
                            self.trackReader.streamIndex - 1, // aaaaahhhh
                            targetDTS.value,
                            AVSEEK_FLAG_BACKWARD);
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

    int ret = av_seek_frame(self.trackReader.formatReader->format_ctx,
                            self.trackReader.streamIndex - 1,
                            targetPTS.value,
                            AVSEEK_FLAG_BACKWARD);
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
    
    completionHandler(self.decodeTimeStamp, YES, nil);
    
    
}

- (void)stepInDecodeOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    int64_t framesStepped = 0;

    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0) {
        if (packet.stream_index == self.trackReader.streamIndex - 1) {

            [self updateStateForPacket:&packet];

            framesStepped++;
            if (framesStepped >= stepCount) {
                break;
            }
        }
        av_packet_unref(&packet);
    }
    
    if (framesStepped < stepCount) {
        NSError *error = [NSError errorWithDomain:@"com.example" code:-1 userInfo:nil];
        completionHandler(framesStepped, error);
    } else {
        completionHandler(framesStepped, nil);
    }
}

- (void)stepInPresentationOrderByCount:(int64_t)stepCount completionHandler:(nonnull void (^)(int64_t, NSError * _Nullable))completionHandler
{
    int64_t framesStepped = 0;

    AVPacket packet;
    while (av_read_frame(self.trackReader.formatReader->format_ctx, &packet) >= 0) {
        if (packet.stream_index == self.trackReader.streamIndex - 1) {

            [self updateStateForPacket:&packet];

            framesStepped++;
            if (framesStepped >= stepCount) {
                break;
            }
        }
        av_packet_unref(&packet);
    }
    
    if (framesStepped < stepCount) {
        NSError *error = [NSError errorWithDomain:@"com.example" code:-1 userInfo:nil];
        completionHandler(framesStepped, error);
    } else {
        completionHandler(framesStepped, nil);
    }
}


// MARK: - Helper Methods

// Function to convert FFmpeg PTS/DTS to CMTime
- (CMTime) convertToCMTime:(int64_t)ptsOrDts timebase:(AVRational)timeBase
{
    // Convert to seconds using the time base
    double seconds = (double)ptsOrDts * av_q2d(timeBase);
    
    // CMTime uses an int64 value to represent time, with a timescale to denote fractional seconds
    CMTime time = CMTimeMakeWithSeconds(seconds, timeBase.den);
    return time;
}

- (BOOL) isTime:(CMTime)time greaterThanOrEqualTo:(CMTime)target fromPacket:(AVPacket*)packet
{
    if ( packet->stream_index == self.trackReader.streamIndex - 1 )
    {
        [self updateStateForPacket:packet];
        
        if ( CMTIME_COMPARE_INLINE(time, >=, target) )
        {
            return true;
        }
    }
    
    return false;
}

- (void) updateStateForPacket:(AVPacket*)packet
{
    // Update currentDTS based on the packet's DTS
    self.decodeTimeStamp = [self convertToCMTime:packet->dts timebase:self.trackReader->stream->time_base];
    self.presentationTimeStamp = [self convertToCMTime:packet->pts timebase:self.trackReader->stream->time_base];
    self.currentSampleDuration = [self convertToCMTime:packet->duration timebase:self.trackReader->stream->time_base];
}

@end
