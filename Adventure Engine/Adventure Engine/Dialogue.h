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
//#import "Engine.h"

@interface Dialogue : CCLayer {
    NSString * speaker;
    CCLabelTTF * contentLabel;
    CCSprite * contentBackground;
    NSArray * noteContent;
    
    int currentDialogue;
    
    bool endingScene;
    
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
