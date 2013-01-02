//
//  WorldObject.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"

@interface WorldObject : CCSprite {
    bool enabled;
    CGPoint tileCoord;
}

-(id) initWithTile:(NSString *) tileName atTilePosition:(CGPoint) tilePt isEnabled:(bool) inputEnabled;
-(id) initWithTile:(NSString *) tileName atTilePosition:(CGPoint) tilePt;
-(bool) isEnabled;
-(CGPoint) getTileCoord;
-(bool) compareTilePosition:(CGPoint) inputPt;
-(void) isTapped;

@end
