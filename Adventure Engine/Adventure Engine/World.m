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
    
    /*
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"wallSet.plist"];
    
    backgroundBatchNode = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"wallSet.png"];
    
    [self addChild:backgroundBatchNode z:Z_BELOW_PLAYER];
    */
    //for (int i = 1; i <= WORLDTILES_X; i++) {
        // Handles 148 sprites flawlessly
        // Minimum of 40 running for background
      //  if (i != 12 && i != 13) {
            /*[self addSprite:@"40x40_set_01.png" atTileCoords:CGPointMake(i, 8) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_03.png" atTileCoords:CGPointMake(i, 7) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_05.png" atTileCoords:CGPointMake(i, 6) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_07.png" atTileCoords:CGPointMake(i, 5) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_09.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_11.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_13.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_15.png" atTileCoords:CGPointMake(i, 1) inFrontOfPlayer:false];*/
            /*
            [self addSprite:@"40x40_set_01.png" atTileCoords:CGPointMake(i*2+1, 8) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_04.png" atTileCoords:CGPointMake(i*2+1, 7) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_06.png" atTileCoords:CGPointMake(i*2+1, 6) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_08.png" atTileCoords:CGPointMake(i*2+1, 5) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_10.png" atTileCoords:CGPointMake(i*2+1, 4) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_12.png" atTileCoords:CGPointMake(i*2+1, 3) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_14.png" atTileCoords:CGPointMake(i*2+1, 2) inFrontOfPlayer:false];
            [self addSprite:@"40x40_set_15.png" atTileCoords:CGPointMake(i*2+1, 1) inFrontOfPlayer:false];
            */
            /*      
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 1) inFrontOfPlayer:true];
             
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 1) inFrontOfPlayer:true];
             */
            /*
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:true];
             [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(i, 1) inFrontOfPlayer:true];
             */
      //  }
    //}
    
    //[self addSprite:@"40x40_rail_02.png" atTileCoords:CGPointMake(3, 1) inFrontOfPlayer:true];
    //[self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(4, 1) inFrontOfPlayer:true];
    //[self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(5, 1) inFrontOfPlayer:true];
    //[self addSprite:@"40x40_rail_02.png" atTileCoords:CGPointMake(6, 1) inFrontOfPlayer:true];
    //[self addSprite:@"40x40_rail_03.png" atTileCoords:CGPointMake(7, 1) inFrontOfPlayer:true];
    //[self addSprite:@"40x40_rail_03.png" atTileCoords:CGPointMake(8, 1) inFrontOfPlayer:true];
    
    /*
     [self addSprite:@"40x40_rail_04.png" atTileCoords:CGPointMake(10, 1) inFrontOfPlayer:true];
     [self addSprite:@"40x40_rail_01.png" atTileCoords:CGPointMake(11, 1) inFrontOfPlayer:true];
     
     [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(5, 2) inFrontOfPlayer:false];
     [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(6, 2) inFrontOfPlayer:false];
     [self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(10, 2) inFrontOfPlayer:false];
     */
    
    /*
    NSArray * animatedComp = [[NSArray alloc] initWithObjects:@"40x40_wallcomp_01.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_02.png",
                              @"40x40_wallcomp_03.png",nil];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"wallcomp.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"wallcomp.png"];
    
    [self addChild:spriteSheet z:Z_BELOW_PLAYER];
    for (int t = 0; t < 8; t++) {
    for (int s = 0; s < 40; s++) {
        NSString * firstString = (NSString *)  [animatedComp objectAtIndex:0];
        CCSprite * wallComp = [CCSprite spriteWithSpriteFrameName:firstString];
        [wallComp setPosition:CGPointMake(20 * s, 20 * t)];
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
    }
    }*/
    
    //for (int i = 1; i < 6; i++) {
        //[self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(i,1) inFrontOfPlayer:false];
        //[self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(i,2) inFrontOfPlayer:false];
        //[self addSprite:@"40x40_wallcomp_04.png" atTileCoords:CGPointMake(i,3) inFrontOfPlayer:false];
        //[self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(i,1) inFrontOfPlayer:false];
        //[self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(i,2) inFrontOfPlayer:false];
        //[self addAnimatedSprite:animatedComp atTileCoords:CGPointMake(i,3) inFrontOfPlayer:false];
    //}
    /*
    [self addSprite:@"decal_patterson_1.png" atTileCoords:CGPointMake(3, 3) inFrontOfPlayer:false];
    [self addSprite:@"decal_patterson_2.png" atTileCoords:CGPointMake(4, 3) inFrontOfPlayer:false];
    
    [self addSprite:@"decal_patterson_1.png" atTileCoords:CGPointMake(7, 3) inFrontOfPlayer:false];
    [self addSprite:@"decal_patterson_2.png" atTileCoords:CGPointMake(8, 3) inFrontOfPlayer:false];
    
    
    [self addSprite:@"40x40_boxes_03.png" atTileCoords:CGPointMake(3, 1) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_04.png" atTileCoords:CGPointMake(3, 1) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_04.png" atTileCoords:CGPointMake(5, 1) inFrontOfPlayer:false];
    
    [self addSprite:@"40x40_boxes_01.png" atTileCoords:CGPointMake(9, 2) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_02.png" atTileCoords:CGPointMake(9, 1) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_01.png" atTileCoords:CGPointMake(9, 3) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_02.png" atTileCoords:CGPointMake(9, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"40x40_boxes_01.png" atTileCoords:CGPointMake(10, 2) inFrontOfPlayer:false];
    [self addSprite:@"40x40_boxes_02.png" atTileCoords:CGPointMake(10, 1) inFrontOfPlayer:false];
    */
    
    
    /*
     for (int i = 1; i <= WORLDTILES_Y; i++) {
     [self addSprite:@"40x40_fg_wires_01.png" atTileCoords:CGPointMake(1, i) inFrontOfPlayer:true];
     [self addSprite:@"40x40_fg_wires_02.png" atTileCoords:CGPointMake(3, i) inFrontOfPlayer:true];
     [self addSprite:@"40x40_fg_wires_02.png" atTileCoords:CGPointMake(5, i) inFrontOfPlayer:true];
     [self addSprite:@"40x40_fg_wires_03.png" atTileCoords:CGPointMake(6, i) inFrontOfPlayer:true];
     [self addSprite:@"40x40_fg_wires_04.png" atTileCoords:CGPointMake(8, i) inFrontOfPlayer:true];
     [self addSprite:@"40x40_fg_wires_03.png" atTileCoords:CGPointMake(10, i) inFrontOfPlayer:true];
     }*/
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
     
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(2,1) inFrontOfPlayer:false];
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(2,2) inFrontOfPlayer:false];
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(2,3) inFrontOfPlayer:false];
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(3,1) inFrontOfPlayer:false];
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(3,2) inFrontOfPlayer:false];
     [self addAnimatedSprite:animatedDoorTop atTileCoords:CGPointMake(3,3) inFrontOfPlayer:false];*/
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
      @"20x20_bath.plist"];
    
    backgroundBatchNode = [CCSpriteBatchNode 
                           batchNodeWithFile:@"20x20_bath.png"];
    
    [self addChild:backgroundBatchNode z:Z_BELOW_PLAYER];
    
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(1, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(1, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(1, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(1, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(2, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(2, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(2, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(2, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(3, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(3, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(3, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_01.png" atTileCoords:CGPointMake(3, 5) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_14.png" atTileCoords:CGPointMake(1, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_14.png" atTileCoords:CGPointMake(2, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_14.png" atTileCoords:CGPointMake(3, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_15.png" atTileCoords:CGPointMake(1, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_15.png" atTileCoords:CGPointMake(1, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_15.png" atTileCoords:CGPointMake(1, 4) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_81.png" atTileCoords:CGPointMake(1, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_82.png" atTileCoords:CGPointMake(2, 2) inFrontOfPlayer:false];
    
    for (int i = 4; i < 14; i++) {
        [self addSprite:@"20x20_set_22.png" atTileCoords:CGPointMake(i, 2) inFrontOfPlayer:false];
        [self addSprite:@"20x20_set_22.png" atTileCoords:CGPointMake(i, 3) inFrontOfPlayer:false];
        
        [self addSprite:@"20x20_set_32.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:false];
        [self addSprite:@"20x20_set_32.png" atTileCoords:CGPointMake(i, 5) inFrontOfPlayer:false];
        [self addSprite:@"20x20_set_32.png" atTileCoords:CGPointMake(i, 6) inFrontOfPlayer:false];
        
        [self addSprite:@"20x20_set_23.png" atTileCoords:CGPointMake(i, 4) inFrontOfPlayer:false];
    }
    
    [self addSprite:@"20x20_set_02.png" atTileCoords:CGPointMake(2, 3) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_13.png" atTileCoords:CGPointMake(3, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_13.png" atTileCoords:CGPointMake(3, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_13.png" atTileCoords:CGPointMake(3, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_13.png" atTileCoords:CGPointMake(3, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_11.png" atTileCoords:CGPointMake(3, 5) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_12.png" atTileCoords:CGPointMake(2, 5) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_43.png" atTileCoords:CGPointMake(1, 5) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_44.png" atTileCoords:CGPointMake(4, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_45.png" atTileCoords:CGPointMake(4, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_21.png" atTileCoords:CGPointMake(5, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_31.png" atTileCoords:CGPointMake(5, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_53.png" atTileCoords:CGPointMake(4, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_54.png" atTileCoords:CGPointMake(5, 4) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_41.png" atTileCoords:CGPointMake(6, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_42.png" atTileCoords:CGPointMake(7, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_34.png" atTileCoords:CGPointMake(6, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_35.png" atTileCoords:CGPointMake(7, 3) inFrontOfPlayer:false];
    
    
    
    [self addSprite:@"20x20_set_24.png" atTileCoords:CGPointMake(8, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_25.png" atTileCoords:CGPointMake(9, 5) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_51.png" atTileCoords:CGPointMake(8, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_52.png" atTileCoords:CGPointMake(9, 4) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_61.png" atTileCoords:CGPointMake(8, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_62.png" atTileCoords:CGPointMake(9, 3) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_71.png" atTileCoords:CGPointMake(8, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_72.png" atTileCoords:CGPointMake(9, 2) inFrontOfPlayer:false];
    
    [self addSprite:@"20x20_set_03.png" atTileCoords:CGPointMake(4, 6) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_04.png" atTileCoords:CGPointMake(13, 6) inFrontOfPlayer:false];
    
    
    [self addSprite:@"20x20_set_63.png" atTileCoords:CGPointMake(11, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_64.png" atTileCoords:CGPointMake(12, 5) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_73.png" atTileCoords:CGPointMake(11, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_74.png" atTileCoords:CGPointMake(12, 4) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_83.png" atTileCoords:CGPointMake(11, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_84.png" atTileCoords:CGPointMake(12, 3) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_93.png" atTileCoords:CGPointMake(11, 2) inFrontOfPlayer:false];
    [self addSprite:@"20x20_set_94.png" atTileCoords:CGPointMake(12, 2) inFrontOfPlayer:false];
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
    
    if (sprite.position.x>520) {
        [((WorldTile *)worldTiles[wtX][wtY]) setVisible:false];
    }
    
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
     }*/
    
    [GameData instance]._cameraPosition = self.position
    = CGPointMake(240 - player.position.x,self.position.y);
    
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
}


@end
