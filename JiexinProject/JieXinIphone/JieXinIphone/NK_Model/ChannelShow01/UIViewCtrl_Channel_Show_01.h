//
//  UIViewCtrl_Channel_Show_01.h
//  JieXinIphone
//
//  Created by gabriella on 14-4-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TypeMe,
    TypeAll
} From;

@interface UIViewCtrl_Channel_Show_01 : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) From from;

- (IBAction)onBtnReturn_Click:(id)sender;

- (IBAction)onBtnFun01_Click:(id)sender;
- (IBAction)onBtnFun02_Click:(id)sender;
- (IBAction)onBtnFun03_Click:(id)sender;
- (IBAction)onBtnFun04_Click:(id)sender;
-(IBAction)onMyListBtn_Click:(id)sender;


- (void) Close_Message:(id)wParam;
- (void) THREAD_PROC_01:(id)wParam;
- (void) THREAD_PROC_02:(id)wParam;
- (void) ON_COMMAND:(id)wParam;
- (void) ON_NOTIFICATION:(NSNotification *) wParam;

@end
