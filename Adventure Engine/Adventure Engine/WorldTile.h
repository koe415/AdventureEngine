//
//  WorldTile.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/23/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DebugFlags.h"

@interface WorldTile : NSObject {
    NSMutableArray * sprites;
    bool visible;
}

-(void) addSprite:(CCSprite *) s;
-(void) removeAllSprites;
-(void) setVisible:(bool) v;
-(bool) isVisible;
-(void) dealloc;

-(void) setBrightness:(int) b;

@end
