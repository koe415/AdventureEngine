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
        Log(@"Inited");
        self._worldTappables = [[NSMutableArray alloc] init];
        self._worldTriggerables = [[NSMutableArray alloc] init];
        self._barriers = [[NSMutableArray alloc] init];
        self._worldObjects = [[NSMutableArray alloc] init];
        self._dialogueInstant = true;
        
        self._worldHistory = [[WorldHistory alloc] init];
        self._encounteredTaps = [[WorldHistory alloc] init];
        self._encounteredTrigs = [[WorldHistory alloc] init];
        
        self._mmShadowsOffsets = ccp(2,-2);
        self._mmShadowsVisible = true;
    }
    
    return self;
}

-(void) clearWorld {
    [self._worldObjects removeAllObjects];
    [self._worldTappables removeAllObjects];
    [self._worldTriggerables removeAllObjects];
    [self._barriers removeAllObjects];
}

-(void) clear {
    Log(@"Cleared");
    self._playerHoldingLeft = false;
    self._playerHoldingRight = false;
    self._actionDelay = false;
    self._actionRunning = false;
    
    [self._worldTappables removeAllObjects];
    [self._worldTriggerables removeAllObjects];
    [self._worldObjects removeAllObjects];
    [self._barriers removeAllObjects];
    [self._worldHistory clear];
    [self._encounteredTaps clear];
    [self._encounteredTrigs clear];
}

-(void) dealloc {
    Log(@"dealloc");
    [self._worldTappables release];
    [self._worldTriggerables release];
    [self._worldObjects release];
    [self._barriers release];
    
    [self._worldHistory release];
    [self._encounteredTaps release];
    [self._encounteredTrigs release];
    [super dealloc];
}

@synthesize _playerPosition, _cameraPosition;
@synthesize _playerHoldingLeft, _playerHoldingRight;
@synthesize _barriers;
@synthesize _worldObjects;
@synthesize _worldTappables;
@synthesize _worldTriggerables;
@synthesize _actionDelay;
@synthesize _actionRunning;
@synthesize _endingGame;
@synthesize _dialogueInstant;
@synthesize _worldHistory,_encounteredTaps,_encounteredTrigs;

@synthesize _mmShadowsOffsets;
@synthesize _mmShadowsVisible;

@end
