//
//  BaseViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize titleStr = _titleStr;
//@synthesize iosChangeFloat = _iosChangeFloat;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        if (iOSVersion < 7.0) {
//            self.iosChangeFloat = 0;
//        }else{
//            self.iosChangeFloat = 20.f;
//        }

    }
    return self;
}


- (void)createCustomNavBar{
    if (self.iosChangeFloat) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    UIImageView *navBarImgView = [[UIImageView alloc] initWithImage:UIImageWithName(@"top_bar_bg.png")];
//    navBarImgView.backgroundColor = [UIColor grayColor];
    navBarImgView.frame = CGRectMake(0, self.iosChangeFloat, kScreen_Width, kNavHeight);
    navBarImgView.userInteractionEnabled = YES;
    [self.view addSubview:navBarImgView];
    [navBarImgView release];
    
    UIImage *image = [UIImage imageNamed:@"top_logo.png"];
    UIImageView *topLogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 11, image.size.width/2, 22)];
    topLogo.image = image;
    [navBarImgView addSubview:topLogo];
    [topLogo release];
    
//    UILabel *titleLb = [[UILabel alloc] initWithFrame:navBarImgView.frame];
//    titleLb.font = [UIFont boldSystemFontOfSize:20.f];
//    titleLb.backgroundColor = [UIColor grayColor];
//    titleLb.text = _titleStr;
//    titleLb.textColor = [UIColor blackColor];
//    titleLb.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLb];
//    [titleLb release];
}

- (void)createCustomNavBarWithoutLogo{
    if (self.iosChangeFloat) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    UIImageView *navBarImgView = [[UIImageView alloc] initWithImage:UIImageWithName(@"top_bar_bg.png")];
    //    navBarImgView.backgroundColor = [UIColor grayColor];
    navBarImgView.frame = CGRectMake(0, self.iosChangeFloat, kScreen_Width, kNavHeight);
    navBarImgView.userInteractionEnabled = YES;
    [self.view addSubview:navBarImgView];
    [navBarImgView release];
    
    //    UILabel *titleLb = [[UILabel alloc] initWithFrame:navBarImgView.frame];
    //    titleLb.font = [UIFont boldSystemFontOfSize:20.f];
    //    titleLb.backgroundColor = [UIColor grayColor];
    //    titleLb.text = _titleStr;
    //    titleLb.textColor = [UIColor blackColor];
    //    titleLb.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:titleLb];
    //    [titleLb release];
}

- (void)dealloc
{
    self.titleStr = nil;
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
