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
//#import "Engine.h"
//#import "WorldObject.h"
#import "Tappable.h"
#import "Triggerable.h"
#import "GameAction.h"
#import "SpawnPosition.h"

#define WORLDTILES_X 72
#define WORLDTILES_Y 8
#define DEFAULTANIMATIONDELAY 0.2f

@interface World : CCLayer {
    GameData * gd;
    Player * player;
    int cameraFocusedOnTile;
    id worldTiles[WORLDTILES_X][WORLDTILES_Y];
    NSMutableArray * spawnPositions;
    
    CCSpriteBatchNode * foregroundBatchNode;
    CCSpriteBatchNode * backgroundBatchNode;
}

-(void) clearWorld;
//-(void) setupWorld:(NSString *) worldToLoad;
-(void) loadWorld:(NSString *) worldToLoad;
-(void) loadWorld:(NSString *) worldToLoad withSpawn:(int) spawnPt;
-(void) addAnimatedSprite:(NSArray *) stringArray atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop;
-(void) addSprite:(NSString *) s atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop;
-(void) addAnimatedSprite:(NSArray *) spriteFrames atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop delay:(float) d;
-(void) tick:(ccTime) dt;
-(void) updateCamera;
-(void) updateTileVisibility;
-(void) dealloc;
@end
