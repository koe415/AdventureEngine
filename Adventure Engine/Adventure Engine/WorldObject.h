//
//  WorldObject.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "DebugFlags.h"

@interface WorldObject : CCSprite {
    NSString * identity;
    NSMutableArray * animations; // CCanimations
}

+(id) objectWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity;
-(id) initWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity;
-(void) addAnimation:(CCAnimation *) inputAnimation;
-(void) playAnimation:(int) animNum;
-(bool) compareWith:(NSString *) inputString;

@end
