//
//  TracksListing.m
//  Mac OS Media File Scanner
//
//  Created by Mikhail Moloksher on 5/28/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "TracksListing.h"

@interface TracksListing ()

@end

@implementation TracksListing
@synthesize tracksListingTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView {
    
    [super loadView];
    NSLog(@"loadView");
    
    
      
}

- (void) awakeFromNib{
    
    NSLog(@"awakeFromNib");
    
   [tracksListingTable setDelegate:self];
    [tracksListingTable setDataSource:self];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 12;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"tableViewtableView");
    // Retrieve to get the @"MyView" from the pool
    // If no version is available in the pool, load the Interface Builder version
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    result.stringValue = @"Hello";
    
    // return the result.
    // return the result.
    return result;
    
}



@end
