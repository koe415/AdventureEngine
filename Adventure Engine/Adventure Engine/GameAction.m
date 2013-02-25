//
//  GameAction.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//

#import "GameAction.h"

@implementation GameAction

-(int) getActionType {
    return type;
}

@end


@implementation ActionDelay

+(id) actionWithDelay:(int)inputDelay {
    return [[[ActionDelay alloc] initWithDelay:inputDelay] autorelease];
}

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

+(id) actionWithDialogue:(NSString *)inputDialogue {
    return [[[ActionDialogue alloc] initWithDialogue:inputDialogue] autorelease];
}

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

+(id) actionWithCutscene:(NSString *)inputCutscene {
    return [[[ActionCutscene alloc] initWithCutscene:inputCutscene] autorelease];
}

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

+(id) actionWithWorldToLoad:(NSString *) inputWorld atSpawnPoint:(int) inputSpawn {
    return [[[ActionLoadWorld alloc] initWithWorldToLoad:inputWorld atSpawnPoint:inputSpawn] autorelease];
}

-(id) initWithWorldToLoad:(NSString *) inputWorld atSpawnPoint:(int) inputSpawn {
    self = [super init];
    if(!self) return nil;
    
    worldToLoad = inputWorld;
    spawnPt = inputSpawn;
    type = ACTIONLOADWORLD;
    
    return self;
}

-(NSString *) getWorld {
    return worldToLoad;
}

-(int) getSpawn {
    return spawnPt;
}

@end

@implementation ActionPickupItem

+(id) actionWithItem:(NSString *)inputItem {
    return [[[ActionPickupItem alloc] initWithItem:inputItem] autorelease];
}

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

+(id) actionWithItem:(NSString *)inputItem {
    return [[[ActionRemoveItem alloc] initWithItem:inputItem] autorelease];
}

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

+(id) actionWithReadable:(NSString *)inputReadable {
    return [[[ActionReadable alloc] initWithReadable:inputReadable] autorelease];
}

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

+(id) action {
    return [[[ActionEndGame alloc] init] autorelease];
}

-(id) init {
    self = [super init];
    if(!self) return nil;
    
    type = ACTIONENDGAME;
    
    return self;
}

@end

@implementation ActionTap

+(id) actionWithID:(int)inputID active:(_Bool)inputStatus {
    return [[[ActionTap alloc] initWithID:inputID active:inputStatus] autorelease];
}

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

+(id) actionWithID:(int)inputID active:(_Bool)inputStatus {
    return [[[ActionTrig alloc] initWithID:inputID active:inputStatus] autorelease];
}

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

@implementation ActionShake

+(id) actionWithIntensity:(int) inputIntensity withDuration:(int) inputDuration {
    return [[[ActionShake alloc] initWithIntensity:inputIntensity withDuration:inputDuration] autorelease];
}

-(id) initWithIntensity:(int) inputIntensity withDuration:(int) inputDuration {
    self = [super init];
    if (!self) return nil;
    
    intensity = inputIntensity;
    duration = inputDuration;
    type = ACTIONSHAKE;
    
    return self;
}

-(int) getIntensity {
    return intensity;
}

-(int) getDuration {
    return duration;
}

@end

@implementation ActionBarrier

+(id) actionWithID:(NSString *) inputID active:(bool) inputStatus {
    return [[[ActionBarrier alloc] initWithID:inputID active:inputStatus] autorelease];
}

-(id) initWithID:(NSString *) inputID active:(bool) inputStatus {
    self = [super init];
    if(!self) return nil;
    
    idOfBarrier = inputID;
    status = inputStatus;
    type = ACTIONBARRIER;
    
    return self;
}

-(NSString *) getID {
    return idOfBarrier;
}

-(bool) getStatus {
    return status;
}

@end


@implementation ActionObjectVisibility 

+(id) actionWithID:(NSString *) inputID active:(bool) inputStatus {
    return [[[ActionObjectVisibility alloc] initWithID:inputID active:inputStatus] autorelease];
}

-(id) initWithID:(NSString *) inputID active:(bool) inputStatus {
    self = [super init];
    if (!self) return nil;
    
    idOfObject = inputID;
    status = inputStatus;
    type = ACTIONOBJECTVISIBILITY;
    
    return self;
}

-(NSString *) getID {
    return idOfObject;
}

-(bool) getStatus {
    return status;
}

@end


@implementation ActionObjectAnimation

+(id) actionWithID:(NSString *) inputID running:(int) inputAnim {
    return [[[ActionObjectAnimation alloc] initWithID:inputID running:inputAnim] autorelease];
}

-(id) initWithID:(NSString *) inputID running:(int) inputAnim {
    self = [super init];
    if (!self) return nil;
    
    idOfObject = inputID;
    animationToRun = inputAnim;
    type = ACTIONOBJECTANIMATION;
    
    return self;
}

-(NSString *) getID {
    return idOfObject;
}

-(int) getAnimation {
    return animationToRun;
}

@end




@implementation ActionHistory

+(id) actionWithID:(NSString *) inputID newStatus:(bool) inputStatus {
    return [[[ActionHistory alloc] initWithID:inputID newStatus:inputStatus] autorelease];
}

-(id) initWithID:(NSString *) inputID newStatus:(bool) inputStatus {
    self = [super init];
    if (!self) return nil;
    
    idOfHistory = inputID;
    newStatus = inputStatus;
    type = ACTIONHISTORY;
    
    return self;
}

-(NSString *) getID {
    return idOfHistory;
}

-(bool) getNewStatus {
    return newStatus;
}

@end