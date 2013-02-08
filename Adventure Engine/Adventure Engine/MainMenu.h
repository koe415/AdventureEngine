//
//  MainMenu.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "Engine.h"
#import "GameData.h"

@interface MainMenu : CCLayer {
    CCNode * text_shadows;
    CGPoint previousTouchPosition;
    CGPoint currentShadowOffset;
    
    UITapGestureRecognizer * _doubleTapRecognizer;
    
    CCSprite * planet;
    CCSprite * planet_clouds;
    CCSprite * planet_clouds_slow;
    CCSprite * planet_clouds_slowest;
    CCSprite * planet_cutout;
    float planet_x;
}

@property (retain) UITapGestureRecognizer * doubleTapRecognizer;

+(CCScene *) scene;
- (void)onContinue:(id)sender;
- (void)onNewGame:(id)sender;

@end
