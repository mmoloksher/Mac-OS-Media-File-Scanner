//
//  FileSystemScanner.m
//  MyMusicCloud
//
//  Created by Mike Moloksher on 5/9/13.
//
//

#import "FileSystemScanner.h"
#import "Utility.h"
#import "Global.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FileMD5Hash.h"
#import "CoreDataUtilities.h"


@implementation FileSystemScanner

+ (void)scanFileSystem:(NSString *)sourcePath
{
    NSLog(@"scanFileSystem");
    
    [[Global instance].mediaLibraryTracks removeAllObjects];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *directoryURL = [[NSURL alloc] initFileURLWithPath:sourcePath isDirectory:YES];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.'
                                             
                                             NSLog(@"Error happend with Enumerator: %@", error);
                                             
                                             return NO;
                                         }];
    
    
    NSNumber *count = 0;
        
    for (NSURL *url in enumerator)
    {
        NSError *error;
        NSNumber *isDirectory = nil;
        
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
            NSLog(@"Error Happened: %@", error);
        }
        else if (! [isDirectory boolValue] && [Utility isValidFileExtension:[[url description] pathExtension]])
        {
            NSLog (@"File Path: %@ | File type: %@", [url description], [[url description] pathExtension]);
            
            count = [NSNumber numberWithInt:[count intValue]+1];
            
            NSMutableDictionary *track = [[NSMutableDictionary alloc] init];
            [track setValue:[url description] forKey:@"Location"];
            [track setValue:[[url description] pathExtension] forKey:@"Name"];
            
            
            [[Global instance].mediaLibraryTracks addObject:track];
        }
    }
        
}

@end
