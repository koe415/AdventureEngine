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
    
    if ([inputTitle isEqualToString:@"first_comp"]) {
        [textContent addObject:@"Activity Log 1.3.35"];
        [textContent addObject:
         @"11:14 | Unidentified Male entered apartment\n"
          "11:20 | Unidentified Male left apartment\n"
          "17:23 | Unidentified Male entered apartment\n"
          "17:29 | Front door locked\n"
          "17:42 | Bathroom door accessed\n"
          "17:42 | Medical Cabinet accessed\n"
          "----------END OF DAYS LOG----------"];
    } else if ([inputTitle isEqualToString:@"foreboding_story"]) {
        [textContent addObject:@"Novel Excerpt"];
        [textContent addObject:@"This was the end for the man. Having had no past, it now seemed likely he would have no future.\n\n"
         "For a minute, the man considered the options available to him. Far away from home in any sense of the word, he was trapped in a world that he didn't belong in. Where had this all gone so wrong?\n\n"
         "He looked up at the sky and said his goodbyes. He wished it had been different."];
    } else {
        [textContent addObject:@"This is the default entry. Something went horribly wrong mate."];
    }
    currentEntry = 0;
    
    
    CCSprite * comp_bk = [CCSprite spriteWithFile:@"blackPixel.png"];
    comp_bk.position = CGPointMake(240, 160);
    comp_bk.opacity = 180;
    [comp_bk setTextureRect:CGRectMake(0, 0, 480, 320)];
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [comp_bk.texture setTexParameters:&params];
    
    text = [CCLabelTTF labelWithString:@"" fontName:@"Courier-Bold" fontSize:11];
    text.dimensions = CGSizeMake(320, 200);
    text.horizontalAlignment = kCCTextAlignmentLeft;
    text.position = ccp(240, 160); //Middle of the screen...
    text.color = ccWHITE;
    
    pageMark = [CCLabelTTF labelWithString:@"" fontName:@"Courier-Bold" fontSize:11];
    pageMark.dimensions = CGSizeMake(100, 15);
    pageMark.horizontalAlignment = kCCTextAlignmentCenter;
    pageMark.position = ccp(240, 20);
    pageMark.color = ccWHITE;
    
    
    [self addChild:comp_bk];
    
    [comp_bk addChild:text];
    [comp_bk addChild:pageMark];
    
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
        [pageMark setString:[NSString stringWithFormat:@"%d/%d",currentEntry+1,[textContent count]]];
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
    
    /*CGPoint location = [touch locationInView:[touch view]];
     
     if ((location.x < 40) || (location.x > 480 - 40)) {
     [self beginEndReadable];
     return;
     }*/
    
    
    [self loadNextEntry];
}

-(void) dealloc {
    [textContent release];
    //[comp_bk release];
    [super dealloc];
}

@end
