//
//  Zombie.h
//  Adventure Engine
//
//  Created by Galen Koehne on 2/16/13.
//

#import "Creature.h"
#import "GameData.h"

enum CREATURESTATE {
    IDLE,
    AGGRESSIVE,
    PURSUIT,
    FLASHED
} ;

@interface Zombie : Creature {
    CCAnimation *walk1a;
    CCAnimation *walk1b;
    CCAnimation *idle1;
    CCAnimation *idle2;
    CCAnimation *idle3;
    CCSequence *pursuitRight;
    CCSequence *pursuitLeft;
    CCSequence *flashed;
    
    int creatureState;
}


@end
