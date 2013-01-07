//
//  GameData.m
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static GameData *_instance = nil;

+(GameData *) instance {
    if (_instance) return _instance;
    
        if(!_instance) {
            _instance = [[self alloc] init];
        }
        
        return _instance;
}

-(id) init {
    if (self = [super init]) {
        self._worldTappables = [[NSMutableArray alloc] init];
        self._worldTriggerables = [[NSMutableArray alloc] init];
        self._barriers = [[NSMutableArray alloc] init];
        self._worldObjects = [[NSMutableArray alloc] init];
        self._dialogueInstant = true;
    }
    
    return self;
}

-(void) clear {
    //Log(@"Cleared");
    self._playerHoldingLeft = false;
    self._playerHoldingRight = false;
    self._actionDelay = false;
    self._actionRunning = false;
    
    [self._worldTappables removeAllObjects];
    [self._worldTriggerables removeAllObjects];
    [self._barriers removeAllObjects];
}

@synthesize _playerPosition, _cameraPosition;
//@synthesize _playerInventory;
@synthesize _playerHoldingLeft, _playerHoldingRight;
@synthesize _barriers;
@synthesize _worldObjects;
@synthesize _worldTappables;
@synthesize _worldTriggerables;
@synthesize _actionDelay;
@synthesize _actionRunning;
@synthesize _endingGame;
@synthesize _dialogueInstant;

@end
