//
//  Tester.h
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import <GLKit/GLKMatrix3.h>
#import <CoreMotion/CoreMotion.h>


#define QTY_PI_IN_5_625_DEG (1.0/32) /* -> tan = 0.098491403357163 */
#define QTY_PI_IN_22_5_DEG (1.0/8)
#define QTY_PI_IN_30_DEG (1.0/6)
#define QTY_PI_IN_90_DEG (1.0/2)




//typedef struct {
//    UserInfo  userInfo;
//    ObjectList objectListInitial;
//    ObjectList objectListFinal;
//} ObjectPathTestGroup;

@interface Tester : NSObject

+(BOOL)Test001;
+(BOOL)Test002;
+(BOOL)Test003;

@end
