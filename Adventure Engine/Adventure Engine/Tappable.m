//
//  Tappable.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Tappable.h"

@implementation Tappable

+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled {
    id t = [[[Tappable alloc] initWithPosition:inputPt withActions:actions withSize:inputSize withIdentity:inputIdent isEnabled:enabled] autorelease];
    [[GameData instance]._worldTappables addObject:t];
    return t;
}

+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent {
    id t = [[[Tappable alloc] initWithPosition:inputPt withActions:actions withSize:CGSizeMake(1.0f, 1.0f) withIdentity:inputIdent isEnabled:true] autorelease];
    [[GameData instance]._worldTappables addObject:t];
    return t;
}

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled {
    self = [super init];
    if (!self) return nil;
    
    tilePosition = inputPt;
    gameActionsToRun = [[NSArray alloc] initWithArray:actions];
    identity = inputIdent;
    isEnabled = enabled;
    prereqs = [[NSMutableArray alloc] init];
    gameActionsIfPrereqsNotMet = [[NSMutableArray alloc] init];
    
    size = inputSize;
    
    glow = [[CCSprite alloc] initWithFile:@"small_glow.png"];
    [glow setPosition:ccp(((inputPt.x-1) * 20 * 2 + ((inputSize.width * 20 * 2) /2)), (inputPt.y-1) * 20 * 2 + ((inputSize.height * 20 * 2) /2))];
    glow.scale = 2.0f;
    //glow.opacity = 150;
    glow.visible = isEnabled;
    CCSequence * glowAnimation = [CCSequence actions:
                                  [CCRotateBy actionWithDuration:1 angle:30],nil];
                                  //[CCScaleTo actionWithDuration:2 scale:4.0f],
                                  //[CCScaleTo actionWithDuration:2 scale:2.0f], nil];
    [glow runAction:[CCRepeatForever actionWithAction:glowAnimation]];
    
    //CCSequence * glowAnimation2 = [CCSequence actions:
    //                               [CCScaleTo actionWithDuration:3 scale:2.5f],
    //                               [CCScaleTo actionWithDuration:3 scale:1.5f], nil];
    //[glow runAction:[CCRepeatForever actionWithAction:glowAnimation2]];
    
    [glow.texture setAliasTexParameters];
    
    [self updateGlow];
    return self;
}

// Using glow's center for now as a compromise on speed of check
// When future galen gets a chance: change to include edges in calculation
-(bool) isTileBlockedByBarrier {
    for (Barrier * b in [GameData instance]._barriers) {
        if (![b isEnabled]) continue;
        
        if (([glow position].x > [b getCenter]) && ([b getCenter] > [GameData instance]._playerPosition)) {
            return true;
        }
        
        if (([glow position].x < [b getCenter]) && ([b getCenter] < [GameData instance]._playerPosition)) {
            return true;
        }
    }
    
    return false;
}

-(void) addPrereq:(NSString *) p {
    [prereqs addObject:p];
}

-(bool) arePrereqsMet {
    if ([prereqs count]==0) return true;
    
    for (NSString * prereq in prereqs) {
        // check if preqreq matches any value in game data's flags
        // if its not there, return false
        if ([[GameData instance]._worldHistory checkValueForID:prereq]) continue;
        
        Log(@"Found False for %@ prereq",prereq);
        
        return false;
    }
    
    return true;
}

-(void) addGameActionsIfPrereqsNotMet:(NSArray *) inputGameActions {
    [gameActionsIfPrereqsNotMet addObjectsFromArray:inputGameActions];
}

-(NSArray *) gameActionsIfPrereqsNotMet {
    return gameActionsIfPrereqsNotMet;
}

-(bool) compareTilePosition:(CGPoint) tilePt {
    if (!isEnabled) return false;
    
    if (tilePt.x < tilePosition.x || tilePt.x >= tilePosition.x + size.width) return false;
    if (tilePt.y < tilePosition.y || tilePt.y >= tilePosition.y + size.height) return false;
    
    return true;
}

-(NSArray *) getActions {
    return gameActionsToRun;
}

-(int) getIdentity {
    return identity;
}

-(void) setEnabled:(bool) inputStatus {
    isEnabled = inputStatus;
    glow.visible = isEnabled;
}

-(void) updateGlow {
    if (!glow.visible) return;
    float dist = glow.position.x - [GameData instance]._playerPosition;//[player getPosition].x;
    if (dist < 0.0f) dist *= -1.0f;
    
    //Log(@"dist=%f",dist);
    
    if (dist > 200.0f) {
        [glow setOpacity:0];
    } else if (dist > 50.0f) {
        
        dist -= 50.0f;
        float newOpac = 200.0f - (200.0f * (dist/150.0f));//(5/3 * dist);
        [glow setOpacity:newOpac];
        [glow setScale:3];

        float newScale = 1.5f + (2.0f * (dist/150.0f));
        [glow setScale:newScale];
    } else {
        [glow setScale:1.5f];
        //[t setOpacity:200];
    }
}

-(CCSprite *) getGlow {
    return glow;
}
/*
-(void) setOpacity:(int) opac {
    [glow setOpacity:opac];
}

-(CGPoint) getGlowPosition {
    return glow.position;
}*/

-(void) dealloc {
    //Log(@"dealloc!");
    [prereqs release];
    [gameActionsIfPrereqsNotMet release];
    [gameActionsToRun release];
    [glow removeFromParentAndCleanup:true];
    [glow release];
    [super dealloc];
}

@end
