//
//  LibAVFormatReader.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVFormatReader.h"
#import "LibAVTrackReader.h"

// Read callback
int readPacket(void *opaque, uint8_t *buf, int buf_size)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;
//    
//    [formatReader.byteSource readDataOfLength:<#(size_t)#>
//                                   fromOffset:<#(int64_t)#>
//                                toDestination:<#(nonnull void *)#>
//                                    bytesRead:<#(nonnull size_t *)#>
//                                        error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
    
//    size_t remaining = dataSize - currentOffset;
//    size_t toCopy = FFMIN(buf_size, remaining);
//    
//    
//    
//    memcpy(buf, dataBuffer + currentOffset, toCopy);
//    currentOffset += toCopy;
//    return toCopy;
    
    return 0;
}

// Seek callback (optional, if your format requires it)
int64_t seek(void *opaque, int64_t offset, int whence)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;

    switch (whence) {
        case SEEK_SET:
//            currentOffset = offset;
            break;
        case SEEK_CUR:
//            currentOffset += offset;
            break;
        case SEEK_END:
//            currentOffset = dataSize + offset;
            break;
        case AVSEEK_SIZE:
//            return dataSize;
    }
    return 0;
}


@implementation LibAVFormatReader

+ (void) initialize
{
    // Seems as though this has been deprecated for a while.
    // ive been doing this for too long
    // av_register_all();
}

- (instancetype) initWithByteSource:(MEByteSource*)byteSource;
{
    self = [super init];
    if (self != nil)
    {
        NSLog(@"Initiaizing LibAVFormatReader");
        self.byteSource = byteSource;
        
        self.completionQueue = dispatch_queue_create("info.vade.LibAVExtension.completionQueue", DISPATCH_QUEUE_SERIAL);
        
        
    }
    
    return self;
}

- (void) dealloc
{
    avformat_close_input(&formatContext);
    formatContext = NULL;

    avio_context_free(&avio_ctx);
    avio_ctx = NULL;

    av_free(avio_ctx_buffer);
    avio_ctx_buffer = NULL;
}


- (void)loadFileInfoWithCompletionHandler:(void (^)(MEFileInfo* _Nullable fileInfo, NSError * _Nullable error))completionHandler
{
    
    LibAVFormatReader* __weak weakSelf = self;

    dispatch_async(self.completionQueue, ^{
        
        LibAVFormatReader* strongSelf = weakSelf;

        NSLog(@"loadFileInfoWithCompletionHandler");
        MEFileInfo* fileInfo = [[MEFileInfo alloc] init];
        
        strongSelf->avio_ctx_buffer = av_malloc(4096);

        // Pass self so we have a callback to our Obj-C objects properties
        strongSelf->avio_ctx = avio_alloc_context(strongSelf->avio_ctx_buffer, 4096, 0, (__bridge void *)(strongSelf), readPacket, NULL, seek);
        
        strongSelf->formatContext = avformat_alloc_context();
        
        strongSelf->formatContext->pb = strongSelf->avio_ctx;
        
        if (avformat_open_input(&(strongSelf->formatContext), NULL, NULL, NULL) < 0)
        {
            // Handle error
        }
        
        avformat_find_stream_info(self->formatContext, NULL);
        
        fileInfo.duration = CMTimeMakeWithSeconds(400,600);// CMTimeMake(self->formatContext->duration, AV_TIME_BASE);
        fileInfo.fragmentsStatus = MEFileInfoCouldNotContainFragments;
        
        completionHandler(fileInfo, nil);
    });
}

- (void)loadMetadataWithCompletionHandler:(void (^)(NSArray< AVMetadataItem * > * _Nullable metadata, NSError * _Nullable error))completionHandler
{
    dispatch_async(self.completionQueue, ^{
        
        NSLog(@"loadMetadataWithCompletionHandler");

        completionHandler(nil, nil);
    });
}

- (void)loadTrackReadersWithCompletionHandler:(nonnull void (^)(NSArray<id<METrackReader>> * _Nullable, NSError * _Nullable))completionHandler
{
    dispatch_async(self.completionQueue, ^{

        NSLog(@"loadTrackReadersWithCompletionHandler");

    // iterate over our loaded tracks and create a LibAVTrackReader for each
    
    NSMutableArray<LibAVTrackReader*>* trackReaders = [NSMutableArray new];
    
    for (unsigned int i = 0; i < formatContext->nb_streams; i++) {
        AVStream *stream = formatContext->streams[i];
        AVCodecParameters *codecpar = stream->codecpar;
        
        // You can check the codec type to determine if it's video, audio, etc.
        if (codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
            // This is a video stream
            printf("Video Stream: %d\n", i);
            printf("Resolution: %dx%d\n", codecpar->width, codecpar->height);
            printf("Codec ID: %d\n", codecpar->codec_id);
        } else if (codecpar->codec_type == AVMEDIA_TYPE_AUDIO) {
            // This is an audio stream
            printf("Audio Stream: %d\n", i);
            printf("Sample Rate: %d\n", codecpar->sample_rate);
            printf("Channels: %d\n", codecpar->ch_layout);
            printf("Codec ID: %d\n", codecpar->codec_id);
        }
        // You can also handle other types like AVMEDIA_TYPE_SUBTITLE, etc.
    }
    
        completionHandler(trackReaders, nil);
    });
    
}




@end
