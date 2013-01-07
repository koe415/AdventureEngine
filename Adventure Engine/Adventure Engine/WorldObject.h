//
//  WorldObject.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"

@interface WorldObject : CCSprite {
    NSString * identy;
    bool loopsToFirst;
    NSArray * animations;
}

-(id) initWithID:(NSString *) inputIdentity loopsFromStart:(bool) inputLoops;
-(void) addAnimation:(NSArray *) inputAnimation;
-(void) playAnimation:(int) animNum stayOut:(bool) inputStayOut;

@end
