//
//  AVMetadataItem+AVDictionaryEntry.m
//  LibAVExtensionHost
//
//  Created by Anton Marini on 8/1/24.
//

#import "AVMetadataItem+AVDictionaryEntry.h"
#import <CoreMedia/CoreMedia.h>
#import <CoreMedia/CMMetadata.h>

@implementation AVMetadataItem (AVDictionaryItem)

+ (AVMetadataItem*) metadataItemFrom:(const AVDictionaryEntry*)dictionaryEntry;
{
    AVMutableMetadataItem* item = [AVMutableMetadataItem metadataItem];

    item.dataType = [item determineDataTypeForDictionaryEntry:dictionaryEntry];

    NSString* key = [[NSString alloc] initWithUTF8String: dictionaryEntry->key];
    NSString* value = [[NSString alloc] initWithUTF8String: dictionaryEntry->value];
        
    item.key = key;
    item.value = value;

    return item;
}

- (NSString*) determineDataTypeForDictionaryEntry:(const AVDictionaryEntry*)dictionaryEntry
{
//    // First, check if we can determine the type based on known keys
//    if (strcmp(dictionaryEntry->key, "creation_time") == 0 || strcmp(dictionaryEntry->key, "date") == 0) {
//        return kCMMetadataBaseDataType_Time;
//    }
//    
//    // Check for boolean values
//    if (strcasecmp(dictionaryEntry->value, "true") == 0 || strcasecmp(dictionaryEntry->value, "false") == 0) {
//        return kCMMetadataBaseDataType_Boolean;
//    }
//    
//    // Check for integer values
//    char *endptr;
//    strtol(dictionaryEntry->value, &endptr, 10);
//    if (*endptr == '\0') {
//        return kCMMetadataBaseDataType_Int64;
//    }
//    
//    // Check for floating-point values
//    strtod(dictionaryEntry->value, &endptr);
//    if (*endptr == '\0') {
//        return (NSString*)kCMMetadataBaseDataType_Float64;
//    }
    
    // If none of the above, assume it's a string
    return (NSString*)kCMMetadataBaseDataType_UTF8;
}
@end
