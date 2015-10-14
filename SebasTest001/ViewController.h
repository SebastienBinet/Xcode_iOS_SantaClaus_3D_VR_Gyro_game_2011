//
//  ViewController.h
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-02.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
#import <GLKit/GLKMatrix4.h>
#import "Model.h"

//typedef struct {
//    int indexInModel; // -1 means that this image is not linked to any object in the model. 
//}ImageToObjectLink;


@interface ViewController : UIViewController {
    __weak IBOutlet UIImageView *anImageView1;
    __weak IBOutlet UIImageView *anImageView2;

    IBOutlet UIImageView *aRunTimeImageView1;
    IBOutlet UIImageView *aRunTimeImageView2;
    NSMutableArray *imagesArrayBroco1Anim;
    NSMutableArray *imagesArrayBroco8Anim;
    NSMutableArray *imagesArrayBrocoAlpha8Anim;
    //NSMutableArray *imagesArrayGiftbox;
    
    //Model:
    Model *model;

    //float userPosX, userPosY, userPosZ;
    //float userRot1, userRot2;
    //float objectPosX, objectPosY, objectPosZ, objectScreenX, objectScreenY;
    
    // ipad section
    
    __weak IBOutlet UILabel *ValueUserPosX;
    __weak IBOutlet UILabel *ValueUserPosY;
    __weak IBOutlet UILabel *ValueUserPosZ;
    __weak IBOutlet UILabel *ValueUserRot1;
    __weak IBOutlet UILabel *ValueUserRot2;
    
    
    __weak IBOutlet UILabel *ValueObjectPosX_inUserCoord;
    __weak IBOutlet UILabel *ValueObjectPosY_inUserCoord;
    __weak IBOutlet UILabel *ValueObjectPosZ_inUserCoord;
    __weak IBOutlet UILabel *ValueObjectDist_inUserCoord;
    
    // Images
    
    IBOutlet UIImageView *image1;
    IBOutlet UIImageView* image[MAX_SIZE_OBJECT_LIST];
    //ImageToObjectLink imageToObjectLink[MAX_SIZE_OBJECT_LIST];
    int imageToObjectLink[MAX_SIZE_OBJECT_LIST];
    
    // attitude
    CMMotionManager *motionManager;
    NSTimer *simulatorTimer;
    /*
     typedef double CFTimeInterval;
     typedef        CFTimeInterval CFAbsoluteTime;
     
     NSTimeInterval timestamp
     */


    
}
@property (strong, nonatomic) IBOutlet UIView *PurpleViewCtrl;
@property (strong, nonatomic) IBOutlet UILabel *Label1;
@property (strong, nonatomic) IBOutlet UIButton *UpdateLabel1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *ButtonTest3;

- (IBAction)TouchUpdateLabel1:(id)sender;
- (IBAction)TouchUpInside:(id)sender;
- (IBAction)TouchInsideButton3:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *SliderUserPosX;
- (IBAction)ChangeSliderUserPosX:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *SliderUserPosY;
- (IBAction)ChangeSliderUserPosY:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *SliderUserPosZ;
- (IBAction)ChangeSliderUserPosZ:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *SliderUserRot1;
- (IBAction)ChangeSliderUserRot1:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *SliderUserRot2;
- (IBAction)ChangeSliderUserRot2:(id)sender;

// Model
-(void)RefreshWorldAndScreen;
-(void)CalculateDeltaTime;
-(void)AnimateModel; // User and objects
-(NSComparisonResult)CompareDistanceOfObject:(id)viewIndex1 withDistanceOfOject2:(id)viewIndex2 inContect:(void *)context;
-(void)SortByDistance;
-(void)CalculateObjectPositionsOnScreen;
-(void)SelectImageForObjects;
-(void)DisplayObjectsOnScreen;

@end
