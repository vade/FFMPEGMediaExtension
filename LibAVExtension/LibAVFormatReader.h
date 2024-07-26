//
//  LibAVFormatReader.h
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import <Foundation/Foundation.h>
#import <MediaExtension/MediaExtension.h>
#import <libavformat/avformat.h>
#import <libavcodec/avcodec.h>
#import <libavformat/avio.h>
#import <libavutil/file.h>

#import <dispatch/dispatch.h>

NS_ASSUME_NONNULL_BEGIN

@interface LibAVFormatReader : NSObject <MEFormatReader>
{
    AVFormatContext *formatContext;

    // We use this to proxy loading from the vended bytes from whatever the hell sandbox
    // into something that AVFormat can handle
    AVIOContext *avio_ctx;
    uint8_t *avio_ctx_buffer;    
}
@property (readwrite, retain) dispatch_queue_t completionQueue;
@property (readwrite, retain) MEByteSource* byteSource;

- (instancetype) initWithByteSource:(MEByteSource*)byteSource;

@end

NS_ASSUME_NONNULL_END
