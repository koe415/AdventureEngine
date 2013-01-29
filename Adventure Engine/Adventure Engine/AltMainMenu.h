//
//  AltMainMenu.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AltMainMenu : CCLayer {
    CCSpriteBatchNode * backgroundBatchNode;
    NSMutableArray * tileArray;
}

-(void) setupTiles;
-(void) tick:(ccTime) dt;

@end
