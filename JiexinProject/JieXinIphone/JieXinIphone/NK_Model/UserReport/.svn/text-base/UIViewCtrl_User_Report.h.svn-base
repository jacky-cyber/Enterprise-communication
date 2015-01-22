//
//  UIViewCtrl_User_Report.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_User_Report : FrameBaseViewController <UITextViewDelegate, UIAlertViewDelegate>
{
    BOOL bTextIsEmpty;
}

@property (assign, nonatomic) IBOutlet UITextView *textview_01;
@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UILabel *label_01;

- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction)Close_KeyBoard:(id)sender;
- (IBAction)onBtnClear_Click:(id)sender;
- (IBAction)onBtnSubmit_Click:(id)sender;
- (void)receiveDataNotification:(NSNotification *)wParam;

@end
