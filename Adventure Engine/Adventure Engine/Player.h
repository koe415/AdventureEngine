//
//  Player.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "SharedTypes.h"
#import "Logic.h"

#define MAXPLAYERSPEED 3.0f

@interface Player : CCSpriteBatchNode {
    CCSprite * playerAvatar;
    Direction playerDirection;
    float playerVelocity;
    
    int xTilePosition;
    
    CCAnimation *walkAnimation;
}

-(id) init;
-(id) initAtPosition:(CGPoint) pos facing:(Direction) d;
-(void) attemptMoveInDirection:(Direction) d;
-(void) attemptNoMove;
-(CGPoint) getPosition;
-(void) moveToPosition:(CGPoint)position;
-(void) setPositionManually:(CGPoint)position; // Overrides any barrier
-(void) setFacing:(Direction) d;

@end
