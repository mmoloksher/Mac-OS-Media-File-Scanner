//
//  CoreDataUtilities.h
//  Mac OS Media File Scanner
//
//  Created by Mike Moloksher on 5/24/13.
//  Copyright (c) 2013 Mike Moloksher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataUtilities : NSObject

+(CoreDataUtilities *)instance;


-(void)addTracksToDB:(NSDictionary *)tracksDictionary withView:(NSView *)mainView withProgressView:(NSProgressIndicator *)progressView withCompletionBlock:(void(^)(void))completionBlock;

-(BOOL)isTrackInDB:(NSString *)md5ID;



@end
