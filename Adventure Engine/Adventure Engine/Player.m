//
//  Player.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/8/12.
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
    
    self = [super initWithFile:@"player.png" capacity:1];
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
    
    NSMutableArray * allIdleFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 5; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_idle1_0%d.png",i]];
        [allIdleFrames addObject:frame];
    }
    
    // Do nothing for 1 sec
    CCAnimation * idle1 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:0], nil] delay:1.0];
    idle1.restoreOriginalFrame = false;
    CCAnimate * idle1Animate = [CCAnimate actionWithAnimation:idle1];
    
    // Do nothing for 3 secs
    CCAnimation * idle2 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:0], nil] delay:3.0];
    idle2.restoreOriginalFrame = false;
    CCAnimate * idle2Animate = [CCAnimate actionWithAnimation:idle2];
    
    // blink
    CCAnimation * idle3 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:1], nil] delay:0.1];
    idle3.restoreOriginalFrame = false;
    CCAnimate * idle3Animate = [CCAnimate actionWithAnimation:idle3];
    
    // Mid arm movement to pocket
    CCAnimation * idle4 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:3], nil] delay:0.2];
    idle4.restoreOriginalFrame = false;
    CCAnimate * idle4Animate = [CCAnimate actionWithAnimation:idle4];
    
    // Hands in pocket
    CCAnimation * idle5 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:4], nil] delay:3.0];
    idle5.restoreOriginalFrame = false;
    CCAnimate * idle5Animate = [CCAnimate actionWithAnimation:idle5];
    
    // Look up
    CCAnimation * idle6 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:2], nil] delay:3.0];
    idle6.restoreOriginalFrame = false;
    CCAnimate * idle6Animate = [CCAnimate actionWithAnimation:idle6];
    
    // blink long
    CCAnimation * idle7 = [CCAnimation animationWithSpriteFrames:[NSArray arrayWithObjects:[allIdleFrames objectAtIndex:1], nil] delay:2.0];
    idle7.restoreOriginalFrame = false;
    CCAnimate * idle7Animate = [CCAnimate actionWithAnimation:idle7];
    
    CCSequence * seqDoNothing1Secs = [CCSequence actions:idle1Animate, nil];
    CCSequence * seqDoNothing2Secs = [CCSequence actions:idle1Animate,idle1Animate, nil];
    CCSequence * seqDoNothing3Secs = [CCSequence actions:idle2Animate, nil];
    CCSequence * seqBlink = [CCSequence actions:idle1Animate,idle3Animate,idle1Animate, nil];
    CCSequence * seqBlinkLong = [CCSequence actions:idle7Animate, nil];
    CCSequence * seqBlinkNap = [CCSequence actions:idle7Animate,idle7Animate,idle7Animate, nil];
    CCSequence * seqBlinkDouble = [CCSequence actions:idle1Animate,idle3Animate,idle2Animate,idle3Animate,idle1Animate,idle3Animate,idle1Animate, nil];
    CCSequence * seqHandsInPocketsLong = [CCSequence actions:idle1Animate,idle4Animate,idle5Animate,idle5Animate,idle4Animate,idle1Animate, nil];
    CCSequence * seqLookUp = [CCSequence actions:idle1Animate,idle3Animate,idle6Animate,idle3Animate,idle1Animate, nil];
    
    
    
    idleAnims = [[NSArray alloc] initWithObjects:seqDoNothing1Secs,seqDoNothing1Secs,seqDoNothing1Secs,seqDoNothing1Secs,seqDoNothing2Secs,seqDoNothing2Secs,seqDoNothing3Secs,seqBlink,seqBlink,seqBlink,seqBlink,seqBlinkDouble,seqHandsInPocketsLong,seqLookUp,seqBlinkLong,seqBlinkNap, nil];
    
    
    
    
    NSMutableArray * walk1aFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_walk1_0%d.png",i]];
        [walk1aFrames addObject:frame];
    }
    
    walk1a = [[CCAnimation alloc] initWithSpriteFrames:walk1aFrames delay:0.15f];
    walk1a.restoreOriginalFrame = false;
    
    NSMutableArray * walk1bFrames = [[NSMutableArray alloc] init];
    
    for (int i = 5; i <= 8; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_walk1_0%d.png",i]];
        [walk1bFrames addObject:frame];
    }
    
    walk1b = [[CCAnimation alloc] initWithSpriteFrames:walk1bFrames delay:0.15f];
    walk1b.restoreOriginalFrame = false;
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
    if ([playerAvatar numberOfRunningActions]==0) {
        int randomIdle = rand()%[idleAnims count];
        [playerAvatar runAction:[idleAnims objectAtIndex:randomIdle]];
        
        //[playerAvatar runAction:[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation a] times:1]];
        
    }
    
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

-(float) getVelocity {
    return playerVelocity;
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

-(void) updateLightingWith: (NSArray *) lightsArray {
    float runningLightVal = 0.0f;
    
    for (NSNumber * l in lightsArray) {
        int lightPos = [l intValue];
        int dist = playerAvatar.position.x - lightPos;
        if (dist < 0) dist = -dist;
        
        // 0 - 400, has an effect on player
        // 0 - 200 is fully lit
        // 200 - 400 is partial die off
        
        if (dist > 200) continue;
        else if (dist > 100) runningLightVal += (155.0f - (155.0f * ((dist - 100.0f) / 100.0f))); // 0 - 200
        else runningLightVal += 155.0f;
    }
    /*
    float lval = runningDist/[lightsArray count];
    if (lval>255.0f) lval = 255.0f;
    else if (lval < 0.0f) lval = 0.0f;*/
    
    
    // lightingValue = 100 - 255
    
    if (runningLightVal > 155.0f) runningLightVal = 155.0f;
    //lightingValue -= 255.0f;
    //lightingValue *= -1.0f;
    float lightingValue = 100 + runningLightVal;
    //lightingValue = 0.0f;
    
    //Log(@"%f",lightingValue);
    [playerAvatar setColor:ccc3(lightingValue, lightingValue, lightingValue)];
    //[playerAvatar setColor:ccc3(255.0f,255.0f, 255.0f)];
}

-(void) dealloc {
    [playerAvatar release];
    [idleAnims release];
    [walk1a release];
    [walk1b release];
    [super dealloc];
}

@end
