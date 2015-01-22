//
//  MsgCategoryDetailViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "MsgCategoryDetailViewController.h"
#import "FMDatabase.h"
#define MsgFont  15.0

@interface MsgCategoryDetailViewController ()
@property (nonatomic, retain)NSMutableArray *listArr;
@property (nonatomic, retain) UITableView *listTableView;
@property (nonatomic, retain) UILabel *titleLabel;

@end

@implementation MsgCategoryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.listArr = nil;
    self.listTableView = nil;
    self.titleStr = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
    [self readLocalDataBase];
    

	// Do any additional setup after loading the view.
}
-(void)readLocalDataBase{
    NSString *localDbPath = [[NSBundle mainBundle] pathForResource:@"qtim" ofType:@"db"];
    FMDatabase *localDataBase = [FMDatabase databaseWithPath:localDbPath];
    if(![localDataBase open]){//打开数据库
        NSLog(@"qtim.db Could not open db.");
    }
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [localDataBase executeQuery:@"select * from smstemplate where categoryId=?",self.cateId];
    while ([rs next]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *id = [rs stringForColumn:@"id"];
        [dic setValue:id forKey:@"id"];
        
        NSString *categoryId = [rs stringForColumn:@"categoryId"];
        [dic setValue:categoryId forKey:@"categoryId"];
        
        NSString *msgContent = [rs stringForColumn:@"msgContent"];
        [dic setValue:msgContent forKey:@"msgContent"];
        
        [resultArray addObject:dic];
    }
    
    [rs close];
    [localDataBase close];
    self.listArr = resultArray;
    [self.listTableView reloadData];
}

- (void)initSubViews
{
    CGFloat changeFloat = 0;
    if (IOSVersion >= 7.0) {
        changeFloat = 20;
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, changeFloat, kScreen_Width, kNavHeight)];
    header.image = UIImageWithName(@"top_bar_bg.png");
    header.userInteractionEnabled = YES;
    [self.view addSubview:header];
    [header release];
    
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, changeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.text = self.titleStr;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_titleLabel];

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.listTableView = tableView;
    [tableView release];
    [self.view addSubview:_listTableView];
}

- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark TableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    //这里要自动定义

    NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    NSString *content = [dic objectForKey:@"msgContent"];
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:MsgFont] constrainedToSize:CGSizeMake(kScreen_Width-20, MAXFLOAT)];
    //    CGFloat height = []
    return size.height + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置正常群组Cell
    static NSString * const CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 300, 20)];
        label.font = [UIFont systemFontOfSize:MsgFont];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1000;
        [cell.contentView addSubview:label];
        [label release];
    }
    NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1000];
    label.numberOfLines = 0;
    NSString *content = [dic objectForKey:@"msgContent"];
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:MsgFont] constrainedToSize:CGSizeMake(kScreen_Width-20, MAXFLOAT)];
    label.frame = CGRectMake(10, 5, kScreen_Width -20, size.height);
    label.text = content;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectMsgDetail:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate selectMsgDetail:dic];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
