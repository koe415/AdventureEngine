//
//  Tappable.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Tappable.h"

@implementation Tappable

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent isEnabled:(bool) enabled {
    self = [super init];
    if (!self) return nil;
    
    tilePosition = inputPt;
    gameActionsToRun = [[NSArray alloc] initWithArray:actions];
    identity = inputIdent;
    isEnabled = enabled;
    
    return self;
}

-(id) initWithPosition:(CGPoint) inputPt withActions:(NSArray *) actions withIdentity:(int) inputIdent {
    return [self initWithPosition:inputPt withActions:actions withIdentity:inputIdent isEnabled:true];
}
-(bool) compareTilePosition:(CGPoint) tilePt {
    if (!isEnabled) return false;
    if (tilePt.x != tilePosition.x) return false;
    if (tilePt.y != tilePosition.y) return false;
    
    return true;
}

-(NSArray *) getActions {
    return gameActionsToRun;
}

-(int) getIdentity {
    return identity;
}

@end
