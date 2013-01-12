//
//  Logic.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameData.h"
#import "DebugFlags.h"
#import "cocos2d.h"
#import "Barrier.h"

@interface Logic : NSObject;

+(bool) checkValidPosition:(CGPoint) newPosition;
+(CGPoint) worldPositionFromTap:(CGPoint) tapPt;

@end
