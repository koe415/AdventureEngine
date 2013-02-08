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
#import "WorldObject.h"
#import "Tappable.h"
#import "Triggerable.h"
#import "GameAction.h"
#import "Barrier.h"
#import "WorldHistory.h"
#import "GameActionSequence.h"

#define WORLDTILES_X 72
#define WORLDTILES_Y 8
#define DEFAULTANIMATIONDELAY 0.2f

@interface World : CCLayer {
    @private
    GameData * gd;
    Player * player;
    int cameraFocusedOnTile;
    id worldTiles[WORLDTILES_X][WORLDTILES_Y];
    CGPoint cameraCenter;
    
    NSString * worldObjectSpriteSheet;
    NSString * tileSpriteSheet;
    NSMutableArray * gameActionsLoaded;
    
    //CCSpriteBatchNode * foregroundBatchNode;
    CCSpriteBatchNode * backgroundBatchNode;
    CCSpriteBatchNode * worldObjectsBatchNode;
}

/* Establishing World Data
 */
-(void) clearWorld;
-(void) loadWorld:(NSString *) worldToLoad;
-(void) loadWorld:(NSString *) worldToLoad withSpawn:(int) playerSpawnPt;

/* Parsers for loading in World Data
 * Adds objects to world if necessary
 */
-(void) parseInfo:(NSString *) inputString;
-(void) parseSpawnPoint:(NSString *) inputString;
-(void) parseTile:(NSString *) inputString;
-(void) parseBarrier:(NSString *) inputString;
-(void) parseWorldObject:(NSString *) inputString;
-(void) parseGameAction:(NSString *) inputString;
-(void) parseTappable:(NSString *) inputString;
-(void) parseTriggerable:(NSString *) inputString;

/* Adding objects to world
 */
-(void) addSprite:(NSString *) s atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop;
-(void) addAnimatedSprite:(NSArray *) spriteFrames atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop delay:(float) d;

/* Game loop
 */
-(void) tick:(ccTime) dt;
-(void) updateCamera;
-(void) updateTileVisibility;

-(void) dealloc;

@end
