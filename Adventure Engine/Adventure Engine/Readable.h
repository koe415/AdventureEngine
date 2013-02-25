//
//  Readable.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/9/13.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "DebugFlags.h"

@interface Readable : CCLayer {
    //int type; // computer terminal, diary, etc.
    //CCSprite * blackbackground;
    bool endingScene;
    int currentEntry;
    NSMutableArray * textContent;
    CCLabelTTF * text;
    CCLabelTTF * pageMark;
}

+(id) nodeWithTitle:(NSString *) inputTitle;

-(id) initWithTitle:(NSString *) inputTitle;
-(void) loadNextEntry;
-(void) beginEndReadable;
-(void) endReadable;

@end
