//
//  Model.m
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Model.h"


#define UNKNOW_TIME 0.1

// posRW
const GLKVector3 ORIGIN = {0,0,0};
const GLKVector3 ON_X = {100,0,0};

// spdRW
const GLKVector3 NO_SPEED = {0,0,0};

const float UNKOWN1 = -10000;
const GLKVector3 UNKNOWN3 = {-10000,-10000,-10000};

const float DEFAULT_MASS = 1; /*kg*/

const int INVALID_INDEX = -1; // to be used when searching in an array

const int MAX_LATERAL_DIST_TO_CAPTURE = 10; // Object should not be farter than 10 cm to the right of the user (same for left, up, and down of the user)


                           
//static Object test100;
//static ObjectList objectListTest1;

@implementation Model


+ (void)checkObject {
//    float x_1=objectListTest1.object[1].posRW.x;
}

- (void)CalculateObjectListPositionsOnScreen {
    [self CalculateObjectListPositionsOnScreenForUser:&userInfo withObjectList:&objectList];
}


- (void)CalculateObjectListPositionsOnScreenForUser:(UserInfo*)i_userInfo withObjectList:(ObjectList*)i_objectList{
    
    // computation based on http://en.wikipedia.org/wiki/3D_projection 2011-11-04
    
    for (int i=0 ; i < i_objectList->numberOfObjects ; i++) {
        // To help debug, place temp info in object
        i_objectList->object[i].posUW = GLKVector3Make(20001, 20002, 20003); 
        i_objectList->object[i].ScreenPosX = 20004;
        i_objectList->object[i].ScreenPosY = 20005;
        i_objectList->object[i].distUW     = 20006;    
        i_objectList->object[i].scale      = 20007;
        i_objectList->object[i].alpha      = 20008;
        
        // delta in initial coordinate system
        GLKVector3 deltaPos = GLKVector3Subtract (i_objectList->object[i].posRW, i_userInfo->pos);
        
        /* not needed because camera transform matrix is directly the atitude gotten from Motion Device
         // calculate of camera transformation matrix
         //CMRotationMatrix *userAttitude;
         GLKMatrix4 matRotAroundX= GLKMatrix4MakeXRotation( - userRot1);
         GLKMatrix4 matRotAroundY= GLKMatrix4MakeYRotation( - userRot2);
         GLKMatrix4 matCameraTransform = GLKMatrix4Multiply(matRotAroundX, matRotAroundY);
         */
        
        // position of object in the camera coordinate system
        bool isInvertible;
        GLKMatrix3 inverse = GLKMatrix3Invert(i_userInfo->devicesAttitude, &isInvertible);
        if(isInvertible) {
            i_objectList->object[i].posUW = GLKMatrix3MultiplyVector3 (inverse, deltaPos); 
            i_objectList->object[i].distUW = GLKVector3Length(i_objectList->object[i].posUW);    
            // If the object is in front of the camera (z<0), distance is kept as positive. 
            // If the object is in back of the camera (z>0), distance is marked as negative.
            if (i_objectList->object[i].posUW.z >0) {
                i_objectList->object[i].distUW = (- i_objectList->object[i].distUW);
            }
            
            
            
            // if object is in front
            if (i_objectList->object[i].posUW.z < -1) {
                i_objectList->object[i].ScreenPosX = i_objectList->object[i].posUW.y * (DISTANCE_USER_TO_SCREEN / i_objectList->object[i].posUW.z) * NB_PIXELS_PER_SCREEN_CM;
                i_objectList->object[i].ScreenPosY = i_objectList->object[i].posUW.x * (DISTANCE_USER_TO_SCREEN / i_objectList->object[i].posUW.z) * NB_PIXELS_PER_SCREEN_CM;

                i_objectList->object[i].scale =  DISTANCE_USER_TO_SCREEN / i_objectList->object[i].distUW;
                    
                // make object opact if farther than the screen in front. 
                if (i_objectList->object[i].distUW >=  DISTANCE_USER_TO_SCREEN) {
                    i_objectList->object[i].alpha = 1.0;
                } else if (i_objectList->object[i].distUW > 0.0) { // Make object transparent if between the screen and the camera
                    i_objectList->object[i].alpha = i_objectList->object[i].distUW / DISTANCE_USER_TO_SCREEN;
                } else { // When the object is behind the camera, should not see it. But for debug puposes, make is slighlty visible.
                    i_objectList->object[i].alpha = 0.111111;
                }
            }
            else { // handle special case: When the object is at the camera or behinbd the camera, should not see it. But for debug puposes, make is slighlty visible.
                //i_objectList->object[i].ScreenPosY = i_objectList->object[i].ScreenPosX = 0;
                i_objectList->object[i].scale = 0;
                i_objectList->object[i].alpha = 0;
            }
        }
    }
}


- (void)SelectStateForObjects{
    int justCapturedIndex = INVALID_INDEX;
    int currentTargetIndex = INVALID_INDEX;

    // find the index for the just captured target.
    for (int i=0 ; i < objectList.numberOfObjects ; i++) {
        if (objectList.object[i].objectState == JUST_CAPTURED)
        {
            justCapturedIndex = i;
        }
    }

    // find the index for the current target.
    for (int i=0 ; i < objectList.numberOfObjects ; i++) {
        if (objectList.object[i].objectState == CURRENT_TARGET)
        {
            currentTargetIndex = i;
        }
    }

    // if the target is captured, update the images
    if (currentTargetIndex != INVALID_INDEX) {
        // if near in front
        if ((objectList.object[currentTargetIndex].posUW.z > -DISTANCE_USER_TO_SCREEN     && objectList.object[currentTargetIndex].posUW.z < 0) &&
          (objectList.object[currentTargetIndex].posUW.x > -MAX_LATERAL_DIST_TO_CAPTURE && objectList.object[currentTargetIndex].posUW.x < MAX_LATERAL_DIST_TO_CAPTURE) &&
          (objectList.object[currentTargetIndex].posUW.y > -MAX_LATERAL_DIST_TO_CAPTURE && objectList.object[currentTargetIndex].posUW.y < MAX_LATERAL_DIST_TO_CAPTURE) ){
            // move the previous JUST_CAPTURED object to INVISIBLE state.
            if (justCapturedIndex != INVALID_INDEX) {
                objectList.object[justCapturedIndex].objectState = NOW_INVISIBLE;
            }
            // change the state the object because it has been captured
            objectList.object[currentTargetIndex].objectState = NOW_JUST_CAPTURED;
            // change the state of the next object in the list because it is now the CURRENT_TARGET
            if (currentTargetIndex < (objectList.numberOfObjects - 1) ) {
                objectList.object[currentTargetIndex + 1].objectState = NOW_CURRENT_TARGET;
                
            }
            
            // add the mass
            userInfo.mass += objectList.object[currentTargetIndex].mass;
        }
    }
}


- (void)InitModel {
    userInfo.pos = GLKVector3Make(0,0,0);
    userInfo.speed = GLKVector3Make(0,0,0);
    userInfo.devicesAttitude = GLKMatrix3Make (0,0,1, 0,1,0, -1,0,0);
    userInfo.rotAroundZ = 0;
    userInfo.rotAroundY = 0;
    userInfo.mass = 1;
    objectList.numberOfObjects=0;
    
/*
    objectList.object[0].posRW = GLKVector3Make(50,0,0);
    objectList.object[0].spdRW = GLKVector3Make(0,0,0);
    objectList.object[0].mass = 1;
    objectList.object[0].objectState = NOW_CURRENT_TARGET;
    objectList.numberOfObjects=1;
    
    objectList.object[1].posRW = GLKVector3Make(75,0.5,0);
    objectList.object[1].spdRW = GLKVector3Make(0,-0.05,-0.1);
    objectList.object[1].mass = 1;
    objectList.object[1].objectState = VISIBLE;
    objectList.numberOfObjects=2;
    
    objectList.object[2].posRW = GLKVector3Make(100,1.5,0.5);
    objectList.object[2].spdRW = GLKVector3Make(0,0.2, 0.4);
    objectList.object[2].mass = 1;
    objectList.object[2].objectState = VISIBLE;
    objectList.numberOfObjects=3;
*/

/*    
    objectList.object[3].posRW = GLKVector3Make(150,2,1.5);
    objectList.object[3].spdRW = GLKVector3Make(0,0,0);
    objectList.object[3].mass = 1;
    objectList.object[3].objectState = VISIBLE;
    objectList.numberOfObjects=4;
*/    
    {
        for (int i=0; i<NB_OF_OBJECTS/4; i++) {
            objectList.object[i].posRW = GLKVector3Make(100+50*i,0,(rand()&255-128)/63.0*i);
            objectList.object[i].spdRW = GLKVector3Make((rand()&255-128)/511.0,(rand()&255-128)/511.0,(rand()&255-128)/511.0 );
            objectList.object[i].mass = 0.1;
            objectList.object[i].objectState = VISIBLE;
            objectList.numberOfObjects++;
            
        }
        int indexStart = NB_OF_OBJECTS/4;
        int indexEnd = NB_OF_OBJECTS;
        int nbIndices=indexEnd - indexStart;
        for (int i=0; i<nbIndices; i++) {
            double sinn = sin (M_PI_2* i/nbIndices);
            double coss = cos (M_PI_2* i/nbIndices);
            objectList.object[indexStart+i].posRW = GLKVector3Make(700*coss,700*sinn,0);
            objectList.object[indexStart+i].spdRW = GLKVector3Make((rand()&255-128)/255.0,(rand()&255-128)/255.0,(rand()&255-128)/255.0 );
            objectList.object[indexStart+i].mass = 0.5;
            objectList.object[indexStart+i].objectState = VISIBLE;
            objectList.numberOfObjects++;
            
        }
        objectList.object[0].objectState = NOW_CURRENT_TARGET;

    }

    deltaTime = thisTimestamp = lastTimestamp = UNKNOW_TIME;
}


-(void) CalculateDeltaTime{
    if (lastTimestamp != UNKNOW_TIME) {
        deltaTime = thisTimestamp - lastTimestamp;
    } 
    else
    {
        deltaTime = 0.01; // second
    }
}

- (void)AnimateModel{
    
    
    /////////// animate camera
    
    // camera pointing direction
    userInfo.headingDirection = GLKMatrix3MultiplyVector3( userInfo.devicesAttitude, GLKVector3Make(0,0,-1) );
    
    
    // [a(tot)] = [g]        +   [a(air)]                      +   [a(prop)]
    //          = [0,0,10]   +   k * |v0|   * [v0]      / m    +   F(prop) * ([[Attitude]] * [1,0,0])     / m 
    
    GLKVector3 propAcceleration = GLKVector3MultiplyScalar(userInfo.headingDirection, FORCE_PROPULSION / userInfo.mass );
    GLKVector3 airAcceleration  = GLKVector3MultiplyScalar(userInfo.speed, - GLKVector3Length(userInfo.speed) * USER_AIR_RESISTANCE / userInfo.mass );
    GLKVector3 userAccelaration = GLKVector3Add(propAcceleration, airAcceleration);
    
    
    userInfo.speed = GLKVector3Add (userInfo.speed, userAccelaration);

    GLKVector3 deltaPos = GLKVector3MultiplyScalar(userInfo.speed, deltaTime);
    userInfo.pos = GLKVector3Add (userInfo.pos, deltaPos);
    
    
    
    
    
    
    ///////// animate objects
    
    for (int i=0 ; i < objectList.numberOfObjects ; i++) {
        // To help debug, place temp info in object
        GLKVector3 deltaPos = GLKVector3MultiplyScalar(objectList.object[i].spdRW , deltaTime);
        objectList.object[i].posRW = GLKVector3Add (objectList.object[i].posRW, deltaPos);
    }
};


@end
