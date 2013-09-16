//
//  ProcessPage.m
//  Mac OS Media File Scanner
//
//  Created by Mikhail Moloksher on 5/27/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import "ProcessPage.h"
#import "Global.h"
#import "Constants.h"
#import "CoreDataUtilities.h"

@interface ProcessPage ()

@end

@implementation ProcessPage
@synthesize progressBar, nextButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
        NSLog(@"TAG: %ld", (long)progressBar.tag);
        
    }
    
    return self;
}


- (void)loadView {
    
    [super loadView];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        [[CoreDataUtilities instance] addTracksToDB:[Global instance].mediaLibraryTracks
                                    withView:[self view]
                            withProgressView:progressBar
                         withCompletionBlock:^(void)
         {
             NSLog(@"addTracksToDB Finished");
             [nextButton setHidden:NO];
         }];
        
        
    });
    
    [progressBar setDoubleValue:10.2];
    
}


- (IBAction)viewTrackListingTable:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TrackListingView" object:self];

}
@end
