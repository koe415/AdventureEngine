//
//  SharedTypes.h
//  Adventure Engine
//
//  Created by Galen Koehne on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Adventure_Engine_SharedTypes_h
#define Adventure_Engine_SharedTypes_h

enum Direction {
    LEFT,
    RIGHT
};
typedef enum Direction Direction;
/*
struct Spawn {
    Direction d;
    int x;
    int y;
};
typedef struct Spawn Spawn;
*/
enum GameActionTypes {
    ACTIONDELAY,
    ACTIONDIALOGUE,
    ACTIONCUTSCENE,
    ACTIONLOADWORLD,
    ACTIONPICKUPITEM,
    ACTIONREMOVEITEM,
    ACTIONREADABLE,
    ACTIONENDGAME,
    ACTIONTAP,
    ACTIONTRIG
};

#endif
