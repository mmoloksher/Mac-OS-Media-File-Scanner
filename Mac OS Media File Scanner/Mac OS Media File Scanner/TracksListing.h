//
//  TracksListing.h
//  Mac OS Media File Scanner
//
//  Created by Mikhail Moloksher on 5/28/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TracksListing : NSViewController <NSTableViewDelegate, NSTableViewDataSource>
{
    NSArray *tracks;
}

@property (strong) IBOutlet NSTableView *tracksListingTable;

@end
