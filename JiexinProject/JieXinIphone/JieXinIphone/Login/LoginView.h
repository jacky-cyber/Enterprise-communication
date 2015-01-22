//
//  LoginView.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseStatusViewController.h"
#import "FPPopoverController.h"
#import "LoginSetView.h"
#import "CustomAlertView.h"

@protocol LoginDelegate

- (void)loginSuccessfully:(NSDictionary *)info;

@end

@interface LoginView : UIView<FPPopoverControllerDelegate,ChooseStatusDelegate,CustomeAlertViewDelegate>

@property (nonatomic, assign) id <LoginDelegate> delegate;
@property (nonatomic, retain) CustomAlertView *customAlertView;

- (IBAction)onBtnForgetPwd_Click:(id)sender;

@end
