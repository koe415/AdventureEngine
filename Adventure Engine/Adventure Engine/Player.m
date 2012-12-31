//
//  Player.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

const int DefaultPlayerDirection = RIGHT;

@implementation Player

-(id) initAtPosition:(CGPoint) pos facing:(Direction) d {
    self = [super initWithFile:@"player.png"];
    if (!self) return nil;
    
    [super setPosition:pos];
    [self setScale:2.0f];
    [[self texture] setAliasTexParameters];
    
    playerDirection = RIGHT;
    [self setFacing:d];
    
    return self;
}

-(void) attemptMoveInDirection:(Direction) d {
    if (d == LEFT) {
        if (playerVelocity < -2.0f) playerVelocity -= 0.005f;
        else if (playerVelocity < -1.5f) playerVelocity -= 0.01f;
        else if (playerVelocity < 0.0f) playerVelocity -= 0.15f;
        else playerVelocity -= 0.2f;
        
        
        if (playerVelocity < -MAXPLAYERSPEED) {
            playerVelocity = -3.0f;
            Log(@"player hit max speed");
        }
    } else if (d == RIGHT) {
        if (playerVelocity > 2.0f) playerVelocity += 0.005f;
        else if (playerVelocity > 1.5f) playerVelocity += 0.01f;
        else if (playerVelocity > 0.0f) playerVelocity += 0.15f;
        else playerVelocity += 0.2f;
        
        if (playerVelocity > MAXPLAYERSPEED) {
            playerVelocity = 3.0f;
            Log(@"player hit max speed");
        }
    }
    
    [self setPosition:CGPointMake(self.position.x+playerVelocity, self.position.y)];
}

-(void) attemptNoMove {
    if (playerVelocity == 0.0f) {
        return;
    } else if (playerVelocity > 0.0f) {
        playerVelocity -= 0.15f;
        if (playerVelocity < 0.0f) playerVelocity = 0.0f;
    } else if (playerVelocity < 0.0f) {
        playerVelocity += 0.15f;
        if (playerVelocity > 0.0f) playerVelocity = 0.0f;
    }
    
    [self setPosition:CGPointMake(self.position.x+playerVelocity, self.position.y)];
}

// Handles hitting barriers, world boundaries
-(void) setPosition:(CGPoint)position {
    if (position.x > self.position.x) {
        [self setFacing:RIGHT];
    } else if (position.x < self.position.x) {
        [self setFacing:LEFT];
    }
    
    // Determine Valid Move
    //if (position.x - 20 < 0) {
    if (position.x - 20 < (60*2)) {
        playerVelocity = 0;
        return;
    } else if (position.x + 20 > (260*2)) {
        playerVelocity = 0;
        return;
    }
    
    [super setPosition:position];
}

-(void) setFacing:(Direction) d {
    // if player is already facing the input direction
    if (playerDirection==d) return;
    
    if (d == LEFT)
        self.scaleX = -2.0f;
    else if (d == RIGHT)
        self.scaleX = 2.0f;
    
    playerDirection = d;
}

@end
