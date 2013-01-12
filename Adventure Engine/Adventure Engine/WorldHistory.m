//
//  PersistantData.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WorldHistory.h"

@implementation WorldHistory

-(id) init {
    self = [super init];
    if(!self) return nil;
    Log(@"Inited");
    
    data = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) setStatus:(bool) inputStatus forID: (NSString *) ident {
    for (PersistentData * pD in data) {
        if ([pD compareID:ident]) {
            Log(@"Setting '%@' to %i",ident,inputStatus);
            [pD setStatus: inputStatus];
            break;
        }
    }
    
    Log(@"Adding '%@' to %i",ident,inputStatus);
    [data addObject:[PersistentData dataWithID:ident status:inputStatus]];
}

-(bool) checkValueForID:(NSString *) ident {
    Log(@"Checking for %@",ident);
    for (PersistentData * pD in data) {
        if ([pD compareID:ident]) {
            Log(@"Found '%@', has status:%i",ident,[pD getStatus]);
            return [pD getStatus];
        }
    }
    
    return nil;
}

-(void) clear {
    [data removeAllObjects];
}

-(void) dealloc {
    Log(@"dealloc");
    [data release];
    [super dealloc];
}

@end
