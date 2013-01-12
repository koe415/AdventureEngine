//
//  DebugFlags.h
//  Certainty
//
//  Created by Galen Koehne on 11/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Note to self: #ifndef means 'if not defined'...not 'if and defined'
#ifndef Certainty_DebugFlags_h
#define Certainty_DebugFlags_h

#define Display_FPS true
#define Display_Debug_Text true
//#define Display_Dev_Objects true
#define Display_Barriers true

// Format: ClassName(LineNumber)| Debug Text
#if Display_Debug_Text
//#define Log(FORMAT, ...) \
fprintf(stderr,"%s(%d)| %s\n", [NSStringFromClass([super class]) UTF8String], \
__LINE__, \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String] )

    #define Log(FORMAT, ...) \
    fprintf(stderr,"%20.20s| %s\n", [[NSString stringWithFormat:@"%@(%4.4d)", NSStringFromClass([super class]), __LINE__] UTF8String], [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String] )
#else
    #define Log(FORMAT, ...)  // Do Nothing
#endif

#endif
