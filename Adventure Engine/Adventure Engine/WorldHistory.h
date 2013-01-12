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

@interface WorldHistory : NSObject {
    NSMutableArray * data;
}

-(void) setStatus:(bool) inputStatus forID: (NSString *) ident;
-(bool) checkValueForID:(NSString *) ident;
-(void) clear;

@end
