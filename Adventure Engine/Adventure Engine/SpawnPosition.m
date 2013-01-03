//
//  SpawnPosition.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SpawnPosition.h"

@implementation SpawnPosition

-(id) initWithPos:(CGPoint) inputPt withDir:(Direction) inputDir withID:(int) inputID {
    self = [super init];
    if(!self) return nil;
    
    position = inputPt;
    dir = inputDir;
    spawnID = inputID;
    
    return self;
}

-(CGPoint) getPosition {
    return position;
}

-(Direction) getDirection {
    return dir;
}

-(int) getID {
    return spawnID;
}

@end
