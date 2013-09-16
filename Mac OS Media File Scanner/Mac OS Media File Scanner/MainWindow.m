//
//  MainWindow.m
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "MainWindow.h"
#import "Global.h"

@interface MainWindow ()

@end

@implementation MainWindow
@synthesize mainView;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSLog(@"windowDidLoad");
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [Global instance].mainWindowController = self;
        
    libraryPicker = [[MediaLibraryPicker alloc] initWithNibName:@"MediaLibraryPicker" bundle:nil];
    [mainView addSubview:libraryPicker.view];
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showProcessingView)
                                                 name:@"ProcessingView"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTrackListingView)
                                                 name:@"TrackListingView"
                                               object:nil];

}


-(void)showProcessingView
{
    NSLog(@"showProcessingView");
    [libraryPicker.view removeFromSuperview];
    
    processPageVC = [[ProcessPage alloc] initWithNibName:@"ProcessPage" bundle:nil];
    [mainView addSubview:processPageVC.view];
}

-(void)showTrackListingView
{
    NSLog(@"showTrackListingView");
    [processPageVC.view removeFromSuperview];
    
    tracksListingPageVC = [[TracksListing alloc] initWithNibName:@"TracksListing" bundle:nil];
    [mainView addSubview:tracksListingPageVC.view];
}

@end
