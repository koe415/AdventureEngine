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

#define DEFAULTFRAMESBETWEENANIMATION 30

@interface CCAnimatedSprite : CCSprite {
    NSArray * spriteNames;
    int currentSpriteFrame;
    int framesBetweenAnimation; // what currentFramesBetweenAnimation resets to
    int currentFramesBetweenAnimation;
    int typeOfLoop; // 0 - start from zero after loop
                    // 1 - count back down to zero
    bool countingDown;
    
}

-(id) initWithArray:(NSArray *) a;
-(id) initWithArray:(NSArray *) a framesBetweenAnimation:(int) frames;
-(void) update;

@end
