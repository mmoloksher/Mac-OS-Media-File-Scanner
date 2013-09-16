//
//  Global.h
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject
{
    NSOperationQueue *globalOperationQueue;
}

@property (nonatomic, retain) NSOperationQueue *globalOperationQueue;

@property (nonatomic, retain) NSWindowController *mainWindowController;
@property (nonatomic, retain) NSArray *validExtensions;
@property (nonatomic, retain) NSMutableArray *mediaLibraryTracks;
@property (nonatomic) NSInteger userPickedMediaLibrary;
@property (nonatomic, retain) NSString *userDirectory;



+(Global *)instance;

@end
