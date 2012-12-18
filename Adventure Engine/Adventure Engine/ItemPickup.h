//
//  ItemPickup.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Logic.h"

@interface ItemPickup : CCLayer {
    CCSprite * itemPickupIcon;
    CCLabelTTF * itemPickupText;
    CCSprite * itemPickupBackground;
}

-(id) initWithItem:(NSString *) item;

@end
