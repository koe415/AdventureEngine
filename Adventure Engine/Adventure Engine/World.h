//
//  TestLayerBottom.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "DebugFlags.h"
#import "Player.h"
#import "WorldTile.h"

#define WORLDTILES_X 36
#define WORLDTILES_Y 4

@interface World : CCLayer {
    GameData * gd;
    Player * player;
    int cameraFocusedOnTile;
    id worldTiles[WORLDTILES_X][WORLDTILES_Y];
}

-(void) clearWorld;
-(void) setupWorld:(NSString *) worldToLoad;
-(void) addAnimatedSprite:(NSArray *) stringArray atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop;
-(void) addSprite:(NSString *) s atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop;
-(void) tick:(ccTime) dt;
-(void) updateCamera;
-(void) updateTileVisibility;
@end
