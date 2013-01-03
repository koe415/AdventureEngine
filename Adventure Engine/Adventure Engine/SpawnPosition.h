//
//  SpawnPosition.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedTypes.h"

@interface SpawnPosition : NSObject {
    CGPoint position;
    Direction dir;
    int spawnID;
}

-(id) initWithPos:(CGPoint) inputPt withDir:(Direction) inputDir withID:(int) inputID;
-(CGPoint) getPosition;
-(Direction) getDirection;
-(int) getID;

@end
