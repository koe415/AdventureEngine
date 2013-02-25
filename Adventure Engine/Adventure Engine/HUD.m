//
//  TestLayerTop.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//

#import "HUD.h"

static int PauseButtonOpacity = 200;
static int PauseButtonPressedOpacity = 100;

static int MovePanelOpacity = 30;
static int MovePanelPressedOpacity = 20;

static int FlashButtonOpacity = 200;
static int FlashButtonPressedOpacity = 100;

static float HUDVisibilityTransition = 0.3f;

@implementation HUD

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    gd = [GameData instance];
    
    pauseButton = [[CCSprite alloc] initWithFile:@"pausebutton.png"];
    pauseButton.position = CGPointMake(30, 290);
    pauseButton.opacity = PauseButtonOpacity;
    [pauseButton setTextureRect:CGRectMake(0, 0, 60, 60)];
    
    move_panel_left = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
    move_panel_right = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
    
    move_panel_left.position = CGPointMake(20, 160 - (40/2));
    move_panel_right.position = CGPointMake(460, 160);
    
    [move_panel_left setTextureRect:CGRectMake(0, 0, 40, 320 - 40)];
    [move_panel_right setTextureRect:CGRectMake(0, 0, 40, 320)];
    
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [move_panel_left.texture setTexParameters:&params];
    [move_panel_right.texture setTexParameters:&params];
    
    move_panel_left.opacity = MovePanelOpacity;
    move_panel_right.opacity = MovePanelOpacity;
    
    flashButton = [[CCSprite alloc] initWithFile:@"gray.png"];
    flashButton.position = CGPointMake(240, 20);
    [flashButton setTextureRect:CGRectMake(0, 0, 120, 40)];
    [flashButton.texture setTexParameters:&params];
    flashButton.opacity = FlashButtonOpacity;
    
    [self addChild:pauseButton];
    [self addChild:flashButton];
    [self addChild:move_panel_left];
    [self addChild:move_panel_right];

    return self;
}

-(void) setPanelVisibility:(bool) v {
    [move_panel_left stopAllActions];
    [move_panel_right stopAllActions];
    
    if (v) {
        Log(@"Making panels visible");
        [move_panel_left runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:MovePanelOpacity]];
        [move_panel_right runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:MovePanelOpacity]];
        [flashButton runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:FlashButtonOpacity]];
    } else {
        Log(@"Making panels invisible!!");
        [move_panel_left runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:0]];
        [move_panel_right runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:0]];
        [flashButton runAction:[CCFadeTo actionWithDuration:HUDVisibilityTransition opacity:0]];
    }
}

-(void) registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) endUserInteraction {
    gd._playerHoldingLeft = false;
    gd._playerHoldingRight = false;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    
    if (location.x < 60 && location.y < 60) {
        touchOrigin = PAUSE;
        pauseButton.opacity = PauseButtonPressedOpacity;
        Log(@"Touch began on pause");
        
        return YES;
    } else if ([GameData instance]._actionDelay) {
        Log(@"Touch ignored due to action delay");
        return YES;
    } else if ([GameData instance]._actionRunning) {
        Log(@"Touch ignored due to action running");
        return YES;
    } else if (location.x < 60) {
        [move_panel_left setOpacity:MovePanelPressedOpacity];
        gd._playerHoldingLeft = true;
        touchOrigin = LEFT_MOVE;
        Log(@"Touch began on move left");
        return YES;
    } else if (location.x > 420) {
        [move_panel_right setOpacity:MovePanelPressedOpacity];
        gd._playerHoldingRight = true;
        touchOrigin = RIGT_MOVE;
        Log(@"Touch began on move right");
        return YES;
    } else if (location.y > 280) {
        flashButton.opacity = FlashButtonPressedOpacity;
        touchOrigin = FLASH;
        Log(@"Touch began on flash button");
        return YES;
    }
    
    return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    
    switch (touchOrigin) {
        case PAUSE:
            if (touchDraggedOffOriginButton) {
                if (location.x < 60 && location.y < 60) {
                    pauseButton.opacity = PauseButtonPressedOpacity;
                    touchDraggedOffOriginButton = false;
                    Log(@"Touch dragged back onto pause");
                }
            } else {
                if (location.x >= 60 || location.y >= 60) {
                    pauseButton.opacity = PauseButtonOpacity;
                    touchDraggedOffOriginButton = true;
                    Log(@"Touch dragged off pause");
                }
            }
            break;
        case FLASH:
            if (touchDraggedOffOriginButton) {
                if (location.y > 280) {
                    flashButton.opacity = FlashButtonPressedOpacity;
                    touchDraggedOffOriginButton = false;
                    Log(@"Touch dragged back onto flash button");
                }
            } else {
                if (location.y <= 280) {
                    flashButton.opacity = FlashButtonOpacity;
                    touchDraggedOffOriginButton = true;
                    Log(@"Touch dragged off flash button");
                }
            }
            break;
        default:
            break;
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    switch (touchOrigin) {
        case PAUSE:
            pauseButton.opacity = PauseButtonOpacity;
            
            if (!touchDraggedOffOriginButton) {
                [[CCDirector sharedDirector] pushScene:[PauseMenu node]];
            }
            break;
        case LEFT_MOVE:
            [move_panel_left setOpacity:MovePanelOpacity];
            gd._playerHoldingLeft = false;
            Log(@"Touch ended on move left");
            break;
        case RIGT_MOVE:
            [move_panel_right setOpacity:MovePanelOpacity];
            gd._playerHoldingRight = false;
            Log(@"Touch ended on move right");
            break;
        case FLASH:
            flashButton.opacity = FlashButtonOpacity;
            
            if (!touchDraggedOffOriginButton) {
                Log(@"FLASHED!");
                gd._playerPressedFlash = true;
            }
            break;
        default:
            
            break;
    }

    touchDraggedOffOriginButton = false;
}

-(void) dealloc {
    [pauseButton release];
    [flashButton release];
    [move_panel_left release];
    [move_panel_right release];
    [super dealloc];
}

@end
