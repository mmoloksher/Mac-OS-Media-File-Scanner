//
//  MediaLibraryPicker.h
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MediaLibraryPicker : NSViewController
{
    NSDictionary *tracksDictionary;
    NSInvocationOperation *backgroundOperation;
}


@property (strong) IBOutlet NSMatrix *libraryPicker;
@property (strong) IBOutlet NSTextField *songsFoundLabel;
@property (weak) IBOutlet NSProgressIndicator *spinningCircle;


- (IBAction)libraryPicked:(id)sender;
- (IBAction)gotoProcessPage:(id)sender;

@end
