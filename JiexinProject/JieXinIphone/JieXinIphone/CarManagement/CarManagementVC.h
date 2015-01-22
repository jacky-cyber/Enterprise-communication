//
//  CarManagementVC.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Car_customCell.h"
#import "PullTableView.h"
#import "CarDetailViewController.h"


@interface CarManagementVC : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,cellBtnSelectedDelegate,PullTableViewDelegate,UIAlertViewDelegate>

{
    NSMutableArray *soureArray;
    PullTableView *listView;
}

@property (nonatomic, retain) NSMutableArray *sourceArray;
@property (nonatomic, retain) PullTableView *listView;

@end
