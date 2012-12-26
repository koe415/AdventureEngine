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
    currentSpriteFrame = 0;
    
    NSString * firstString = (NSString *) [a objectAtIndex:currentSpriteFrame];
//    Log(@"Sprite inited to %@",firstString);
    self = [super initWithFile:firstString];
    
    if (!self) return nil;
    
    spriteNames = [[NSArray alloc] initWithArray:a];
    
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
        NSString * nextSpriteFrame = (NSString *) [spriteNames objectAtIndex:currentSpriteFrame];
        
        //Log(@"Updating animated sprite to:%@",nextSpriteFrame);
        
        currentFramesBetweenAnimation = framesBetweenAnimation;
        [self setTexture:[[CCSprite spriteWithFile:
                           nextSpriteFrame
                           ]texture]];
        
        [[self texture] setAliasTexParameters];
        
    }
}

@end
