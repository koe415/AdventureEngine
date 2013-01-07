//
//  Dialogue.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "GameData.h"

#define FRAMES_PER_LETTER 1
// 0 - Instant
// 1 - Fast
// 2 - Slow

@interface Dialogue : CCLayer {
    NSString * speaker;
    CCLabelTTF * contentLabel;
    NSString * contentString;
    CCSprite * contentBackground;
    NSArray * noteContent;
    
    int currentDialogue;
    
    bool endingScene;
    
    int drawingLetter;
    int currentFPL;
    
    bool dialogueInstant;
    
}

+(id) nodeWithDialogue:(NSString *) dial;
-(id) initWithDialogue:(NSString *) dial;
-(void) loadNextDialogue;
-(void) endDialogue;
-(void) endScene;
-(void) dealloc;
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
@end
