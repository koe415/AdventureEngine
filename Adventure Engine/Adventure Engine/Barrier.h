//
//  Barrier.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"

@interface Barrier : NSObject {
    float position;
    float totalWidth;
    NSString * identity;
    bool active;
    CCSprite * visual;
}

// Defaults to 0 width
// NOTE: Barrier always defaults to disabled upon initialization.
//       Up to world to enable.
+(id) barrierWithPosition:(float) inputPos withID:(NSString *)inputID;
+(id) barrierWithPosition:(float) inputPos withWidth:(float) inputTotalWidth withID:(NSString *)inputID;

-(id) initWithPosition:(float) inputPos withWidth:(float) inputTotalWidth withID:(NSString *)inputID;
-(float) getCenter;
-(float) getLeftEdge;
-(float) getRightEdge;
-(void) setEnabled:(bool) inputActive;
-(bool) isEnabled;
-(bool) compareWith:(NSString *) inputString;
-(CCSprite *) getVisual;


@end
