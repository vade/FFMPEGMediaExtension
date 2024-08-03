//
//  AVMetadataItem+AVMetadataItem_AVDictionaryEntry.h
//  LibAVExtension
//
//  Created by Anton Marini on 8/1/24.
//

#import <AVFoundation/AVFoundation.h>
#import <libavformat/avformat.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVMetadataItem (AVDictionaryItem)

+ (AVMetadataItem*) metadataItemFrom:(const AVDictionaryEntry*)dictionaryEntry;

@end

NS_ASSUME_NONNULL_END
