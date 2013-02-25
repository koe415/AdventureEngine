//
//  Cutscene.h
//  Adventure Engine
//
//  Created by Galen Koehne on 1/9/13.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Cutscene : CCLayer {
    
}

+(id) nodeWithCutscene:(NSString *) cutsceneToShow;
-(id) initWithCutscene:(NSString *) cutsceneToShow;

@end
