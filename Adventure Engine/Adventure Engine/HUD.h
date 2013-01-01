//
//  TestLayerTop.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "PauseMenu.h"
#import "DebugFlags.h"

@interface HUD : CCLayer {
    GameData * gd;
    
    bool touchOriginatedOnPause;
    bool touchDragOffPause;
    CCSprite * pauseButton;
    
    CCSprite * move_panel_left;
    CCSprite * move_panel_right;
    int move_panel_opacity;
}

-(void) setMovePanelVisibility:(bool) v;

@end
