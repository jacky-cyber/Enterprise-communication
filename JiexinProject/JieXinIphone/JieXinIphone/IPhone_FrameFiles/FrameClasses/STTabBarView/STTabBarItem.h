//
//  STTabBarItem.h
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//
#define kItemTitle              @"Title"
#define kItemBgNormal           @"Nomal"
#define kItemBgSelected         @"Selected"
#define kTitleOffsetX            0
#define kTitleOffsetY            17
#define kTitleWidth              80
#define kTitleHeight             48
#define kTitleFontSize           11.0f


#import <UIKit/UIKit.h>

@interface STTabBarItem : UIControl
{
    UIImageView *_bgImageView;
    UILabel *_titleLabel;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *bgImageName;
@property (nonatomic, copy) NSString *bgImageSelectedName;

//@"title" @"normal" @"selected"
- (id)initWithFrame:(CGRect)frame withItemInfo:(NSDictionary *)infoDic;
- (void)changeState:(BOOL)selected;
@end
