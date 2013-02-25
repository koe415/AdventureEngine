//
//  Zombie.m
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import "Zombie.h"

@implementation Zombie

static int dist_sees_player = 160;
static int dist_losses_player = 240;

-(id) init {
    self = [super initWithSpriteFrameName:@"zombie_idle1_01.png"];
    if (!self) return nil;
    
    [self setScale:2.0f];
    [[self texture] setAliasTexParameters];
    
    [self setupAnimations];
    
    creatureState = IDLE;
    creatureDir = RIGHT;
    
    return self;
}

-(void) update {
    if ([self numberOfRunningActions] != 0) return;
    
    GameData * gd = [GameData instance];
    
    switch (creatureState) {
        case IDLE: // Slow
            //Log(@"Zombie Idle");
            
            if ((rand()%2)==0) [self setFacing:LEFT];
            else [self setFacing:RIGHT];
            
            /*
            if (gd._playerPosition > self.position.x && creatureDir == RIGHT) {
                float distBetween = gd._playerPosition - self.position.x;
                if (distBetween < dist_sees_player) {
                    creatureState = PURSUIT;
                    break;
                }
                
                
            } else if (gd._playerPosition < self.position.x && creatureDir == LEFT) {
                float distBetween = self.position.x - gd._playerPosition;
                if (distBetween < dist_sees_player) {
                    creatureState = PURSUIT;
                    break;
                }
            }
            */
            int r = rand()%3;
            if (r==0) [self runAction:[CCAnimate actionWithAnimation:idle1]];
            else if (r==0) [self runAction:[CCAnimate actionWithAnimation:idle2]];
            else [self runAction:[CCAnimate actionWithAnimation:idle3]];
            break;
        case AGGRESSIVE: // Saw player, movement fast
            //Log(@"Zombie Agressive");
            break;
        case PURSUIT: // See player, chasing
            //Log(@"Zombie Pursuit");
            if (gd._playerPosition > self.position.x) { 
                [self setFacing:RIGHT];
                float distBetween = gd._playerPosition - self.position.x;
                if (distBetween > dist_losses_player) {creatureState = IDLE; break;}
                [self runAction:pursuitRight];
            } else {
                [self setFacing:LEFT];
                float distBetween = self.position.x - gd._playerPosition;
                if (distBetween > dist_losses_player) {creatureState = IDLE; break;}
                [self runAction:pursuitLeft];
            }
            break;
        case FLASHED: // injured, recovering
            [self setOpacity:255];
            creatureState = IDLE;
            break;
        default:
            break;
    }
}

-(void) isFlashed {
    if (creatureState!=FLASHED) {
        [self stopAllActions];
        [self runAction:flashed];
        creatureState = FLASHED;
        [self setOpacity:150];
    }
}

-(void) setupAnimations {
    NSMutableArray * walk1aFrames = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 4; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"zombie_walk1_0%d.png",i]];
        [walk1aFrames addObject:frame];
    }
    
    walk1a = [[CCAnimation alloc] initWithSpriteFrames:walk1aFrames delay:0.15f];
    walk1a.restoreOriginalFrame = false;
    
    NSMutableArray * walk1bFrames = [[NSMutableArray alloc] init];
    
    for (int i = 5; i <= 8; i++) {
        CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"zombie_walk1_0%d.png",i]];
        [walk1bFrames addObject:frame];
    }
    
    walk1b = [[CCAnimation alloc] initWithSpriteFrames:walk1bFrames delay:0.15f];
    walk1b.restoreOriginalFrame = false;
    
    
    NSMutableArray * idle1Frames = [[NSMutableArray alloc] init];
    
    [idle1Frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"zombie_idle1_01.png"]];
    
    idle1 = [[CCAnimation alloc] initWithSpriteFrames:idle1Frames delay:0.15f];
    idle1.restoreOriginalFrame = false;
    
    NSMutableArray * idle2Frames = [[NSMutableArray alloc] init];
    
    [idle2Frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"zombie_idle1_02.png"]];
    
    idle2 = [[CCAnimation alloc] initWithSpriteFrames:idle2Frames delay:0.5f];
    idle2.restoreOriginalFrame = false;
    
    NSMutableArray * idle3Frames = [[NSMutableArray alloc] init];
    
    [idle3Frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"zombie_idle1_03.png"]];
    
    idle3 = [[CCAnimation alloc] initWithSpriteFrames:idle3Frames delay:1.0];
    idle3.restoreOriginalFrame = false;
    
    
    
    pursuitLeft = [[CCSequence actions:[CCMoveBy actionWithDuration:1.0 position:ccp(-20,0)],[CCDelayTime actionWithDuration:1], nil] retain];
    pursuitRight = [[CCSequence actions:[CCMoveBy actionWithDuration:1.0 position:ccp(20,0)],[CCDelayTime actionWithDuration:1], nil] retain];
    
    flashed = [[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0,-40)],[CCDelayTime actionWithDuration:5],[CCMoveBy actionWithDuration:3 position:ccp(0,40)], nil] retain];
}

@end
