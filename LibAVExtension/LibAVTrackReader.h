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

@class LibAVFormatReader;

@interface LibAVTrackReader : NSObject <METrackReader>
{
    // Unowned reference - owned by formatReader
    @public AVStream* stream;
}

@property (readonly, strong) LibAVFormatReader* formatReader;
@property (readonly, assign) NSUInteger streamIndex;

- (instancetype) initWithFormatReader:(LibAVFormatReader*)formatReader stream:(AVStream*)stream atIndex:(NSUInteger)index;
- (nullable CMFormatDescriptionRef) formatDescription;

@end

NS_ASSUME_NONNULL_END
