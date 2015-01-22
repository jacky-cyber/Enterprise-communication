//
//  STTabBarHomeView.h
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//
#define kNotification_ButtonTouched          @"notificationbuttontouched"
#import <UIKit/UIKit.h>

@interface STTabBarHomeView : UIView
@property (nonatomic, retain) NSArray *contentArray;
@property (nonatomic, retain) NSMutableArray *items;
- (id)initWithFrame:(CGRect)frame withContent:(NSArray *)array;

- (void)show;
- (void)hide;
-(void)changeMemberIcon:(NSString *)iconName;
@end
