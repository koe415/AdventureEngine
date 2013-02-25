//
//  ItemPickup.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
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
