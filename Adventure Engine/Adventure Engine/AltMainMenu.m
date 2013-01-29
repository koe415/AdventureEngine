//
//  AltMainMenu.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AltMainMenu.h"


@implementation AltMainMenu


+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    AltMainMenu *layer = [AltMainMenu node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        [self setupTiles];
        [self schedule:@selector(tick:) interval:1];
    }
    return self;
}

-(void) setupTiles {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"menuTileSheet.plist"]];
    
    backgroundBatchNode = [CCSpriteBatchNode 
                           batchNodeWithFile:
                           [NSString stringWithFormat:@"menuTileSheet.png"]];
    
    [self addChild:backgroundBatchNode];
    
    tileArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 48; i++) {
        for (int j = 0; j < 32; j++) {
            CCSprite * currentTile = [CCSprite spriteWithSpriteFrameName:@"menuTile.png"];
            [currentTile setPosition:ccp(i*10+5,j*10+5)];
            [[currentTile texture] setAliasTexParameters];
            
            //id modifyWidth = [CCActionTween actionWithDuration:1 key:@"opacity" from:200 to:255];
            //[target runAction:modifyWidth];
            
            //[currentTile runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeOut actionWithDuration:2],[CCFadeIn actionWithDuration:2], nil]]];
            
            [currentTile setOpacity:rand()%255];
            [tileArray addObject:currentTile];
            
            [backgroundBatchNode addChild:currentTile];
        }
    }
    
}

-(void) tick:(ccTime) dt {
    for (CCSprite * tile in tileArray) {
        
        tile.opacity= tile.opacity+1;
        
        if (tile.opacity>255) tile.opacity = 0;
        
    }
}


@end
