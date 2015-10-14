//
//  ViewController.m
//  SebasTest001
//
//  Created by Sebastien Binet on 11-11-02.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Tester.h"


@implementation ViewController
@synthesize SliderUserRot2;
@synthesize SliderUserRot1;
@synthesize SliderUserPosZ;
@synthesize SliderUserPosY;
@synthesize SliderUserPosX;
@synthesize PurpleViewCtrl;
@synthesize Label1;
@synthesize UpdateLabel1;
@synthesize Button2;
@synthesize ButtonTest3;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // ipod
    {
        bool test001=[Tester Test001];
        bool test002=[Tester Test002];
        bool test003=[Tester Test003];
        if (test001 || test002 || test003) {
            //problem!!!!!
            while(1){;};
        }
        
        
        int numberOfFamesBroco1Anim = 2359-2327+1;
        imagesArrayBroco1Anim = [NSMutableArray arrayWithCapacity:numberOfFamesBroco1Anim];
        
        
        for (int i=0; numberOfFamesBroco1Anim > i; ++i)
        {
            NSString *tempFileName = [NSString stringWithFormat:@"IMG_%d.JPG", 2327+i];
            UIImage *tempImage = [UIImage imageNamed:tempFileName];
            [imagesArrayBroco1Anim addObject:tempImage];
        }
        //    anImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(80,140,100,60)] ];
        //    [self.view addSubview:anImageView1];
        anImageView1.animationImages = imagesArrayBroco1Anim; 
        anImageView1.animationDuration = 3;
        [anImageView1 startAnimating];
    }

    

    
    // ipad images
     
    int animationStartingImageNumber = 2340;
    int imageNumberOffsetForType8[] = {0,1,3,5,6,5,3,1};
    int numberOfFamesBroco8Anim = 8;
    imagesArrayBroco8Anim = [NSMutableArray arrayWithCapacity:numberOfFamesBroco8Anim];
    imagesArrayBrocoAlpha8Anim = [NSMutableArray arrayWithCapacity:numberOfFamesBroco8Anim];
    //imagesArrayGiftbox = [NSMutableArray arrayWithCapacity:1];
    
    for (int i=0; numberOfFamesBroco8Anim > i; ++i)
    {
        NSString *tempFileName = [NSString stringWithFormat:@"IMG_%d.JPG", animationStartingImageNumber+imageNumberOffsetForType8[i]];
        UIImage *tempImage = [UIImage imageNamed:tempFileName];
        [imagesArrayBroco8Anim addObject:tempImage];
    }

    for (int i=0; numberOfFamesBroco8Anim > i; ++i)
    {
        NSString *tempFileName = [NSString stringWithFormat:@"IMG_%d.png", animationStartingImageNumber+imageNumberOffsetForType8[i]];
        UIImage *tempImage = [UIImage imageNamed:tempFileName];
        [imagesArrayBrocoAlpha8Anim addObject:tempImage];
    }
    
     
/* 
    image[0] = [[UIImageView alloc] initWithFrame:CGRectMake(80,240,1000,600)];
    [self.view addSubview:image[0]];
    image[0].animationImages = imagesArrayBroco8Anim; 
    image[0].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 5;
    [image[0] startAnimating];
    NSArray *xxx=[self.view subviews];

    image[1] = [[UIImageView alloc] initWithFrame:CGRectMake(100,260,1200,600)];
    [self.view addSubview:image[1]];
    image[1].animationImages = imagesArrayBroco8Anim; 
    image[1].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 7;
    [image[1] startAnimating];

    image[2] = [[UIImageView alloc] initWithFrame:CGRectMake(120,240,1000,800)];
    [self.view addSubview:image[2]];
    image[2].animationImages = imagesArrayBroco8Anim; 
    image[2].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 10;
    [image[2] startAnimating];
*/

    for (int i=0; i<NB_OF_OBJECTS; i++){
        /*
        image[i] = [[UIImageView alloc] initWithFrame:CGRectMake(120,240,1000,800)];
        [self.view addSubview:image[i]];
        image[i].animationImages = imagesArrayGiftbox; 
        //image[i].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 10;
        [image[i] startAnimating];
        
        */
        
        NSString *tempFileName = [NSString stringWithFormat:@"g_%03d.png", 12];
        UIImage *tempImage = [UIImage imageNamed:tempFileName];
        image[i] = [[UIImageView alloc] initWithFrame:CGRectMake(150,260,200,60)];
        UIView *tempView = [image[i] initWithImage:tempImage];
        tempView.tag = 100+i;
        imageToObjectLink[i]=i;
        [self.view addSubview:tempView];
         
    }
    
    // preparation for image of current target
    NSString *tempFileName = [NSString stringWithFormat:@"g_%03d.png", 11];
    [image1 initWithImage:([UIImage imageNamed:tempFileName])];

    // test only: [[self.view viewWithTag:102] removeFromSuperview];
/*
    NSArray *xxx;
    
    // Giftbox blue
    NSString *tempFileName00 = [NSString stringWithFormat:@"giftbox_%03d.png", 1];
    UIImage *tempImage00 = [UIImage imageNamed:tempFileName00];
    image[0] = [[UIImageView alloc] initWithFrame:CGRectMake(750,260,20,6)];
    [self.view addSubview:[image[0] initWithImage:tempImage00]];
    
    xxx=[self.view subviews];
    
    // Giftbox golden
    NSString *tempFileName1 = [NSString stringWithFormat:@"giftbox_%03d.png", 3];
    UIImage *tempImage1 = [UIImage imageNamed:tempFileName1];
    image[1] = [[UIImageView alloc] initWithFrame:CGRectMake(250,560,20,6)];
    [self.view addSubview:[image[1] initWithImage:tempImage1]];

    xxx=[self.view subviews];

    // Giftbox red with yellow polka dots
    NSString *tempFileName2 = [NSString stringWithFormat:@"giftbox_%03d.png", 9];
    UIImage *tempImage2 = [UIImage imageNamed:tempFileName2];
    image[2] = [[UIImageView alloc] initWithFrame:CGRectMake(500,760,20,6)];
    [self.view addSubview:[image[2] initWithImage:tempImage2]];

    
    xxx=[self.view subviews];

    

    image[3] = [[UIImageView alloc] initWithFrame:CGRectMake(140,260,120,80)];
    [self.view addSubview:image[3]];
    image[3].animationImages = imagesArrayBroco8Anim; //imagesArrayBrocoAlpha8Anim; 
    image[3].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 2;
    [image[3] startAnimating];
    

    xxx=[self.view subviews];
    
*/
    // TBD: faire afficher image giftbox
    //NSString *tempFileName = [NSString stringWithFormat:@"giftbox_%03d.png", 1];
    //UIImage *tempImage = [UIImage imageNamed:tempFileName];
    //image[4] = [[UIImageView alloc] initWithFrame:CGRectMake(60,260,100,100)];
    //[self.view addSubview:[image[4] initWithImage:tempImage]];
    //[image[4] initWithImage:tempImage];
    //image[4].animationImages = imagesArrayBrocoAlpha8Anim; 
    //image[4].animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 2;
    //[image[4] startAnimating];
    
    // model
    model = [Model alloc];
    [model InitModel];
    
    
    
    // attitude
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.deviceMotionAvailable) {
        
        model->isSimulator = NO;
        
        // Tell CoreMotion to show the compass calibration HUD when required to provide true north-referenced attitude
        motionManager.showsDeviceMovementDisplay = YES;
        
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        
        //[motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical];
        [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical toQueue:[NSOperationQueue currentQueue]
                                                       withHandler:
         ^(CMDeviceMotion *motion, NSError *error) {
             
             /* from the loat demo attitude utilisation
              CATransform3D transform;
              
              double newPitch = motion.attitude.pitch;
              double newRoll = motion.attitude.roll;
              
              transform = CATransform3DMakeRotation(newPitch, 1, 0, 0);
              transform = CATransform3DRotate(transform, newRoll, 0, 1, 0);
              
              self.view.layer.sublayerTransform = transform;
              */
             
             if (motion != nil) {
                 model->userInfo.rotAroundZ = motion.attitude.pitch; // just for display on screen
                 
                 SliderUserRot1.value = motion.attitude.yaw;
                 ValueUserRot1.text = [NSString stringWithFormat:@"UserRot 1 (yaw)=%f*pi -> about %d degrees",(SliderUserRot1.value/M_PI),(int)((SliderUserRot1.value/M_PI)*180.0)];
                 
                 SliderUserRot2.value = motion.attitude.roll;
                 ValueUserRot2.text = [NSString stringWithFormat:@"UserRot 2 (roll) =%f*pi -> about %d degrees",(SliderUserRot2.value/M_PI),(int)((SliderUserRot2.value/M_PI)*180.0)];
                 
                 model->userInfo.devicesAttitude = GLKMatrix3Make(
                                                                  motion.attitude.rotationMatrix.m11,
                                                                  motion.attitude.rotationMatrix.m12,
                                                                  motion.attitude.rotationMatrix.m13,
                                                                  motion.attitude.rotationMatrix.m21,
                                                                  motion.attitude.rotationMatrix.m22,
                                                                  motion.attitude.rotationMatrix.m23,
                                                                  motion.attitude.rotationMatrix.m31,
                                                                  motion.attitude.rotationMatrix.m32,
                                                                  motion.attitude.rotationMatrix.m33);
                 
                 
                 model->lastTimestamp = model->thisTimestamp;
                 model->thisTimestamp = motion.timestamp;
                 
                 [self RefreshWorldAndScreen];
                 
             }
         }];
        
    }
    else {
        model->isSimulator = YES;
        simulatorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(simulatorTick) userInfo:nil repeats:YES];

    }
}

- (void)simulatorTick{
    model->lastTimestamp = model->thisTimestamp;
    model->thisTimestamp = [[NSDate date] timeIntervalSince1970];

    [self RefreshWorldAndScreen];
}

- (void)viewDidUnload
{
    [self setPurpleViewCtrl:nil];
    [self setUpdateLabel1:nil];
    [self setLabel1:nil];
    anImageView1 = nil;
    anImageView2 = nil;
    [self setButton2:nil];
    [self setButtonTest3:nil];
    [self setSliderUserPosX:nil];
    SliderUserPosX = nil;
    ValueUserPosX = nil;
    [self setSliderUserPosX:nil];
    [self setSliderUserPosY:nil];
    [self setSliderUserPosZ:nil];
    ValueUserPosY = nil;
    ValueUserPosZ = nil;
    ValueUserRot1 = nil;
    [self setSliderUserRot1:nil];
    [self setSliderUserRot2:nil];
    ValueUserRot2 = nil;
    ValueObjectPosX_inUserCoord = nil;
    ValueObjectPosZ_inUserCoord = nil;
    ValueObjectPosY_inUserCoord = nil;
    image[0] = nil;
    image[1] = nil;
    ValueObjectDist_inUserCoord = nil;
    model = nil;
    motionManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


//start iphone view
- (IBAction)TouchUpdateLabel1:(id)sender {
    Label1.text = @"aaa";

    
/*  test 1
    // set up a rounded border
    CALayer *layer = [CALayer layer];   
    layer.bounds=CGRectMake(0,0,100,100);
    layer.position=CGPointMake(50,50);
    // clear the view's background color so that our background
    // fits within the rounded border
    CGColorRef backgroundColor = [PurpleViewCtrl.backgroundColor CGColor];
    PurpleViewCtrl.backgroundColor = [UIColor clearColor];
    layer.backgroundColor = backgroundColor;
    
    layer.borderColor = [[UIColor blackColor] CGColor];
    layer.borderWidth = 3.0f;
    [UpdateLabel1.layer addSubLayer:layer];
    
    layer.cornerRadius = 4.0f;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];   
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    [shapeLayer setLineCap:kCALineCapRound];
    [shapeLayer setLineWidth:4.0f];
    [layer addSublayer:shapeLayer];   
    
    [self setNeedsDisplay];
   
    CGRect bounds = PurpleViewCtrl.bounds;
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat startX = CGRectGetMinX(bounds) + 10;
    CGFloat width = CGRectGetWidth(bounds) - 20;
    
    CGFloat startY = CGRectGetMidY(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 800, 800);        
//    CGPathMoveToPoint(path, NULL, startX, startY);
//    CGPathAddLineToPoint(path, NULL, startX + 100, startY+100);        
    [shapeLayer setPath:path];
    [shapeLayer setNeedsDisplay];
    CFRelease(path);    

 */
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [anImageView2.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), (random()&0xFF)/255.0, (random()&0xFF)/255.0, (random()&0xFF)/255.0, (random()&0xFF)/255.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 10, 10);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 200, 100+random()&0xFF);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    anImageView2.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    int animationStartingImageNumber = 2340;
    int imageNumberOffsetForType8[] = {0,1,3,5,6,5,3,1};
    int numberOfFamesBroco8Anim = 8;
    imagesArrayBroco8Anim = [NSMutableArray arrayWithCapacity:numberOfFamesBroco8Anim];
    
    
    for (int i=0; numberOfFamesBroco8Anim > i; ++i)
    {
        NSString *tempFileName = [NSString stringWithFormat:@"IMG_%d.JPG", animationStartingImageNumber+imageNumberOffsetForType8[i]];
        UIImage *tempImage = [UIImage imageNamed:tempFileName];
        [imagesArrayBroco8Anim addObject:tempImage];
    }

    aRunTimeImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(80,240,100,60)];
    aRunTimeImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(130,270,100,60)];
    [self.view addSubview:aRunTimeImageView1];
    [self.view addSubview:aRunTimeImageView2];
    aRunTimeImageView1.animationImages = imagesArrayBroco8Anim; 
    aRunTimeImageView2.animationImages = imagesArrayBroco8Anim; 
    aRunTimeImageView1.animationDuration = 1.0 / 60 * numberOfFamesBroco8Anim * 5;
    aRunTimeImageView2.animationDuration = 0.3;
    [aRunTimeImageView1 startAnimating];    
    [aRunTimeImageView2 startAnimating];

}

- (IBAction)TouchUpInside:(id)sender {
    /*
     [self.view addSubview:aRunTimeImageView1];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.0];
    aRunTimeImageView2.center = CGPointMake(15,150);
    [UIView commitAnimations];
    */
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
}
// stop iphone view

// start ipad view
- (IBAction)TouchInsideButton3:(id)sender {
    CGPoint CenterOfView = [self.view center];
    aRunTimeImageView1.center=CenterOfView;
    aRunTimeImageView2.center=CGPointMake(CenterOfView.x+200, CenterOfView.y);
}
- (IBAction)ChangeSliderUserPosX:(id)sender {
    model->userInfo.pos.x = (int)([SliderUserPosX value]);
    ValueUserPosX.text = [NSString stringWithFormat:@"UserPos X=%d",(int)(model->userInfo.pos.x)];
    [self RefreshWorldAndScreen];
}
- (IBAction)ChangeSliderUserPosY:(id)sender {
    model->userInfo.pos.y = (int)([SliderUserPosY value]);
    ValueUserPosY.text = [NSString stringWithFormat:@"UserPos Y=%d",(int)(model->userInfo.pos.y)];
    [self RefreshWorldAndScreen];
}
- (IBAction)ChangeSliderUserPosZ:(id)sender {
    model->userInfo.pos.z = (int)([SliderUserPosZ value]);
    ValueUserPosZ.text = [NSString stringWithFormat:@"UserPos Z=%d",(int)(model->userInfo.pos.z)];
    [self RefreshWorldAndScreen];
}


- (IBAction)ChangeSliderUserRot1:(id)sender {
    model->userInfo.rotAroundZ = ((int)([SliderUserRot1 value]*128)/128.0);
    //userRot1 = ((int)([SliderUserRot1 value]*128)/128.0);
    ValueUserRot1.text = [NSString stringWithFormat:@"UserRot 1=%f*pi -> about %d degrees",(model->userInfo.rotAroundZ/M_PI),(int)((model->userInfo.rotAroundZ/M_PI)*180.0)];
    float cos = cosf(model->userInfo.rotAroundZ);
    float sin = sinf(model->userInfo.rotAroundZ);
    model->userInfo.devicesAttitude = GLKMatrix3Make(0,0,1, sin,cos,0, -cos,sin,0);
    [self RefreshWorldAndScreen];

}
- (IBAction)ChangeSliderUserRot2:(id)sender {
    model->userInfo.rotAroundY = ((int)([SliderUserRot2 value]*64)/64.0);
    //userRot2 = ((int)([SliderUserRot2 value]*64)/64.0);
    ValueUserRot2.text = [NSString stringWithFormat:@"UserRot 2=%f*pi -> about %d degrees",(model->userInfo.rotAroundY/M_PI),(int)((model->userInfo.rotAroundY/M_PI)*180.0)];
    [self RefreshWorldAndScreen];
}

-(void)RefreshWorldAndScreen{
    [self CalculateDeltaTime];
    [self AnimateModel];
    [self SortByDistance];
    [self CalculateObjectPositionsOnScreen];
    [self SelectImageForObjects];
    [self DisplayObjectsOnScreen];

};

-(void)CalculateObjectPositionsOnScreen {
    
    [model CalculateObjectListPositionsOnScreen];
    ValueUserPosX.text               = [NSString stringWithFormat:@"UserPos X=%f",model->userInfo.pos.x];
    ValueUserPosY.text               = [NSString stringWithFormat:@"UserPos Y=%f",model->userInfo.pos.y];
    ValueUserPosZ.text               = [NSString stringWithFormat:@"UserSpeed X=%f",model->userInfo.speed.x];//[NSString stringWithFormat:@"UserPos Z=%f",model->userInfo.pos.z];
    SliderUserPosX.value             = model->userInfo.pos.x;
    SliderUserPosY.value             = model->userInfo.pos.y;
    SliderUserPosZ.value             = model->userInfo.speed.x;//model->userInfo.pos.z;
    
    ValueObjectPosX_inUserCoord.text = [NSString stringWithFormat:@"Obj Pos x (user coord.):%f",model->objectList.object[0].posUW.x];
    ValueObjectPosY_inUserCoord.text = [NSString stringWithFormat:@"Obj Pos y (user coord.):%f",model->objectList.object[0].posUW.y];
    ValueObjectPosZ_inUserCoord.text = [NSString stringWithFormat:@"Obj Pos z (user coord.):%f",model->objectList.object[0].posUW.z];
    ValueObjectDist_inUserCoord.text = [NSString stringWithFormat:@"Obj Dist (user coord.):%f",model->objectList.object[0].distUW];
    
}

-(void)SelectImageForObjects{
    [model SelectStateForObjects];
    for (int i=0 ; i < model->objectList.numberOfObjects ; i++) {
        if (model->objectList.object[i].objectState == NOW_CURRENT_TARGET) {
            //image[i].animationImages = imagesArrayBroco1Anim;
            //[image[i] startAnimating];
            //image[i] = [UIImage initWithImage:image1];
            //image[i] = nil;
            //NSString *tempFileName = [NSString stringWithFormat:@"g_%03d.png", 6];
            //[image[i] initWithImage:([UIImage imageNamed:tempFileName])];
            image[i].transform = CGAffineTransformMakeRotation(M_PI_2);
            model->objectList.object[i].objectState = CURRENT_TARGET;
        }
        
        if (model->objectList.object[i].objectState == NOW_JUST_CAPTURED) {
            image[i].animationImages = imagesArrayBrocoAlpha8Anim;
            [image[i] startAnimating];
            model->objectList.object[i].objectState = JUST_CAPTURED;
        }

        if (model->objectList.object[i].objectState == NOW_INVISIBLE) {
            [[self.view viewWithTag:100+i] removeFromSuperview];
            image[i] = nil;
            model->objectList.object[i].objectState = INVISIBLE;
        }
  }    
    
}


-(void)DisplayObjectsOnScreen{
    for (int i=0 ; i < model->objectList.numberOfObjects ; i++) {
        // if object is visible and in front
        if (model->objectList.object[i].objectState != INVISIBLE && model->objectList.object[i].distUW >0) {
            CGPoint CenterOfView = [self.view center];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0];
            image[i].center = CGPointMake(CenterOfView.y + model->objectList.object[i].ScreenPosX, CenterOfView.x + model->objectList.object[i].ScreenPosY);
            image[i].alpha = model->objectList.object[i].alpha;
            
            image[i].transform = CGAffineTransformMakeScale(model->objectList.object[i].scale, model->objectList.object[i].scale);
            [UIView commitAnimations];
            
        }
        else { // object is invisible or is back
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0];
            image[i].center = CGPointMake(-1000, -1000);
            image[i].alpha = model->objectList.object[i].alpha;
            [UIView commitAnimations];
            
        }
    }    
};

-(void)CalculateDeltaTime{
    [model CalculateDeltaTime];    
};

-(void)AnimateModel{
    [model AnimateModel];    
};


NSComparisonResult CompareDistanceOfObject2(id viewIndex1, id viewIndex2, void *context){
    int v1 = [viewIndex1 intValue];
    int v2 = [viewIndex2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
    
}



-(NSComparisonResult)CompareDistanceOfObject:(id)viewIndex1 withDistanceOfOject2:(id)viewIndex2 inContect:(void *)context{
    int v1 = [viewIndex1 intValue];
    int v2 = [viewIndex2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
  
}

-(void)SortByDistance{
/*
    int a=rand()&0x3;
    int b=rand()&0x3;
    [self.view subviews];
 */
    // setSubviews
    //[self.view exchangeSubviewAtIndex:37 withSubviewAtIndex:38 ];
    NSArray *xxx=[self.view subviews];
    GLfloat zzz=[self.view layer].zPosition;
    zzz=zzz;
    //[self.view sortSubviewsUsingFunction:CompareDistanceOfObject2 context:NULL];
    int numberOfObjects = model->objectList.numberOfObjects;
    
    for (int imageIndexFori=0; imageIndexFori < numberOfObjects; imageIndexFori++) {
        for (int imageIndexForj=0; imageIndexForj < numberOfObjects; imageIndexForj++) {
            int objectIndexFori = imageToObjectLink[imageIndexFori];
            int objectIndexForj = imageToObjectLink[imageIndexForj];
            // if image i is currently farter than image j in the subview list
            if (imageIndexFori < imageIndexForj) {
                // check in model if these two images needs to be changed (if object i is closer than object j)
                if (model->objectList.object[objectIndexFori].distUW < model->objectList.object[objectIndexForj].distUW) {
                    [self.view exchangeSubviewAtIndex:(35 + imageIndexFori) withSubviewAtIndex:(35 + imageIndexForj) ];
                    imageToObjectLink[imageIndexFori] = objectIndexForj;
                    imageToObjectLink[imageIndexForj] = objectIndexFori;
                }
            }
            // if image i is currently closer than image j in the subview list
            if (imageIndexFori > imageIndexForj) {
                // check in model if these two images needs to be changed (if object i is farter than object j)
                if (model->objectList.object[objectIndexFori].distUW > model->objectList.object[objectIndexForj].distUW) {
                    [self.view exchangeSubviewAtIndex:(35 + imageIndexFori) withSubviewAtIndex:(35 + imageIndexForj) ];
                    imageToObjectLink[imageIndexFori] = objectIndexForj;
                    imageToObjectLink[imageIndexForj] = objectIndexFori;
                }
            }
        }
    }
    
    
/*    
    for (int i=0 ; i < numberOfObjects ; i++) {
        for (int j=i+1 ; j < numberOfObjects ; j++) {
            if (model->objectList.object[j].distUW < model->objectList.object[i].distUW) {
                // find image indices to exchange
                int imageIndexFori;
                int imageIndexForj;
                for (imageIndexFori=0; imageIndexFori < numberOfObjects; imageIndexFori++) {
                    if (imageToObjectLink[imageIndexFori] == i) {
                        break;
                    }
                    while (1); // problem!!!
                }
                for (imageIndexForj=0; imageIndexForj < numberOfObjects; imageIndexForj++) {
                    if (imageToObjectLink[imageIndexForj] == i) {
                        break;
                    }
                    while (1); // problem!!!
                }
                [self.view exchangeSubviewAtIndex:(35 + imageIndexFori) withSubviewAtIndex:(35 + imageIndexForj) ];
            }
        }
    }    
*/
};

@end
