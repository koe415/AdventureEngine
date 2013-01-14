//
//  WorldObject.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WorldObject.h"

@implementation WorldObject

+(id) objectWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity {
    WorldObject * o = [[[WorldObject alloc] initWithPos:inputPos withID:inputIdentity] autorelease];
    [[GameData instance]._worldObjects addObject:o];
    return o;
}

-(id) initWithPos:(CGPoint) inputPos withID:(NSString *) inputIdentity {
    self = [super initWithSpriteFrameName:@"objects_01.png"];
    if (!self) return nil;
    
    [self setPosition:CGPointMake(((inputPos.x-1) * 20 * 2) + 20, ((inputPos.y-1) * 20 * 2) + 20)];
    [self setScale:2];
    [[self texture] setAliasTexParameters];
    
    identity = [[NSString alloc] initWithFormat:@"%@",inputIdentity];
    animations = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) addAnimation:(CCAnimation *) inputAnimation {
    [animations addObject:inputAnimation];
    
    if ([animations count]==1) { // if first animation added, make it idle
        //if ([inputAnimation.frames count] >1) {
        //    [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:inputAnimation]]];
        //} else {
        [self runAction:[CCAnimate actionWithAnimation:inputAnimation]];
        //}
    }
}

-(void) playAnimation:(int) animNum {
    [self runAction:[CCAnimate actionWithAnimation:[animations objectAtIndex:animNum-1]]];
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
