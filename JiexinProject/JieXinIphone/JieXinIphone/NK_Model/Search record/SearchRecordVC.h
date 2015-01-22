//
//  SearchRecordVC.h
//  JieXinIphone
//
//  Created by macOne on 14-4-22.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRecordVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>

- (IBAction)goBack:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *view_01;

@property (retain, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) int queryway;//方式 0/1/2/3
@property (retain, nonatomic) NSString *queryby;//内容:名称(filename)/年度(year)/编号(filenum)/类型。
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) UIButton *button_search;
@property (retain, nonatomic) UISearchBar *searchBar_search;
@property (retain, nonatomic) IBOutlet UIView *view_02;
- (IBAction)searchWithName:(id)sender;
- (IBAction)searchWithYear:(id)sender;
- (IBAction)searchWithNumber:(id)sender;


@property (retain, nonatomic) UITextField *textField_search;
@property (retain, nonatomic) NSMutableArray *typeArray;

- (IBAction)showTypes:(id)sender;

-(void)chooseQueryway;
-(void)chooseType:(UIButton *)button_chooseType;

@property (assign, nonatomic) int pageNumber;//页数
@property (assign, nonatomic) int pageCount;//每页的数量
@property (assign, nonatomic) int totalPage;//总共页数
@end
