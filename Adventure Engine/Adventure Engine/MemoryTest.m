//
//  MemoryTest.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MemoryTest.h"


@implementation MemoryTest

+(CCScene *) node
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// layers are autorelease objects.
	MemoryTest * memoryTest = [[[MemoryTest alloc] init] autorelease];
    
	// add layers as children to scene
	[scene addChild: memoryTest];
    
	return scene;
}

-(id) init {
    self = [super init];
    
    if (!self) return nil;
    
    CCMenuItem * backItem = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
    
    CCMenu * menu = [CCMenu menuWithItems:backItem, nil];
    [menu setColor:ccWHITE];
    [self addChild:menu];
    
    return self;
}

-(void) onBack:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[MainMenu node]];
}

-(void) dealloc {
    NSLog(@"dealloc from mem test");
    [super dealloc];
}
@end
