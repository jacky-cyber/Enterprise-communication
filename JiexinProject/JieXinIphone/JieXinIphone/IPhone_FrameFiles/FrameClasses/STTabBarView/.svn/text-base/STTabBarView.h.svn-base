//
//  STTabBarView.h
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//
#define kTabbarHeight           50
#define kHomeButtonWidth        128/2
#define kTabbarItemWidth        80
#define kHomeViewWidth          320
#define kHomeViewHeight         kScreen_Height
#define kMoreItemLeft           @"jiantou-01.png"
#define kMoreItemRight           @"jiantou-02.png"

#define UIImageGetImageFromName(__POINTER) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__POINTER ofType:nil]]

@protocol STTabBarTouchDelegate <NSObject>

- (void)didTabbarHomeButtonTouched:(id)sender;
- (void)didTabbarViewButtonTouched:(id)sender;

@end

#import <UIKit/UIKit.h>

@class STTabBarItem;
@class STTabBarHomeView;

@interface STTabBarView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    STTabBarItem *_homeButton;
    UIImageView *_leftIndicator;
    UIImageView *_rightIndicator;
    STTabBarHomeView *_homeView;
    
//    UIImageView *_bgImageView;
    BOOL _isHomeShown;
    NSInteger _selectedIndex;
}
@property (nonatomic, retain) NSArray *contentArray;
@property (nonatomic, retain) NSDictionary *homeItemDic;
@property (nonatomic, assign) id<STTabBarTouchDelegate> delegate;

//contentArray
//dictionary:@"title" @"normal" @"selected"
- (id)initWithFrame:(CGRect)frame withContent:(NSArray *)array homeItemDic:(NSDictionary *)homeItemDic;
- (NSArray *)getItemArray;
- (void)setSelectedIndex:(int)index animated:(BOOL)animated;
- (void)reloadContentData;
- (void)performHomeButtonTapped;

@end
