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
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"player.plist"]];
    
    //self = [CCSpriteBatchNode batchNodeWithFile:@"player.png"];
    self = [super initWithFile:@"player.png" capacity:3];
    if (!self) return nil;
    
    playerAvatar = [[CCSprite alloc] initWithSpriteFrameName:@"player_01.png"];
    [playerAvatar setPosition:pos];
    [playerAvatar setScale:2.0f];
    [[playerAvatar texture] setAliasTexParameters];
    
    playerDirection = RIGHT;
    [self setFacing:d];
    
    [self addChild:playerAvatar];
    
    
    NSMutableArray * walkFrames = [[NSMutableArray alloc] init];
    
    for (int i = 2; i <= 3; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_0%d.png",i]];
        [walkFrames addObject:frame];
    }
    
    walkAnimation = [[CCAnimation alloc] initWithSpriteFrames:walkFrames delay:0.2f];
    walkAnimation.restoreOriginalFrame = true;
    
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
    
    [self setPosition:CGPointMake(playerAvatar.position.x+playerVelocity, playerAvatar.position.y)];
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
    
    [self setPosition:CGPointMake(playerAvatar.position.x+playerVelocity, playerAvatar.position.y)];
}

-(CGPoint) getPosition {
    return playerAvatar.position;
}

// Handles hitting barriers, world boundaries
-(void) setPosition:(CGPoint)position {
    if (position.x > playerAvatar.position.x) {
        [self setFacing:RIGHT];
    } else if (position.x < playerAvatar.position.x) {
        [self setFacing:LEFT];
    }
    
    
    // Determine Valid Move
    if ([Logic checkValidPosition:position]) {
        if ([playerAvatar numberOfRunningActions]==0)
            [playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walkAnimation] times:1]];
        [playerAvatar setPosition:position];
        return;
    } else {
        // Not valid position
        playerVelocity = 0;
        return;
    }
}

-(void) setFacing:(Direction) d {
    // if player is already facing the input direction
    if (playerDirection==d) return;
    
    if (d == LEFT)
        [playerAvatar setScaleX: -2.0f];
    else if (d == RIGHT)
        [playerAvatar setScaleX: 2.0f];
    
    playerDirection = d;
}

@end
