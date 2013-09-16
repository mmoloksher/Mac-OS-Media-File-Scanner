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
#import "AppDelegate.h"
#import "Audio.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FileMD5Hash.h"
#import "CoreDataUtilities.h"


@implementation FileSystemScanner

+ (void)scanFileSystem:(NSString *)sourcePath
{
    NSLog(@"scanFileSystem");
    
    [[Global instance].mediaLibraryTracks removeAllObjects];
    
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSFileManager * fm = [NSFileManager defaultManager];

    
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
            
            NSEntityDescription *description = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:moc];
            Audio *song = [[Audio alloc] initWithEntity:description insertIntoManagedObjectContext:nil];
            
            song.title = [[url description] pathExtension];
            song.itunesURL = [Utility normalizeFilePath:[url description]];
            
            // Grab ID3 data from mp3 file
            NSURL *url = [[NSURL alloc] initFileURLWithPath:song.itunesURL];
            AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
            
            NSArray *metadata = [asset commonMetadata];
            
            for (AVMetadataItem * item in metadata )
            {
                NSString *key = [item commonKey];
                NSString *value = [item stringValue];
                
                //NSLog(@"key = %@, value = %@", key, value);
                
                if([key isEqualToString:@"title"])
                {
                    song.title = value;
                }
                
            }

            
            [[Global instance].mediaLibraryTracks addObject:song];
            
        }
    }
        
}

@end
