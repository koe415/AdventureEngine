//
//  PersistentData.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/8/13.
//

#import <Foundation/Foundation.h>

@interface PersistentData : NSObject {
    NSString * ident;
    bool status;
}

+(id) dataWithID:(NSString *) inputID status:(bool) inputStatus;

-(id) initWithID:(NSString *) inputID status:(bool) inputStatus;
-(bool) compareID:(NSString *) inputID;
-(void) setStatus:(bool) inputStatus;
-(bool) getStatus;

@end
