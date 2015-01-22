//
//  RotatePhotoViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-6-10.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "RotatePhotoViewController.h"

#define kBottomHeight  44
@interface RotatePhotoViewController ()
{
    int rotation;
}

@property (nonatomic, retain) UIImageView *imageView;

@end



@implementation RotatePhotoViewController
- (void)dealloc
{
    self.rotateImage = nil;
    self.imageView = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBarWithoutLogo];
    [self initSubViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initSubViews
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"normalBack.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"图片";
    [self.view addSubview:titleLabel];
    [titleLabel release];

    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+kNavHeight, kScreen_Width, kScreen_Height-kBottomHeight-20-kNavHeight)] autorelease];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.autoresizesSubviews = YES;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.image = _rotateImage;
    [self.view addSubview:_imageView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), kScreen_Width, kBottomHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    
    UIImage *rotateImage = [UIImage imageNamed:@"rotateBtnBg.png"];
    UIButton *rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotateBtn.frame = CGRectMake(0, 0, 100, kBottomHeight);
    [rotateBtn setImage:rotateImage forState:UIControlStateNormal];
    [rotateBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 100-10-rotateImage.size.width/2-10)];
    [rotateBtn addTarget:self action:@selector(rotateImageBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rotateBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kScreen_Width -110, 0, 100, kBottomHeight);
    [sureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [sureBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [sureBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGBCOLOR(1, 165, 228) forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [sureBtn addTarget:self action:@selector(onSendBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
}
- (void)fillRotateImageView:(UIImage *)rotateImage
{
    self.rotateImage = rotateImage;
    _imageView.image = rotateImage;
}

- (void)onSendBtnTap
{
    if(_delegate && [(NSObject *)_delegate respondsToSelector:@selector(selectImage:withInfo:)])
    {
        [_delegate selectImage:_rotateImage withInfo:nil];
    }
}
- (void)onReturnBtnPressed:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

//旋转
-(void)rotateImageBtnTap:(UIButton *)button
{

//    rotation += 1;
//    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(rotation * M_PI / 2);
//    [UIView animateWithDuration:0.5f animations:^{
//        self.imageView.transform = rotationTransform;
//        self.imageView.frame = CGRectMake(0,self.iosChangeFloat+kNavHeight, CGRectGetHeight(self.imageView.frame), CGRectGetWidth(self.imageView.frame));
//    }];
    

    [UIView animateWithDuration:0.5f animations:^{
        switch (_rotateImage.imageOrientation) {
            case UIImageOrientationUp:
                self.rotateImage = [UIImage imageWithCGImage:_rotateImage.CGImage scale:1.0 orientation:UIImageOrientationLeft ];
                
                break;
            case UIImageOrientationLeft:
                self.rotateImage = [UIImage imageWithCGImage:_rotateImage.CGImage scale:1.0 orientation:UIImageOrientationDown ];
                
                break;

            case UIImageOrientationDown:
                self.rotateImage = [UIImage imageWithCGImage:_rotateImage.CGImage scale:1.0 orientation:UIImageOrientationRight ];
                
                break;

            case UIImageOrientationRight:
                self.rotateImage = [UIImage imageWithCGImage:_rotateImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
                break;
            default:
                break;
        }
        self.imageView.image = _rotateImage;

    }];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
