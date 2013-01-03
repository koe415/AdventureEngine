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

-(id) initWithDelay:(int) inputDelay;
-(int) getDelay;

@end


@interface ActionDialogue : GameAction {
    NSString * dialogue;
}

-(id) initWithDialogue:(NSString *) inputDialogue;
-(NSString *) getDialogue;

@end


@interface ActionCutscene : GameAction {
    NSString * cutscene;
}

-(id) initWithCutscene:(NSString *) inputCutscene;
-(NSString *) getCutscene;

@end


@interface ActionLoadWorld : GameAction {
    NSString * worldToLoad;
}

-(id) initWithWorldToLoad:(NSString *) inputWorld;
-(NSString *) getWorld;

@end


@interface ActionPickupItem : GameAction {
    NSString * itemToPickup;
}

-(id) initWithItem:(NSString *) inputItem;
-(NSString *) getItem;

@end


@interface ActionRemoveItem : GameAction {
    NSString * itemToRemove;
}

-(id) initWithItem:(NSString *) inputItem;
-(NSString *) getItem;

@end


@interface ActionReadable : GameAction {
    NSString * readable;
}

-(id) initWithReadable:(NSString *) inputReadable;
-(NSString *) getReadable;

@end


@interface ActionEndGame : GameAction

-(id) init;

@end

@interface ActionTap : GameAction {
    int idOfTap;
    bool status;
}

-(id) initWithID:(int) inputID active:(bool) inputStatus;
-(int) getID;
-(bool) getStatus;
@end

@interface ActionTrig : GameAction {
    int idOfTap;
    bool status;
}

-(id) initWithID:(int) inputID active:(bool) inputStatus;
-(int) getID;
-(bool) getStatus;
@end