//
//  TracksListing.m
//  Mac OS Media File Scanner
//
//  Created by Mikhail Moloksher on 5/28/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "TracksListing.h"
#import "Audio.h"
#import "AppDelegate.h"

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
        
      
}

- (void) awakeFromNib{
    
    NSLog(@"awakeFromNib");
    
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Audio" inManagedObjectContext:[delegate managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [request setEntity:entityDescription];
    
    NSError *error;
    
    if(!tracks)
       tracks = [[NSArray alloc] init];
       
    tracks = [[delegate managedObjectContext] executeFetchRequest:request error:&error];
    
    if (tracks == nil)
    {
        NSLog(@"ERROR %@", error);
    }
    
    NSLog(@"=========");
    NSLog(@"Tracks Amount in DB: %ld", (unsigned long)[tracks count]);

    
    [tracksListingTable setDelegate:self];
    [tracksListingTable setDataSource:self];

    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [tracks count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    NSLog(@"NSTableCellView");
    
    // get an existing cell with the MyView identifier if it exists
    NSTableCellView *result = [tableView makeViewWithIdentifier:[tableColumn identifier] owner:self];
    
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
        
        // create the new NSTextField with a frame of the {0,0} with the width of the table
        // note that the height of the frame is not really relevant, the row-height will modify the height
        // the new text field is then returned as an autoreleased object
        result = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 200, 25)];
        //        [result setBordered:NO];
        //        [result setBackgroundColor:[NSColor clearColor]];
        
        // the identifier of the NSTextField instance is set to MyView. This
        // allows it to be re-used
        result.identifier = @"MyView";
    }
    
    // result is now guaranteed to be valid, either as a re-used cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    
    Audio *cellTrack = [tracks objectAtIndex:row];
    
    result.textField.stringValue = cellTrack.title;
        return result;
    
}



@end
