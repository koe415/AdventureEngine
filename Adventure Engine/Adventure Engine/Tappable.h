//
//  Tappable.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Tappable : NSObject {
    int identity;
    CGPoint tilePosition;
    bool isEnabled;
    NSArray * gameActionsToRun; // Tappable cares not what is in the array
    
    CCSprite * glow;
}

-(id) initWithPosition:(CGPoint) pt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled;
-(id) initWithPosition:(CGPoint) pt withActions:(NSArray *) actions withIdentity:(int) inputIdent;
-(bool) compareTilePosition:(CGPoint) tilePt;
-(NSArray *) getActions;
-(int) getIdentity;
-(void) setEnabled:(bool) inputStatus;
-(CCSprite *) getGlow;

@end
