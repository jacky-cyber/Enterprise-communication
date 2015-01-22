//
//  UIViewCtrl_Channel_Detail_01.h
//  JieXinIphone
//
//  Created by gabriella on 14-4-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_Channel_Detail_01 : UIViewController

@property (strong, nonatomic) NSMutableArray * array_weblog;


- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction)onBtnFun01_Click:(id)sender;
- (IBAction)onBtnFun02_Click:(id)sender;
- (IBAction)onBtnFun03_Click:(id)sender;
- (IBAction)onBtnFun04_Click:(id)sender;
- (IBAction)onBtnFun05_Click:(id)sender;
- (void)onBtnFun06_Click:(id)sender;
- (IBAction)onBtnFun07_Click:(id)sender;
- (void) Close_Message:(id)wParam;

- (void) THREAD_PROC_01:(id)wParam;
- (void) THREAD_PROC_02:(id)wParam;
- (void) ON_NOTIFICATION:(NSNotification *) wParam;
-(void)headViewLongpress:(UILongPressGestureRecognizer*)gestureRecognizer;

@end
