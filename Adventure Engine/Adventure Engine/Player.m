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
    
    self = [super initWithFile:@"player.png" capacity:3];
    if (!self) return nil;
    
    playerAvatar = [[CCSprite alloc] initWithSpriteFrameName:@"player_idle1_01.png"];
    [playerAvatar setScale:2.0f];
    [[playerAvatar texture] setAliasTexParameters];
    
    [self setPositionManually:pos];
    
    playerDirection = RIGHT;
    [self setFacing:d];
    
    [self addChild:playerAvatar];
    
    [self setupAnimations];
    
    return self;
}

-(void) setupAnimations {
    NSMutableArray * idle1Frames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_idle1_0%d.png",i]];
        [idle1Frames addObject:frame];
    }
    
    idle1 = [[CCAnimation alloc] initWithSpriteFrames:idle1Frames delay:0.5f];
    idle1.restoreOriginalFrame = true;
    
    NSMutableArray * walk1aFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_walk1_0%d.png",i]];
        [walk1aFrames addObject:frame];
    }
    
    walk1a = [[CCAnimation alloc] initWithSpriteFrames:walk1aFrames delay:0.15f];
    walk1a.restoreOriginalFrame = true;
    
    NSMutableArray * walk1bFrames = [[NSMutableArray alloc] init];
    
    for (int i = 5; i <= 8; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_walk1_0%d.png",i]];
        [walk1bFrames addObject:frame];
    }
    
    walk1b = [[CCAnimation alloc] initWithSpriteFrames:walk1bFrames delay:0.15f];
    walk1b.restoreOriginalFrame = true;
}

-(bool) attemptMoveInDirection:(Direction) d {
    if (playerVelocity == 0.0f)
        [playerAvatar stopAllActions];
    
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
    if ([playerAvatar numberOfRunningActions]==0)
        [playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:idle1] times:1]];
    
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
        //[playerAvatar stopAllActions];
        if ([playerAvatar numberOfRunningActions]==0) {
            if (playingWalk1a) {
                [playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walk1b] times:1]];
                playingWalk1a = false;
            } else {
                [playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walk1a] times:1]];
                playingWalk1a = true;
            }
        }
        
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
    [idle1 release];
    [walk1a release];
    [walk1b release];
    [super dealloc];
}

@end
