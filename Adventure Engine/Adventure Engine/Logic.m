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

+(bool) attemptPlayerMoveLeft {
    if ([GameData instance]._playerPosition - 1.5f > [GameData instance]._mapLeftBoundary) {
        [GameData instance]._playerPosition -= 1.5f;
        return true;
    }
    
    return false;
}

+(bool) attemptPlayerMoveRight {
    if ([GameData instance]._playerPosition + 1.5f < [GameData instance]._mapRightBoundary) {
        [GameData instance]._playerPosition += 1.5f;
        return true;
    }
    
    return false;
}
/*
+(GameActionArray *) checkPlayerTriggeringGameActionArray {
    CGPoint pt = CGPointMake([GameData instance]._playerPosition, 30);
    for (TriggerableGameActionArray * triggerableGameAction in [GameData instance]._worldTriggerables) {
        //if they are close enough and item is enabled
        if ([triggerableGameAction contains:pt] && [triggerableGameAction isEnabled]) {
            Log(@"WorldLayer: Found triggerable array in world");
            
            if ([triggerableGameAction isOneTimeUse]) {
                Log(@"WorldLayer: Triggerable array is one time use");
                
                [triggerableGameAction setEnabled:false];
                [[triggerableGameAction getSpriteReference] setVisible:false];
            }
            
            // react!
            return [triggerableGameAction getArray];
        }
    }
    
    return nil;
}


+(GameActionArray *) checkDialogueGameActionArray:(NSString *) arrayName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString * inputGameActionPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"dialogueGameActions.plist"]];
    NSDictionary * gameActionsPlistData = [[NSDictionary dictionaryWithContentsOfFile:inputGameActionPath] retain];
    
    for (NSDictionary * array in gameActionsPlistData) {
        
        if ([[array description] isEqualToString:arrayName]) {
            
            GameActionArray * newArray = [[GameActionArray alloc] init];
            
            NSDictionary * directCallToDic = (NSDictionary *)[gameActionsPlistData objectForKey:array];
            
            int gaIter = 1;
            
            while ([directCallToDic objectForKey:[NSString stringWithFormat:@"ga%d",gaIter]]) {
                NSDictionary * tmp = (NSDictionary *) [directCallToDic objectForKey:[NSString stringWithFormat:@"ga%d",gaIter]];
                
                [newArray add:[[GameAction alloc] 
                               initWithType:[(NSNumber *)[tmp objectForKey:@"type"] intValue]
                               
                               withString:(NSString *)[tmp objectForKey:@"val"]
                               
                               withDelay:[(NSNumber *)[tmp objectForKey:@"delay"] intValue] ]];
                gaIter++;
            }
            
            return newArray;
        }
        
    }
    
    return nil;
}
*/
#pragma mark Inventory Management

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

#pragma mark World

+(CGPoint) worldPositionFromTap: (CGPoint) tapPt {
    return ccp(
               0 - [GameData instance]._cameraPosition.x + tapPt.x,
               320 - [GameData instance]._cameraPosition.y - tapPt.y);
}

+(NSString *) getItemPickupText:(NSString *) itemName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString * inputPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"playerItems.plist"]];
    
    NSDictionary * plistData = [[NSDictionary dictionaryWithContentsOfFile:inputPath] retain];
    
    return [plistData objectForKey:itemName];
}

@end
