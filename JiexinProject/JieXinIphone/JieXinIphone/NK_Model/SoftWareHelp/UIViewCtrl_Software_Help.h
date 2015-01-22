//
//  UIViewCtrl_Software_Help.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_Software_Help : FrameBaseViewController<UIWebViewDelegate>

@property (assign, nonatomic) IBOutlet UIWebView *webview_01;

- (IBAction)onBtnReturn_Click:(id)sender;

@end
