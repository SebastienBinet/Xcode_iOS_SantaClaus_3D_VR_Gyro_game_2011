//
//  Model.h
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMatrix3.h>
//#import <GLKit/GLKMatrix4.h>
#import <CoreMotion/CoreMotion.h>
//#import <CMAttitude/CMAttitude.h>



// Device coordinates:
//             x                    Rotation: positive means:
//            ^                               thumbs on the direction of the axe
//            |                               the rotation is in the sens on the other fingers.
//    y       |      
//      <-----+      O button is here
//           /
//        z *  display is on this side
//       

// Reference frame for objects and attitude:
//             z (always up)        Rotation: positive means:
//            ^                               thumbs on the direction of the axe
//            | * x                              the rotation is in the sens on the other fingers.
//      y     |/
//       <----+
//           

// Screen coordinates
//                   x
//            +----> 
//            |  
//            |
//            v              O button is here
//             
//             y
//            



// RW: Coordonates in Real World
// UW: Coordinates in User World (camera world)

typedef enum{
    VISIBLE,
    NOW_CURRENT_TARGET,
    CURRENT_TARGET,
    NOW_JUST_CAPTURED,
    JUST_CAPTURED,
    NOW_INVISIBLE,
    INVISIBLE
} ObjectState;

typedef struct {
    GLKVector3 posRW;
    GLKVector3 spdRW;
    GLKVector3 posUW;
    float ScreenPosX;
    float ScreenPosY;
    float distUW; // positif means in front of user.
    float scale;
    float alpha; // 0: when behind the camera. ]0,1[ when in front but less than screen distance. 1 when farther or equal to screen distance.
    float mass;   // kg
    ObjectState objectState;
}Object;


#define MAX_SIZE_OBJECT_LIST 40
typedef struct {
    int numberOfObjects;
    Object object[MAX_SIZE_OBJECT_LIST];
}ObjectList;

typedef struct {
    GLKVector3 pos;   //unit is cm
    GLKVector3 speed; //unit is cm/s
    GLKMatrix3 devicesAttitude;
    GLKVector3 headingDirection; //unit vector used for acceleration
    float rotAroundZ; // Left-right. Right is positive ???? TBD: confirm that
    float rotAroundY; // Up-Down. Up is positive ???? TBD: confirm that
    float mass; // kg
    // TBD float distanceToScreen; // m
    // calcul of speed: F = m * a.    v`= v + a(air) + a(prop) + g

    // Based on http://fr.wikibooks.org/wiki/Formules_de_physique 2011-11-25
    // v1 = v0 + a * t
    // x1 = x0 + ((v0 + v1) / 2) * t
    
    // g = 10 m/s^2
    // F(air): air resistance = k * v^2

    // Since F(gravity) is always vertical, a(g) is directional and = g
    // Since F(air-resistance) is in opposite direction of current speed, a(air) is directional and = k * v^2 / m
    // Since F(propulsion) is in direction of the attitude, a(prop) is directional and = F(prop) / m
    
    
    // symbols in this code:
    //  [a]: complete vector (a.x, a.y, a.z). Has a length and a direction.
    //  |a|: length of [a]: positive scalar or 0
    //  ^a^: direction of [a]. This is equal to [a] / |a|
    //  [[attitude]]: Transpose matrix of attitude.
    
    // F(tot) = m * [a(tot)] = m * ( [g] + [a(tot)] + [a(prop)] )
    
    // [a(tot)] = [g]        +   [a(air)]                      +   [a(prop)]
    //          = [0,0,10]   +   k * |v0|^2 * ^v0^      / m    +   F(prop) * unitaryVectorInDirOfAttitude / m
    //          = [0,0,10]   +   k * |v0|^2 * [v0]/|v0| / m    +   F(prop) * ([[Attitude]] * [1,0,0])     / m 
    //          = [0,0,10]   +   k * |v0|   * [v0]      / m    +   F(prop) * ([[Attitude]] * [1,0,0])     / m 

    
    
} UserInfo;

// posRW
const GLKVector3 ORIGIN;
const GLKVector3 ON_X;

// spdRW
const GLKVector3 NO_SPEED;

const float UNKOWN1;
const GLKVector3 UNKNOWN3;

const float DEFAULT_MASS;

const int INVALID_INDEX;

#define NB_OF_OBJECTS (40)

#define DISTANCE_USER_TO_SCREEN (25.0 /*25 cm*/)
#define NB_PIXELS_PER_SCREEN_CM (132 /*ppi*/ / 2.54 /* cm/in*/) 
#define FORCE_PROPULSION (1.0 /* TBD: replace by variable value if wanted*/)
#define USER_AIR_RESISTANCE (0.002 /* TBD: replace by variable value if wanted*/)


@interface Model : NSObject {
@public
    UserInfo userInfo;
    ObjectList objectList;
    NSTimeInterval lastTimestamp;
    NSTimeInterval thisTimestamp;
    NSTimeInterval deltaTime;
    BOOL isSimulator;
    
}

- (void)CalculateObjectListPositionsOnScreenForUser:(UserInfo*)i_userInfo withObjectList:(ObjectList*)i_objectList;
- (void)CalculateObjectListPositionsOnScreen;
- (void)SelectStateForObjects;
- (void)CalculateDeltaTime;
- (void)AnimateModel;

+ (void)checkObject;
- (void)InitModel; 

@end





//static ObjectPath *testObjectPath1;
