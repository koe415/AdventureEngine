//
//  MainMenu.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "Engine.h"

@interface MainMenu : CCLayer {
    CCLabelTTF * mainTitle;
    
    CCMenu * mainMenuListing;
    CCMenuItem * continueItem, * newGameItem;
}

+(CCScene *) scene;
- (void)onContinue:(id)sender;
- (void)onNewGame:(id)sender;

@end
