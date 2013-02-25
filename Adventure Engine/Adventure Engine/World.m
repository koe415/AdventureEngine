//
//  World.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
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
    
    creatureManager = [[CreatureManager alloc] init];
    [self addChild:creatureManager z:Z_PLAYER];
    
    player = [[Player alloc] init];
    [self addChild:player z:Z_PLAYER];
    
    gameActionsLoaded = [[NSMutableArray alloc] init];
    
    //[self runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:5 angle:15],[CCRotateBy actionWithDuration:4 angle:-15], nil]]];
    return self;
}

// Called when loading a world or when scene is switched
-(void) clearWorld {
    //Log(@"clearing world");
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            [(WorldTile *)worldTiles[i][j] removeAllSprites];
            [(WorldTile *)worldTiles[i][j] setVisible:true];
        }
    }
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [backgroundBatchNode removeFromParentAndCleanup:true];
    [worldObjectsBatchNode removeFromParentAndCleanup:true];
    [gameActionsLoaded removeAllObjects];
    [creatureManager clear];
    
    [[GameData instance] clearWorld];
}

// Defaults to the first spawn available
-(void) loadWorld:(NSString *) worldToLoad {
    [self loadWorld:worldToLoad withSpawn:1];
}

// Spawn Points increment from 1 and up
-(void) loadWorld:(NSString *) worldToLoad withSpawn:(int) playerSpawnPt {
    [self clearWorld];
    
    NSError * error;
    NSString * contents = [NSString stringWithContentsOfFile:
                           [[NSBundle mainBundle] pathForResource:worldToLoad ofType:@"txt"]
                                                    encoding:NSUTF8StringEncoding
                                                       error:&error];
    
    NSAssert2(contents, @"Loading %@ produced error:%@", worldToLoad,[error localizedDescription]);
    
    NSArray * contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    int spawnPtID = 0;
    
    for (NSString * s in contentsArray) {
        s = [s stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([s length] == 0) {
            // Disregard white space!
        } else if ([s hasPrefix:@"//"]) {
            // Disregard notes!
        } else if ([s hasPrefix:@"#end"]) {
            // Debug: Premature end to file stream
            break;
        } else if ([s hasPrefix:@"info"]) {
            [self parseInfo: [s substringFromIndex:5]];
        } else if ([s hasPrefix:@"spawn"]) {
            spawnPtID++;
            // Only parse if player spawn, no reason to store points otherwise
            if (spawnPtID==playerSpawnPt)
                [self parseSpawnPoint: [s substringFromIndex:6]];
        } else if ([s hasPrefix:@"tile"]) {
            [self parseTile: [s substringFromIndex:5]];
        } else if ([s hasPrefix:@"barrier"]) {
            [self parseBarrier: [s substringFromIndex:8]];
        } else if ([s hasPrefix:@"object"]) {
            [self parseWorldObject:[s substringFromIndex:7]];
        } else if ([s hasPrefix:@"action"]) {
            [self parseGameAction:[s substringFromIndex:7]];
        } else if ([s hasPrefix:@"tap"]) {
            [self parseTappable:[s substringFromIndex:4]];
        } else if ([s hasPrefix:@"trig"]) {
            [self parseTriggerable:[s substringFromIndex:5]];
        } else if ([s hasPrefix:@"creature:"]) {
            [self parseCreature:[s substringFromIndex:9]];
        } else {
            NSAssert1(false, @"Line not recognized:%@",s);
        }
    }
    
    NSAssert(spawnPtID>0, @"Spawn Point not provided in world load");
}

-(void) parseInfo:(NSString *) inputString {
    NSArray * inputInfo = [inputString componentsSeparatedByString:@","];
    
    NSString * leftBarrierString = [inputInfo objectAtIndex:0];
    Barrier * leftWorldBoundary = [Barrier barrierWithPosition:[leftBarrierString floatValue] withID:@"left_boundary"];
    [leftWorldBoundary setEnabled:true];
    if (Display_Barriers) [self addChild:[leftWorldBoundary getVisual] z:Z_BELOW_PLAYER];
    
    
    NSString * rightBarrierString = [inputInfo objectAtIndex:1];
    Barrier * rightWorldBoundary = [Barrier barrierWithPosition:[rightBarrierString floatValue] withID:@"left_boundary"];
    [rightWorldBoundary setEnabled:true];
    if (Display_Barriers) [self addChild:[rightWorldBoundary getVisual] z:Z_BELOW_PLAYER];
    
    
    tileSpriteSheet = [inputInfo objectAtIndex:2];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"%@.plist",tileSpriteSheet]];
    
    backgroundBatchNode = [CCSpriteBatchNode 
                           batchNodeWithFile:
                           [NSString stringWithFormat:@"%@.png",tileSpriteSheet]];
    
    [self addChild:backgroundBatchNode z:Z_BELOW_PLAYER];
    
    worldObjectSpriteSheet = [inputInfo objectAtIndex:3];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"%@.plist",worldObjectSpriteSheet]];
    
    worldObjectsBatchNode = [CCSpriteBatchNode 
                             batchNodeWithFile:
                             [NSString stringWithFormat:@"%@.png",worldObjectSpriteSheet]];
    
    [self addChild:worldObjectsBatchNode z:Z_BELOW_PLAYER];
}

-(void) parseSpawnPoint:(NSString *) inputString {
    NSArray * spawnInfo = [inputString componentsSeparatedByString:@","];
    
    int spawnX = [[spawnInfo objectAtIndex:0] intValue];
    int spawnY = [[spawnInfo objectAtIndex:1] intValue];
    
    Direction d;
    if ([[spawnInfo objectAtIndex:2] isEqualToString:@"R"]) d = RIGHT;
    else if ([[spawnInfo objectAtIndex:2] isEqualToString:@"L"]) d = LEFT;
    
    NSAssert(d, @"Spawn Point's direction not valid");
    
    [player setPositionManually:CGPointMake(spawnX, spawnY)];
    [player setFacing:d];
    
    cameraCenter = CGPointMake(240 - player.position.x, player.position.y);
}

-(void) parseTile:(NSString *) inputString {
    bool isAnimated = false;
    NSArray * tileArray = [inputString componentsSeparatedByString:@","];
    
    NSString * tileName; // Used only if static
    NSMutableArray * animatedTileNames; // Used only if animated
    float animationDelay; // Used only if animated
    
    if ([[tileArray objectAtIndex:0] rangeOfString:@"-"].location == NSNotFound) {
        tileName = [NSString stringWithFormat:@"%@_%@.png",tileSpriteSheet,[tileArray objectAtIndex:0]];
    } else {
        NSMutableArray * animatedTileNumbers = [NSMutableArray arrayWithArray:[[tileArray objectAtIndex:0] componentsSeparatedByString:@"-"]];
        animatedTileNames = [NSMutableArray array];
        animationDelay = [[animatedTileNumbers objectAtIndex:0] floatValue];
        [animatedTileNumbers removeObjectAtIndex:0];
        
        for (NSString * animatedTileNumber in animatedTileNumbers) {
            [animatedTileNames addObject:[NSString stringWithFormat:@"%@_%@.png",tileSpriteSheet,animatedTileNumber]];
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

-(void) parseBarrier:(NSString *) inputString {
    NSArray * barrierInfo = [inputString componentsSeparatedByString:@","];
    
    float newBarrierPosition = [[barrierInfo objectAtIndex:0] floatValue];
    float newBarrierWidth = [[barrierInfo objectAtIndex:1] floatValue];
    NSString * newBarrierID = [[barrierInfo objectAtIndex:2] retain];
    
    NSNumber * newBarrierEnabled = nil; // Check if barrier is in persistent data, else load default value and add to persistent data(?)

    if (newBarrierEnabled == nil) { // if barrier wasn't found in persistent data
        NSString * newBarrierIsEnabledString = [[barrierInfo objectAtIndex:3] retain];
        if ([newBarrierIsEnabledString isEqualToString:@"enabled"])
            newBarrierEnabled = [NSNumber numberWithBool:YES];
        else newBarrierEnabled = [NSNumber numberWithBool:NO];
    }
    
    Barrier * newBarrier = [Barrier barrierWithPosition:newBarrierPosition withWidth:newBarrierWidth withID:newBarrierID];
    [newBarrier setEnabled:[newBarrierEnabled boolValue]];
    if (Display_Barriers) [self addChild:[newBarrier getVisual] z:Z_BELOW_PLAYER];
}

-(void) parseWorldObject:(NSString *) inputString {
    NSArray * objectComponents = [inputString componentsSeparatedByString:@","];
    
    NSString * objectName = [objectComponents objectAtIndex:0];
    int objectX = [[objectComponents objectAtIndex:1] intValue];
    int objectY = [[objectComponents objectAtIndex:2] intValue];
    
    NSArray * framesInAnimation = [[objectComponents objectAtIndex:3] componentsSeparatedByString:@"-"];
    
    NSMutableArray * idleAnimFrames = [NSMutableArray array];
    
    for (NSString * animatedFrame in framesInAnimation) {
        NSString * currentFrameName = [NSString stringWithFormat:@"%@_%@.png",worldObjectSpriteSheet,animatedFrame];
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:currentFrameName];
        [idleAnimFrames addObject:frame];
    }
    
    CCAnimation *objectIdleAnimation = [CCAnimation animationWithSpriteFrames:idleAnimFrames delay:DEFAULTANIMATIONDELAY];
    objectIdleAnimation.restoreOriginalFrame = true;
    
    WorldObject * object = [WorldObject objectWithPos:ccp(objectX,objectY) withID:objectName withIdle:objectIdleAnimation];
    
    for (int i = 4; i < [objectComponents count]; i++) {
        NSArray * framesInAnimation = [[objectComponents objectAtIndex:i] componentsSeparatedByString:@"-"];
        
        NSMutableArray * animFrames = [NSMutableArray array];
        
        for (NSString * animatedFrame in framesInAnimation) {
            NSString * currentFrameName = [NSString stringWithFormat:@"%@_%@.png",worldObjectSpriteSheet,animatedFrame];
            CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:currentFrameName];
            [animFrames addObject:frame];
        }
        
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:DEFAULTANIMATIONDELAY];
        animation.restoreOriginalFrame = false;
        [object addAnimation:animation];
    }
    
    [worldObjectsBatchNode addChild:object z:Z_BELOW_PLAYER];
}

// TODO: Ugly behemoth within. Should rewrite!
// Switch to switch statement, int given in world file
// pros: efficiency! readability of code!
// cons: zero readability of data file!
-(void) parseGameAction:(NSString *) inputString {
    NSArray * gameActionInfo = [inputString componentsSeparatedByString:@","];
    NSString * actionID = [gameActionInfo objectAtIndex:0];
    NSString * actionType = [gameActionInfo objectAtIndex:1];
    GameAction * newGA;

    // oh glob...its a monster!
    if ([actionType isEqualToString:@"ACTIONDELAY"]) {
        newGA = [ActionDelay actionWithDelay:[[gameActionInfo objectAtIndex:2] intValue]];
    } else if ([actionType isEqualToString:@"ACTIONDIALOGUE"]) {
        newGA = [ActionDialogue actionWithDialogue:[[gameActionInfo objectAtIndex:2] retain]];
    } else if ([actionType isEqualToString:@"ACTIONCUTSCENE"]) {
        newGA = [ActionCutscene actionWithCutscene:[[gameActionInfo objectAtIndex:2] retain]];
    } else if ([actionType isEqualToString:@"ACTIONLOADWORLD"]) {
        newGA = [ActionLoadWorld actionWithWorldToLoad:[[gameActionInfo objectAtIndex:2] retain] atSpawnPoint:[[gameActionInfo objectAtIndex:3] intValue]];
    } else if ([actionType isEqualToString:@"ACTIONPICKUPITEM"]) {
        newGA = [ActionPickupItem actionWithItem:[[gameActionInfo objectAtIndex:2] retain]];
    } else if ([actionType isEqualToString:@"ACTIONREMOVEITEM"]) {
        newGA = [ActionRemoveItem actionWithItem:[[gameActionInfo objectAtIndex:2] retain]];
    } else if ([actionType isEqualToString:@"ACTIONREADABLE"]) {
        newGA = [ActionReadable actionWithReadable:[[gameActionInfo objectAtIndex:2] retain]];
    } else if ([actionType isEqualToString:@"ACTIONENDGAME"]) {
        newGA = [ActionEndGame action];
    } else if ([actionType isEqualToString:@"ACTIONTAP"]) {
        bool isEnabled = [[gameActionInfo objectAtIndex:3] isEqualToString:@"enabled"]? true: false;
        newGA = [ActionTap actionWithID:[[gameActionInfo objectAtIndex:2] intValue] active:isEnabled];
    } else if ([actionType isEqualToString:@"ACTIONTRIG"]) {
        bool isEnabled = [[gameActionInfo objectAtIndex:3] isEqualToString:@"enabled"]? true: false;
        newGA = [ActionTrig actionWithID:[[gameActionInfo objectAtIndex:2] intValue] active:isEnabled];
    } else if ([actionType isEqualToString:@"ACTIONSHAKE"]) {
        newGA = [ActionShake actionWithIntensity:[[gameActionInfo objectAtIndex:2] intValue] withDuration:[[gameActionInfo objectAtIndex:3] intValue]];
    } else if ([actionType isEqualToString:@"ACTIONBARRIER"]) {
        bool isEnabled = [[gameActionInfo objectAtIndex:3] isEqualToString:@"enabled"]? true: false;
        newGA = [ActionBarrier actionWithID:[[gameActionInfo objectAtIndex:2] retain] active:isEnabled];
    } else if ([actionType isEqualToString:@"ACTIONOBJECTVISIBILITY"]) {
        bool isEnabled = [[gameActionInfo objectAtIndex:3] isEqualToString:@"enabled"]? true: false;
        newGA = [ActionObjectVisibility actionWithID:[[gameActionInfo objectAtIndex:2] retain] active:isEnabled];
    } else if ([actionType isEqualToString:@"ACTIONOBJECTANIMATION"]) {
        newGA = [ActionObjectAnimation actionWithID:[[gameActionInfo objectAtIndex:2] retain] running:[[gameActionInfo objectAtIndex:3] intValue]];
    } else if ([actionType isEqualToString:@"ACTIONHISTORY"]) {
        bool isEnabled = [[gameActionInfo objectAtIndex:3] isEqualToString:@"enabled"]? true: false;
        newGA = [ActionHistory actionWithID:[[gameActionInfo objectAtIndex:2] retain] newStatus:isEnabled];
    } else {
        Log(@"what up:%@",actionType);
        [NSException raise:@"Invalid action type value" format:@"%@ is invalid",actionType];
        //NSAssert1(false,@"Didn't recognize action type:%@",actionType);
    }
    
    
    // for each sequence already loaded
    for (GameActionSequence * gas in gameActionsLoaded) {
    //  check if id is already there
        if ([gas compareID:actionID]) {
            //   if so, fucking awesome, add current GA to it
            [gas addGA: newGA];
            return;
        }
    }
    
    GameActionSequence * newSequence = [GameActionSequence sequenceWithID:actionID];
    //   if not, too fucking bad, add a new sequence to it
    [newSequence addGA:newGA];
    [gameActionsLoaded addObject:newSequence];
}

-(void) parseTappable:(NSString *) inputString {
    NSArray * tapInfo = [inputString componentsSeparatedByString:@","];
    
    CGPoint position = ccp([[tapInfo objectAtIndex:0] intValue],[[tapInfo objectAtIndex:1] intValue]);
    CGSize size = CGSizeMake([[tapInfo objectAtIndex:3] intValue],[[tapInfo objectAtIndex:4] intValue]);
    int identity = [[tapInfo objectAtIndex:5] intValue];
    
    NSArray * actions; // Check for previously loaded actions [[inputArray] objectAtIndex:2]
    
    for (GameActionSequence * gas in gameActionsLoaded) {
        if ([gas compareID:[tapInfo objectAtIndex:2]]) {
            actions = [[NSArray alloc] initWithArray:[gas getArray]];
        }
    }
    
    NSAssert([actions count]>0, @"Action Sequence not found to be loaded.");
    
    bool enabled;
/*
    if ([[GameData instance]._encounteredTaps hasValueForID:[NSString stringWithFormat:@"%d",identity]]) {
        enabled = [[GameData instance]._encounteredTaps checkValueForID:[NSString stringWithFormat:@"%d",identity]];
    } else {*/
        NSString * newTappableIsEnabledString = [tapInfo objectAtIndex:6];
        if ([newTappableIsEnabledString isEqualToString:@"enabled"])
            enabled = true;
        else enabled = false;
        
        //[[GameData instance]._encounteredTaps setStatus:enabled forID:[NSString stringWithFormat:@"%d",identity]];
    //}
    
    Tappable * t = [Tappable tappableWithPosition:position withActions:actions withSize:size withIdentity:identity isEnabled:enabled];
    
    // check for prereqs
    if ([tapInfo count]>7) {
        NSString * prereq = [[tapInfo objectAtIndex:7] retain];
        NSString * actionsWithoutPrereq = [tapInfo objectAtIndex:8];
        NSArray * actionsIfPrereqNotMet;
        
        for (GameActionSequence * gas in gameActionsLoaded) {
            if ([gas compareID:actionsWithoutPrereq]) {
                actionsIfPrereqNotMet = [[NSArray alloc] initWithArray:[gas getArray]];
            }
        }
        
        NSAssert([actionsIfPrereqNotMet count]>0, @"Action Sequence not found to be loaded.");
        
        [t addPrereq:prereq];
        [t addGameActionsIfPrereqsNotMet:actionsIfPrereqNotMet];
    }
    
    if (Display_Tappables) [self addChild:[t getGlow] z:Z_BELOW_PLAYER];
}

-(void) parseTriggerable:(NSString *) inputString {
    /*
     Triggerable * doorToCatBed = [Triggerable triggerableWithPosition:ccp(1,2) withActions: [NSArray arrayWithObjects:
     [ActionLoadWorld actionWithWorldToLoad:@"catherine_bed" atSpawnPoint:2], nil] withIdentity:0 isEnabled:true];*/
    
    NSArray * trigInfo = [inputString componentsSeparatedByString:@","];
    
    CGPoint position = ccp([[trigInfo objectAtIndex:0] intValue],[[trigInfo objectAtIndex:1] intValue]);
    int identity = [[trigInfo objectAtIndex:3] intValue];
    
    NSArray * actions; // Check for previously loaded actions [[inputArray] objectAtIndex:2]
    
    for (GameActionSequence * gas in gameActionsLoaded) {
        if ([gas compareID:[trigInfo objectAtIndex:2]]) {
            actions = [[NSArray alloc] initWithArray:[gas getArray]];
        }
    }
    
    NSAssert([actions count]>0, @"Action Sequence not found to be loaded.");
    
    bool enabled; // Check for persistent data otherwise load default
    
    NSNumber * newTriggerableEnabled = nil; // Check if tap is in persistent data, else load default value and add to persistent data(?)
    
    if (newTriggerableEnabled == nil) { // if tap wasn't found in persistent data
        NSString * newTriggerableIsEnabledString = [trigInfo objectAtIndex:4];
        if ([newTriggerableIsEnabledString isEqualToString:@"enabled"])
            newTriggerableEnabled = [NSNumber numberWithBool:YES];
        else newTriggerableEnabled = [NSNumber numberWithBool:NO];
        
        enabled = [newTriggerableEnabled boolValue];
    }
    
    Triggerable * t = [Triggerable triggerableWithPosition:position withActions:actions withIdentity:identity isEnabled:enabled];
    
    // check for prereqs
    /*
    if ([trigInfo count]>5) {
        NSString * prereq = [[trigInfo objectAtIndex:7] retain];
        NSString * actionsWithoutPrereq = [trigInfo objectAtIndex:8];
        NSArray * actionsIfPrereqNotMet;
        
        for (GameActionSequence * gas in gameActionsLoaded) {
            if ([gas compareID:actionsWithoutPrereq]) {
                actionsIfPrereqNotMet = [[NSArray alloc] initWithArray:[gas getArray]];
            }
        }
        
        NSAssert([actionsIfPrereqNotMet count]>0, @"Action Sequence not found to be loaded.");
        
        //[t addPrereq:prereq];
        //[t addGameActionsIfPrereqsNotMet:actionsIfPrereqNotMet];
    }*/
    
    if (Display_Triggers) [self addChild:[t getGlow] z:Z_BELOW_PLAYER];
}

-(void) parseCreature:(NSString *) inputString {
    NSArray * creatureInfo = [inputString componentsSeparatedByString:@","];
    
    int type = [[creatureInfo objectAtIndex:0] intValue];
    int xPos = [[creatureInfo objectAtIndex:1] intValue];
    
    [creatureManager createCreature:type at:xPos];
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
    if (gd._playerPressedFlash) {
        [creatureManager handleFlashFrom: gd._playerPosition];
        gd._playerPressedFlash = false;
    }
    
    bool playerChangedPos;
    if (gd._playerHoldingLeft) {
        playerChangedPos = [player attemptMoveInDirection:LEFT];
    } else if (gd._playerHoldingRight) {
        playerChangedPos = [player attemptMoveInDirection:RIGHT];
    } else {
        playerChangedPos = [player attemptNoMove];
    }
    
    //NSArray * lights = [NSArray arrayWithObjects:[NSNumber numberWithInt:350], nil];
    //if (Display_Lighting) [player updateLightingWith:lights];
    
    if(playerChangedPos) {
        for (Tappable * t in [GameData instance]._worldTappables) {
            [t updateGlow];
        }
    }
    
    [creatureManager update];
    
    [self updateCamera];
}

-(void) updateCamera {
    CGPoint centerOfView = ccp(480.0/2,320.0/2);
    CGPoint viewPoint = ccpSub(centerOfView, self.position);
    
    cameraCenter.x = 240 - [player getPosition].x;
    

    [GameData instance]._cameraPosition = self.position = cameraCenter;
    
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

-(void) registerWithTouchDispatcher {
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
    
    float newScale = self.scale;
    
    if(location.x > 240.0f) newScale += 0.01f;
    else newScale -= 0.01f;
    
    if (newScale > 1.5f) newScale = 1.5f;
    else if (newScale < 0.5f) newScale = 0.5f;
    
    self.scale = newScale;
    Log(@"scale level = %f",newScale);
}

-(void) dealloc {
    //Log(@"dealloc called");
    for (int i = 0; i < WORLDTILES_X; i++) {
        for (int j = 0; j < WORLDTILES_Y; j++) {
            [(WorldTile *)worldTiles[i][j] release];
        }
    }
    
    [creatureManager release];
    [player release];
    [gameActionsLoaded removeAllObjects];
    [gameActionsLoaded release];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [super dealloc];
}

@end
