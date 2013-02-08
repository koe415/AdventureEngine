//
//  MainMenu.m
//  Adventure Engine
//
//  Created by Galen Koehne on 12/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"

#define Z_BACKGROUND 1
#define Z_SHADOW 2
#define Z_MENU 3

#define MAX_SHADOW_OFFSET 4

@implementation MainMenu

@synthesize doubleTapRecognizer = _doubleTapRecognizer;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    MainMenu *layer = [MainMenu node];
    
    [scene addChild: layer];
    
    return scene;
}

-(void) setupBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    /*
    CCSprite * background = [CCSprite spriteWithFile:@"empty_space.png"];
    [background setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [background setScale:1.5];
    [[background texture] setAliasTexParameters];
    
    [background runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:5 angle:10]]];
    
    CCSprite * background_shadows = [CCSprite spriteWithFile:@"main_menu_background_shadows.png"];
    [background_shadows setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    
    [background_shadows runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCFadeTo actionWithDuration:4 opacity:100],[CCDelayTime actionWithDuration:0.5],[CCFadeTo actionWithDuration:4 opacity:255], nil]]];
    
    CCParticleSystem *particles = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"falling_debris.plist"];
    [[particles texture] setAliasTexParameters];
    
    [self addChild:background z:Z_BACKGROUND];
    [self addChild:background_shadows z:Z_BACKGROUND];
    [background addChild:particles];
    */
    
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    
    planet = [CCSprite spriteWithFile:@"planet.png"];
    [planet setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [planet setScale:2];
    [[planet texture] setTexParameters:&params];
    //[planet setRotation:-10];
    [self addChild:planet];
    
    planet_clouds = [CCSprite spriteWithFile:@"planet_clouds.png"];
    [planet_clouds setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [planet_clouds setScale:2];
    [[planet_clouds texture] setTexParameters:&params];
    [planet_clouds setOpacity:40];
    //[planet_clouds setRotation:-10];
    [self addChild:planet_clouds];
    
    planet_clouds_slow = [CCSprite spriteWithFile:@"planet_clouds.png"];
    [planet_clouds_slow setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [planet_clouds_slow setScale:-2];
    [[planet_clouds_slow texture] setTexParameters:&params];
    [planet_clouds_slow setOpacity:20];
    //[planet_clouds_slow setRotation:-10];
    [self addChild:planet_clouds_slow];
    
    planet_clouds_slowest = [CCSprite spriteWithFile:@"planet_clouds.png"];
    [planet_clouds_slowest setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [planet_clouds_slowest setScale:2];
    [[planet_clouds_slowest texture] setTexParameters:&params];
    [planet_clouds_slowest setOpacity:20];
    //[planet_clouds_slowest setRotation:-10];
    [self addChild:planet_clouds_slowest];
    
    planet_cutout = [CCSprite spriteWithFile:@"planet_cutout.png"];
    [planet_cutout setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [planet_cutout setScale:2];
    [[planet_cutout texture] setTexParameters:&params];
    //[planet_cutout setRotation:-10];
    [self addChild:planet_cutout];
    
    
}

-(void) tick:(ccTime) dt {
    planet_x += 0.04;
    
    [planet setTextureRect:CGRectMake(planet_x, 0, 128, 128)];
    [planet_clouds setTextureRect:CGRectMake(- planet_x * 4, 0, 128, 128)];
    [planet_clouds_slow setTextureRect:CGRectMake(50 + planet_x * 3.5, 100, 128, 128)];
    [planet_clouds_slowest setTextureRect:CGRectMake(100 + planet_x * 2.0, 50, 128, 128)];
    
}

-(void) setupText {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    [CCMenuItemFont setFontName:@"Helvetica-Bold"];
    [CCMenuItemFont setFontSize:24];
    
    CCLabelTTF * mainTitle = [CCLabelTTF labelWithString:@"Control." fontName:@"Helvetica-Bold" fontSize:36];
    [mainTitle setHorizontalAlignment:kCCTextAlignmentCenter];
    [mainTitle setColor:ccWHITE];
    [mainTitle setOpacity:0];
    [mainTitle setPosition: ccp(screenSize.width/2,screenSize.height/2 + 40)];
    
    CCMenuItemFont * continueItem = [CCMenuItemFont itemWithString:@"Continue?" target:self selector:@selector(onContinue:)];
    [continueItem setAnchorPoint:ccp(0,0)];
    CCMenuItemFont * newGameItem = [CCMenuItemFont itemWithString:@"New." target:self selector:@selector(onNewGame:)];
    [newGameItem setAnchorPoint:ccp(0,0)];
    
    bool saveExists = true; // Check saved data!
    
    NSArray * menuItems = [NSArray arrayWithObject:newGameItem];
    if (saveExists) menuItems = [NSArray arrayWithObjects:newGameItem, continueItem, nil];
    else menuItems = [NSArray arrayWithObject:newGameItem];
    
    CCMenu * mainMenuListing = [CCMenu menuWithArray:menuItems];
    [mainMenuListing alignItemsVertically];
    [mainMenuListing setColor:ccWHITE];
    [mainMenuListing setOpacity:0];
    
    if (saveExists) [mainMenuListing setPosition:CGPointMake(20, 30)];
    else [mainMenuListing setPosition:CGPointMake(20, 20)];
    
    
    CCLabelTTF * credits = [CCLabelTTF labelWithString:@"by Galen Koehne" fontName:@"Helvetica" fontSize:12];
    [credits setHorizontalAlignment:kCCTextAlignmentRight];
    [credits setColor:ccWHITE];
    [credits setOpacity:0];
    [credits setPosition:ccp(screenSize.width-55,10)];
    
    [mainTitle runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCFadeTo actionWithDuration:0.5 opacity:255], nil]];
    [mainMenuListing runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0],[CCFadeTo actionWithDuration:0.5 opacity:255], nil]];
    [credits runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.2],[CCFadeTo actionWithDuration:0.5 opacity:255], nil]];
    
    [self addChild:mainTitle z:Z_MENU];
    [self addChild:mainMenuListing z:Z_MENU];
    [self addChild:credits z:Z_MENU];
}

-(void) setupShadows {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    text_shadows = [CCNode node];
    
    [CCMenuItemFont setFontName:@"Helvetica-Bold"];
    [CCMenuItemFont setFontSize:24];
    
    CCLabelTTF * mainTitle = [CCLabelTTF labelWithString:@"Control." fontName:@"Helvetica-Bold" fontSize:36];
    [mainTitle setHorizontalAlignment:kCCTextAlignmentCenter];
    [mainTitle setColor:ccBLACK];
    [mainTitle setOpacity:0];
    [mainTitle setPosition: ccp(screenSize.width/2,screenSize.height/2 + 40)];
    
    CCMenuItemFont * continueItem = [CCMenuItemFont itemWithString:@"Continue?"];
    [continueItem setAnchorPoint:ccp(0,0)];
    CCMenuItemFont * newGameItem = [CCMenuItemFont itemWithString:@"New."];
    [newGameItem setAnchorPoint:ccp(0,0)];
    
    bool saveExists = true; // Check saved data!
    
    NSArray * menuItems = [NSArray arrayWithObject:newGameItem];
    if (saveExists) menuItems = [NSArray arrayWithObjects:newGameItem, continueItem, nil];
    else menuItems = [NSArray arrayWithObject:newGameItem];
    
    CCMenu * mainMenuListing = [CCMenu menuWithArray:menuItems];
    [mainMenuListing alignItemsVertically];
    [mainMenuListing setColor:ccBLACK];
    [mainMenuListing setOpacity:0];
    if (saveExists) [mainMenuListing setPosition:CGPointMake(20, 30)];
    else [mainMenuListing setPosition:CGPointMake(20, 20)];
    
    [mainMenuListing setEnabled:false];
    
    
    CCLabelTTF * credits = [CCLabelTTF labelWithString:@"by Galen Koehne" fontName:@"Helvetica" fontSize:12];
    [credits setHorizontalAlignment:kCCTextAlignmentRight];
    [credits setColor:ccBLACK];
    [credits setOpacity:0];
    [credits setPosition:ccp(screenSize.width-55,10)];
    
    [mainTitle runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCFadeTo actionWithDuration:0.5 opacity:80], nil]];
    [mainMenuListing runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0],[CCFadeTo actionWithDuration:0.5 opacity:80], nil]];
    [credits runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.2],[CCFadeTo actionWithDuration:0.5 opacity:80], nil]];
    
    [text_shadows addChild:mainTitle];
    [text_shadows addChild:mainMenuListing];
    [text_shadows addChild:credits];
    
    currentShadowOffset = [GameData instance]._mmShadowsOffsets;
    text_shadows.visible = [GameData instance]._mmShadowsVisible;
    
    [text_shadows setPosition:currentShadowOffset];
    
    [self addChild:text_shadows z:Z_SHADOW];
}

-(id) init
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = true;
        
        [self setupBackground];
        [self setupShadows];
        [self setupText];
        
        [self schedule:@selector(tick:)];
    }
    return self;
}

-(void) registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) handleQuadTap {
    [GameData instance]._mmShadowsVisible = ![GameData instance]._mmShadowsVisible;
    text_shadows.visible = [GameData instance]._mmShadowsVisible;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    previousTouchPosition = [touch locationInView:[touch view]];
    return true;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint newPosition = [touch locationInView:[touch view]];
    CGPoint touchMovement = ccp(newPosition.x - previousTouchPosition.x,previousTouchPosition.y - newPosition.y);
    previousTouchPosition = newPosition;
    touchMovement = ccp(touchMovement.x/20.0f,touchMovement.y/20.0f); // 20:1 movement ratio
    
    currentShadowOffset = ccpAdd(touchMovement, currentShadowOffset);
    
    // Would be nice: Circular movement around text, instead of square
    if (currentShadowOffset.x>MAX_SHADOW_OFFSET) currentShadowOffset.x = MAX_SHADOW_OFFSET;
    else if (currentShadowOffset.x<-MAX_SHADOW_OFFSET) currentShadowOffset.x = -MAX_SHADOW_OFFSET;
    
    if (currentShadowOffset.y>MAX_SHADOW_OFFSET) currentShadowOffset.y = MAX_SHADOW_OFFSET;
    else if (currentShadowOffset.y<-MAX_SHADOW_OFFSET) currentShadowOffset.y = -MAX_SHADOW_OFFSET;
    
    [text_shadows setPosition:currentShadowOffset];
    [GameData instance]._mmShadowsOffsets = currentShadowOffset;
}

- (void)onContinue:(id)sender
{
    if (Display_Debug_Text) Log(@"Continue Clicked");
    
    //[[CCDirector sharedDirector] replaceScene:[Engine continueGameScene]];
    [[CCDirector sharedDirector] replaceScene:[Engine newGameScene]];
}

- (void)onNewGame:(id)sender
{
    if (Display_Debug_Text) Log(@"New Game Clicked");
    
    [[CCDirector sharedDirector] replaceScene:[Engine newGameScene]];
}

-(void) onEnter {
    self.doubleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleQuadTap)] autorelease];
    _doubleTapRecognizer.numberOfTapsRequired = 4;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:_doubleTapRecognizer];
    [super onEnter];
}

-(void) onExit {
    [[[CCDirector sharedDirector] view] removeGestureRecognizer:_doubleTapRecognizer];
    [super onExit];
}

-(void) dealloc {
    [_doubleTapRecognizer release];
    _doubleTapRecognizer = nil;
    [super dealloc];
}

@end
