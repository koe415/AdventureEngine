//
//  GameData.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property(nonatomic) float _playerPosition;
@property(nonatomic, retain) NSMutableArray * _worldTriggerables;
//@property(nonatomic, retain) NSMutableArray * _playerInventory;
//@property(nonatomic, retain) NSMutableArray * _worldObjects;
@property(nonatomic) CGPoint _cameraPosition;

@property(nonatomic) bool _playerHoldingLeft,_playerHoldingRight;
@property(nonatomic, retain) NSMutableArray * _barriers;
@property(nonatomic, retain) NSMutableArray * _worldTappables;
@property(nonatomic) bool _actionDelay;

+(GameData *) instance;
-(id) init;

@end
