//
//  MediaLibraryPicker.m
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "MediaLibraryPicker.h"
#import "ITunesScan.h"
#import "FileSystemScanner.h"
#import "Global.h"
#import "Constants.h"

@interface MediaLibraryPicker ()

@end

@implementation MediaLibraryPicker
@synthesize libraryPicker, songsFoundLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) awakeFromNib{
    
    [Global instance].mediaLibraryTracks = [ITunesScan scanItunesLibrary];
    [self displaySongsAmount];
    
}



- (IBAction)libraryPicked:(id)sender
{
    NSButtonCell *radioButton = [sender selectedCell];
    NSLog(@"libraryPikced Pressed %ld", (long)radioButton.tag);
    
    if(radioButton.tag == ITUNES_LIBRARY)
    {
        NSLog(@"iTunes Library Selected");
        [Global instance].userPickedMediaLibrary = ITUNES_LIBRARY;
        
        // Look for music in the iTunes XML File
        [Global instance].mediaLibraryTracks = [ITunesScan scanItunesLibrary];
        
    }
    else if (radioButton.tag == MUSIC_LIBRARY)
    {
        NSLog(@"Music Folder Library Selected");
        [Global instance].userPickedMediaLibrary = MUSIC_LIBRARY;
        
        //Looking for files in Music Folder
        [Global instance].mediaLibraryTracks = [FileSystemScanner scanFileSystem:[NSString stringWithFormat:@"%@Music/", [Global instance].userDirectory]];
    }
    else
    {
        NSLog(@"Other Selected");
        [Global instance].userPickedMediaLibrary = OTHER_LIBRARY;
        
        
        // Create a File Open Dialog class.
        NSOpenPanel* openDlg = [NSOpenPanel openPanel];
        
        // Enable options in the dialog.
        [openDlg setCanChooseFiles:NO];
        [openDlg setCanChooseDirectories:YES];
        [openDlg setAllowsMultipleSelection:NO];
        [openDlg setMessage:@"Pick a folder to scan for media files..."];
        
        [openDlg beginSheetModalForWindow:[[Global instance].mainWindowController window]
                        completionHandler:^(NSInteger result)
         {
             if (result == NSOKButton)
             {
                 // Gets list of all files selected
                 NSArray *files = [openDlg URLs];
                 
                 
                 // Do something with the filename.
                 NSLog(@"File path: %@", [[files objectAtIndex:0] path]);
                 
                 
                 dispatch_queue_t fileScannerQueue = dispatch_queue_create("com.mmc.fileScannerQueue", NULL);
                 dispatch_async(fileScannerQueue,
                                ^{
                                    [Global instance].mediaLibraryTracks = [FileSystemScanner scanFileSystem:[[files objectAtIndex:0] path]];
                                    
                                    dispatch_sync(dispatch_get_main_queue(),
                                                  ^{
                                                      NSLog(@"Scan Finished");
                                                      [self displaySongsAmount];
                                                  });
                                });
                 
             }
         }];
        
        
    }
    
    [self displaySongsAmount];
    
    
}

- (IBAction)gotoProcessPage:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProcessingView" object:self];
    
}

-(void)displaySongsAmount
{
    songsFoundLabel.stringValue = [NSString stringWithFormat:@"Found: %ld songs", (unsigned long)[[Global instance].mediaLibraryTracks count]];
}

@end
