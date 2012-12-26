//
//  WorldTile.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorldTile.h"

@implementation WorldTile 

-(id) init {
    self = [super init];
    if (!self) return nil;
    
    sprites = [[NSMutableArray alloc] init];
    animatedSprites = [[NSMutableArray alloc] init];
    visible = true;
    
    return self;
}

-(void) addSprite:(CCSprite *) s {
    [sprites addObject:s];
}

-(void) addAnimatedSprite:(CCAnimatedSprite *) s {
    [animatedSprites addObject:s];
}

-(void) removeAllSprites {
    [sprites removeAllObjects];
    [animatedSprites removeAllObjects];
}

-(void) update {
    for (CCAnimatedSprite * animation in animatedSprites) {
        [animation update];
    }
}

-(void) setVisible:(bool) v {
    visible = v;
    
    for (CCSprite * sprite in sprites) {
        [sprite setVisible:v];
    }
    
    for (CCAnimatedSprite * animation in animatedSprites) {
        [animation setVisible:v];
    }
}

-(bool) isVisible {
    return visible;
}

-(bool) hasAnimatedSprites {
    return ([animatedSprites count] == 0)? false: true;
}


@end
