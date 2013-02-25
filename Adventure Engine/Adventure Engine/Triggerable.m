//
//  Triggerable.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//

#import "Triggerable.h"

@implementation Triggerable

+(id) triggerableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled {
    id t = [[[Triggerable alloc] initWithPosition:inputPt withActions:actions withIdentity:inputIdent isEnabled:enabled] autorelease];
    [[GameData instance]._worldTriggerables addObject:t];
    return t;
}

+(id) triggerableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent {
    id t = [[[Triggerable alloc] initWithPosition:inputPt withActions:actions withIdentity:inputIdent isEnabled:true] autorelease];
    [[GameData instance]._worldTriggerables addObject:t];
    return t;
}

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled {
    self = [super init];
    if (!self) return nil;
    
    tilePosition = inputPt;
    gameActionsToRun = [[NSArray alloc] initWithArray:actions];
    identity = inputIdent;
    isEnabled = enabled;
    
    glow = [[CCSprite alloc] initWithFile:@"small_glow_red.png"];
    [glow setPosition:ccp((inputPt.x-1) * 20 * 2 + 20, (inputPt.y-1) * 20 * 2 + 20)];
    glow.opacity = 150;
    glow.visible = isEnabled;
    CCSequence * glowAnimation = [CCSequence actions:
                                  [CCScaleTo actionWithDuration:2 scale:4.0f],
                                  [CCScaleTo actionWithDuration:2 scale:2.0f], nil];
    [glow runAction:[CCRepeatForever actionWithAction:glowAnimation]];
    
    return self;
}

-(bool) compareTilePosition:(CGPoint) tilePt {
    //Log(@"Comparing input(%f,%f) with trig pos(%f,%f)",tilePt.x,tilePt.y,tilePosition.x,tilePosition.y);
    
    if (!isEnabled) {
        //Log(@"trig is not enabled");
        return false;
    }
    if (tilePt.x != tilePosition.x) {
        //Log(@"trig has a different X");
        return false;
    }
    if (tilePt.y != tilePosition.y) {
        //Log(@"trig has a different Y");
        return false;
    }

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

-(void) dealloc {
    [gameActionsToRun release];
    [glow removeFromParentAndCleanup:true];
    [glow release];
    [super dealloc];
}

@end
