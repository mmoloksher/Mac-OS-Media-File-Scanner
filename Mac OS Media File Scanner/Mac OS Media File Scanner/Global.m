//
//  Global.m
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "Global.h"

@implementation Global
@synthesize mainWindowController, validExtensions, mediaLibraryTracks, userPickedMediaLibrary, userDirectory, globalOperationQueue;

static Global *instance = Nil;
+(Global *)instance {
    @synchronized(self) {
        if (instance == Nil) {
            instance = [[self alloc] init];
            
            instance.userDirectory = [NSString stringWithFormat:@"/Users/%@/", NSUserName()];
            instance.validExtensions = [NSArray arrayWithObjects:@"mp3", nil];
            instance.mediaLibraryTracks = [[NSMutableArray alloc] init];
            instance.globalOperationQueue = [[NSOperationQueue alloc] init];
            instance.globalOperationQueue.maxConcurrentOperationCount = 1;
            instance.userPickedMediaLibrary = 1;
        }
    }
    
    return instance;
}


@end
