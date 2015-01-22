//
//  ContactGroupView.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavPushDelegate.h"
#import "PullTableView.h"
#import "CommonCell.h"
#import "CustomAlertView.h"

@interface ContactGroupView : UIView<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,PullTableViewDelegate,CommonCellDelegate,CustomeAlertViewDelegate>
{
    PullTableView *listView;
    NSMutableArray *sourceData;
    NSMutableArray *flagArr;
    WhatTodo operate;
    BOOL isCanSelect;
}

@property (nonatomic, retain) PullTableView *listView;
@property (nonatomic, retain) NSMutableArray *sourceData;
@property (nonatomic, assign) BOOL isCanSelect;
@property (nonatomic, retain) NSMutableArray *groupChoose;
@property (nonatomic, retain) NSMutableArray *flagArr;
@property (nonatomic, assign) BOOL isCanLongPress;

@property(nonatomic,assign) id<NavPushDelegate> pushDelegate;

- (void)requestGroupList;

@end
