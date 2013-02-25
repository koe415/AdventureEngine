//
//  Logic.m
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//

#import "Logic.h"

@implementation Logic

#pragma mark Player Movement

+(bool) checkValidPosition:(CGPoint) newPosition {
    NSArray * barriers = [NSArray arrayWithArray:[GameData instance]._barriers];
    
    float currentPlayerPos = [GameData instance]._playerPosition;
    
    for (Barrier * b in barriers) {
        if (![b isEnabled]) continue;
        
        float leftEdge = [b getLeftEdge];
        float rightEdge = [b getRightEdge];
        
        if (currentPlayerPos < leftEdge) {
            if (newPosition.x + 20.0f > leftEdge) {
                return false;
            }
        } else if (currentPlayerPos > rightEdge) {
            if (newPosition.x - 20.0f < rightEdge) {
                return false;
            }
        }
    }
    
    return true;
}

#pragma mark World

+(CGPoint) worldPositionFromTap:(CGPoint) tapPt {
    return CGPointMake(
               (0 - [GameData instance]._cameraPosition.x + tapPt.x),
               (320 - [GameData instance]._cameraPosition.y - tapPt.y));
}

@end
