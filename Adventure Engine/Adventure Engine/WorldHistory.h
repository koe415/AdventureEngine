//
//  PersistantData.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistentData.h"
#import "DebugFlags.h"

/*
 * Stores a series of bool values corresponding to checks
 * ie. tapping a button stores value door_is_unlocked as true
 *     tapping a nearby door checks that value, allowing player to continue
 */
@interface WorldHistory : NSObject {
    NSMutableArray * data;
}

-(void) setStatus:(bool) inputStatus forID: (NSString *) ident;
-(bool) hasValueForID:(NSString *) ident;
-(bool) checkValueForID:(NSString *) ident;
-(void) clear;

@end
