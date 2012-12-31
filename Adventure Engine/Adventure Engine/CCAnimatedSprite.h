//
//  CCAnimatedSprite.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"

#define DEFAULTFRAMESBETWEENANIMATION 10

@interface CCAnimatedSprite : CCSprite {
    NSArray * spriteNames;
    int currentSpriteFrame;
    int framesBetweenAnimation; // what currentFramesBetweenAnimation resets to
    int currentFramesBetweenAnimation;
    int typeOfLoop; // 0 - start from zero after loop
                    // 1 - count back down to zero
    bool countingDown;
    
    NSMutableArray * animFrames;
}

-(id) initWithArray:(NSArray *) a;
-(id) initWithArray:(NSArray *) a framesBetweenAnimation:(int) frames;
-(id) initWithArray:(NSArray *) animNames atAnimation:(int) animNumber framesBetweenAnimation:(int) frames;
-(void) update;

@end
