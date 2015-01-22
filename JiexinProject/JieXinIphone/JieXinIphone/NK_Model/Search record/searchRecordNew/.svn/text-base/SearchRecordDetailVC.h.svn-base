//
//  SearchRecordDetailVC.h
//  JieXinIphone
//
//  Created by macOne on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRecordDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) int queryway;//方式 0/1/2/3
@property (retain, nonatomic) NSString *queryby;//内容

@property (retain, nonatomic) UITableView *tableView;

@property (retain, nonatomic) NSMutableArray *dataArray;

@property (retain, nonatomic) IBOutlet UIView *view_01;
@property (retain, nonatomic) NSString *titleString;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;



@property (assign, nonatomic) int pageNumber;//页数
@property (assign, nonatomic) int pageCount;//每页的数量
@property (assign, nonatomic) int totalPage;//总共页数
- (IBAction)goBack:(id)sender;

@end
