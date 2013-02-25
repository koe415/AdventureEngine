//
//  Player.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/8/12.
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
    
    NSArray * idleAnims;
    CCAnimation *walk1a;
    CCAnimation *walk1b;
    bool playingWalk1a;
}

-(id) init;
-(id) initAtPosition:(CGPoint) pos facing:(Direction) d;
-(void) setupAnimations;
-(bool) attemptMoveInDirection:(Direction) d;
-(bool) attemptNoMove;
-(bool) moveToPosition:(CGPoint)position;
-(void) setPositionManually:(CGPoint)position; // Overrides any barrier
-(CGPoint) getPosition;
-(float) getVelocity;
-(void) setFacing:(Direction) d;

-(void) updateLightingWith: (NSArray *) lightsArray;

@end
