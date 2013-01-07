//
//  EditorOptionsMenu.m
//  wars
//
//  Created by Galen Koehne on 6/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"
#import "Engine.h"

@implementation PauseMenu

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    PauseMenu *layer = [PauseMenu node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        mainTitle = [CCLabelTTF labelWithString:@"Paused" fontName:@"Helvetica-Bold" fontSize:20];
        [mainTitle setHorizontalAlignment:kCCTextAlignmentCenter];
        [mainTitle setColor:ccc3(255, 255, 255)];
        mainTitle.position = CGPointMake(240, 300);
        
        exitItem = [CCMenuItemFont itemWithString:@"Exit" target:self selector:@selector(onExit:)];
        cancelItem = [CCMenuItemFont itemWithString:@"Resume" target:self selector:@selector(onCancel:)];
        
        mainMenuListing = [CCMenu menuWithItems:cancelItem, exitItem, nil];
        [mainMenuListing alignItemsVertically];
        [mainMenuListing setColor:ccc3(255, 255, 255)];
        [mainMenuListing setPosition:CGPointMake(240, 120)];
        
        [self addChild:mainTitle];
        [self addChild:mainMenuListing];
    }
    return self;
}

// Potential issue : if there is more than just pause and engine scenes running
-(void)onExit:(id)sender
{
    Log(@"Exit Clicked");
    [GameData instance]._endingGame = true;
    [[CCDirector sharedDirector] popScene];
    //[[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
    //[(Engine *) [[CCDirector sharedDirector] runningScene] endGame];
}

-(void)onCancel:(id)sender
{
    Log(@"Cancel Clicked");
    [[CCDirector sharedDirector] popScene];
}

@end
