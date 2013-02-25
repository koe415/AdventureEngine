//
//  CreatureManager.m
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import "CreatureManager.h"

#define kBATCHNODE 1

@implementation CreatureManager

-(id) init {
    self = [super initWithFile:@"creatures.png" capacity:10];
    if (!self) return nil;
    
    creatures = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) createCreature:(int) type at:(float) xPos {
    Log(@"Creating creature of type %d at %d",type,xPos);
    
    Creature * newCreature;
    switch (type) {
        case 1:
            newCreature = [[Zombie alloc] init];
            break;
        default:
            break;
    }
    
    [newCreature setXPosition:xPos];
    
    [self addChild:newCreature];
    [creatures addObject:newCreature];
}

-(void) handleFlashFrom: (float) xPos {
    for (Creature * c in creatures) {
        float distBetween = c.position.x - xPos;
        if (distBetween<0.0f) distBetween *= -1.0f;
        
        if (distBetween < 200.0f)
            [c isFlashed];
    }
}

-(void) update {
    for (Creature * c in creatures) {
        [c update];
    }
}

-(void) clear {
    [self removeAllChildrenWithCleanup:true];
    [creatures removeAllObjects];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"creatures.plist"]];
}

-(void) dealloc {
    [creatures release];
    [super dealloc];
}

@end
