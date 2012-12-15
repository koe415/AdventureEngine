//
//  TestLayerTop.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestLayerTop.h"

static int DefaultPauseButtonOpacity = 200;

@implementation TestLayerTop

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    [self schedule:@selector(tick:)];
    
    gd = [GameData instance];
    
    pauseButton = [[CCSprite alloc] initWithFile:@"pausebutton.png"];
    pauseButton.position = CGPointMake(30, 290);
    pauseButton.opacity = DefaultPauseButtonOpacity;
    [pauseButton setTextureRect:CGRectMake(0, 0, 60, 60)];
    
    [self addChild:pauseButton];
    
    return self;
}

-(void) tick:(ccTime) dt {
    //NSLog(@"top layer tick");
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"top layer recognized touch begin");
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    if (location.x < 60 && location.y < 60) {
        touchOriginatedOnPause = true;
        gd._touchHandled = true;
        pauseButton.opacity = DefaultPauseButtonOpacity/2;
        NSLog(@"changed pause opacity");
    }
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    if (!touchOriginatedOnPause) return;
    
    if (location.x >= 60 || location.y >= 60) {
        if (pauseButton.opacity==DefaultPauseButtonOpacity) {
            pauseButton.opacity = DefaultPauseButtonOpacity/2;
            NSLog(@"changed pause opacity");
        }
    } else if (location.x < 60 && location.y < 60) {
        if (pauseButton.opacity!=DefaultPauseButtonOpacity) {
            pauseButton.opacity = DefaultPauseButtonOpacity;
            NSLog(@"changed pause opacity back");
        }
    }
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArr = [touches allObjects];
    UITouch *aTouch = [touchArr objectAtIndex:0];
    CGPoint location = [aTouch locationInView:[aTouch view]];
    
    if (touchOriginatedOnPause) {
        // check pause button selection!
        if (location.x < 60 && location.y < 60) {
            //pauseButton.opacity = DefaultPauseButtonOpacity;
            gd._paused = !gd._paused;
        }
        
        pauseButton.opacity = DefaultPauseButtonOpacity;
        touchOriginatedOnPause = false;
        
        gd._touchHandled = false;
    }
}

@end
