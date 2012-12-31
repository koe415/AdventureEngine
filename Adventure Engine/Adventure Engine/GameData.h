//
//  GameData.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "cocos2d.h"

@interface GameData : NSObject

@property(nonatomic) float _playerPosition;
@property(nonatomic, retain) NSMutableArray * _worldTappables;
@property(nonatomic, retain) NSMutableArray * _worldTriggerables;
//@property(nonatomic, retain) NSMutableArray * _playerInventory;
@property(nonatomic) float _mapLeftBoundary;
@property(nonatomic) float _mapRightBoundary;
@property(nonatomic) CGPoint _cameraPosition;

@property(nonatomic) bool _playerHoldingLeft,_playerHoldingRight;


+(GameData *) instance;
-(id) init;

@end
