//
//  Tester.m
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Tester.h"


@implementation Tester


+(void)TestTool_PlaceUserLookingForwardInPath:(Model*)i_model atX:(float)i_posX atY:(float)i_posY atZ:(float)i_posZ{
    i_model->userInfo.pos = GLKVector3Make(i_posX,i_posY,i_posZ);
    i_model->userInfo.devicesAttitude = GLKMatrix3Make(0,0,1, 0,1,0, -1,0,0);
   
}

+(void)TestTool_PlaceUserLookingOnRightInPath:(Model*)i_model atX:(float)i_posX atY:(float)i_posY atZ:(float)i_posZ atAngle:(float)i_angleInQtyOfPi {
    i_model->userInfo.pos = GLKVector3Make(i_posX,i_posY,i_posZ);
    float cos = cosf(M_PI * i_angleInQtyOfPi);
    float sin = sinf(M_PI * i_angleInQtyOfPi);
    // does not work as I expect -    i_model->userInfo.devicesAttitude = GLKMatrix3MakeZRotation(i_angleInQtyOfPi*M_PI);    
    i_model->userInfo.devicesAttitude = GLKMatrix3Make(0,0,1, sin,cos,0, -cos,sin,0);
}

+(void)TestTool_AddObjectInPath:(Model*)i_model atX:(float)i_posX atY:(float)i_posY atZ:(float)i_posZ{
    if (i_model->objectList.numberOfObjects < MAX_SIZE_OBJECT_LIST) {
        i_model->objectList.object[i_model->objectList.numberOfObjects].posRW  = GLKVector3Make(i_posX,i_posY,i_posZ);
        i_model->objectList.object[i_model->objectList.numberOfObjects].spdRW  = UNKNOWN3;
        i_model->objectList.object[i_model->objectList.numberOfObjects].posUW  = UNKNOWN3;
        i_model->objectList.object[i_model->objectList.numberOfObjects].distUW = UNKOWN1;
        i_model->objectList.object[i_model->objectList.numberOfObjects].alpha  = UNKOWN1;
        i_model->objectList.object[i_model->objectList.numberOfObjects].mass   = DEFAULT_MASS ;
        i_model->objectList.numberOfObjects++;
    }
    else {
        while (1) {;}
    }
}

// Verify that the value is within these bounds:
//  [99.9% expected , 100.1% expected] when expected is positive
//  [expected -0.001 , expected +0.001] when expected is around 0
//  [100.1% expected - 0.001 , 99.9% expected + 0.001] when expected is positive
+(BOOL)TestTool_verifyValue:(float)i_valueToVerify to:(float)i_expectedValue {
    BOOL Fail = NO;
    if (i_expectedValue > 0) {
        if (i_valueToVerify < (0.999 * i_expectedValue - 0.001) ||
            i_valueToVerify > (1.001 * i_expectedValue + 0.001) ) {
            Fail = YES;
        }
    } else { // so value is negative
        if (i_valueToVerify < (1.001 * i_expectedValue - 0.001) ||
            i_valueToVerify > (0.999 * i_expectedValue + 0.001) ) {
            Fail = YES;
        }        
    }
    return Fail;
}

+(BOOL)TestTool_VerifyObjectScreenPosScaleAlphaOfPath:(Model*)i_model atXPixels:(float)i_posX atYPixels:(float)i_posY atDistanceCm:(float)i_distance withScale:(float)i_scale withAlpha:(float)i_withAlpha {
    BOOL Fail = NO;
    Fail = Fail || [Tester TestTool_verifyValue:i_model->objectList.object[0].ScreenPosX to:i_posX];
    Fail = Fail || [Tester TestTool_verifyValue:i_model->objectList.object[0].ScreenPosY to:i_posY];
    Fail = Fail || [Tester TestTool_verifyValue:i_model->objectList.object[0].distUW to:i_distance];
    Fail = Fail || [Tester TestTool_verifyValue:i_model->objectList.object[0].scale to:i_scale];
    Fail = Fail || [Tester TestTool_verifyValue:i_model->objectList.object[0].alpha to:i_withAlpha];
    return Fail;
}

+(BOOL)Test001 { // User looking in front. Object straight in front
    Model *modelUnderTest = [Model alloc];
    BOOL Fail = NO;
    //ObjectPathTestGroup objectPathTestGroup;

    [Tester TestTool_PlaceUserLookingForwardInPath:modelUnderTest atX:0 atY:0 atZ:0];
    [Tester TestTool_AddObjectInPath:modelUnderTest atX:25 atY:0 atZ:0];
    [modelUnderTest CalculateObjectListPositionsOnScreenForUser:&(modelUnderTest->userInfo) withObjectList:&(modelUnderTest->objectList)];
    Fail = Fail || [Tester TestTool_VerifyObjectScreenPosScaleAlphaOfPath:modelUnderTest atXPixels:0 atYPixels:0 atDistanceCm:25 withScale:1 withAlpha:1.0]; // should be direclty on center of screen, original size.
    //[model release];
    return Fail;
}

+(BOOL)Test002 { // User looking in front. Object slightly to its right.
    Model *modelUnderTest = [Model alloc];
    BOOL Fail = NO;
    //ObjectPathTestGroup objectPathTestGroup;
    
    [Tester TestTool_PlaceUserLookingForwardInPath:modelUnderTest atX:0 atY:0 atZ:0];
    [Tester TestTool_AddObjectInPath:modelUnderTest atX:250 atY:-250.0*tanf(M_PI * QTY_PI_IN_5_625_DEG) atZ:0]; 
    [modelUnderTest CalculateObjectListPositionsOnScreenForUser:&modelUnderTest->userInfo withObjectList:&modelUnderTest->objectList];
    Fail = Fail || [Tester TestTool_VerifyObjectScreenPosScaleAlphaOfPath:modelUnderTest atXPixels:DISTANCE_USER_TO_SCREEN*tanf(M_PI * QTY_PI_IN_5_625_DEG)*NB_PIXELS_PER_SCREEN_CM atYPixels:0 atDistanceCm:250.0/cosf(M_PI * QTY_PI_IN_5_625_DEG) withScale:DISTANCE_USER_TO_SCREEN/cosf(M_PI * QTY_PI_IN_5_625_DEG)/250.0 withAlpha:1.0]; // about 1/10 size.
    return Fail;
}

+(BOOL)Test003 { // User looking to right. Object slightly to its left.
    Model *modelUnderTest = [Model alloc];
    BOOL Fail = NO;
    //ObjectPathTestGroup objectPathTestGroup;

    [Tester TestTool_PlaceUserLookingOnRightInPath:modelUnderTest atX:0 atY:0 atZ:0 atAngle:QTY_PI_IN_30_DEG];
    [Tester TestTool_AddObjectInPath:modelUnderTest atX:12.5 atY:-12.5*tanf(M_PI * QTY_PI_IN_22_5_DEG) atZ:0];
    [modelUnderTest CalculateObjectListPositionsOnScreenForUser:&(modelUnderTest->userInfo) withObjectList:&(modelUnderTest->objectList)];
    Fail = Fail || [Tester TestTool_VerifyObjectScreenPosScaleAlphaOfPath:modelUnderTest atXPixels:-DISTANCE_USER_TO_SCREEN*tanf(M_PI * (QTY_PI_IN_30_DEG-QTY_PI_IN_22_5_DEG))*NB_PIXELS_PER_SCREEN_CM atYPixels:0 atDistanceCm:12.5/cosf(M_PI * QTY_PI_IN_22_5_DEG) withScale:DISTANCE_USER_TO_SCREEN*cosf(M_PI * QTY_PI_IN_22_5_DEG)/12.5 withAlpha:1/DISTANCE_USER_TO_SCREEN/cosf(M_PI * QTY_PI_IN_22_5_DEG)*12.5]; // 2 times size, alpha
    return Fail;
}


@end
