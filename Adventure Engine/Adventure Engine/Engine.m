//
//  HelloWorldLayer.m
//  Certainty
//
//  Created by Galen Koehne on 11/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "Engine.h"

#pragma mark - Engine

@implementation Engine

+(CCScene *) continueGameScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// layers are autorelease objects.
	Engine *engine = [Engine node];
    
	// add layers as children to scene
	[scene addChild: engine];
    
    //[engine continueGame];
    
	return scene;
}

+(CCScene *) newGameScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// layers are autorelease objects.
	Engine *engine = [Engine node];
    
	// add layers as children to scene
	[scene addChild: engine];
    
    // New Game
    [engine newGame];
    
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        //self.isTouchEnabled = true;
        //[self schedule:@selector(tick:)];
        
        risky = [HUD node];
        [self addChild:[World node]];
        [self addChild:risky];
	}
	return self;
}

-(void) handleTileTapAt:(CGPoint) tilePt {
    // 8,4 or 9,4
    Log(@"Tapped at tile location:(%.0f,%.0f)",tilePt.x,tilePt.y);
    // Check for actions to run
    if ((tilePt.x == 8) && (tilePt.y == 4)) {
        //Log(@"found action!");
        [self addChild:[Dialogue nodeWithDialogue:@"dsda"]];
        [self setMoveVisibility:false];
    }
}

-(void) setMoveVisibility:(bool) v {
    //Log(@"engine received move panel call!");
    [(HUD *)risky setMovePanelVisibility:v];
}
/*
-(void) runNextAction {
    GameAction * action = [runningActions pop];
    [self runGameAction:action];
    gameActionDelay = [action getDelay];
}*/

//-(void) tick:(ccTime) dt {
    // Check for triggers at spawn
    // todo: move to loadMap method
    // issue as is, can't run pushscene during class initiation which causes map load flicker
    /*
    if (firstTimeRunningWorld) {
        GameActionArray * potentialArray = [Logic checkPlayerTriggeringGameActionArray];
        
        if (potentialArray) {
            if (![potentialArray isEmpty]) {
                // add array to running actions
                [runningActions addArray:potentialArray];
                
                // run first action
                [self runNextAction];
            }
        }
        
        firstTimeRunningWorld = false;
    }
    
    if ([_hudLayer isItemPickupShown]) {
        // Ignore running anything if item pickup screen shown
    } else if ([_dialogueLayer displayingDialogue]) {
        // Ignore running actions or any movement attempts
    } else if (gameActionDelay>0) {
        if ([_hudLayer isMovePanelVisible])
            [_hudLayer setMovePanelVisibility:false];
        //Log(@"waiting!");
        gameActionDelay--;
    } else if (![runningActions isEmpty]) {
        [self runNextAction];
    } else if (movingLeft) {
        [Logic attemptPlayerMoveLeft];
        // check for trigger
        GameActionArray * potentialArray = [Logic checkPlayerTriggeringGameActionArray];
        
        if (potentialArray) {
            if (![potentialArray isEmpty]) {
                // add array to running actions
                [runningActions addArray:potentialArray];
                
                // run first action
                [self runNextAction];
            }
        }
        
    } else if (movingRight) {
        [Logic attemptPlayerMoveRight];
        // check for trigger
        GameActionArray * potentialArray = [Logic checkPlayerTriggeringGameActionArray];
        
        if (potentialArray) {
            if (![potentialArray isEmpty]) {
                // add array to running actions
                [runningActions addArray:potentialArray];
                
                // run first action
                [self runNextAction];
            }
        }
    }
    
    [_worldLayer updateWorld];*/
//}


/*
-(void) pickupItem:(NSString *) item {
    [_hudLayer setItemPickup:item];
    [Logic addPlayerItem:item];
}

-(void) runGameAction: (GameAction *) actionToRun {
    movingLeft = movingRight = false;
    
    switch ([actionToRun getType]) {
        case 1:
            if (Display_Debug_Text) Log(@"Engine: Cutscene to run:%@",[actionToRun getValue]);
            [[CCDirector sharedDirector] pushScene:[Cutscene sceneWithCutscene:[actionToRun getValue]]];
            break;
        case 2:
            if (Display_Debug_Text) Log(@"Engine: Dialogue to run:%@",[actionToRun getValue]);
            [_dialogueLayer startDialogue:[actionToRun getValue]];
            [_hudLayer setMovePanelVisibility: false];
            break;
        case 3:
            if (Display_Debug_Text) Log(@"Engine: World to load:%@",[actionToRun getValue]);
            [self loadMap:[actionToRun getValue]];
            break;
        case 4:
            if (Display_Debug_Text) Log(@"Engine: Item to pick up:%@",[actionToRun getValue]);
            [self pickupItem:[actionToRun getValue]];
            [_hudLayer setMovePanelVisibility:false];
            break;
        case 5:
            if (Display_Debug_Text) Log(@"Engine: Item to remove:%@",[actionToRun getValue]);
            [Logic removePlayerItem:[actionToRun getValue]];
            break;
        case 6:
            if (Display_Debug_Text) Log(@"Engine: Text to show:%@",[actionToRun getValue]);
            [[CCDirector sharedDirector] pushScene:[Readable sceneWithText:[actionToRun getValue]]];
            break;
        case 7:
            if (Display_Debug_Text) Log(@"Engine: Game ending!");
            [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
            break;
        default:
            if (Display_Debug_Text) Log(@"Engine: ERROR - Given improper game action (%d) with text:%@",[actionToRun getType],[actionToRun getValue]);
            break;
    }
}*/

-(void) newGame {
    //[GameData instance]._playerInventory = [[NSMutableArray alloc] init];
    
    //GameData * gd = [GameData instance];
    
    //[Logic removeAllPlayerItems];
    //[self loadMap:@"bunk1"];
}
/*
-(void) continueGame {
    // file system load player map and prior gamedata
    [self loadMap:@"mtns"];
}

-(void) loadMap:(NSString *) map {
    World worldLoaded = [Worlds access:map];
    
    [GameData instance]._playerPosition = worldLoaded.playerSpawn;
    [GameData instance]._mapLeftBoundary = worldLoaded.mapLeftBoundary;
    [GameData instance]._mapRightBoundary = worldLoaded.mapRightBoundary;
    [GameData instance]._worldTappables = worldLoaded.worldTappables;
    [GameData instance]._worldTriggerables = worldLoaded.worldTriggerables;
    
    [_worldLayer setupWorld:worldLoaded.background];
    
    firstTimeRunningWorld = true;
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    // check pause button selection!
    if (location.x < 60 && location.y < 60) { // Handled by hud
        //Log(@"pause button pressed!");
        [_hudLayer setPauseButtonPressed:true];
        pauseButtonTap = true;
    } else if ([_hudLayer isItemPickupShown]) { // Handled by hud
        
    } else if ([_dialogueLayer displayingDialogue]) { // Handled by dialogue
        [_dialogueLayer touchBegan:true];
        
    } else if (gameActionDelay>0) { // Every touch handler has to verify that gameactiondelay is not active
    } else if (![runningActions isEmpty]) { // Every touch handler has to verify this as well
    } else if (location.x < 60) { // Handled by hud
        //Log(@"move left!");
        movingLeft = true;
    } else if (location.x > 420) { // Handled by hud
        //Log(@"move right?");
        movingRight = true;
    } 
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    if (pauseButtonTap) {
        if ([_hudLayer isPauseButtonPressed]) {
            // Check for player dragging outside pause button
            if (location.x > 60 || location.y > 60) {
                [_hudLayer setPauseButtonPressed:false];
            }
        } else {
            // Check for player dragging back inside pause button
            if (location.x < 60 && location.y < 60) {
                [_hudLayer setPauseButtonPressed:true];
            }
        }
    }
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    if (movingLeft) {
        //Log(@"Moving Left Released");
        movingLeft = false;
        return;
    } else if (movingRight) {
        //Log(@"Moving Right Released");
        movingRight = false;
        return;
    } else if (pauseButtonTap) {
        if ([_hudLayer isPauseButtonPressed]) {
            //if (Display_Debug_Text) Log(@"paused bitch!");
            [_hudLayer setPauseButtonPressed:false];
            [[CCDirector sharedDirector] pushScene:[PauseMenu scene]];
        }
        pauseButtonTap = false;
        
    } else if ([_hudLayer isItemPickupShown]) { 
        [_hudLayer setItemPickupVisibility:false];
        [_hudLayer setMovePanelVisibility:true];
    } else if ([_dialogueLayer displayingDialogue] && [_dialogueLayer touchOriginatedInDialogue]) {
        [_dialogueLayer touchBegan:false];
        if ([_dialogueLayer isMultiChoice]) {
            if (location.y > 220) {
                
                NSString * potentialGA;
                
                // determine what players choice
                if (location.x < 120) 
                    potentialGA = [_dialogueLayer chooseNode:1];
                else if (location.x < 240)
                    potentialGA = [_dialogueLayer chooseNode:2];
                else if (location.x < 360)
                    potentialGA = [_dialogueLayer chooseNode:3];
                else if (location.x < 480)
                    potentialGA = [_dialogueLayer chooseNode:4];
                
                if (![potentialGA isEqualToString:@""]) {
                    GameActionArray * potentialArray = [Logic checkDialogueGameActionArray:potentialGA];
                    [runningActions addArray:potentialArray];
                }
            }
            
        } else {
            NSString * potentialGA = [_dialogueLayer getAction];
            
            if (![potentialGA isEqualToString:@""]) {
                GameActionArray * potentialArray = [Logic checkDialogueGameActionArray:potentialGA];
                [runningActions addArray:potentialArray];
            }
            
            if ([_dialogueLayer hasMoreDialogue]) {
                [_dialogueLayer continueDialogue];
            } else {
                if (gameActionDelay==0)
                    [_hudLayer setMovePanelVisibility: YES];
            }
        }
    } else if (gameActionDelay>0) {
        if (Display_Debug_Text) Log(@"Engine: Ignored tap. Is waiting!");
    } else if (![runningActions isEmpty]) {
        if (Display_Debug_Text) Log(@"Engine: Ignored tap. Is running an action still!");
    } else {
        //Log(@"tap coords:%f,%f",location.x,location.y);
        //Log(@"camera coords:%f,%f",[GameData instance]._cameraPosition.x,[GameData instance]._cameraPosition.y);
        
        // determine tap location on map
        CGPoint tapPositionInWorld = [Logic worldPositionFromTap:location];
        // retrieve potential action on map from tap
        GameActionArray * potentialArray = [_worldLayer handleWorldTapAt:tapPositionInWorld];
        
        // if array is valid
        if (potentialArray) {
            //if (Display_Debug_Text) Log(@"Engine: Found array. Is valid!");
            // if array has actions
            if (![potentialArray isEmpty]) {
                //if (Display_Debug_Text) Log(@"Engine: Found array has items!");
                
                // add array to running actions
                [runningActions addArray:potentialArray];
                
                // run first action
                [self runNextAction];
            }
        }
    }
}*/

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}

@end
