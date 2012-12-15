//
//  HUDLayer.h
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Logic.h"

// Handles pause touch, move panels, and item pick up screen
@interface HUDLayer : CCLayer {
    CCSprite * move_panel_left;
    CCSprite * move_panel_right;
    int move_panel_opacity;
    
    CCSprite * pauseButton;
    bool pausePressed;

    CCSprite * itemPickupIcon;
    CCLabelTTF * itemPickupText;
    CCSprite * itemPickupBackground;
}

-(void) setMovePanelVisibility: (bool) vis;
-(bool) isMovePanelVisible;
-(void) setPauseButtonPressed: (bool) isPressed;
-(bool) isPauseButtonPressed;

-(void) setItemPickup:(NSString *) itemName;
-(void) setItemPickupVisibility: (bool) vis;
-(bool) isItemPickupShown;

@end
