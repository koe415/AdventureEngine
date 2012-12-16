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
    
    //[self schedule:@selector(tick:)];
    
    gd = [GameData instance];
    
    pauseButton = [[CCSprite alloc] initWithFile:@"pausebutton.png"];
    pauseButton.position = CGPointMake(30, 290);
    pauseButton.opacity = DefaultPauseButtonOpacity;
    [pauseButton setTextureRect:CGRectMake(0, 0, 60, 60)];
    
    [self addChild:pauseButton];
    
    return self;
}

//-(void) tick:(ccTime) dt {
    //NSLog(@"top layer tick");
//}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    
    if (location.x < 60 && location.y < 60) {
        touchOriginatedOnPause = true;
        gd._touchHandled = true;
        pauseButton.opacity = DefaultPauseButtonOpacity/2;
        Log(@"changed pause opacity!");
        
        return YES;
    }
    
    return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    //NSArray *touchArr = [touches allObjects];
    //UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [touch locationInView:[touch view]];
    
    if (!touchOriginatedOnPause) return;
    
    if (location.x >= 60 || location.y >= 60) {
        if (pauseButton.opacity!=DefaultPauseButtonOpacity) {
            pauseButton.opacity = DefaultPauseButtonOpacity;
            Log(@"changed pause opacity");
        }
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //NSArray *touchArr = [touches allObjects];
    //UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [touch locationInView:[touch view]];
    
    if (touchOriginatedOnPause) {
        // check pause button selection!
        if (location.x < 60 && location.y < 60) {
            //pauseButton.opacity = DefaultPauseButtonOpacity;
            gd._paused = true;
            //[[CCDirector sharedDirector] pushScene:[PauseMenu node]];
        }
        
        pauseButton.opacity = DefaultPauseButtonOpacity;
        touchOriginatedOnPause = false;
        
        gd._touchHandled = false;
    }
}

@end
