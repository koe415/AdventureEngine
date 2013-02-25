//
//  WorldObject.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//

#import "WorldObject.h"

@implementation WorldObject

+(id) objectWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity withIdle:(CCAnimation *) inputIdle {
    WorldObject * o = [[[WorldObject alloc] initWithPos:inputPos withID:inputIdentity withIdle:(CCAnimation *) inputIdle] autorelease];
    [[GameData instance]._worldObjects addObject:o];
    return o;
}

-(id) initWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity withIdle:(CCAnimation *) inputIdle {
    CCSpriteFrame * objectInitialFrame = [[[inputIdle frames] objectAtIndex:0] spriteFrame];

    self = [super initWithSpriteFrame:objectInitialFrame];
    if (!self) return nil;
    
    [self setPosition:CGPointMake(((inputPos.x-1) * 20 * 2) + 20, ((inputPos.y-1) * 20 * 2) + 20)];
    [self setScale:2];
    [[self texture] setAliasTexParameters];
    
    identity = [[NSString alloc] initWithFormat:@"%@",inputIdentity];
    animations = [[NSMutableArray alloc] init];
    
    [self addAnimation:inputIdle];
    [self playAnimation:1 loop:true];
    
    return self;
}

-(void) addAnimation:(CCAnimation *) inputAnimation {
    [animations addObject:inputAnimation];
}

-(void) playAnimation:(int) animNum {
    [self playAnimation:animNum loop:false];
}

-(void) playAnimation:(int) animNum loop:(bool) animLoops {
    [self stopAllActions];
    if (animLoops)
        [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[animations objectAtIndex:animNum-1]]]];
    else [self runAction:[CCAnimate actionWithAnimation:[animations objectAtIndex:animNum-1]]];
}

-(bool) compareWith:(NSString *) inputString {
    return [identity isEqualToString:inputString];
}

-(void) dealloc {
    [identity release];
    [animations removeAllObjects];
    [animations release];
    [super dealloc];
}

@end
