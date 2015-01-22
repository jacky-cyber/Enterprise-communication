//
//  ApplyPopoverView.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverDelegate <NSObject>

@optional
- (void)commitApply;
- (void)modifyApply;

@end

@interface ApplyPopoverView : UIView<PopoverDelegate>

@property (nonatomic, assign) id<PopoverDelegate> popoverDelegate;

@end

