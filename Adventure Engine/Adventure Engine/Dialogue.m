//
//  Dialogue.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Dialogue.h"

@implementation Dialogue

+(CCScene *) nodeWithDialogue:(NSString *) dial {
    CCScene *scene = [CCScene node];
	
	// layers are autorelease objects.
    Dialogue * dialogue = [[[Dialogue alloc] initWithDialogue:dial] autorelease];
    
	// add layers as children to scene
	[scene addChild: dialogue];
    
    return scene;
}

-(id) initWithDialogue:(NSString *) dial {
    Log(@"initing dial");
    
    self = [super init];
    
    if (!self) return nil;
    
    self.isTouchEnabled = true;
    
    noteContent = [[NSArray alloc] initWithObjects:@"I've seen better days.",
                   @"Wait..",
                   @"Where'd that gash on my forehead come from?", nil];
    currentDialogue = 0;
    
    
    contentBackground = [[CCSprite alloc] initWithFile:@"blackPixel.png"];
    contentBackground.position = CGPointMake(240, -25);
    [contentBackground setTextureRect:CGRectMake(0, 0, 480, 50)];
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [contentBackground.texture setTexParameters:&params];
    [contentBackground setOpacity:200];
    
    [self addChild:contentBackground];
    
    
    
    
    contentLabel = [CCLabelTTF labelWithString:[noteContent objectAtIndex:0]
                                    dimensions:CGSizeMake(300, 50)
                                    hAlignment:kCCTextAlignmentCenter
                                    vAlignment:kCCVerticalTextAlignmentCenter
                                      fontName:@"Helvetica-Bold"
                                      fontSize:12];
    
    [contentLabel setColor:ccc3(250, 250, 50)];
    
    contentLabel.position = CGPointMake(240, 25);
    [contentBackground addChild:contentLabel];
    
    
    
    //action move up by 100, for 1 sec
    [contentBackground runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0,50)]];
    [self.parent setMovePanelVisibility:false];
    
    return self;
}

-(void) loadNextDialogue {
    currentDialogue++;
    if (currentDialogue>=[noteContent count])
        [self endDialogue];
    else {
        [contentLabel setString:[noteContent objectAtIndex:currentDialogue]];
    }
}

-(void) endDialogue {
    CCSequence * endSequence = [CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0,-50)],
                                [CCCallFunc actionWithTarget:self selector:@selector(endScene)],nil];
    
    [contentBackground runAction:endSequence];
    
    endingScene = true;
    

    [ self.parent setMovePanelVisibility:true];
}

-(void) endScene {
    [self removeFromParentAndCleanup:true];
    //[[CCDirector sharedDirector] popScene];
}

-(void) dealloc {
    noteContent = nil;
    [contentBackground removeFromParentAndCleanup:YES];
    [super dealloc];
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (endingScene) return false;
    return true;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (endingScene) return;
    
    [self loadNextDialogue];
}

@end
