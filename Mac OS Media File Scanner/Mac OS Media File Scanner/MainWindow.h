//
//  MainWindow.h
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MediaLibraryPicker.h"
#import "ProcessPage.h"

@interface MainWindow : NSWindowController
{
    MediaLibraryPicker *libraryPicker;
    ProcessPage *processPageVC;

}
@property (strong) IBOutlet NSView *mainView;

-(void)showProcessingView;


@end
