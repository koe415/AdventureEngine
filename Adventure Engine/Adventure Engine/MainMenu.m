//
//  MainMenu.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"


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
    if( (self=[super init]) ) {
        mainTitle = [[CCLabelTTF alloc] initWithString:@"Certainty" fontName:@"Helvetica-Bold" fontSize:20];
        [mainTitle setHorizontalAlignment:kCCTextAlignmentCenter];
        [mainTitle setColor:ccc3(255, 255, 255)];
        mainTitle.position = CGPointMake(240, 300);
        
        continueItem = [CCMenuItemFont itemWithString:@"Continue" target:self selector:@selector(onContinue:)];
        newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(onNewGame:)];
        
        mainMenuListing = [CCMenu menuWithItems:continueItem, newGameItem, nil];
        [mainMenuListing alignItemsVertically];
        [mainMenuListing setColor:ccc3(255, 255, 255)];
        [mainMenuListing setPosition:CGPointMake(360, 120)];
        
        [self addChild:mainTitle];
        [self addChild:mainMenuListing];
    }
    return self;
}

- (void)onContinue:(id)sender
{
    if (Display_Debug_Text) NSLog(@"Continue Clicked");
    
    //[[CCDirector sharedDirector] replaceScene:[Engine continueGameScene]];
}

- (void)onNewGame:(id)sender
{
    if (Display_Debug_Text) NSLog(@"New Game Clicked");
    
    [[CCDirector sharedDirector] replaceScene:[Engine newGameScene]];
}

@end
