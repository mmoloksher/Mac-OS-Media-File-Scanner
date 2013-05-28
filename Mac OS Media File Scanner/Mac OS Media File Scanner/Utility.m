//
//  Utility.m
//  MyMusicCloud
//
//  Created by Mike Moloksher on 5/9/13.
//
//

#import "Utility.h"
#import "Global.h"
#import "Constants.h"
#import "FileMD5Hash.h"

@implementation Utility


// validates the raw path of files/dirs to be used for MacOSX SDK functions
+(NSString *)normalizeFilePath:(NSString *)filePath
{
    NSString *libraryPathEncoded = [[filePath componentsSeparatedByString:@"file://localhost"] objectAtIndex:1];
    NSString *libraryPathDecoded = [libraryPathEncoded stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return libraryPathDecoded;
}

+(NSString *)getFileName:(NSString *)filePath
{
    NSArray *filePathParts = [filePath componentsSeparatedByString:@"/"];
    NSString *fileNameEncoded = [filePathParts objectAtIndex:[filePathParts count]-1];
    NSString *fileNameDecoded = [fileNameEncoded stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return fileNameDecoded;

}

// Checks whether a file extention is part of the valid extentions we allow
+(BOOL)isValidFileExtension:(NSString *)fileExtension
{
    NSArray *validExtentions = [Global instance].validExtensions;
    
    for(NSString *ext in validExtentions)
    {
        if([fileExtension isEqualToString:ext]) // if the passed extention matches one of the valid ones, return yes
        {
            return YES;
        }
    }
    
    return NO;
}

+ (NSString *)getMD5FromFile:(NSString *)filePath
{
    NSLog(@"getMD5FromFile File Path %@", filePath);
    CFStringRef executableFileMD5Hash = FileMD5HashCreateWithPath((__bridge CFStringRef)filePath, FileHashDefaultChunkSizeForReadingData);
    
    if (executableFileMD5Hash)
    {
        return ((__bridge NSString *)executableFileMD5Hash);
        CFRelease(executableFileMD5Hash);
    }

    
    return @"";
}


+ (NSString *)getMD5FromString:(NSString *)stringObj
{
    const char *cstr = [stringObj UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    NSLog(@"HASH %@", [NSString stringWithFormat:
                       @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3],
                       result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11],
                       result[12], result[13], result[14], result[15]
                       ]);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
