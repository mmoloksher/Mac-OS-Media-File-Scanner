//
//  ITunesScan.m
//  MyMusicCloud
//
//  Created by Mike Moloksher on 4/25/13.
//
//

#import "ITunesScan.h"
#import "AppDelegate.h"
#import "Audio.h"
#import "CoreDataUtilities.h"
#import "Utility.h"
#import "FileMD5Hash.h"

@implementation ITunesScan

+ (NSDictionary *)scanItunesLibrary
{
    // Grab user's iTunes Library Path
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userPref = [userDefaults persistentDomainForName:@"com.apple.iApps"];
    NSArray *recentDatabases = [userPref objectForKey:@"iTunesRecentDatabases"];
    
    NSString *libraryPathDecoded = [Utility normalizeFilePath:[recentDatabases objectAtIndex:0]];
    
    //NSLog(@"ITUNES DB %@", libraryPathDecoded);
    
    // Convert iTunes XML into NSDictionary 
    NSDictionary* musicLibrary = [NSDictionary dictionaryWithContentsOfFile: libraryPathDecoded];
    //NSLog(@"Music Dictionary %@", musicLibrary);

    NSDictionary *tracksDict = [musicLibrary objectForKey:@"Tracks"];
    //NSLog(@"Tracks Dictionary %@", tracksDict);
    
    
    
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];

    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"ERROR %@", error);
    }
    
    NSLog(@"Tracks Amount in DB: %ld", (unsigned long)[array count]);
   
    for(Audio *track in array)
    {
        NSLog(@"Audio Name: %@ | ID: %@ ", track.title, track.md5);
    }
    
    return tracksDict;
    
}

@end
