//
//  GameAction.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GameAction.h"

@implementation GameAction

-(int) getActionType {
    return type;
}

@end


@implementation ActionDelay

-(id) initWithDelay:(int) inputDelay {
    self = [super init];
    if(!self) return nil;
    
    delayLength = inputDelay;
    type = ACTIONDELAY;
    
    return self;
}

-(int) getDelay {
    return delayLength;
}

@end


@implementation ActionDialogue

-(id) initWithDialogue:(NSString *) inputDialogue {
    self = [super init];
    if(!self) return nil;
    
    dialogue = inputDialogue;
    type = ACTIONDIALOGUE;
    
    return self;
}

-(NSString *) getDialogue {
    return dialogue;
}

@end


@implementation ActionCutscene

-(id) initWithCutscene:(NSString *) inputCutscene {
    self = [super init];
    if(!self) return nil;
    
    cutscene = inputCutscene;
    type = ACTIONCUTSCENE;
    
    return self;
}

-(NSString *) getCutscene {
    return cutscene;
}

@end

@implementation ActionLoadWorld

-(id) initWithWorldToLoad:(NSString *) inputWorld {
    self = [super init];
    if(!self) return nil;
    
    worldToLoad = inputWorld;
    type = ACTIONLOADWORLD;
    
    return self;
}

-(NSString *) getWorld {
    return worldToLoad;
}

@end

@implementation ActionPickupItem

-(id) initWithItem:(NSString *) inputItem {
    self = [super init];
    if(!self) return nil;
    
    itemToPickup = inputItem;
    type = ACTIONPICKUPITEM;
    
    return self;
}

-(NSString *) getItem {
    return itemToPickup;
}

@end

@implementation ActionRemoveItem

-(id) initWithItem:(NSString *) inputItem {
    self = [super init];
    if(!self) return nil;
    
    itemToRemove = inputItem;
    type = ACTIONREMOVEITEM;
    
    return self;
}

-(NSString *) getItem {
    return itemToRemove;
}

@end


@implementation ActionReadable

-(id) initWithReadable:(NSString *) inputReadable {
    self = [super init];
    if(!self) return nil;
    
    readable = inputReadable;
    type = ACTIONREADABLE;
    
    return self;
}

-(NSString *) getReadable {
    return readable;
}

@end


@implementation ActionEndGame

-(id) init {
    self = [super init];
    if(!self) return nil;
    
    type = ACTIONENDGAME;
    
    return self;
}

@end

@implementation ActionTap

-(id) initWithID:(int)inputID active:(bool)inputStatus {
    self = [super init];
    if(!self) return nil;
    
    idOfTap = inputID;
    status = inputStatus;
    type = ACTIONTAP;
    
    return self;
}

-(int) getID {
    return idOfTap;
}

-(bool) getStatus {
    return status;
}

@end

@implementation ActionTrig

-(id) initWithID:(int)inputID active:(bool)inputStatus {
    self = [super init];
    if(!self) return nil;
    
    idOfTap = inputID;
    status = inputStatus;
    type = ACTIONTRIG;
    
    return self;
}

-(int) getID {
    return idOfTap;
}

-(bool) getStatus {
    return status;
}

@end