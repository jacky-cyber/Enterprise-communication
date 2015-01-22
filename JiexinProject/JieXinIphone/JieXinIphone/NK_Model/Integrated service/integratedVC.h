//
//  integratedVC.h
//  JieXinIphone
//
//  Created by macOne on 14-4-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integratedVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UIView *view_01;
- (IBAction)goBack:(id)sender;
@property (retain,nonatomic) NSMutableArray *dataArray;//保存所有数据的
@property (assign,nonatomic) int max;
@property (retain, nonatomic) UITableView *tableView_current;

@property (assign, nonatomic) int pageNumber;//页数
@property (assign, nonatomic) int pageCount;//每页的数量
@property (assign, nonatomic) int totalPage;//总共页数

@end
