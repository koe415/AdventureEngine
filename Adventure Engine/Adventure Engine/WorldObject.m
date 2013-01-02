//
//  WorldObject.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WorldObject.h"

@implementation WorldObject

-(id) initWithTile:(NSString *) tileName atTilePosition:(CGPoint) tilePt isEnabled:(bool) inputEnabled {
    self = [super initWithFile:tileName];
    if (!self) return nil;
    
    [self setScale:2.0f];
    [[self texture] setAliasTexParameters];
    
    enabled = inputEnabled;
    tileCoord = tilePt;
    [self setPosition:ccp((tileCoord.x-1) * 20 * 2 + 20,(tileCoord.y-1) * 20 * 2 + 20)];
    
    return self;
}

-(id) initWithTile:(NSString *) tileName atTilePosition:(CGPoint) tilePt {
    return [self initWithTile:tileName atTilePosition:tilePt isEnabled:true]; 
}

-(bool) isEnabled {
    return enabled;
}

-(CGPoint) getTileCoord {
    return tileCoord;
}

-(bool) compareTilePosition:(CGPoint) inputPt {
    if (tileCoord.x == inputPt.x) {
        if (tileCoord.y == inputPt.y) {
            Log(@"Shower Door tapped");
            return true;
        }
    }
    
    return false;
}

-(void) isTapped {
    [self setVisible:!self.visible];
    
}

@end
