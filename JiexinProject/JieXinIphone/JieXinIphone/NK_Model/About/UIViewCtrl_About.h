//
//  UIViewCtrl_About.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_About : FrameBaseViewController

@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UIView *view_02;
@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UILabel *label_02;
@property (assign, nonatomic) IBOutlet UILabel *label_03;


- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction)onBtnRCall_Click:(id)sender;
-(IBAction)onBtnDownload:(id)sender;
@end
