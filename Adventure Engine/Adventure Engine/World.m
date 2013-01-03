//
//  TestLayerBottom.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"
#import "Engine.h"

#define Z_PLAYER 5
#define Z_BELOW_PLAYER 1
#define Z_IN_FRONT_OF_PLAYER 10

@implementation World

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    [self schedule:@selector(tick:)];
    
    gd = [GameData instance];
    
    cameraFocusedOnTile = 6;
    
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            WorldTile * wt = [[WorldTile alloc] init];
            worldTiles[i][j] = wt;
        }
    }
    
    spawnPositions = [[NSMutableArray alloc] init];
    player = [[Player alloc] init];
    [self addChild:player z:Z_PLAYER];
    
    [self loadWorld:@"bath"];
    
    return self;
}

-(void) onExit {
    Log(@"EXITED WORLD");
}

-(void) clearWorld {
    
}

// Defaults to the first spawn available
-(void) loadWorld:(NSString *) worldToLoad {
    [self loadWorld:worldToLoad withSpawn:2];
}

// Spawn Points increment from 1 and up
-(void) loadWorld:(NSString *) worldToLoad withSpawn:(int) spawnPt {
    [self clearWorld];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"%@.plist",worldToLoad]];
    
    backgroundBatchNode = [CCSpriteBatchNode 
                           batchNodeWithFile:
                           [NSString stringWithFormat:@"%@.png",worldToLoad]];
    
    [self addChild:backgroundBatchNode z:Z_BELOW_PLAYER];
    
    
    NSError * error;
    
    NSString * contents = [NSString stringWithContentsOfFile:
                           [[NSBundle mainBundle] pathForResource:worldToLoad ofType:@"txt"]
                                                    encoding:NSUTF8StringEncoding
                                                       error:&error];
    
    NSArray * contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    int spawnPtID = 0;
    
    for (NSString * s in contentsArray) {
        if ([s hasPrefix:@"spawn"]) {
            NSArray * spawnInfo = [s componentsSeparatedByString:@","];
            int spawnX = [[spawnInfo objectAtIndex:1] intValue];
            int spawnY = [[spawnInfo objectAtIndex:2] intValue];
            Direction d;
            if ([[spawnInfo objectAtIndex:3] isEqualToString:@"R"]) d = RIGHT;
            else d = LEFT;
            
            spawnPtID++;
            
            SpawnPosition * currentSpawn = [[SpawnPosition alloc] initWithPos:CGPointMake(spawnX, spawnY) withDir:d withID:spawnPtID];
            [spawnPositions addObject:currentSpawn];
            
            if (spawnPtID==spawnPt) {
                [player setPositionManually:CGPointMake(spawnX, spawnY)];
                [player setFacing:d];
            }
        } else if ([s hasPrefix:@"info"]) {
            NSMutableArray * barriers = [NSMutableArray array];
            
            NSArray * inputBarriers = [s componentsSeparatedByString:@","];
            
            
            NSString * leftBarrierString = [inputBarriers objectAtIndex:1];
            int leftB = [leftBarrierString floatValue];
            [barriers addObject:[NSNumber numberWithFloat:leftB]];
            
            NSString * RightBarrierString = [inputBarriers objectAtIndex:2];
            int RightB = [RightBarrierString floatValue];
            [barriers addObject:[NSNumber numberWithFloat:RightB]];
            
            
            [[GameData instance]._barriers addObjectsFromArray:barriers];
            
        } else {
            bool isAnimated = false;
            NSArray * tileArray = [s componentsSeparatedByString:@","];
            
            NSString * tileName; // Used only if static
            NSMutableArray * animatedTileNames; // Used only if animated
            float animationDelay; // Used only if animated
            
            if ([[tileArray objectAtIndex:0] rangeOfString:@"-"].location == NSNotFound) {
                tileName = [NSString stringWithFormat:@"%@_%@.png",worldToLoad,[tileArray objectAtIndex:0]];
            } else {
                NSMutableArray * animatedTileNumbers = [NSMutableArray arrayWithArray:[[tileArray objectAtIndex:0] componentsSeparatedByString:@"-"]];
                animatedTileNames = [NSMutableArray array];
                animationDelay = [[animatedTileNumbers objectAtIndex:0] floatValue];
                [animatedTileNumbers removeObjectAtIndex:0];
                
                for (NSString * animatedTileNumber in animatedTileNumbers) {
                    [animatedTileNames addObject:[NSString stringWithFormat:@"%@_%@.png",worldToLoad,animatedTileNumber]];
                }
                
                isAnimated = true;
            }
            
            
            NSString * xRange = [tileArray objectAtIndex:1];
            NSString * yRange = [tileArray objectAtIndex:2];
            
            int tileMinX,tileMaxX;
            int tileMinY,tileMaxY;
            
            if ([xRange rangeOfString:@"-"].location == NSNotFound) {
                // only 1 value
                tileMinX = tileMaxX = [xRange intValue];
            } else {
                // multiple values
                NSArray * xArray = [xRange componentsSeparatedByString:@"-"];
                tileMinX = [[xArray objectAtIndex:0] intValue];
                tileMaxX = [[xArray objectAtIndex:1] intValue];
            }
            
            if ([yRange rangeOfString:@"-"].location == NSNotFound) {
                // only 1 value
                tileMinY = tileMaxY = [yRange intValue];
            } else {
                // multiple values
                NSArray * yArray = [yRange componentsSeparatedByString:@"-"];
                tileMinY = [[yArray objectAtIndex:0] intValue];
                tileMaxY = [[yArray objectAtIndex:1] intValue];
            }
            
            
            for (int tx = tileMinX; tx <= tileMaxX; tx++) {
                for (int ty = tileMinY; ty <= tileMaxY; ty++) {
                    if (!isAnimated) {
                        [self addSprite:tileName atTileCoords:CGPointMake(tx,ty) inFrontOfPlayer:false];
                    } else {
                        [self addAnimatedSprite:animatedTileNames atTileCoords:CGPointMake(tx, ty) inFrontOfPlayer:false delay:animationDelay];
                    }
                    
                }
            }
            
        }
    }
    
    //WorldObject * temp = [[WorldObject alloc] initWithTile:@"bath_13.png" atTilePosition:CGPointMake(3, 3)];
    //[[GameData instance]._worldObjects addObject: temp];
    //[self addChild:temp z:Z_BELOW_PLAYER];
    
    
    GameAction * firstAction = [[ActionDelay alloc] initWithDelay:60];
    GameAction * secondAction = [[ActionDialogue alloc] initWithDialogue:@"Enabled Coat"];
    GameAction * thirdAction = [[ActionTap alloc] initWithID:1 active:false];
    GameAction * fourthAction = [[ActionTap alloc] initWithID:2 active:true];
    
    NSArray * mirrorActions = [NSArray arrayWithObjects: thirdAction, firstAction, secondAction, fourthAction,nil];
    
    
    Tappable * mirrorTap = [[Tappable alloc] initWithPosition:ccp(8,4) withActions:mirrorActions withIdentity:1];
    [self addChild:[mirrorTap getGlow] z:Z_BELOW_PLAYER];
    [[GameData instance]._worldTappables addObject: mirrorTap];
    
    
    
    
    GameAction * firstAction2 = [[ActionDialogue alloc] initWithDialogue:@"Enabled Mirror"];
    GameAction * secondAction2 = [[ActionTap alloc] initWithID:2 active:false];
    GameAction * thirdAction2 = [[ActionTap alloc] initWithID:1 active:true];
    GameAction * fourthAction2 = [[ActionTrig alloc] initWithID:9 active:true];
    
    NSArray * coatActions = [NSArray arrayWithObjects: secondAction2, firstAction2, thirdAction2, fourthAction2, nil];
    
    Tappable * coatTap = [[Tappable alloc] initWithPosition:ccp(2,2) withActions:coatActions withIdentity:2 isEnabled:false];
    [self addChild:[coatTap getGlow] z:Z_BELOW_PLAYER];
    [[GameData instance]._worldTappables addObject:coatTap];
    
    
    
    GameAction * trigAct1 = [[ActionTrig alloc] initWithID:9 active:false];    
    GameAction * trigAct2 = [[ActionDialogue alloc] initWithDialogue:@"Triggered!"];
    
    NSArray * bloodActions = [NSArray arrayWithObjects: trigAct1, trigAct2, nil];
    
    Triggerable * bloodTrig = [[Triggerable alloc] initWithPosition:ccp(5,2) withActions:bloodActions withIdentity:9];
    [self addChild:[bloodTrig getGlow] z:Z_BELOW_PLAYER];
    [[GameData instance]._worldTriggerables addObject:bloodTrig];
    
    //Load each world object in
    // For each world object, check for prior history
    
}

-(void) addAnimatedSprite:(NSArray *) animatedSpriteFrames atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop {
    [self addAnimatedSprite:animatedSpriteFrames atTileCoords:pt inFrontOfPlayer:ifop delay:DEFAULTANIMATIONDELAY];
}

-(void) addAnimatedSprite:(NSArray *) spriteFrames atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop delay:(float) d {
    CCSprite * sprite = [CCSprite spriteWithSpriteFrameName:[spriteFrames objectAtIndex:0]];
    [sprite setScale:2];
    [sprite setPosition:CGPointMake((pt.x-1) * 20 * 2 + 20, (pt.y-1) * 20 * 2 + 20)];
    if (ifop) [sprite setZOrder:Z_IN_FRONT_OF_PLAYER];
    else [sprite setZOrder:Z_BELOW_PLAYER];
    [[sprite texture] setAliasTexParameters];
    
    NSMutableArray * animFrames = [[NSMutableArray alloc] init];
    
    for (NSString * animatedFrame in spriteFrames) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:animatedFrame];
        [animFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:d];
    [sprite runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation] ]];
    
    
    [backgroundBatchNode addChild:sprite];
    
    int wtX = pt.x - 1;
    int wtY = pt.y - 1;
    
    [((WorldTile *)worldTiles[wtX][wtY]) addSprite:sprite];
    
    if (sprite.position.x>[player getPosition].x + 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    else if (sprite.position.x<[player getPosition].x - 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
}

-(void) addSprite:(NSString *) s atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop {
    CCSprite * sprite = [CCSprite spriteWithSpriteFrameName:s];
    [sprite setScale:2];
    [sprite setPosition:CGPointMake((pt.x-1) * 20 * 2 + 20, (pt.y-1) * 20 * 2 + 20)];
    if (ifop) [sprite setZOrder:Z_IN_FRONT_OF_PLAYER];
    else [sprite setZOrder:Z_BELOW_PLAYER];
    [[sprite texture] setAliasTexParameters];
    
    [backgroundBatchNode addChild:sprite];
    
    int wtX = pt.x - 1;
    int wtY = pt.y - 1;
    
    [((WorldTile *)worldTiles[wtX][wtY]) addSprite:sprite];
    
    if (sprite.position.x>[player getPosition].x + 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    else if (sprite.position.x<[player getPosition].x - 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    
}

-(void) tick:(ccTime) dt {
    if (gd._playerHoldingLeft) {
        [player attemptMoveInDirection:LEFT];
    } else if (gd._playerHoldingRight) {
        [player attemptMoveInDirection:RIGHT];
    } else [player attemptNoMove];
    
    [self updateCamera];
}

-(void) updateCamera {
    CGPoint centerOfView = ccp(480.0/2,320.0/2);
    CGPoint viewPoint = ccpSub(centerOfView, self.position);
    
    [GameData instance]._cameraPosition = self.position
    = CGPointMake(240 - [player getPosition].x,self.position.y);
    
    // Determine what tile the camera is at
    // If that is different than old camera tile pos, make one col visible and one not
    if (cameraFocusedOnTile != ((int)(viewPoint.x/40))) {
        //Log(@"Updating tile visibility:%d vs %d", cameraFocusedOnTile, (int)(viewPoint.x/40));
        [self updateTileVisibility];
    }
}

-(void) updateTileVisibility {
    int tilesToRenderFromCam = 7;
    
    CGPoint centerOfView = ccp(480.0/2,320.0/2);
    CGPoint viewPoint = ccpSub(centerOfView, self.position);
    int newCameraTilePos = viewPoint.x/40;
    if (newCameraTilePos>cameraFocusedOnTile) {
        // add to right, remove from left
        for (int i = 0; i < WORLDTILES_Y; i++) {
            if (cameraFocusedOnTile+tilesToRenderFromCam >= 0 && cameraFocusedOnTile+tilesToRenderFromCam < WORLDTILES_X)
                //((CCSprite *)worldTiles[cameraFocusedOnTile+7][i]).visible = true;
                [((WorldTile *)worldTiles[cameraFocusedOnTile+tilesToRenderFromCam][i]) setVisible:true];
            
            if (cameraFocusedOnTile-tilesToRenderFromCam >= 0 && cameraFocusedOnTile-tilesToRenderFromCam < WORLDTILES_X)
                [((WorldTile *)worldTiles[cameraFocusedOnTile-tilesToRenderFromCam][i]) setVisible:false];
        }
    } else {
        // add to left, remove from right
        for (int i = 0; i < WORLDTILES_Y; i++) {
            if (cameraFocusedOnTile+tilesToRenderFromCam >= 0 && cameraFocusedOnTile+tilesToRenderFromCam < WORLDTILES_X)
                [((WorldTile *)worldTiles[cameraFocusedOnTile+tilesToRenderFromCam][i]) setVisible:false];
            
            if (cameraFocusedOnTile-tilesToRenderFromCam >= 0 && cameraFocusedOnTile-tilesToRenderFromCam < WORLDTILES_X)
                [((WorldTile *)worldTiles[cameraFocusedOnTile-tilesToRenderFromCam][i]) setVisible:true];
        }
    }
    cameraFocusedOnTile = newCameraTilePos;
    //Log(@"camera position = %d",cameraTilePos);
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint worldLocation = [Logic worldPositionFromTap:location];
    CGPoint tileLocation = CGPointMake((int)worldLocation.x/40 + 1, (int)worldLocation.y/40 + 1);
    
    [(Engine *) self.parent handleTileTapAt:tileLocation];
}

-(void) dealloc {
    Log(@"dealloc called");
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            [(WorldTile *)worldTiles[i][j] release];
        }
    }
    
    [player release];
    [spawnPositions release];
    [super dealloc];
}

@end
