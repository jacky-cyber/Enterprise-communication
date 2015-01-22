//
//  AppDelegate.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//
#import <UIKit/UIKit.h>
//#import "MainTabBarController.h"

@class MainTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) MainTabBarController	 *mainTabBarVC;
@property (nonatomic, retain) UINavigationController *rootNavigation;
@property (nonatomic, assign) NSInteger nowChatUserId;
@property (nonatomic, assign) long long int serverAndLocalDiff;
//登录是否切换账户
@property(nonatomic) BOOL sameUserName;
//登录是否切Ip
@property(nonatomic) BOOL sameIP;

@property(nonatomic) BOOL isLogin;
//消息数组
@property(nonatomic,strong)NSMutableArray*newsModelArray;


+ (AppDelegate *)shareDelegate;
- (void)registerForRemoteNotification:(id)sender;
- (void)setSelectIndex:(int)index;
@end
