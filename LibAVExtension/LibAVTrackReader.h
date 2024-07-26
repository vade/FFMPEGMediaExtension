//
//  LibAVTrackReader.h
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

@interface LibAVTrackReader : NSObject <METrackReader>
{
    AVStream* stream;
}

- (instancetype) initWithStream:(AVStream*)stream;

@end

NS_ASSUME_NONNULL_END
