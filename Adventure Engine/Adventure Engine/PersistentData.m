//
//  PersistentData.m
//  Adventure Engine
//
//  Created by Galen Koehne on 1/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PersistentData.h"

@implementation PersistentData

+(id) dataWithID:(NSString *) inputID status:(bool) inputStatus {
    return [[[PersistentData alloc] initWithID:inputID status:inputStatus] autorelease];
}

-(id) initWithID:(NSString *) inputID status:(bool) inputStatus {
    self = [super init];
    if(!self) return nil;
    
    ident = inputID;
    status = inputStatus;
    
    return self;
}

-(bool) compareID:(NSString *) inputID {
    return [ident isEqualToString:inputID];
}

-(void) setStatus:(bool) inputStatus {
    status = inputStatus;
}

-(bool) getStatus {
    return status;
}

-(void) dealloc {
    
}

@end
