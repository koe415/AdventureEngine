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
    visible = true;
    
    return self;
}

-(void) addSprite:(CCSprite *) s {
    [sprites addObject:s];
}

-(void) removeAllSprites {
    [sprites removeAllObjects];
}

-(void) setVisible:(bool) v {
    visible = v;
    
    for (CCSprite * sprite in sprites) {
        [sprite setVisible:v];
    }
}

-(bool) isVisible {
    return visible;
}

-(void) setBrightness:(int) b {
    for (CCSprite * sprite in sprites) {
        [sprite setColor:ccc3(b, b, b)];
    }
}

-(void) dealloc {
    for (CCSprite * s in sprites) {
        [s removeFromParentAndCleanup:true];
    }
    [sprites removeAllObjects];
    [sprites release];
    [super dealloc];
}

@end
