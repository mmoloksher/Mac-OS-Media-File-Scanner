//
//  ITunesScan.m
//  MyMusicCloud
//
//  Created by Mike Moloksher on 4/25/13.
//
//

#import "ITunesScan.h"
#import <ScriptingBridge/SBApplication.h>
#import "AppDelegate.h"
#import "Global.h"
#import "Audio.h"
#import "CoreDataUtilities.h"
#import "Utility.h"
#import "FileMD5Hash.h"

@implementation ITunesScan

static ITunesScan *instance = Nil;

+(ITunesScan *)instance {
    @synchronized(self) {
        if (instance == Nil) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}

- (void)scanItunesLibrary
{
    
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    
    [[Global instance].mediaLibraryTracks removeAllObjects];
    
    if(!library)
        [self getItunesLibrary];
    
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    NSArray *libraryLists = [[library libraryPlaylists] get];
    for (iTunesUserPlaylist *list in libraryLists)
    {
        NSArray *listTracks = [[list fileTracks] get];
        for (iTunesFileTrack *rawSong in listTracks)
        {
            NSLog(@"TRACK: %@", [rawSong properties]);
            
            if([rawSong.location absoluteString])
            {
                NSEntityDescription *description = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:moc];
                Audio *song = [[Audio alloc] initWithEntity:description insertIntoManagedObjectContext:nil];
                
                NSString *songFilePath = [Utility normalizeFilePath:[rawSong.location absoluteString]];
                
                song.title = [rawSong name];
                song.itunesURL = songFilePath;
                
                [[Global instance].mediaLibraryTracks addObject:song];
                
            }
        }
    }
    
    NSLog(@"Done Scanning iTunes");
    
}

-(void)getItunesLibrary
{
    SBElementArray *iSources = [iTunes sources];
    library = nil;
    for (iTunesSource *source in iSources)
    {
        if ([[source name] isEqualToString:@"Library"])
        {
            NSLog(@"Found Library");
            library = source;
            break;
        }
        else
        {
            NSLog(@"Found Library");
        }
    }
    
    // could not find the itunes library
    if (!library) {
        NSLog(@"Could not connect to the iTunes library");
    }
    
}

@end
