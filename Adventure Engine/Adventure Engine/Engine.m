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
        [self schedule:@selector(tick:)];
        
        hud = [HUD node];
        world = [World node];
        [self addChild:world];
        [self addChild:hud];
        
        actionsToRun = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void) handleTileTapAt:(CGPoint) tilePt {
    //Log(@"Tapped at tile location:(%.0f,%.0f)",tilePt.x,tilePt.y);
    
    for (Tappable * t in [GameData instance]._worldTappables) {
        if ([t compareTilePosition:tilePt]) {
            // If any barrier is in between player and tappable
            if ([t isTileBlockedByBarrier]) continue;
            
            if (![t arePrereqsMet]) {
                [actionsToRun addObjectsFromArray:[t gameActionsIfPrereqsNotMet]];
                continue;
            }
            
            [actionsToRun addObjectsFromArray:[t getActions]];
        }
    }
}

-(void) handleTriggerAt:(CGPoint) tilePt {
    //Log(@"Checking for trigger at tile location:(%.0f,%.0f)",tilePt.x,tilePt.y);
    
    for (Triggerable * t in [GameData instance]._worldTriggerables) {
        //Log(@"Checking trig with ID %d!",[t getIdentity]);
        if ([t compareTilePosition:tilePt]) {
            [actionsToRun addObjectsFromArray:[t getActions]];
        }
    }
}

-(void) setMoveVisibility:(bool) v {
    //Log(@"engine received move panel call!");
    [(HUD *)hud setMovePanelVisibility:v];
}

// Used for running game actions
-(void) tick:(ccTime) dt {
    if (actionDelay>0) {
        actionDelay--;
        
        if (actionDelay==0) {
            Log(@"Action delay done.");
            [GameData instance]._actionDelay = false;
            [self setMoveVisibility:true];
            
        }
        return;
    }
    
    if ([GameData instance]._actionRunning) {
        return;
    }
    
    if ([actionsToRun count]!=0) {
        GameAction * action = [actionsToRun objectAtIndex:0];
        [actionsToRun removeObjectAtIndex:0];
        
        [self run:action];
    }
}

-(void) run:(GameAction *) ga {
    [(HUD *) hud endUserInteraction];
    
    int actionType = [ga getActionType];
    
    switch (actionType) {
        case ACTIONDELAY:
            Log(@"Added delay!");
            actionDelay+=[(ActionDelay *) ga getDelay];
            [GameData instance]._actionDelay = true;
            [self setMoveVisibility:false];
            break;
        case ACTIONDIALOGUE:
            [self addChild:[Dialogue nodeWithDialogue:[(ActionDialogue *) ga getDialogue]]];
            [self setMoveVisibility:false];
            break;
        case ACTIONCUTSCENE:
            Log(@"Running Cutscene: %@", [(ActionCutscene *) ga getCutscene]);
            break;
        case ACTIONLOADWORLD:
            Log(@"Loading World: %@ At Spawn:%d", [(ActionLoadWorld *) ga getWorld],[(ActionLoadWorld *) ga getSpawn]);
            [(World *) world loadWorld:[(ActionLoadWorld *) ga getWorld] withSpawn:[(ActionLoadWorld *) ga getSpawn]];
            break;
        case ACTIONPICKUPITEM:
            Log(@"Picking Up Item: %@", [(ActionPickupItem *) ga getItem]);
            break;
        case ACTIONREMOVEITEM:
            Log(@"Removing Item: %@", [(ActionRemoveItem *) ga getItem]);
            break;
        case ACTIONREADABLE:
            Log(@"Loading Readable: %@", [(ActionReadable *) ga getReadable]);
            [self addChild:[Readable nodeWithTitle:[(ActionReadable *) ga getReadable]]];
            [self setMoveVisibility:false];
            break;
        case ACTIONENDGAME:
            Log(@"Ending Game");
            break;
        case ACTIONTAP:
            for (Tappable * t in [GameData instance]._worldTappables) {
                if ([t getIdentity] == [((ActionTap *) ga) getID]) {
                    [t setEnabled:[((ActionTap *) ga) getStatus]];
                }
            }
            break;
        case ACTIONTRIG:
            for (Triggerable * t in [GameData instance]._worldTriggerables) {
                if ([t getIdentity] == [((ActionTrig *) ga) getID]) {
                    [t setEnabled:[((ActionTrig *) ga) getStatus]];
                }
            }
            break;
        case ACTIONSHAKE:
            [GameData instance]._actionRunning = true;
            [(World *) world setScreenShakeIntensity:[(ActionShake *) ga getIntensity] withDuration:[(ActionShake *) ga getDuration]];
            break;
        case  ACTIONBARRIER:
            for (Barrier * b in [GameData instance]._barriers) {
                if ([b compareWith:[(ActionBarrier *) ga getID]]) {
                    [b setEnabled:[(ActionBarrier *) ga getStatus]];
                }
            }
            
            break;
        case ACTIONOBJECTVISIBILITY:
            for (WorldObject * wo in [GameData instance]._worldObjects) {
                if ([wo compareWith:[(ActionObjectVisibility *) ga getID]]) {
                    [wo setVisible:[(ActionObjectVisibility *) ga getStatus]];
                }
            }
            
            break;
        case ACTIONOBJECTANIMATION:
            for (WorldObject * wo in [GameData instance]._worldObjects) {
                if ([wo compareWith:[(ActionObjectAnimation *) ga getID]]) {
                    [wo playAnimation:[(ActionObjectAnimation *) ga getAnimation]];
                }
            }
            
            break;
        case ACTIONHISTORY:
            [[GameData instance]._worldHistory setStatus: [(ActionHistory *) ga getNewStatus] forID:[(ActionHistory *) ga getID]];
            
            break;
        default:
            Log(@"Tried to run invalid game action type (%d)",actionType);
            break;
    }
}

-(void) onEnter {
    [super onEnter];
    if ([GameData instance]._endingGame) [self endGame];
}

-(void) endGame {
    [GameData instance]._endingGame = false;
    [[GameData instance] clear];
    [[CCDirector sharedDirector] replaceScene:[MainMenu node]];
}


-(void) newGame {
    // Set all game data to default!
    
    [(World *) world loadWorld:@"bath" withSpawn:1];
}

-(void) continueGame {
    // Read in saved string, parse it
    // Saved data has to have current map, and spawn point
}


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
*/

// on "dealloc" you need to release all your retained objects
-(void) dealloc
{
    [actionsToRun release];
	[super dealloc];
}

@end
