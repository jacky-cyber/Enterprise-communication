//
//  BaseTabBarController.h
//  WoAiPhoneApp
//
//  Created by 雷克 on 10-11-19.
//  Copyright 2010 Sharppoint Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "STTabBarView.h"
#import "WelcomeView.h"


@interface MainTabBarController : UITabBarController <UIScrollViewDelegate,
    STTabBarTouchDelegate,LoginDelegate,HideWelcomeDelegate>
{
//	int _choosenIndex;
	STTabBarView *customTabbarView;
    UIImageView *leftIndicator,*rightIndicator;
	NSTimer *timer;
    //hbf
	UIControl *currentBtn;
    //LoginView  *loginView;
	UIButton *btn1;
    NSMutableArray *btns;
    //TO DO: Temp
    NSMutableDictionary *indicatorDic;
}
//@property (nonatomic, assign) int choosenIndex;
@property (nonatomic, retain) STTabBarView *customTabbarView;
@property (nonatomic, retain) UIImageView *leftIndicator,*rightIndicator;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) UIControl *currentBtn;
@property (nonatomic, retain) NSMutableArray *btns;
@property (nonatomic, retain) NSMutableDictionary *indicatorDic;
@property (nonatomic, retain) LoginView *loginView;
@property (nonatomic, retain) WelcomeView *welcome;

//@property (nonatomic,retain) LoginView  *loginView;
//设置tabBar的title。
- (void)loadMenuItems;
//- (void)
- (void)settingTabBarItemWithTitleArray:(NSArray *)titleArray;
- (void)callOutCustomTabbar:(NSNotification *)notification;
- (void)doLogin;
- (void)showWelcomeView;
- (void)makeTabBarHidden:(BOOL)hide;

@end 