//
//  EditorOptionsMenu.h
//  wars
//
//  Created by Galen Koehne on 6/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenu.h"
#import "DebugFlags.h"

@interface PauseMenu : CCLayer {
    CCLabelTTF * mainTitle;
    
    CCMenu * mainMenuListing;
    CCMenuItem * cancelItem, * exitItem;
}

+(CCScene *) scene;
- (void)onExit:(id)sender;
- (void)onCancel:(id)sender;

@end
