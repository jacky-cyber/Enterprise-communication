//
//  UIViewCtrl_About.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "AppDelegate.h"
#import "NGLABAL_DEFINE.h"
#import "UIViewCtrl_About.h"

@interface UIViewCtrl_About ()

@end

@implementation UIViewCtrl_About

@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;
@synthesize label_03 = _label_03;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_version = [infoDic valueForKey:@"CFBundleShortVersionString"];
    [self.label_01 setText:[NSString stringWithFormat:@"当前版本：V%@", app_version]];
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr isEqualToString:@"111.11.28.29"])
    {
        [self.label_03 setText:@"Copyright © 2014 www.cmccsi.cn Inc. All Rights Reserved."];
        [self.label_02 setText:@"中国移动政企分公司 版权所有"];
    }
    else if([headStr isEqualToString:@"111.11.28.41"])
    {
        [self.label_03 setText:@"Copyright © 2014 CMCC Inc. All Rights Reserved."];
        [self.label_02 setText:@"中国移动政企分公司 版权所有"];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods
-(IBAction)onBtnDownload:(id)sender{
    NSURL *urlStr=nil;
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr isEqualToString:@"111.11.28.29"] || [headStr isEqualToString:@"111.11.28.30"]){
        urlStr=[NSURL URLWithString:@"http://uc.cmccsi.cn/"];
    }
    else if([headStr isEqualToString:@"111.11.28.41"]){
        urlStr=[NSURL URLWithString:@"http://uczq.cmccsi.cn/"];
    }
    [[UIApplication sharedApplication]openURL:urlStr];

}
- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnRCall_Click:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://031185815795"]];
}

@end
