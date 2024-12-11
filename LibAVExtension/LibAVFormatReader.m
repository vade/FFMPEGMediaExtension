//
//  LibAVFormatReader.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVFormatReader.h"
#import "LibAVTrackReader.h"
#import "AVMetadataItem+AVDictionaryEntry.h"
#import <AVFoundation/AVFoundation.h>

@interface LibAVFormatReader ()

@property (readwrite, assign) CMTime duration;
@property (readwrite, assign) size_t currentReadOffset;
//@property (readwrite, retain) dispatch_queue_t completionQueue;
@property (readwrite, retain) MEByteSource* byteSource;

@end


int readPacket(void *opaque, uint8_t *buf, int buf_size)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;
    
    size_t bytesRead = 0;
    
    NSError* error = nil;
    
    BOOL readResult = [formatReader.byteSource readDataOfLength:buf_size
                                                     fromOffset:formatReader.currentReadOffset
                                                  toDestination:buf
                                                      bytesRead:&bytesRead
                                                          error:&error];

    if (readResult != true || error != nil)
    {
        NSLog(@"LibAVFormatReader got readPacket Fail: %@, fromOffset: %zu, size: %i, read: %zu", error, formatReader.currentReadOffset, buf_size, bytesRead);
        switch (error.code)
        {
            case MEErrorEndOfStream:
                return AVERROR_EOF;

            case MEErrorPermissionDenied:
                return AVERROR_HTTP_UNAUTHORIZED;

            case MEErrorLocationNotAvailable:
                return AVERROR_UNKNOWN;
            default:
                return AVERROR_BUG;
        }
    }
//    NSLog(@"LibAVFormatReader got readPacket Success: fromOffset: %zu, size: %i, read: %zu", formatReader.currentReadOffset, buf_size, bytesRead);
//
    formatReader.currentReadOffset += bytesRead;
    
//    formatReader.currentReadOffset = avio_tell(formatReader->format_ctx->pb);
        
    return bytesRead;
}

// Seek callback (optional, if your format requires it)
int64_t seek(void *opaque, int64_t offset, int whence)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;
    
    switch (whence) {
        case SEEK_SET:
            formatReader.currentReadOffset = offset;
            return formatReader.currentReadOffset;
            
        case SEEK_CUR:
            formatReader.currentReadOffset += offset;
            return formatReader.currentReadOffset;

        case SEEK_END:
            formatReader.currentReadOffset = [formatReader.byteSource fileLength] + offset;
            return formatReader.currentReadOffset;

        case AVSEEK_SIZE:
            return [formatReader.byteSource fileLength];
    }
    
    return 0;
}



@implementation LibAVFormatReader

+ (void) initialize
{
    // Seems as though this has been deprecated for a while.
    // I've been doing this for too long
    // av_register_all();
}

- (instancetype) initWithByteSource:(MEByteSource*)byteSource;
{
    self = [super init];
    if (self != nil)
    {
        NSLog(@"Initiaizing LibAVFormatReader");
        self.byteSource = byteSource;
        self.currentReadOffset = 0;
    }
    
    return self;
}

- (void) dealloc
{
    avformat_close_input(&format_ctx);
    format_ctx = NULL;

    avio_context_free(&avio_ctx);
    avio_ctx = NULL;

    av_free(avio_ctx_buffer);
    avio_ctx_buffer = NULL;
}


- (void)loadFileInfoWithCompletionHandler:(void (^)(MEFileInfo* _Nullable fileInfo, NSError * _Nullable error))completionHandler
{
    NSLog(@"LibAVFormatReader loadFileInfoWithCompletionHandler");
    MEFileInfo* fileInfo = [[MEFileInfo alloc] init];
    
    self->format_ctx = avformat_alloc_context();
    
//    self->format_ctx->avio_flags = AVIO_FLAG_DIRECT;
    
    self->avio_ctx_buffer = av_malloc(4096);
    
    // Pass self so we have a callback to our Obj-C objects properties
    self->avio_ctx = avio_alloc_context(self->avio_ctx_buffer, 4096, 0, (__bridge void *)(self), &readPacket, NULL, &seek);
    
    self->format_ctx->pb = self->avio_ctx;
    
    if (avformat_open_input(&(self->format_ctx), NULL, NULL, NULL) < 0)
    {
        // Handle error
        NSLog(@"LibAVFormatReader loadFileInfoWithCompletionHandler unable to open input");
    }
    
    avformat_find_stream_info(self->format_ctx, NULL);
    
    self.duration = CMTimeMake(self->format_ctx->duration, AV_TIME_BASE);
    
    fileInfo.duration = self.duration;
    fileInfo.fragmentsStatus = MEFileInfoCouldNotContainFragments;
    
    NSLog(@"LibAVFormatReader loadFileInfoWithCompletionHandler got duration: %@", CMTimeCopyDescription(kCFAllocatorDefault, fileInfo.duration) );
    
    completionHandler(fileInfo, nil);
}

- (void)loadMetadataWithCompletionHandler:(void (^)(NSArray< AVMetadataItem * > * _Nullable metadata, NSError * _Nullable error))completionHandler
{
    NSLog(@"loadMetadataWithCompletionHandler");
    
//    if ( av_dict_count(self->format_ctx->metadata) > 0)
//    {
//        NSMutableArray<AVMetadataItem*>* metadataItems = [NSMutableArray new];
//        
//        const AVDictionaryEntry *e = NULL;
//        while ((e = av_dict_iterate(self->format_ctx->metadata, e)))
//        {
//            if (e != NULL)
//            {
//                AVMetadataItem* item = [AVMetadataItem metadataItemFrom:e];
//                [metadataItems addObject:item];
//            }
//        }
//        
//        completionHandler(metadataItems, nil);
//
//    }
    
    
    completionHandler(nil, nil);
}

- (void)loadTrackReadersWithCompletionHandler:(nonnull void (^)(NSArray<id<METrackReader>> * _Nullable, NSError * _Nullable))completionHandler
{
    NSLog(@"loadTrackReadersWithCompletionHandler");
    
    // iterate over our loaded tracks and create a LibAVTrackReader for each
    NSMutableArray<LibAVTrackReader*>* trackReaders = [NSMutableArray new];
    
    for (unsigned int i = 0; i < self->format_ctx->nb_streams; i++)
    {
        AVStream *stream = self->format_ctx->streams[i];
        
        // TODO: Only support video and audio tracks for now
        if (stream->codecpar->codec_type == AVMEDIA_TYPE_VIDEO
//            || stream->codecpar->codec_type == AVMEDIA_TYPE_AUDIO
            )
        {
            LibAVTrackReader* trackReader = [[LibAVTrackReader alloc] initWithFormatReader:self stream:stream atIndex:i];
            
            [trackReaders addObject:trackReader];
        }
    }
    
    completionHandler(trackReaders, nil);
}




@end
