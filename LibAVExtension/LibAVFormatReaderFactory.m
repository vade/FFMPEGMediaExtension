//
//  LibAVFormatReaderFactory.m
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

#import "LibAVFormatReaderFactory.h"
#import "LibAVFormatReader.h"

@implementation LibAVFormatReaderFactory

- (id<MEFormatReader> _Nullable) formatReaderWithByteSource:(nonnull MEByteSource *)primaryByteSource
                                                    options:(MEFormatReaderInstantiationOptions * _Nullable)options
                                                      error:(NSError *__autoreleasing  _Nullable * _Nullable)error
{
    return [[LibAVFormatReader alloc] initWithByteSource:primaryByteSource];
}

@end
