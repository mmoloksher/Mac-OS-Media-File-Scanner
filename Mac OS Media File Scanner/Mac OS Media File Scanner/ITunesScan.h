//
//  ITunesScan.h
//  MyMusicCloud
//
//  Created by Mike Moloksher on 4/25/13.
//
//

#import <Foundation/Foundation.h>
#import "iTunes.h"

@interface ITunesScan : NSObject
{
    
    iTunesFileTrack * track;
    iTunesApplication *iTunes;
    iTunesSource *library;
    iTunesUserPlaylist *playlist;
    
    NSMutableArray *foundTracks;
    
}

- (void)scanItunesLibrary;
+ (ITunesScan *)instance;

@end
