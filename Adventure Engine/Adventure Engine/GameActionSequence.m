//
//  GameActionSequence.m
//  Adventure Engine
//
//  Created by Galen Koehne on 2/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GameActionSequence.h"

@implementation GameActionSequence

+(id) sequenceWithID: (NSString *) inputID {
    return [[[GameActionSequence alloc] initWithID:inputID] autorelease];
}

-(id) initWithID: (NSString *) inputID {
    self = [super init];
    if (!self) return nil;
    
    gameActions = [[NSMutableArray alloc] init];
    identity = inputID;
    
    return self;
}

-(bool) compareID:(NSString *) inputID {
    return [identity isEqualToString:inputID];
}

-(void) addGA: (GameAction *) ga {
    [gameActions addObject:ga];
}

-(NSMutableArray *) getArray {
    return gameActions;
}

-(void) dealloc {
    [gameActions removeAllObjects];
    [gameActions release];
    [super dealloc];
}

@end
