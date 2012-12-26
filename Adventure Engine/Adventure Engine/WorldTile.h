//
//  WorldTile.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"
#import "CCAnimatedSprite.h"

@interface WorldTile : NSObject {
    NSMutableArray * sprites;
    NSMutableArray * animatedSprites;
    bool visible;
}

-(void) addSprite:(CCSprite *) s;
-(void) addAnimatedSprite:(CCAnimatedSprite *) s;
-(void) removeAllSprites;
-(void) setVisible:(bool) v;
-(bool) isVisible;
-(bool) hasAnimatedSprites;
-(void) update;

@end
