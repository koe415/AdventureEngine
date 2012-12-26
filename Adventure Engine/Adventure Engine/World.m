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
    
    cameraFocusedOnTile = 3;
        
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            WorldTile * wt = [[WorldTile alloc] init];
            worldTiles[i][j] = wt;
        }
    }
    
    player = [CCSprite spriteWithFile:@"player.png"];
    [player setScale:4];
    [player setPosition:CGPointMake(240, 100)];
    [[player texture] setAliasTexParameters];
    [player setZOrder:Z_PLAYER];
    
    [self addChild:player];
    
    [self setupWorld:@""];
    
    return self;
}

-(void) clearWorld {
    
}

-(void) setupWorld:(NSString *) worldToLoad {
    [self clearWorld];
    
    // For each tile in world array
    // find x, find y, z-layer placement
    // add sprite with filename
    
    
    for (int i = 1; i <= WORLDTILES_X; i++) {
        // Handles 148 sprites flawlessly
        // Minimum of 40 running for background
        [self addSprite:@"40x40_set_01.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:false];
        [self addSprite:@"40x40_set_02.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:false];
        [self addSprite:@"40x40_set_03.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:false];
        [self addSprite:@"40x40_set_04.png" atTileCoords:CGPointMake(i, 1) inFrontOfPlayer:false];
    }
    
    [self addSprite:@"40x40_rail_02.png" atTileCoords:CGPointMake(3, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(4, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(5, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_02.png" atTileCoords:CGPointMake(6, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_03.png" atTileCoords:CGPointMake(7, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_03.png" atTileCoords:CGPointMake(8, 1) inFrontOfPlayer:true];
    
    [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(10, 1) inFrontOfPlayer:true];
    [self addSprite:@"40x40_rail_01.png" atTileCoords:CGPointMake(11, 1) inFrontOfPlayer:true];
    
    [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(5, 2) inFrontOfPlayer:false];
    [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(6, 2) inFrontOfPlayer:false];
    [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(10, 2) inFrontOfPlayer:false];
    
    NSArray * animatedComp = [[NSArray alloc] initWithObjects:@"40x40_wallcomp_01.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_03.png",nil];
    
    [self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(5,2) inFrontOfPlayer:false];
    [self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(6,2) inFrontOfPlayer:false];
    [self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(10,2) inFrontOfPlayer:false];
    
    [self addSprite:@"decal_patterson_1.png" atTileCoords:CGPointMake(5, 3) inFrontOfPlayer:false];
    [self addSprite:@"decal_patterson_2.png" atTileCoords:CGPointMake(6, 3) inFrontOfPlayer:false];
    
    /*
    NSArray * animatedDoorTop = [[NSArray alloc] initWithObjects:@"40x80_door_top_1.png",
                                 @"40x80_door_top_2.png",
                                 @"40x80_door_top_3.png",
                                 @"40x80_door_top_4.png",
                                 @"40x80_door_top_5.png",
                                 @"40x80_door_top_6.png",
                                 @"40x80_door_top_7.png",
                                 @"40x80_door_top_8.png",
                                 nil];
    
    NSArray * animatedDoorMiddle = [[NSArray alloc] initWithObjects:@"40x80_door_middle_1.png",
                                    @"40x80_door_middle_2.png",
                                    @"40x80_door_middle_3.png",
                                    @"40x80_door_middle_4.png",
                                    @"40x80_door_middle_5.png",
                                    @"40x80_door_middle_6.png",
                                    @"40x80_door_middle_7.png",
                                    @"40x80_door_middle_8.png",
                                    nil];
    
        NSArray * animatedDoorBottom = [[NSArray alloc] initWithObjects:@"40x80_door_bottom_1.png",
                                        @"40x80_door_bottom_2.png",
                                        @"40x80_door_bottom_3.png",
                                        @"40x80_door_bottom_4.png",
                                        @"40x80_door_bottom_5.png",
                                        @"40x80_door_bottom_6.png",
                                        @"40x80_door_bottom_7.png",
                                        @"40x80_door_bottom_8.png",
                                        nil];
    
    [self addAnimatedSprite:animatedDoorBottom atTileCoords:CGPointMake(2,1) inFrontOfPlayer:false];
    [self addAnimatedSprite:animatedDoorMiddle atTileCoords:CGPointMake(2,2) inFrontOfPlayer:false];
    [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(2,3) inFrontOfPlayer:false];
    */
    
    // For each decal
    // find actual x, y
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
    
    if (animatedSprite.position.x>520) {
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    }
}

-(void) addSprite:(NSString *) s atTileCoords:(CGPoint) pt inFrontOfPlayer:(bool) ifop {
    CCSprite * sprite = [CCSprite spriteWithFile:s];
    [sprite setScale:2];
    [sprite setPosition:CGPointMake((pt.x-1) * 40 * 2 + 40, (pt.y-1) * 40 * 2 + 40)];
    if (ifop) [sprite setZOrder:Z_IN_FRONT_OF_PLAYER];
    else [sprite setZOrder:Z_BELOW_PLAYER];
    [[sprite texture] setAliasTexParameters];
    
    [self addChild:sprite];
    
    int wtX = pt.x - 1;
    int wtY = pt.y - 1;
    
    [((WorldTile *)worldTiles[wtX][wtY]) addSprite:sprite];
    
    if (sprite.position.x>520) {
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    }
    
}

-(void) tick:(ccTime) dt {
    if (gd._playerMovingLeft) {
        [player setPosition:CGPointMake(player.position.x-2, player.position.y)];
    } else if (gd._playerMovingRight) {
        [player setPosition:CGPointMake(player.position.x+2, player.position.y)];
    }
    
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
    
    float distBetweenCamAndPlayer = player.position.x - viewPoint.x;
    
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
    }
    
    // Determine what tile the camera is at
    // If that is different than old camera tile pos, make one col visible and one not
    if (cameraFocusedOnTile != ((int)(viewPoint.x/80))) {
        //Log(@"Updating tile visibility:%d vs %d", cameraFocusedOnTile, (int)(viewPoint.x/40));
        [self updateTileVisibility];
    }
}

-(void) updateTileVisibility {
    int tilesToRenderFromCam = 4;
    
    CGPoint centerOfView = ccp(480.0/2,320.0/2);
    CGPoint viewPoint = ccpSub(centerOfView, self.position);
    int newCameraTilePos = viewPoint.x/80;
    if (newCameraTilePos>cameraFocusedOnTile) {
        // add to right, remove from left
        for (int i = 0; i < WORLDTILES_Y; i++) {
            if (cameraFocusedOnTile+tilesToRenderFromCam > 0 && cameraFocusedOnTile+tilesToRenderFromCam < WORLDTILES_X)
                //((CCSprite *)worldTiles[cameraFocusedOnTile+7][i]).visible = true;
                [((WorldTile *)worldTiles[cameraFocusedOnTile+tilesToRenderFromCam][i]) setVisible:true];
            
            if (cameraFocusedOnTile-tilesToRenderFromCam > 0 && cameraFocusedOnTile-tilesToRenderFromCam < WORLDTILES_X)
                [((WorldTile *)worldTiles[cameraFocusedOnTile-tilesToRenderFromCam][i]) setVisible:false];
        }
    } else {
        // add to left, remove from right
        for (int i = 0; i < WORLDTILES_Y; i++) {
            if (cameraFocusedOnTile+tilesToRenderFromCam > 0 && cameraFocusedOnTile+tilesToRenderFromCam < WORLDTILES_X)
                [((WorldTile *)worldTiles[cameraFocusedOnTile+tilesToRenderFromCam][i]) setVisible:false];
            
            if (cameraFocusedOnTile-tilesToRenderFromCam > 0 && cameraFocusedOnTile-tilesToRenderFromCam < WORLDTILES_X)
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
    //Log(@"bottom layer recognized touch begin");
    //if (gd._pausePressed) NSLog(@"Tap Ignored");
    //Log(@"Tap recognized at bottom layer!");
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //Log(@"bottom layer recognized touch end");
}


@end
