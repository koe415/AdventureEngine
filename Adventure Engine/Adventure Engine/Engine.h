//
//  HelloWorldLayer.h
//  Certainty
//
//  Created by Galen Koehne on 11/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"

// Import.....EVERYTHING!
//#import "Dialogue.h"
//#import "WorldLayer.h"
#import "HUDLayer.h"
#import "GameData.h"
#import "Logic.h"
//#import "PauseMenu.h"
//#import "GameAction.h"
//#import "World.h"
//#import "Worlds.h"
#import "DebugFlags.h"
//#import "Cutscene.h"
//#import "Readable.h"
//#import "GameActionArray.h"

#import "TestLayerTop.h"
#import "TestLayerBottom.h"

// Engine Layer
@interface Engine : CCLayer
{
    //DialogueLayer *_dialogueLayer;
    //WorldLayer *_worldLayer;
    //HUDLayer *_hudLayer;
    
    // Player moving main character
    //bool movingLeft, movingRight;
    
    // Player in pause button tap
    //bool pauseButtonTap;
    
    //int gameActionDelay;
    
    //GameActionArray * runningActions;
    
    //bool firstTimeRunningWorld;
}

// returns a CCScene that contains the all the Core Engine Layers as the only child
+(CCScene *) continueGameScene;
+(CCScene *) newGameScene;
//-(void) runNextAction;
-(void) newGame;
//-(void) continueGame;
//-(void) runGameAction: (GameAction *) actionToRun;
//-(void) loadMap:(NSString *) map;

//@property (nonatomic, retain) DialogueLayer * dialogueLayer;
//@property (nonatomic, retain) WorldLayer * worldLayer;
//@property (nonatomic, retain) HUDLayer * hudLayer;

@end
