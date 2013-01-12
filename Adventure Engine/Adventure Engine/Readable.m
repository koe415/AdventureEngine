//
//  Readable.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Readable.h"
#import "Engine.h"

@implementation Readable

+(id) nodeWithTitle:(NSString *) inputTitle {
    return [[[Readable alloc] initWithTitle:inputTitle] autorelease];
}

-(id) initWithTitle:(NSString *) inputTitle {
    self = [super init];
    if (!self) return nil;
    
    self.isTouchEnabled = true;
    
    textContent = [[NSMutableArray alloc] init];
    [textContent addObject:@"Tap on highlighted objects to interact with the environment"
     ". For example, doors can be opened and switches can be switched!\n\nAmazing stuff!\n\nNow I'm may just be reaching of any material to fill in space but I really can't be sure of that. Who knows, I may actually come up with something that legitimately looks like text.\n\nBut then again I don't think I would be able to pull that off. So fuck it, this is what you get.\n\nGood riddence."];
    [textContent addObject:@"This is the second text entry! woot!"];
    
    currentEntry = 0;
    
    
    CCSprite * top_edge = [CCSprite spriteWithFile:@"compscreen_side.png"];
    CCSprite * bottom_edge = [CCSprite spriteWithFile:@"compscreen_side.png"];
    CCSprite * left_edge = [CCSprite spriteWithFile:@"compscreen_side.png"];
    CCSprite * right_edge = [CCSprite spriteWithFile:@"compscreen_side.png"];
    
    top_edge.position = CGPointMake(240, 310);
    bottom_edge.position = CGPointMake(240, 10);
    left_edge.position = CGPointMake(50, 160);
    right_edge.position = CGPointMake(430, 160);
    
    [top_edge setTextureRect:CGRectMake(0, 0, 400, 20)];
    [bottom_edge setTextureRect:CGRectMake(0, 0, 400, 20)];
    [left_edge setTextureRect:CGRectMake(0, 0, 20, 280)];
    [right_edge setTextureRect:CGRectMake(0, 0, 20, 280)];
    
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [top_edge.texture setTexParameters:&params];
    [bottom_edge.texture setTexParameters:&params];
    [left_edge.texture setTexParameters:&params];
    [right_edge.texture setTexParameters:&params];
    
    
    CCSprite * comp_bk = [CCSprite spriteWithFile:@"compscreen_bk.png"];
    comp_bk.position = CGPointMake(240, 160);
    [comp_bk setTextureRect:CGRectMake(0, 0, 360, 280)];
    [comp_bk.texture setTexParameters:&params];
    
    CCLabelTTF * headertext = [CCLabelTTF labelWithString:@"-------------- ServYu Co.™ --------------" fontName:@"Courier-Bold" fontSize:9];
    headertext.dimensions = CGSizeMake(340, 15);
    headertext.horizontalAlignment = kCCTextAlignmentCenter;
    headertext.position = ccp(240, 320-30); 
    headertext.color = ccBLACK;
    
    text = [CCLabelTTF labelWithString:@"" fontName:@"Courier-Bold" fontSize:11];
    text.dimensions = CGSizeMake(320, 200);
    text.horizontalAlignment = kCCTextAlignmentLeft;
    text.position = ccp(240, 160); //Middle of the screen...
    text.color = ccBLACK;
    
    NSString * postTextString = [NSString stringWithFormat:@"# ####!@$%%###%@###%%$@!#### #",inputTitle];
    
    CCLabelTTF * posttext = [CCLabelTTF labelWithString:postTextString fontName:@"Courier-Bold" fontSize:9];
    posttext.dimensions = CGSizeMake(320, 15);
    posttext.horizontalAlignment = kCCTextAlignmentCenter;
    posttext.position = ccp(240, 30);
    posttext.color = ccBLACK;
    
    
    CCSprite * whiteBar1 = [CCSprite spriteWithFile:@"white.png"];
    CCSprite * whiteBar2 = [CCSprite spriteWithFile:@"white.png"];
    
    whiteBar1.position = CGPointMake(240, 320);
    whiteBar2.position = CGPointMake(240, 320);
    
    whiteBar1.opacity = 30;
    whiteBar2.opacity = 30;
    
    [whiteBar1 setTextureRect:CGRectMake(0, 0, 360, 5)];
    [whiteBar2 setTextureRect:CGRectMake(0, 0, 360, 1)];
    
    [whiteBar1.texture setTexParameters:&params];
    [whiteBar2.texture setTexParameters:&params];
    
    
    CCSequence * whiteBar1Sequence = [CCSequence actions:[CCMoveTo actionWithDuration:10 position:CGPointMake(240, 0)],[CCMoveTo actionWithDuration:0 position:CGPointMake(240, 320)], nil];
    CCSequence * whiteBar2Sequence = [CCSequence actions:[CCMoveTo actionWithDuration:5 position:CGPointMake(240, 0)],[CCMoveTo actionWithDuration:0 position:CGPointMake(240, 320)], nil];
    
    [whiteBar1 runAction:[CCRepeatForever actionWithAction:whiteBar1Sequence]];
    [whiteBar2 runAction:[CCRepeatForever actionWithAction:whiteBar2Sequence]];
    
    
    CCSequence * screenBlink = [CCSequence actions:[CCDelayTime actionWithDuration:20],[CCTintTo actionWithDuration:0 red:200 green:200 blue:200],[CCDelayTime actionWithDuration:0.02],[CCTintTo actionWithDuration:0 red:255 green:255 blue:255], nil];
    
    [comp_bk runAction:[CCRepeatForever actionWithAction:screenBlink]];
    
    
    
    [self addChild:comp_bk];
    
    [self addChild:headertext];
    
    [self addChild:text];
    
    [self addChild:posttext];
    
    [self addChild:whiteBar1];
    [self addChild:whiteBar2];
    
    [self addChild:top_edge];
    [self addChild:bottom_edge];
    [self addChild:left_edge];
    [self addChild:right_edge];
    
    
    [self loadNextEntry];
    
    [GameData instance]._actionRunning = true;
    
    return self;
}

-(void) loadNextEntry {
    Log(@"Loading next entry");
    if (currentEntry==[textContent count]) {
        [self beginEndReadable];
    } else {
        [text setString:[textContent objectAtIndex:currentEntry]];
    }
    
    currentEntry++;
}

-(void) beginEndReadable {
    /*CCSequence * endSequence = [CCSequence actions:
                                [CCFadeTo actionWithDuration:2 opacity:0],
                                [CCCallFunc actionWithTarget:self selector:@selector(endReadable)],nil];
    
    [self runAction:endSequence];
    [self runAction:[CCScaleTo actionWithDuration:2 scale:0.5f]];
    */
    endingScene = true;
    
    [(Engine *) self.parent setMoveVisibility:true];
    [GameData instance]._actionRunning = false;
    [self endReadable];
}

-(void) endReadable {
    [self removeFromParentAndCleanup:true];
}

-(void) registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // If scene is in the process of ending, user likely trying to interact with world
    if (endingScene) return NO;
    
    CGPoint location = [touch locationInView:[touch view]];
    if (location.x < 60 && location.y < 60) {
        // Touched pause, needs to fall through this layer
        return NO;
    }
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (endingScene) return;
    
    CGPoint location = [touch locationInView:[touch view]];
    
    if ((location.x < 40) || (location.x > 480 - 40)) {
        [self beginEndReadable];
        return;
    }
    
    
    [self loadNextEntry];
}

-(void) dealloc {
    [textContent release];
    //[comp_bk release];
    [super dealloc];
}

@end
