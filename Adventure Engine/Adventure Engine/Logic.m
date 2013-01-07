//
//  Logic.m
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Logic.h"

@implementation Logic

#pragma mark Player Movement

+(bool) checkValidPosition:(CGPoint) newPosition {
    NSArray * barriers = [NSArray arrayWithArray:[GameData instance]._barriers];
    
    float currentPlayerPos = [GameData instance]._playerPosition;
    
    for (Barrier * b in barriers) {
        if (![b isEnabled]) continue;
        
        float leftEdge = [b getLeftEdge];
        float rightEdge = [b getRightEdge];
        
        if (currentPlayerPos < leftEdge) {
            if (newPosition.x + 20.0f > leftEdge) {
                return false;
            }
        } else if (currentPlayerPos > rightEdge) {
            if (newPosition.x - 20.0f < rightEdge) {
                return false;
            }
        }
    }
    
    return true;
}

#pragma mark Inventory Management
/*
+(bool) doesPlayerHave:(NSString *) item {
    for (NSString * obj in [GameData instance]._playerInventory) {
        Log(@"Checking if (%@) is equal to (%@)",item,obj);
        if ([obj isEqualToString:item]) {
            Log(@"Player has %@!",item);
            return true;
        }
    }
    
    Log(@"Player does NOT have %@...",item);
    return false;
}

+(void) addPlayerItem:(NSString *) item {
    Log(@"Item added (%@)",item);
    [[GameData instance]._playerInventory addObject:item];
}

+(void) removePlayerItem:(NSString *) item {
    Log(@"Item removed (%@)",item);
    [[GameData instance]._playerInventory removeObject:item];
}

+(void) removeAllPlayerItems {
    Log(@"Inventory cleared out!");
    [[GameData instance]._playerInventory removeAllObjects];
}
*/

#pragma mark World

+(CGPoint) worldPositionFromTap:(CGPoint) tapPt {
    return CGPointMake(
               (0 - [GameData instance]._cameraPosition.x + tapPt.x),
               (320 - [GameData instance]._cameraPosition.y - tapPt.y));
}

@end
