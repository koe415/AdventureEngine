//
//  GameData.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "WorldHistory.h"

@interface GameData : NSObject

/* Player interactions */
@property(nonatomic) bool _playerHoldingLeft;
@property(nonatomic) bool _playerHoldingRight;
@property(nonatomic) bool _playerPressedFlash;

/* World */
@property(nonatomic) float _playerPosition;
@property(nonatomic) CGPoint _cameraPosition;

@property(nonatomic, retain) NSMutableArray * _worldObjects;
@property(nonatomic, retain) NSMutableArray * _barriers;
@property(nonatomic, retain) NSMutableArray * _worldTappables;
@property(nonatomic, retain) NSMutableArray * _worldTriggerables;

/* Game Actions */
@property(nonatomic) bool _actionDelay;
@property(nonatomic) bool _actionRunning;
@property(nonatomic) bool _dialogueInstant;
@property(nonatomic) bool _endingGame;

/* Persistent Data */
@property(nonatomic, retain) WorldHistory * _worldHistory;
@property(nonatomic, retain) WorldHistory * _encounteredTaps;
@property(nonatomic, retain) WorldHistory * _encounteredTrigs;

/* Main Menu Saved variables */
@property(nonatomic) CGPoint _mmShadowsOffsets;
@property(nonatomic) bool _mmShadowsVisible;

/*
 * Inited when app starts.
 * Has all the data loaded in when game starts
 */
+(GameData *) instance;
-(id) init;

/* Called for when a new world is being loaded */
-(void) clearWorld;

/* Called for when ending a game. Removes all data */
-(void) resetAllData;

@end
