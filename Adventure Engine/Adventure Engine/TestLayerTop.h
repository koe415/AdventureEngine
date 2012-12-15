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

@interface TestLayerTop : CCLayer {
    GameData * gd;
    
    bool touchOriginatedOnPause;
    CCSprite * pauseButton;
}

-(void) tick:(ccTime) dt;

@end
