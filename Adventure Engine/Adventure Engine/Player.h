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
    
    //Animations
    //walk
    //run
    //press item
    //idle
    //use computer
    CCAnimation *walkAnimation;
}

-(id) init;
-(id) initAtPosition:(CGPoint) pos facing:(Direction) d;
-(bool) attemptMoveInDirection:(Direction) d;
-(bool) attemptNoMove;
-(bool) moveToPosition:(CGPoint)position;
-(void) setPositionManually:(CGPoint)position; // Overrides any barrier
-(CGPoint) getPosition;
-(void) setFacing:(Direction) d;

@end
