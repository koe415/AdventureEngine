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

@interface Tappable : NSObject {
    int identity;
    CGPoint tilePosition;
    bool isEnabled;
    NSArray * gameActionsToRun; // Tappable cares not what is in the array
    CGSize size;
    
    CCSprite * glow;
}

+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled;
// Gives size as (1,1) and enabled as true
+(id) tappableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent;

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withSize:(CGSize) inputSize withIdentity:(int) inputIdent isEnabled:(bool) enabled;
-(bool) isTileBlockedByBarrier;
-(bool) compareTilePosition:(CGPoint) tilePt;
-(NSArray *) getActions;
-(int) getIdentity;
-(void) setEnabled:(bool) inputStatus;
-(CCSprite *) getGlow;
-(void) setOpacity:(int) opac;
-(CGPoint) getGlowPosition;

@end
