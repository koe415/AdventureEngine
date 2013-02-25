//
//  Triggerable.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "GameData.h"

@interface Triggerable : NSObject {
    int identity;
    CGPoint tilePosition;
    bool isEnabled;
    NSArray * gameActionsToRun;
    
    CCSprite * glow;
}

+(id) triggerableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled;
+(id) triggerableWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent;

-(id) initWithPosition:(CGPoint) pt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled;
-(bool) compareTilePosition:(CGPoint) tilePt;
-(NSArray *) getActions;
-(int) getIdentity;
-(void) setEnabled:(bool) inputStatus;
-(CCSprite *) getGlow;

@end
