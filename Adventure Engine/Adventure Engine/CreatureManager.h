//
//  CreatureManager.h
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import <Foundation/Foundation.h>
#import "DebugFlags.h"
#import "Creature.h"
#import "cocos2d.h"
#import "Zombie.h"

/**
 * Contains every creature currently in the world
 **/
@interface CreatureManager : CCSpriteBatchNode {
    NSMutableArray * creatures;
}

-(void) createCreature:(int) type at:(float) xPos;
-(void) handleFlashFrom: (float) xPos;

-(void) update;
-(void) clear;

@end
