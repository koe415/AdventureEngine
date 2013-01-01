//
//  TestLayerBottom.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"

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
    
    player = [[Player alloc] initAtPosition:CGPointMake(240, 100) facing:RIGHT];    
    [self addChild:player z:Z_PLAYER];
    
    [self setupWorld:@"bath"];
    
    return self;
}

-(void) clearWorld {
    
}

-(void) setupWorld:(NSString *) worldToLoad {
    [self clearWorld];
        
    /*
     NSArray * animatedComp = [[NSArray alloc] initWithObjects:@"40x40_wallcomp_01.png",
     @"40x40_wallcomp_02.png",
     @"40x40_wallcomp_03.png",nil];
     
     [self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(i,3) inFrontOfPlayer:false];
     
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"wallcomp.plist"];
     
     CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
     batchNodeWithFile:@"wallcomp.png"];
     
     [self addChild:spriteSheet z:Z_BELOW_PLAYER];
     
     
     NSString * firstString = (NSString *)  [animatedComp objectAtIndex:0];
     CCSprite * wallComp = [CCSprite spriteWithSpriteFrameName:firstString];
     [wallComp setPosition:CGPointMake(20, 20)];
     [wallComp setScale:2.0f];
     
     NSMutableArray * animFrames = [[NSMutableArray alloc] init];
     
     for (int i = 1; i < 4; i++) {
     CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"40x40_wallcomp_0%d.png",i]];
     [animFrames addObject:frame];
     }
     
     CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
     [wallComp runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation] ]];
     
     [[wallComp texture] setAliasTexParameters];
     
     [spriteSheet addChild:wallComp];
     */
    
    /*
    NSMutableArray * animFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"40x40_wallcomp_0%d.png",i]];
        [animFrames addObject:frame];
    }*/
    
    //CCSprite * s;
    //CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
    //[s runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation] ]];
    
    // For each world set, need:
    //   - area name (ie. "bath") used for plist and spritesheet png
    //   - tile (filename and cgpoint)
    
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
    
    for (NSString * s in contentsArray) {
        if ([s hasPrefix:@"info:"]) {
            Log(@"found info, parsing it now");
            
        } else {
            NSArray * tileArray = [s componentsSeparatedByString:@","];
            NSString * tileName = [NSString stringWithFormat:@"%@_%@.png",worldToLoad,[tileArray objectAtIndex:0]];
            
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
                    [self addSprite:tileName atTileCoords:CGPointMake(tx,ty) inFrontOfPlayer:false];
                }
            }
        
        }
    }
    
}

-(void) addAnimatedSprite:(NSArray *) stringArray atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop {
    
    CCAnimatedSprite * animatedSprite = [[CCAnimatedSprite alloc] initWithArray:stringArray];
    [animatedSprite setScale:2];
    [animatedSprite setPosition:CGPointMake((pt.x-1) * 40 * 2 + 40, (pt.y-1) * 40 * 2 + 40)];
    if (ifop) [animatedSprite setZOrder:Z_IN_FRONT_OF_PLAYER];
    else [animatedSprite setZOrder:Z_BELOW_PLAYER];
    [[animatedSprite texture] setAliasTexParameters];
    
    [self addChild:animatedSprite];
    
    int wtX = pt.x - 1;
    int wtY = pt.y - 1;
    
    [((WorldTile *)worldTiles[wtX][wtY]) addAnimatedSprite:animatedSprite];
    
    if (animatedSprite.position.x>[player getPosition].x + 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    else if (animatedSprite.position.x<[player getPosition].x - 260) 
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];}

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
    
    
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            if ([(WorldTile *)worldTiles[i][j] hasAnimatedSprites]) {
                [(WorldTile *)worldTiles[i][j] update];
            }
        }
    }
}

-(void) updateCamera {
    
    CGPoint centerOfView = ccp(480.0/2,320.0/2);
    CGPoint viewPoint = ccpSub(centerOfView, self.position);
    /*
     float distBetweenCamAndPlayer = [player getPosition].x - viewPoint.x;
     
     bool isNegative = false;
     if (distBetweenCamAndPlayer<0) {
     distBetweenCamAndPlayer *= -1.0f;
     isNegative = true;
     }
     
     if (distBetweenCamAndPlayer > 50) {
     if (!isNegative) {
     distBetweenCamAndPlayer*=-1.0f;
     }
     
     [GameData instance]._cameraPosition = self.position
     = CGPointMake(self.position.x + (distBetweenCamAndPlayer/70.0f),self.position.y);
     }*/
    
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

/**
 * Need to recognize which tile accepted the tap,
 * then determine if trigger is at tile
 **/
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //Log(@"bottom layer recognized touch begin");
    //if (gd._pausePressed) NSLog(@"Tap Ignored");
    //Log(@"Tap recognized at bottom layer!");
    
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //Log(@"bottom layer recognized touch end");
    
    CGPoint location = [touch locationInView:[touch view]];
    
    CGPoint worldLocation = [Logic worldPositionFromTap:location];
    
    //Log(@"Tapped at world location:(%.0f,%.0f)",worldLocation.x,worldLocation.y);
    
    CGPoint tileLocation = CGPointMake((int)worldLocation.x/40 + 1, (int)worldLocation.y/40 + 1);
    
    Log(@"Tapped at tile location:(%.0f,%.0f)",tileLocation.x,tileLocation.y);
    
    //[Logic handleTapAt:tileLocation];
    [(Engine *) self.parent handleTileTapAt:tileLocation];
    
    //[((WorldTile *)worldTiles[(int)(tileLocation.x-1)][(int)(tileLocation.y-1)]) setVisible:false];
    
    // check for note at location
    // if yes
    // signal hud to show note (move from bottom of screen, fade move bars)
    // wait for tap again
    // if there is more note, show note
    // else disappear note, resume gameplay (move back to bottom of screen, fade move bars back)
    
}


@end
