//
//  LibAVSampleCursor.h
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import <Foundation/Foundation.h>
#import <MediaExtension/MediaExtension.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

@class LibAVTrackReader;

@interface LibAVSampleCursor : NSObject <MESampleCursor>

@property (readonly, strong) LibAVTrackReader* trackReader;

// Required Properties
@property (nonatomic, readonly) CMTime presentationTimeStamp;
@property (nonatomic, readonly) CMTime decodeTimeStamp;
@property (nonatomic, readonly) CMTime currentSampleDuration;
@property (nonatomic, readonly, nullable) __attribute__((NSObject)) CMFormatDescriptionRef currentSampleFormatDescription;

// Optional Sync Properties
@property (nonatomic, readonly) AVSampleCursorSyncInfo syncInfo;
@property (nonatomic, readonly) AVSampleCursorDependencyInfo currentSampleDependencyInfo;


- (instancetype) initWithTrackReader:(LibAVTrackReader*)trackReader;

- (void) seekToBeginningOfFile;
- (void) seekToEndOfFile;

@end

NS_ASSUME_NONNULL_END
