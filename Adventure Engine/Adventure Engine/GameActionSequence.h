//
//  GameActionSequence.h
//  Adventure Engine
//
//  Created by Galen Koehne on 2/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameAction.h"

@interface GameActionSequence : NSObject {
    NSMutableArray * gameActions;
    NSString * identity;
}

+(id) sequenceWithID: (NSString *) inputID;
-(id) initWithID: (NSString *) inputID;
-(bool) compareID:(NSString *) inputID;
-(void) addGA: (GameAction *) ga;
-(NSMutableArray *) getArray;

@end
