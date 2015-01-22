//
//  CardApplyViewController.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ApplyPopoverView.h"
#import "ApplyPickerView.h"
#import "SelectVC.h"

@interface CardApplyViewController : BaseViewController<PopoverDelegate,UITextFieldDelegate,PickerConfirmDelegate,UIAlertViewDelegate,SelectDelegate>
{
    Language language;
    UIScrollView *contentView;
}

@property (nonatomic, assign) CGFloat iosChangeFloat;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) UIScrollView *contentView;
@property (nonatomic, copy)     NSString *userid; //申请人id


- (id)initWithJurisdiction:(NSString *)jurisdiction  withUserId:(NSString *)userid;
- (void)commitApply;
- (void)modifyApply;

@end
