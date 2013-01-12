//
//  MainMenu.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"

// After X opens, Ask to rate once.
// Menu Flow:
// Tap to continue
// 

@implementation MainMenu

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    MainMenu *layer = [MainMenu node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    if( (self=[super initWithColor:ccc4(150,150,150,255)]) ) {
        
        CCSprite * topWhiteBar = [CCSprite spriteWithFile:@"white.png"];
        CCSprite * bottomWhiteBar = [CCSprite spriteWithFile:@"white.png"];
        CCSprite * whiteCenter = [CCSprite spriteWithFile:@"white.png"];
        
        topWhiteBar.position = CGPointMake(240, 300);
        bottomWhiteBar.position = CGPointMake(240, 20);
        whiteCenter.position = CGPointMake(240, 160);
        
        [topWhiteBar setTextureRect:CGRectMake(0, 0, 480, 2)];
        [bottomWhiteBar setTextureRect:CGRectMake(0, 0, 480, 2)];
        [whiteCenter setTextureRect:CGRectMake(0, 0, 480, 280)];
        
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [topWhiteBar.texture setTexParameters:&params];
        [bottomWhiteBar.texture setTexParameters:&params];
        [whiteCenter.texture setTexParameters:&params];
        
        topWhiteBar.opacity = 150;
        bottomWhiteBar.opacity = 150;
        whiteCenter.opacity = 40;
        
        [self addChild:topWhiteBar];
        [self addChild:bottomWhiteBar];
        [self addChild:whiteCenter];
        
        
        
        
        
        
        [CCMenuItemFont setFontName:@"Helvetica-Bold"];
        [CCMenuItemFont setFontSize:20];
        
        mainTitle = [[CCLabelTTF alloc] initWithString:@"Certainty" fontName:@"Helvetica-Bold" fontSize:20];
        [mainTitle setHorizontalAlignment:kCCTextAlignmentCenter];
        [mainTitle setColor:ccBLACK];
        mainTitle.position = CGPointMake(240, 280);
        
        continueItem = [CCMenuItemFont itemWithString:@"Continue" target:self selector:@selector(onContinue:)];
        newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(onNewGame:)];
        
        mainMenuListing = [CCMenu menuWithItems:continueItem, newGameItem, nil];
        [mainMenuListing alignItemsHorizontallyWithPadding:40.0f];
        [mainMenuListing setColor:ccBLACK];
        [mainMenuListing setPosition:CGPointMake(240, 40)];
        
        [self addChild:mainTitle];
        [self addChild:mainMenuListing];
        
        [mainTitle setOpacity:200];
        [mainMenuListing setOpacity:200];
  
        //[mainTitle runAction:[CCSequence actions:[CCFadeTo actionWithDuration:1 opacity:255], nil]];
        //[mainMenuListing runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1],[CCFadeTo actionWithDuration:1 opacity:255], nil]];
        
        
    }
    return self;
}

- (void)onContinue:(id)sender
{
    if (Display_Debug_Text) Log(@"Continue Clicked");
    
    //[[CCDirector sharedDirector] replaceScene:[Engine continueGameScene]];
}

- (void)onNewGame:(id)sender
{
    if (Display_Debug_Text) Log(@"New Game Clicked");
    
    [[CCDirector sharedDirector] replaceScene:[Engine newGameScene]];
}

@end
