//
//  Logic.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
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
