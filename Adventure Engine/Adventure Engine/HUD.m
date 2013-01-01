//
//  TestLayerTop.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HUD.h"

static int DefaultPauseButtonOpacity = 200;

@implementation HUD

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    gd = [GameData instance];
    
    pauseButton = [[CCSprite alloc] initWithFile:@"pausebutton.png"];
    pauseButton.position = CGPointMake(30, 290);
    pauseButton.opacity = DefaultPauseButtonOpacity;
    [pauseButton setTextureRect:CGRectMake(0, 0, 60, 60)];
    
    move_panel_opacity = 30;
    
    move_panel_left = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
    move_panel_right = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
    
    move_panel_left.position = CGPointMake(20, 160 - (40/2));
    move_panel_right.position = CGPointMake(460, 160);
    
    [move_panel_left setTextureRect:CGRectMake(0, 0, 40, 320 - 40)];
    [move_panel_right setTextureRect:CGRectMake(0, 0, 40, 320)];
    
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [move_panel_left.texture setTexParameters:&params];
    [move_panel_right.texture setTexParameters:&params];
    
    move_panel_left.opacity = move_panel_opacity;
    move_panel_right.opacity = move_panel_opacity;
    
    [self addChild:pauseButton];
    [self addChild:move_panel_left];
    [self addChild:move_panel_right];
    
    return self;
}

-(void) setMovePanelVisibility:(bool) v {
    [move_panel_left stopAllActions];
    [move_panel_right stopAllActions];
    
    if (v) {
        [move_panel_left runAction:[CCFadeTo actionWithDuration:0.3 opacity:move_panel_opacity]];
        [move_panel_right runAction:[CCFadeTo actionWithDuration:0.3 opacity:move_panel_opacity]];
    } else {
        [move_panel_left runAction:[CCFadeTo actionWithDuration:0.3 opacity:0]];
        [move_panel_right runAction:[CCFadeTo actionWithDuration:0.3 opacity:0]];
    }
}

-(void) registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    
    if (location.x < 60 && location.y < 60) {
        touchOriginatedOnPause = true;
        touchDragOffPause = false;
        pauseButton.opacity = DefaultPauseButtonOpacity/2;
        Log(@"Touch began on pause");
        
        return YES;
    } else if (location.x < 60) {
        gd._playerHoldingLeft = true;
        Log(@"Touch began on move left");
        
        return YES;
    } else if (location.x > 420) {
        gd._playerHoldingRight = true;
        Log(@"Touch began on move right");
        
        return YES;
    }
    
    return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    
    if (touchOriginatedOnPause) {
        if (location.x >= 60 || location.y >= 60) {
            if (pauseButton.opacity!=DefaultPauseButtonOpacity) {
                pauseButton.opacity = DefaultPauseButtonOpacity;
                touchDragOffPause = true;
                Log(@"Touch dragged off pause");
            }
        }
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (touchOriginatedOnPause) {
        pauseButton.opacity = DefaultPauseButtonOpacity;
        touchOriginatedOnPause = false;
        
        if (!touchDragOffPause) {
            touchDragOffPause = false;
            [[CCDirector sharedDirector] pushScene:[PauseMenu node]];
        }
    } else if (gd._playerHoldingLeft) {
        gd._playerHoldingLeft = false;
        Log(@"Touch ended on move left");
    } else if (gd._playerHoldingRight) {
        gd._playerHoldingRight = false;
        Log(@"Touch ended on move right");
    }
}

@end
