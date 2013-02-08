//
//  Tappable.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "Barrier.h"
#import "DebugFlags.h"

@interface Tappable : NSObject {
    int identity;
    CGPoint tilePosition;
    bool isEnabled;
    NSArray * gameActionsToRun; // Tappable cares not what is in the array
    CGSize size;
    NSMutableArray * prereqs;
    NSMutableArray * gameActionsIfPrereqsNotMet;
    
    CCSprite * glow;
}

+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled;
// Gives size as (1,1) and enabled as true
+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent;

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled;
-(bool) isTileBlockedByBarrier;
-(void) addPrereq:(NSString *) p;
-(bool) arePrereqsMet;
-(void) addGameActionsIfPrereqsNotMet:(NSArray *) inputGameActions;
-(NSArray *) gameActionsIfPrereqsNotMet;
-(bool) compareTilePosition:(CGPoint) tilePt;
-(NSArray *) getActions;
-(int) getIdentity;
-(void) setEnabled:(bool) inputStatus;
-(void) updateGlow;
-(CCSprite *) getGlow;
//-(void) setOpacity:(int) opac;
//-(CGPoint) getGlowPosition;

@end
