//
//  Creature.h
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SharedTypes.h"
#import "DebugFlags.h"

@interface Creature : CCSprite {
    Direction creatureDir;
}

-(void) setFacing:(Direction) d;
-(void) setXPosition:(int) xPos;

/* The following methods need to be overridden! */
-(void) update;
-(void) setupAnimations;
-(void) isFlashed;

@end
