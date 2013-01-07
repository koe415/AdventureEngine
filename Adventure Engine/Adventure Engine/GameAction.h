//
//  GameAction.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedTypes.h"

@interface GameAction : NSObject {
    int type;
}

-(int) getActionType;

@end


@interface ActionDelay : GameAction {
    int delayLength;
}

+(id) actionWithDelay:(int) inputDelay;
-(id) initWithDelay:(int) inputDelay;
-(int) getDelay;

@end


@interface ActionDialogue : GameAction {
    NSString * dialogue;
}

+(id) actionWithDialogue:(NSString *) inputDialogue;
-(id) initWithDialogue:(NSString *) inputDialogue;
-(NSString *) getDialogue;

@end


@interface ActionCutscene : GameAction {
    NSString * cutscene;
}

+(id) actionWithCutscene:(NSString *) inputCutscene;
-(id) initWithCutscene:(NSString *) inputCutscene;
-(NSString *) getCutscene;

@end


@interface ActionLoadWorld : GameAction {
    NSString * worldToLoad;
    int spawnPt;
}

+(id) actionWithWorldToLoad:(NSString *) inputWorld atSpawnPoint:(int) inputSpawn;
-(id) initWithWorldToLoad:(NSString *) inputWorld atSpawnPoint:(int) inputSpawn;
-(NSString *) getWorld;
-(int) getSpawn;

@end


@interface ActionPickupItem : GameAction {
    NSString * itemToPickup;
}

+(id) actionWithItem:(NSString *) inputItem;
-(id) initWithItem:(NSString *) inputItem;
-(NSString *) getItem;

@end


@interface ActionRemoveItem : GameAction {
    NSString * itemToRemove;
}

+(id) actionWithItem:(NSString *) inputItem;
-(id) initWithItem:(NSString *) inputItem;
-(NSString *) getItem;

@end


@interface ActionReadable : GameAction {
    NSString * readable;
}

+(id) actionWithReadable:(NSString *) inputReadable;
-(id) initWithReadable:(NSString *) inputReadable;
-(NSString *) getReadable;

@end


@interface ActionEndGame : GameAction

+(id) action;
-(id) init;

@end

@interface ActionTap : GameAction {
    int idOfTap;
    bool status;
}

+(id) actionWithID:(int) inputID active:(bool) inputStatus;
-(id) initWithID:(int) inputID active:(bool) inputStatus;
-(int) getID;
-(bool) getStatus;
@end

@interface ActionTrig : GameAction {
    int idOfTap;
    bool status;
}

+(id) actionWithID:(int) inputID active:(bool) inputStatus;
-(id) initWithID:(int) inputID active:(bool) inputStatus;
-(int) getID;
-(bool) getStatus;
@end

@interface ActionShake : GameAction {
    int intensity;
    int duration;
}

+(id) actionWithIntensity:(int) inputIntensity withDuration:(int) inputDuration;
-(id) initWithIntensity:(int) inputIntensity withDuration:(int) inputDuration;
-(int) getIntensity;
-(int) getDuration;
@end

@interface ActionBarrier : GameAction {
    NSString * idOfBarrier;
    bool status;
}

+(id) actionWithID:(NSString *) inputID active:(bool) inputStatus;
-(id) initWithID:(NSString *) inputID active:(bool) inputStatus;
-(NSString *) getID;
-(bool) getStatus;
@end