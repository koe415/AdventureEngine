//
//  CCAnimatedSprite.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CCAnimatedSprite.h"

@implementation CCAnimatedSprite

-(id) initWithArray:(NSArray *) a {
    self = [self initWithArray:a framesBetweenAnimation:DEFAULTFRAMESBETWEENANIMATION];
    
    return self;
}

-(id) initWithArray:(NSArray *) a framesBetweenAnimation:(int) frames {
    self = [self initWithArray:a atAnimation:0 framesBetweenAnimation:frames];
    
    return self;
}

-(id) initWithArray:(NSArray *) animNames atAnimation:(int) animNumber framesBetweenAnimation:(int) frames {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"wallcomp.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                      batchNodeWithFile:@"wallcomp.png"];
    
    [self addChild:spriteSheet];
    currentSpriteFrame = animNumber;
    NSString * firstString = (NSString *)  [animNames objectAtIndex:currentSpriteFrame];
    self = [super initWithSpriteFrameName:firstString];     
    
    if (!self) return nil;
    
    spriteNames = [[NSArray alloc] initWithArray:animNames];
    
    animFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"40x40_wallcomp_0%d.png",i]];
        [animFrames addObject:frame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
    [self runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation] ]];
    
    
    currentFramesBetweenAnimation = framesBetweenAnimation = frames;
    
    typeOfLoop = 1;
    
    
    return self;
}

-(void) update {
    currentFramesBetweenAnimation--;
    
    if (currentFramesBetweenAnimation<=0) {
        // change to next sprite
        if (countingDown) {
            currentSpriteFrame--;
            if (currentSpriteFrame<0) {
                if (typeOfLoop==0) currentSpriteFrame = 0;
                else currentSpriteFrame = 0;
                countingDown = false;
            }
        } else {
            currentSpriteFrame++;
            if (currentSpriteFrame>[spriteNames count]) {
                if (typeOfLoop==0) currentSpriteFrame = 0;
                else currentSpriteFrame = [spriteNames count];
                countingDown = true;
            }
        }
        //NSString * nextSpriteFrame = (NSString *) [spriteNames objectAtIndex:currentSpriteFrame];
        
        //Log(@"Updating animated sprite to:%@",nextSpriteFrame);
        
        currentFramesBetweenAnimation = framesBetweenAnimation;
        
        
        
        
        
        //[self setTexture:[[CCSprite spriteWithFile:
        //                   nextSpriteFrame
        //                   ]texture]];
        
        //CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
        //                        spriteFrameByName:
        //                        nextSpriteFrame];
        
        /*
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]
                               spriteFrameByName:
                               nextSpriteFrame]];*/
        
        
        
        //[self setDisplayFrame:[animFrames objectAtIndex:currentSpriteFrame]];
        
        
        
        
        /*
        NSArray *frames = [animation_ frames];
        NSUInteger numberOfFrames = [frames count];
        CCSpriteFrame *frameToDisplay = nil;
        
        for( NSUInteger i=nextFrame_; i < numberOfFrames; i++ ) {
            NSNumber *splitTime = [splitTimes_ objectAtIndex:i];
            
            if( [splitTime floatValue] <= t ) {
                CCAnimationFrame *frame = [frames objectAtIndex:i];
                frameToDisplay = [frame spriteFrame];
                [(CCSprite*)target_ setDisplayFrame: frameToDisplay];
                */
        
        //[[self texture] setAliasTexParameters];
       
        
    }
}

@end
