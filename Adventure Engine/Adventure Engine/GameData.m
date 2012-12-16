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
    
    //id * object;
    
    //NSObject * nso = (NSObject *)object;
    
    //[nso cut:nso];
    
    
    
    @synchronized([GameData class]) {
        if(!_instance) {
            _instance = [[self alloc] init];
        }
        
        return _instance;
    }
    
    return nil;
}

-(id) init {
    if (self = [super init]) {
        //NSLog(@"Game Data initiated");
        self._worldTappables = [[NSMutableArray alloc] init];
        self._worldTriggerables = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@synthesize _playerPosition, _worldTappables, _mapLeftBoundary, _mapRightBoundary, _cameraPosition;
@synthesize _worldTriggerables;
@synthesize _playerInventory;
@synthesize _paused, _touchHandled;
@end
