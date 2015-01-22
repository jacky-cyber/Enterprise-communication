//
//  myLib.h
//  chatView
//
//  Created by lxrent02 on 14-3-20.
//  Copyright (c) 2014年 miaoLiZhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
//get current device
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone5ScreenHeight 1136/2
#define notIphone5ScreenHeight 960/2
@interface myLib : UIViewController

+(void)mSetStatesBar:(UINavigationController*)nav;
//for tabbarController with four items
+(UITabBarController*)CreatTabbarViewArray:(NSArray*)viewArray andTitleArray:(NSArray*)titleArray andImageArray:(NSArray*)imageArray andselectedImageArray:(NSArray*)selectedImageArray andItemsCount:(NSInteger)count;

@end
