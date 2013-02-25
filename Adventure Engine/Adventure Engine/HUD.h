//
//  TestLayerTop.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "PauseMenu.h"
#import "DebugFlags.h"

enum touchOrigin {
    PAUSE,
    LEFT_MOVE,
    RIGT_MOVE,
    FLASH
} touchOrigin;

@interface HUD : CCLayer {
    GameData * gd;
    
    bool touchDraggedOffOriginButton;
    
    CCSprite * pauseButton;
    CCSprite * flashButton;
    
    CCSprite * move_panel_left;
    CCSprite * move_panel_right;
}

/** Set move panel and any button visibility **/
-(void) setPanelVisibility:(bool) v;
-(void) endUserInteraction;

@end
