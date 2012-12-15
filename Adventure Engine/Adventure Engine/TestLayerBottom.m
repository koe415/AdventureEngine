//
//  TestLayerBottom.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestLayerBottom.h"


@implementation TestLayerBottom

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    [self schedule:@selector(tick:)];
    
    gd = [GameData instance];
    
    return self;
}

-(void) tick:(ccTime) dt {
    //NSLog(@"bottom layer tick");
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"bottom layer recognized touch begin");
    //if (gd._pausePressed) NSLog(@"Tap Ignored");
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (gd._paused) NSLog(@"game paused, ignored..");
    else NSLog(@"touch gladly handled!");
    //NSLog(@"bottom layer recognized touch end");
    //if (gd._pausePressed) NSLog(@"Tap Ignored");
    //else NSLog(@"Game running, Tap taken");
}


@end
