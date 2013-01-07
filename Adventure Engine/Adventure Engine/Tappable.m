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
    
    size = inputSize;
    
    glow = [[CCSprite alloc] initWithFile:@"small_glow.png"];
    [glow setPosition:ccp(((inputPt.x-1) * 20 * 2 + ((inputSize.width * 20 * 2) /2)), (inputPt.y-1) * 20 * 2 + ((inputSize.height * 20 * 2) /2))];
    glow.opacity = 150;
    glow.visible = isEnabled;
    CCSequence * glowAnimation = [CCSequence actions:
                                  [CCScaleTo actionWithDuration:2 scale:4.0f],
                                  [CCScaleTo actionWithDuration:2 scale:2.0f], nil];
    [glow runAction:[CCRepeatForever actionWithAction:glowAnimation]];
    
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

-(CCSprite *) getGlow {
    return glow;
}

-(void) setOpacity:(int) opac {
    [glow setOpacity:opac];
}

-(CGPoint) getGlowPosition {
    return glow.position;
}

-(void) dealloc {
    //Log(@"dealloc!");
    [gameActionsToRun release];
    [glow removeFromParentAndCleanup:true];
    [glow release];
    [super dealloc];
}

@end
