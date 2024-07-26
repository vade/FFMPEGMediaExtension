//
//  LibAVTrackReader.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVTrackReader.h"
#import <CoreMedia/CoreMedia.h>

@implementation LibAVTrackReader

- (instancetype) initWithStream:(AVStream*)stream
{
    self = [super init];
    if (self != nil)
    {
        // Todo - do I need to mem copy this or some shit?
        self->stream = stream;
    }
    return self;
}


- (void)generateSampleCursorAtFirstSampleInDecodeOrderWithCompletionHandler:(nonnull void (^)(id<MESampleCursor> _Nullable, NSError * _Nullable))completionHandler {
    
}

- (void)generateSampleCursorAtLastSampleInDecodeOrderWithCompletionHandler:(nonnull void (^)(id<MESampleCursor> _Nullable, NSError * _Nullable))completionHandler { 
    
}

- (void)generateSampleCursorAtPresentationTimeStamp:(CMTime)presentationTimeStamp completionHandler:(nonnull void (^)(id<MESampleCursor> _Nullable, NSError * _Nullable))completionHandler { 
    
}


- (void)loadTrackInfoWithCompletionHandler:(nonnull void (^)(METrackInfo * _Nullable, NSError * _Nullable))completionHandler {
    
    CMFormatDescriptionRef format = [self formatDescription];
    
    NSArray* formats = @[(id)CFBridgingRelease(format)];
    
    METrackInfo* trackInfo = [[METrackInfo alloc] initWithMediaType:[self streamMediaType]
                                                            trackID:(CMPersistentTrackID)self->stream->index
                                                 formatDescriptions:formats];
    
    // do this in place
    completionHandler(trackInfo, nil);
    
}

// MARK: - Helper Methods

- (CMMediaType) streamMediaType
{
    CMMediaType type;
    
    switch (self->stream->codecpar->codec_type)
    {
        case AVMEDIA_TYPE_UNKNOWN:
            return -1;
            
        case AVMEDIA_TYPE_VIDEO:
            return kCMMediaType_Video;

        case AVMEDIA_TYPE_AUDIO:
            return kCMMediaType_Audio;

        case AVMEDIA_TYPE_DATA:
            return kCMMediaType_Metadata; //?

        case AVMEDIA_TYPE_SUBTITLE:
            return kCMMediaType_Subtitle;

        case AVMEDIA_TYPE_ATTACHMENT:
            return -1;

        case AVMEDIA_TYPE_NB:
            return -1;
    }
}

- (nullable CMFormatDescriptionRef) formatDescription
{
    switch (self->stream->codecpar->codec_type)
    {
        case AVMEDIA_TYPE_UNKNOWN:
            return NULL;
        case AVMEDIA_TYPE_VIDEO:
            return [self videoFormatDescription];

        case AVMEDIA_TYPE_AUDIO:
            return [self audioFormatDescription];

        case AVMEDIA_TYPE_DATA:
            return NULL;

        case AVMEDIA_TYPE_SUBTITLE:
            return NULL;

        case AVMEDIA_TYPE_ATTACHMENT:
            return NULL;

        case AVMEDIA_TYPE_NB:
            return NULL;
    }
}

- (nullable CMFormatDescriptionRef) videoFormatDescription
{
    CMFormatDescriptionRef formatDescription = NULL;

    CMVideoCodecType codecType = (CMVideoCodecType) self->stream->codecpar->codec_tag;

    // Create video format description
    OSStatus status = CMVideoFormatDescriptionCreate(kCFAllocatorDefault,
                                                     codecType,
                                                     self->stream->codecpar->width,
                                                     self->stream->codecpar->height,
                                                     NULL,  // Optional extensions
                                                     &formatDescription);
    
    if (status != noErr)
    {
        // Handle error
        return NULL;
    }
    
    return formatDescription;
}

- (nullable CMFormatDescriptionRef) audioFormatDescription
{
    
    CMAudioFormatDescriptionRef audioFormatDescription = NULL;
    
    AudioFormatID audioFormatID = (AudioFormatID)self->stream->codecpar->codec_tag;

    AudioStreamBasicDescription asbd = {0};
    asbd.mSampleRate = self->stream->codecpar->sample_rate;
    asbd.mChannelsPerFrame = self->stream->codecpar->ch_layout.nb_channels;
    asbd.mFormatID = audioFormatID;

    
    // Create audio format description
    OSStatus status = CMAudioFormatDescriptionCreate(
                                                     kCFAllocatorDefault,
                                                     &asbd,
                                                     0,       // Layout size (0 if no layout)
                                                     NULL,    // Layout (NULL if no layout)
                                                     0,       // Magic cookie size
                                                     NULL,    // Magic cookie
                                                     NULL,    // Extensions
                                                     &audioFormatDescription
                                                     );
    
    if (status != noErr) {
        // Handle error
        return NULL;
    }
    
    return audioFormatDescription;
}

@end
