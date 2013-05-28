//
//  ProcessPage.h
//  Mac OS Media File Scanner
//
//  Created by Mikhail Moloksher on 5/27/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ProcessPage : NSViewController
{
    NSProgressIndicator *progressBar;
}

@property (strong) IBOutlet NSProgressIndicator *progressBar;


@end
