//
//  Barrier.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Barrier.h"

@implementation Barrier

+(id) barrierWithPosition:(float) inputPos withID:(NSString *)inputID {
    Barrier * b = [[[Barrier alloc] initWithPosition:inputPos withWidth:0.0f withID:inputID] autorelease];
    [[GameData instance]._barriers addObject:b];
    return b;
}

+(id) barrierWithPosition:(float) inputPos withWidth:(float) inputTotalWidth withID:(NSString *)inputID {
    Barrier * b = [[[Barrier alloc] initWithPosition:inputPos withWidth:inputTotalWidth withID:inputID] autorelease];
    [[GameData instance]._barriers addObject:b];
    return b;
}

-(id) initWithPosition:(float) inputPos withWidth:(float) inputTotalWidth withID:(NSString *)inputID {
    self = [super init];
    if(!self) return nil;
    
    position = inputPos;
    totalWidth = inputTotalWidth;
    identity = inputID;
    
    visual = [[CCSprite alloc] initWithFile:@"red.png"];
    [visual setPosition:ccp(inputPos, 160)];
    [visual setOpacity:200];
    if (totalWidth!=0.0f) [visual setTextureRect:CGRectMake(0, 0, totalWidth, 320)];
    else [visual setTextureRect:CGRectMake(0, 0, 1, 320)];
    
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [visual.texture setTexParameters:&params];
    
    visual.visible = false;
    CCSequence * visualAnimation = [CCSequence actions:
                                  [CCFadeTo actionWithDuration:2.5 opacity:0],
                                  [CCFadeTo actionWithDuration:2.5 opacity:150], nil];
    [visual runAction:[CCRepeatForever actionWithAction:visualAnimation]];
    
    return self;
}

-(float) getCenter {
    return position;
}

-(float) getLeftEdge {
    return position - (totalWidth/2.0f);
}

-(float) getRightEdge {
    return position + (totalWidth/2.0f);
}

-(void) setEnabled:(bool) inputActive {
    visual.visible = active = inputActive;
}

-(bool) isEnabled {
    return active;
}

-(bool) compareWith:(NSString *) inputString {
    return [identity isEqualToString:inputString];
}

-(CCSprite *) getVisual {
    return visual;
}

-(void) dealloc {
    [visual removeFromParentAndCleanup:true];
    [visual release];
    [super dealloc];
}

@end
