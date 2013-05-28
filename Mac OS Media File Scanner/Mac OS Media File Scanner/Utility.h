//
//  Utility.h
//  MyMusicCloud
//
//  Created by Mike Moloksher on 5/9/13.
//
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject


+(NSString *)normalizeFilePath:(NSString *)filePath;
+(NSString *)getFileName:(NSString *)filePath;


+(BOOL)isValidFileExtension:(NSString *)fileExtension;
+ (NSString *)getMD5FromFile:(NSString *)filePath;
+ (NSString *)getMD5FromString:(NSString *)stringObj;

@end
