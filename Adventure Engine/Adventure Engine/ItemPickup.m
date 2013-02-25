//
//  ItemPickup.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//

#import "ItemPickup.h"


@implementation ItemPickup

-(id) initWithItem:(NSString *) item {
    self = [super init];
    
    if (!self) return nil;
    
    
    itemPickupBackground = [[CCSprite alloc] initWithFile:@"blackPixel.png"];
    itemPickupBackground.position = CGPointMake(240, 100);
    [itemPickupBackground setTextureRect:CGRectMake(0, 0, 340, 60)];
    ccTexParams repeatPatternParams = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [itemPickupBackground.texture setTexParameters:&repeatPatternParams];
    itemPickupBackground.visible = false;
    
    itemPickupIcon = [[CCSprite alloc] init];
    itemPickupIcon.position = CGPointMake(240, 200);
    [itemPickupIcon setScale:2.0f];
    [itemPickupIcon setTextureRect:CGRectMake(0, 0, 60, 60)];
    itemPickupIcon.visible = false;
    
    itemPickupText = [CCLabelTTF labelWithString:@"init item pickup text" fontName:@"Helvetica-Bold" fontSize:14.0f];
    [itemPickupText setHorizontalAlignment:kCCTextAlignmentCenter];
    itemPickupText.position = CGPointMake(240, 100);
    itemPickupText.color = ccWHITE;
    [itemPickupText setDimensions: CGSizeMake(320, 40)];
    itemPickupText.visible = false;
    
    
    [self addChild:itemPickupBackground];
    [self addChild:itemPickupIcon];
    [self addChild:itemPickupText];
    
    /*
    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:
                        [NSString stringWithFormat:@"%@.png",itemName]];
    [itemPickupIcon setTexture: tex];
    [itemPickupIcon setTextureRect:CGRectMake(0, 0,
                                              itemPickupIcon.texture.contentSize.width,
                                              itemPickupIcon.texture.contentSize.height)];
    [[itemPickupIcon texture] setAliasTexParameters];
    
    
    [itemPickupText setString:[Logic getItemPickupText:itemName]];
    */
    return self;
}

@end
