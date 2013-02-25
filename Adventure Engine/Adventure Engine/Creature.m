//
//  Creature.m
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import "Creature.h"

@implementation Creature

-(void) setFacing:(Direction) d {
    // if player is already facing the input direction
    if (creatureDir==d) return;
    
    if (d == LEFT)
        [self setScaleX: -2.0f];
    else if (d == RIGHT)
        [self setScaleX: 2.0f];
    
    creatureDir = d;
}

-(void) setXPosition:(int) xPos {
    [super setPosition:CGPointMake(xPos, 100)];
}

// TODO: Fix this!
-(void) update {}
-(void) setupAnimations {}
-(void) isFlashed {}

@end
