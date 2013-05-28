//
//  CoreDataUtilities.m
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "CoreDataUtilities.h"
#import "AppDelegate.h"
#import "Global.h"
#import "Utility.h"
#import "Constants.h"
#import "Audio.h"

@implementation CoreDataUtilities

static CoreDataUtilities *instance = Nil;

+(CoreDataUtilities *)instance {
    @synchronized(self) {
        if (instance == Nil) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}


-(void)addTracksToDB:(NSDictionary *)tracksDictionary
            withView:(NSView *)mainView
    withProgressView:(NSProgressIndicator *)progressView
 withCompletionBlock:(void(^)(void))completionBlock
{
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    
    NSLog(@"+++ addTracksToDB STARTED");
    
    NSTextField * progressBarInfo = (NSTextField *)[mainView viewWithTag:PROGRESSBAR_INFO_TAG];
    
    double songsWorth = 100.0/[tracksDictionary count];
    double parsePercentage = 0.0;
    int songCount = 0;
    
    [progressView setDoubleValue:50.0];
    
    // Going Through Each Track
    for (id track in tracksDictionary)
    {
        NSDictionary *trackDict = [tracksDictionary objectForKey:track];
        
        NSLog(@"Song: %@", [trackDict objectForKey:@"Name"]);
        
        
        songCount++;
        parsePercentage = songsWorth * songCount;
        
        // Update View with Information
        [progressView setDoubleValue:parsePercentage];
        [progressBarInfo setStringValue:[NSString stringWithFormat:@"Processing File: %@",[Utility getFileName:[trackDict objectForKey:@"Location"]]]];
        
        
        // INIT
        NSString * trackDict_trackName = [trackDict objectForKey:@"Name"];
        NSString * trackDict_location = [trackDict objectForKey:@"Location"];
        
        
        /* === SONGS === */
        NSString *audioName;
        NSEntityDescription *AudioEntity = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:[delegate managedObjectContext]];
        
        if([trackDict_trackName length] == 0)
            audioName = @"Unknown";
        else
            audioName = trackDict_trackName;
        
        // Gets the MD5 from the file to be used an ID
        NSString *audioCode = [Utility getMD5FromFile:[Utility normalizeFilePath:trackDict_location]];
        
        NSLog(@"MD5: %@ for Track: %@\n\n", audioCode, trackDict_trackName);
        
        
        if (![self isTrackInDB:audioCode])
        {
            NSLog(@"Creating DB Record");
            Audio *audioObj = [[Audio alloc] initWithEntity:AudioEntity insertIntoManagedObjectContext:[delegate managedObjectContext]];
            [audioObj setTitle:audioName];
            [audioObj setMd5:audioCode];
            [audioObj setItunesURL:[trackDict objectForKey:@"Location"]];
        }
    }
    
    NSError *error;
    
    if (![[delegate managedObjectContext] save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    
    // Update View with Information
    [progressView setDoubleValue:0.0];
    [progressBarInfo setStringValue:[NSString stringWithFormat:@"Finished Processing Files"]];
    NSLog(@"+++ addTracksToDB ENDED");
    
    completionBlock();
}

-(BOOL)isTrackInDB:(NSString *)md5ID
{
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSPredicate *searchFilter = [NSPredicate predicateWithFormat:@"md5 == %@", md5ID];
    [request setPredicate:searchFilter];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if([results count] != 0)
        return YES;
    else
        return NO;
}


@end
