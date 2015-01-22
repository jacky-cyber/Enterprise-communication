//
//  GroupEditViewController.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LinkDepartmentView.h"
#import "CustomAlertView.h"
#import <MessageUI/MFMessageComposeViewController.h>


@interface GroupEditViewController :BaseViewController<UIScrollViewDelegate,CustomeAlertViewDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>
{
    UIScrollView *membersView;
    NSString *groupid;
    NSString *creatorid;
    GroupType groupType;
    UIButton *editBtn;
    UIButton *doneBtn;
    NSMutableArray *membersArr;
    UIPageControl *pageControl;
    LinkDepartmentView *linkDepartmentView;
    BOOL isCanSelect;
}

@property (nonatomic, retain) UIScrollView *membersView;
@property (nonatomic, retain) NSString *groupid;
@property (nonatomic, retain) NSString *creatorid;
@property (nonatomic, retain) UIButton *editBtn;
@property (nonatomic, retain) UIButton *doneBtn;
@property (nonatomic, retain) NSMutableArray *membersArr;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) LinkDepartmentView *linkDepartmentView;
@property (nonatomic, retain) NSMutableArray *personWillDelete;
@property (nonatomic, retain)     CustomAlertView *customAllertView;
@property (nonatomic, retain) UILabel *titleLabel;


- (id)initWithGroupid:(NSString *)groupid;

@end
