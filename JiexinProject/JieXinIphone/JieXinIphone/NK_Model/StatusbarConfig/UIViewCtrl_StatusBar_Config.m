//
//  UIViewCtrl_StatusBar_Config.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//
#import "AppDelegate.h"
#import "UIViewCtrl_StatusBar_Config.h"

@interface UIViewCtrl_StatusBar_Config ()

@end

@implementation UIViewCtrl_StatusBar_Config

@synthesize view_01 = _view_01;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

@end
