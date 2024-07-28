//
//  LibAVFormatReader.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVFormatReader.h"
#import "LibAVTrackReader.h"

// Read callback
//int readPacket(void *opaque, uint8_t *buf, int buf_size)
//{
//    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;
//
//    // this causes overflow lol
////    buf_size = FFMIN(buf_size, (int)[formatReader.byteSource fileLength]);
//    
//    size_t bytesRead = 0;
//    
//    NSLog(@"LibAVFormatReader got readPacket %i %p", buf_size, buf);
//
//    [formatReader.byteSource readDataOfLength:buf_size
//                                   fromOffset:formatReader.currentReadOffset
//                                toDestination:buf
//                                    bytesRead:&bytesRead
//                                        error:nil];
//    
//    formatReader.currentReadOffset += bytesRead;
//    
////    int64_t remaining = [formatReader.byteSource availableLengthAtOffset: formatReader.currentReadOffset];
//    
//    return buf_size;
//}

int readPacket(void *opaque, uint8_t *buf, int buf_size)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;

    
    size_t bytesRead = 0;
    
    NSLog(@"LibAVFormatReader got readPacket %i %p", buf_size, buf);

    [formatReader.byteSource readDataOfLength:buf_size
                                   fromOffset:formatReader->avio_ctx->pos
                                toDestination:buf
                                    bytesRead:&bytesRead
                                        error:nil];
    
    formatReader.currentReadOffset += bytesRead;
    
//    int64_t remaining = [formatReader.byteSource availableLengthAtOffset: formatReader.currentReadOffset];
    
    return buf_size;
}

// Seek callback (optional, if your format requires it)
int64_t seek(void *opaque, int64_t offset, int whence)
{
    LibAVFormatReader* formatReader = (__bridge LibAVFormatReader*) opaque;

    switch (whence) {
        case SEEK_SET:
            formatReader.currentReadOffset = offset;
            break;
        case SEEK_CUR:
            formatReader.currentReadOffset += offset;
            break;
        case SEEK_END:
            formatReader.currentReadOffset = [formatReader.byteSource fileLength] + offset;
            break;
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
//        self.completionQueue = dispatch_queue_create("info.vade.LibAVExtension.formatCompletionQueue", DISPATCH_QUEUE_SERIAL);
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
    
//    LibAVFormatReader* __weak weakSelf = self;
//
//    dispatch_async(self.completionQueue, ^{
//        
//        LibAVFormatReader* strongSelf = weakSelf;

    LibAVFormatReader* strongSelf = self;

        NSLog(@"loadFileInfoWithCompletionHandler");
        MEFileInfo* fileInfo = [[MEFileInfo alloc] init];
        
        strongSelf->format_ctx = avformat_alloc_context();

        strongSelf->avio_ctx_buffer = av_malloc(4096);

        // Pass self so we have a callback to our Obj-C objects properties
        strongSelf->avio_ctx = avio_alloc_context(strongSelf->avio_ctx_buffer, 4096, 0, (__bridge void *)(strongSelf), &readPacket, NULL, &seek);
        
        strongSelf->format_ctx->pb = strongSelf->avio_ctx;
        
        if (avformat_open_input(&(strongSelf->format_ctx), NULL, NULL, NULL) < 0)
        {
            // Handle error
            NSLog(@"loadFileInfoWithCompletionHandler unable to open input");

        }
        
        avformat_find_stream_info(self->format_ctx, NULL);
        
        fileInfo.duration = CMTimeMake(self->format_ctx->duration, AV_TIME_BASE);
        fileInfo.fragmentsStatus = MEFileInfoCouldNotContainFragments;
        
        NSLog(@"loadFileInfoWithCompletionHandler got duration: %@", CMTimeCopyDescription(kCFAllocatorDefault, fileInfo.duration) );

        completionHandler(fileInfo, nil);
//    });
}

- (void)loadMetadataWithCompletionHandler:(void (^)(NSArray< AVMetadataItem * > * _Nullable metadata, NSError * _Nullable error))completionHandler
{
//    dispatch_async(self.completionQueue, ^{
        
        NSLog(@"loadMetadataWithCompletionHandler");

        completionHandler(nil, nil);
//    });
}

- (void)loadTrackReadersWithCompletionHandler:(nonnull void (^)(NSArray<id<METrackReader>> * _Nullable, NSError * _Nullable))completionHandler
{
//    LibAVFormatReader* __weak weakSelf = self;
//
//    dispatch_async(self.completionQueue, ^{
//        
//        LibAVFormatReader* strongSelf = weakSelf;

    LibAVFormatReader* strongSelf = self;

        NSLog(@"loadTrackReadersWithCompletionHandler");

        // iterate over our loaded tracks and create a LibAVTrackReader for each
        NSMutableArray<LibAVTrackReader*>* trackReaders = [NSMutableArray new];

        for (unsigned int i = 0; i < strongSelf->format_ctx->nb_streams; i++) {
            AVStream *stream = strongSelf->format_ctx->streams[i];
           
            // TODO: Only support video and audio tracks for now
            if (stream->codecpar->codec_type == AVMEDIA_TYPE_VIDEO
//                || stream->codecpar->codec_type == AVMEDIA_TYPE_AUDIO
                )
            {
                LibAVTrackReader* trackReader = [[LibAVTrackReader alloc] initWithFormatReader:self stream:stream atIndex:i];
                
                [trackReaders addObject:trackReader];
            }
        }
    
        completionHandler(trackReaders, nil);
//    });
    
}




@end
