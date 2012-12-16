//
//  HUDLayer.m
//  Certainty
//
//  Created by Galen Koehne on 11/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"

static int DefaultPauseButtonOpacity = 200;

@implementation HUDLayer

-(id) init {
    if (self = [super init]) {
        
        move_panel_opacity = 30;
        
        move_panel_left = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
        move_panel_right = [[CCSprite alloc] initWithFile:@"checkers_pattern.png"];
        
        move_panel_left.position = CGPointMake(20, 160 - (40/2));
        move_panel_right.position = CGPointMake(460, 160);
        
        [move_panel_left setTextureRect:CGRectMake(0, 0, 40, 320 - 40)];
        [move_panel_right setTextureRect:CGRectMake(0, 0, 40, 320)];
        
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [move_panel_left.texture setTexParameters:&params];
        [move_panel_right.texture setTexParameters:&params];
        
        move_panel_left.opacity = move_panel_opacity;
        move_panel_right.opacity = move_panel_opacity;
        
        
        
        pauseButton = [[CCSprite alloc] initWithFile:@"pausebutton.png"];
        pauseButton.position = CGPointMake(30, 290);
        pauseButton.opacity = DefaultPauseButtonOpacity;
        [pauseButton setTextureRect:CGRectMake(0, 0, 60, 60)];
        
        
        /*
        itemPickupBackground = [[CCSprite alloc] initWithFile:@"blackPixel.png"];
        itemPickupBackground.position = CGPointMake(240, 100);
        [itemPickupBackground setTextureRect:CGRectMake(0, 0, 340, 60)];
        ccTexParams repeatPatternParams = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [itemPickupBackground.texture setTexParameters:&repeatPatternParams];
        itemPickupBackground.visible = false;
        
        itemPickupIcon = [[CCSprite alloc] init];
        itemPickupIcon.position = CGPointMake(240, 200);
        [itemPickupIcon setScale:2.0f];
        [itemPickupIcon setTextureRect:CGRectMake(0, 0, 60, 60)];
        itemPickupIcon.visible = false;
        
        itemPickupText = [CCLabelTTF labelWithString:@"init item pickup text" fontName:@"Helvetica-Bold" fontSize:14.0f];
        [itemPickupText setHorizontalAlignment:kCCTextAlignmentCenter];
        itemPickupText.position = CGPointMake(240, 100);
        itemPickupText.color = ccWHITE;
        [itemPickupText setDimensions: CGSizeMake(320, 40)];
        itemPickupText.visible = false;*/
        
        
        [self addChild:move_panel_left];
        [self addChild:move_panel_right];
        [self addChild:pauseButton];
        
        //[self addChild:itemPickupBackground];
        //[self addChild:itemPickupIcon];
        //[self addChild:itemPickupText];
    }
    
    return self;
}

#pragma mark Move Panels

-(void) setMovePanelVisibility: (bool) vis {
    move_panel_right.visible = move_panel_left.visible = vis;
}

-(bool) isMovePanelVisible {
    return move_panel_left.visible;
}

#pragma mark Pause Button

-(bool) isPauseButtonPressed {
    return pausePressed;
}

-(void) setPauseButtonPressed: (bool) isPressed {
    pausePressed = isPressed;
    if (pausePressed)
        pauseButton.opacity = DefaultPauseButtonOpacity/2;
    else
        pauseButton.opacity = DefaultPauseButtonOpacity;
}

/*
#pragma mark Item Pickup

-(void) setItemPickup:(NSString *) itemName {
    
    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:
                        [NSString stringWithFormat:@"%@.png",itemName]];
    [itemPickupIcon setTexture: tex];
    [itemPickupIcon setTextureRect:CGRectMake(0, 0,
                                          itemPickupIcon.texture.contentSize.width,
                                          itemPickupIcon.texture.contentSize.height)];
    [[itemPickupIcon texture] setAliasTexParameters];
    
    
    [itemPickupText setString:[Logic getItemPickupText:itemName]];
    
    [self setItemPickupVisibility:true];
}

-(void) setItemPickupVisibility: (bool) vis {
    itemPickupIcon.visible = itemPickupText.visible = itemPickupBackground.visible = vis;
}

-(bool) isItemPickupShown {
    return itemPickupIcon.visible || itemPickupText.visible || itemPickupBackground.visible;
}
*/


@end
