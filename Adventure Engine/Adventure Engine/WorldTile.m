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

-(void) update {
    // May be depreciated due to lack of need to update animated sprites manually
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


@end
