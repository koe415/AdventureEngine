//
//  TestLayerBottom.h
//  AdventureEngine
//
//  Created by Galen Koehne on 12/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "DebugFlags.h"

@interface World : CCLayer {
    GameData * gd;
    CCLabelTTF * currentAction;
}


-(void) tick:(ccTime) dt;

@end
