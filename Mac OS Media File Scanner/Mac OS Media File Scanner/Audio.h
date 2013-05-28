//
//  Audio.h
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Audio : NSManagedObject

@property (nonatomic, retain) NSString * md5;
@property (nonatomic, retain) NSString * itunesURL;
@property (nonatomic, retain) NSString * title;

@end
