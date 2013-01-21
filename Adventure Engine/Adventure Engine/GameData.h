//
//  GameData.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "WorldHistory.h"

@interface GameData : NSObject

@property(nonatomic) float _playerPosition;
@property(nonatomic, retain) NSMutableArray * _worldObjects;
@property(nonatomic) CGPoint _cameraPosition;

@property(nonatomic) bool _playerHoldingLeft,_playerHoldingRight;
@property(nonatomic, retain) NSMutableArray * _barriers;
@property(nonatomic, retain) NSMutableArray * _worldTappables;
@property(nonatomic, retain) NSMutableArray * _worldTriggerables;
@property(nonatomic) bool _actionDelay;
@property(nonatomic) bool _actionRunning;
@property(nonatomic) bool _endingGame;

@property(nonatomic) bool _dialogueInstant;
@property(nonatomic, retain) WorldHistory * _worldHistory;

@property(nonatomic) CGPoint _mmShadowsOffsets;
@property(nonatomic) bool _mmShadowsVisible;

+(GameData *) instance;
-(id) init;
-(void) clear;

@end
