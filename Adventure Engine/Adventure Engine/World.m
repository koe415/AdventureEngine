//
//  TestLayerBottom.m
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"


@implementation World

-(id) init {
    self=[super init];
    if(!self) return nil;
    
    self.isTouchEnabled = true;
    
    [self schedule:@selector(tick:)];
    
    gd = [GameData instance];
    
    currentAction = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Helvetica-Bold" fontSize:20];
    [currentAction setHorizontalAlignment:kCCTextAlignmentCenter];
    [currentAction setColor:ccc3(255, 255, 255)];
    currentAction.position = CGPointMake(240, 160);
    [self addChild:currentAction];
    
    myFace = [[CCSprite alloc] initWithFile:@"1.png"];
    myFace.scale = 4;
    myFace.position = CGPointMake(240, 160);
    [myFace.texture setAliasTexParameters];
    [self addChild:myFace];
    
    
    return self;
}

-(void) tick:(ccTime) dt {
    if ((myFaceRefresh--) <=0) {
        myFaceRefresh = 15;
        if((++myFaceCnt)>9) myFaceCnt = 1;
        
        [myFace setTexture:[[CCSprite spriteWithFile:
                           [NSString stringWithFormat:@"%d.png",myFaceCnt]
                           ]texture]];
        [myFace.texture setAliasTexParameters];
    }
    
    
    if (gd._playerMovingLeft) {
        if (![[currentAction string] isEqualToString:@"Moving Left"]) {
            [currentAction setString:@"Moving Left"];
        }
    } else if (gd._playerMovingRight) {
        if (![[currentAction string] isEqualToString:@"Moving Right"]) {
            [currentAction setString:@"Moving Right"];
        }
    } else {
        if (![[currentAction string] isEqualToString:@""]) {
            [currentAction setString:@""];
        }
    }
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //Log(@"bottom layer recognized touch begin");
    //if (gd._pausePressed) NSLog(@"Tap Ignored");
    //Log(@"Tap recognized at bottom layer!");
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //Log(@"bottom layer recognized touch end");
}


@end
