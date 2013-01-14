//
//  Player.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Engine.h"

const int DefaultPlayerDirection = RIGHT;

@implementation Player

-(id) init {
    return [self initAtPosition:CGPointMake(0, 0) facing:RIGHT];
}

-(id) initAtPosition:(CGPoint) pos facing:(Direction) d {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"player.plist"]];
    
    //self = [CCSpriteBatchNode batchNodeWithFile:@"player.png"];
    self = [super initWithFile:@"player.png" capacity:3];
    if (!self) return nil;
    
    playerAvatar = [[CCSprite alloc] initWithSpriteFrameName:@"player_01.png"];
    [playerAvatar setScale:2.0f];
    [[playerAvatar texture] setAliasTexParameters];
    
    [self setPositionManually:pos];
    
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

-(bool) attemptMoveInDirection:(Direction) d {
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
    
    return [self moveToPosition:CGPointMake(playerAvatar.position.x+playerVelocity, playerAvatar.position.y)];
}

-(bool) attemptNoMove {
    if (playerVelocity == 0.0f) {
        return false;
    } else if (playerVelocity > 0.0f) {
        playerVelocity -= 0.15f;
        if (playerVelocity < 0.0f) playerVelocity = 0.0f;
    } else if (playerVelocity < 0.0f) {
        playerVelocity += 0.15f;
        if (playerVelocity > 0.0f) playerVelocity = 0.0f;
    }
    
    return [self moveToPosition:CGPointMake(playerAvatar.position.x+playerVelocity, playerAvatar.position.y)];
}

// Handles hitting barriers, world boundaries
-(bool) moveToPosition:(CGPoint)position {
    if (position.x > playerAvatar.position.x) {
        [self setFacing:RIGHT];
    } else if (position.x < playerAvatar.position.x) {
        [self setFacing:LEFT];
    }
    
    // Determine Valid Move
    if ([Logic checkValidPosition:position]) {
        if ([playerAvatar numberOfRunningActions]==0)
            [playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walkAnimation] times:1]];
        
        [GameData instance]._playerPosition = position.x;
        [playerAvatar setPosition:position];
        if ((int)(position.x/40) != xTilePosition) {
            //Log(@"calc new tile position");
            [((Engine *) (self.parent.parent)) handleTriggerAt:CGPointMake((int)(position.x/40 + 1),2)];
            xTilePosition = position.x/40;
        }
        return true;
    } else {
        // Not valid position
        playerVelocity = 0;
        return false;
    }
}

-(void) setPositionManually:(CGPoint)position {
    playerVelocity = 0.0f;
    [GameData instance]._playerPosition = position.x;
    [playerAvatar setPosition:position];
    xTilePosition = position.x/40;
}

-(CGPoint) getPosition {
    return playerAvatar.position;
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

-(void) dealloc {
    [playerAvatar release];
    [walkAnimation release];
    [super dealloc];
}

@end
