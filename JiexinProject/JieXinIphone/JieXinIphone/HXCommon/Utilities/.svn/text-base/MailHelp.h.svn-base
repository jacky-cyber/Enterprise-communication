//
//  MailHelp.h
//  SunboxApp_Standard_IPad
//
//  Created by apple on 13-5-6.
//  Copyright (c) 2013年 Raik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MessageUI/MessageUI.h>

@interface MailHelp : NSObject <MFMailComposeViewControllerDelegate>
{
    UIViewController *viewController;
    SEL selector;
}

@property (nonatomic, assign) UIViewController *viewController;
@property (nonatomic, retain) NSArray *recipients;
@property (nonatomic, assign) BOOL isShowScreenShot;

+ (MailHelp *)sharedService;
- (void)sendMailWithPresentViewController:(UIViewController *)presentVC;
- (void)sendMailWithPresentViewController:(UIViewController *)presentVC andReturnSel:(SEL)aSelector;
- (UIImage *)getScreen1WithView:(UIView *)view;

@end