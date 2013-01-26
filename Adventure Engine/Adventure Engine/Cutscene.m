//
//  Cutscene.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Cutscene.h"


@implementation Cutscene

+(id) nodeWithCutscene:(NSString *) cutsceneToShow {
    return [[[self alloc] initWithCutscene:cutsceneToShow] autorelease];
}

-(id) initWithCutscene:(NSString *) cutsceneToShow {
    self = [super init];
    if (!self) return nil;
    
    
    
    
    
    return self;
}

@end
