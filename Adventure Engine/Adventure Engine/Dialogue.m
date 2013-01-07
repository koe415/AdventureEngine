//
//  Dialogue.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Dialogue.h"
#import "Engine.h"

@implementation Dialogue

+(id) nodeWithDialogue:(NSString *) dial
{
    return [[[self alloc] initWithDialogue:dial] autorelease];
}

-(id) initWithDialogue:(NSString *) dial {
    self = [super init];
    
    if (!self) return nil;
    
    self.isTouchEnabled = true;
    
    noteContent = [[NSArray alloc] initWithObjects:@"I've seen better days.",
                   @"Wait..",
                   @"Where'd that gash on my forehead come from?",
                   @"This is a really long string. I wonder how well my dialogue layer will handle under this much freaking pressure.",
                   @"Some more nonsense.", nil];
    currentDialogue = 0;
    
    
    contentBackground = [[CCSprite alloc] initWithFile:@"blackPixel.png"];
    contentBackground.position = CGPointMake(240, -25);
    [contentBackground setTextureRect:CGRectMake(0, 0, 480, 50)];
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [contentBackground.texture setTexParameters:&params];
    [contentBackground setOpacity:200];
    
    [self addChild:contentBackground];
    
    
    
    
//    contentLabel = [CCLabelTTF labelWithString:[noteContent objectAtIndex:0]
    contentLabel = [CCLabelTTF labelWithString:@""
                                    dimensions:CGSizeMake(300, 50)
                                    hAlignment:kCCTextAlignmentCenter
                                    vAlignment:kCCVerticalTextAlignmentCenter
                                      fontName:@"Helvetica-Bold"
                                      fontSize:12];
    
    [contentLabel setColor:ccc3(250, 250, 50)];
    
    contentLabel.position = CGPointMake(240, 25);
    [contentBackground addChild:contentLabel];
    
    [contentBackground runAction:[CCMoveBy actionWithDuration:0.3f position:ccp(0,50)]];
    
    // Won't register if run from init
    // [(Engine *) self.parent setMoveVisibility:false];
    
    [GameData instance]._actionRunning = true;
    
    dialogueInstant = [GameData instance]._dialogueInstant;
    if (!dialogueInstant) {
        contentString = [[NSString alloc] initWithFormat:dial];
        drawingLetter = 0;
        [self schedule:@selector(tick:)];
    } else {
        [contentLabel setString:[noteContent objectAtIndex:0]];
    }
    return self;
}

-(void) loadNextDialogue {
    
    currentDialogue++;
    if (currentDialogue>=[noteContent count])
        [self endDialogue];
    else {
        if (dialogueInstant) {
            [contentLabel setString:[noteContent objectAtIndex:currentDialogue]];
        } else {
            [contentLabel setString:@""];
            contentString = [noteContent objectAtIndex:currentDialogue];
            drawingLetter = 0;
        }
    }
}

-(void) endDialogue {
    CCSequence * endSequence = [CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0,-50)],
                                [CCCallFunc actionWithTarget:self selector:@selector(endScene)],nil];
    
    [contentBackground runAction:endSequence];
    
    endingScene = true;
    

    [(Engine *) self.parent setMoveVisibility:true];
    [GameData instance]._actionRunning = false;
}

-(void) endScene {
    [self removeFromParentAndCleanup:true];
}

-(void) dealloc {
    noteContent = nil;
    [contentBackground removeFromParentAndCleanup:YES];
    [contentString release];
    [super dealloc];
}

// Not run if dialogue instantly shows
-(void) tick:(ccTime) dt {
    if (drawingLetter!=-1) {
        if (currentFPL<FRAMES_PER_LETTER) {
            currentFPL++;
        } else {
            currentFPL = 0;
            [contentLabel setString:[[contentLabel string] stringByAppendingFormat:@"%C",[contentString characterAtIndex:drawingLetter]]];
            drawingLetter++;
            
            if (drawingLetter==[contentString length])
                drawingLetter= -1;
        }
    }
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
    
    if (!dialogueInstant && drawingLetter!=-1) {
        [contentLabel setString:contentString];
        drawingLetter=-1;
        return;
    }
    
    [self loadNextDialogue];
}

@end
