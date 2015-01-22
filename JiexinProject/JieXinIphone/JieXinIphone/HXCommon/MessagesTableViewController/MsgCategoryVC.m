//
//  MsgCategoryVC.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "MsgCategoryVC.h"
#import "FMDatabase.h"
#import "MsgCategoryDetailViewController.h"

@interface MsgCategoryVC ()<MsgDelegate>

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain)NSMutableArray *listArr;
@property (nonatomic, retain) UITableView *listTableView;

@end

@implementation MsgCategoryVC

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
    self.titleLabel = nil;
    self.listArr = nil;
    self.listTableView = nil;
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
    FMResultSet *rs = [localDataBase executeQuery:@"select * from smscategory order by id Asc"];
    while ([rs next]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *id = [rs stringForColumn:@"id"];
        [dic setValue:id forKey:@"id"];
        
        NSString *categoryName = [rs stringForColumn:@"categoryName"];
        [dic setValue:categoryName forKey:@"categoryName"];

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
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"短信";
    [self.view addSubview:_titleLabel];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight) style:UITableViewStyleGrouped];
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
//    
//    ChatMessagesFeed *feed = [_messageDetailList objectAtIndex:indexPath.row];
//    NSString *name = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
//    NSString *timenameStr = [NSString stringWithFormat:@"%@  %@",name,feed.date];
//    CGSize sizeName = [timenameStr sizeWithFont:[UIFont systemFontOfSize:kHistoryNameFont] constrainedToSize:CGSizeMake(kScreen_Width-10, MAXFLOAT)];
//    CGSize sizeMessage = [feed.message sizeWithFont:[UIFont systemFontOfSize:kHistoryMessageFont] constrainedToSize:CGSizeMake(kScreen_Width-10, MAXFLOAT)];
//    //    CGFloat height = []
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置正常群组Cell
    static NSString * const CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType =     UITableViewCellAccessoryDisclosureIndicator;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 200, 20)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1000;
        [cell.contentView addSubview:label];
        [label release];
    }
    NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1000];
    label.text = [dic objectForKey:@"categoryName"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
    
    MsgCategoryDetailViewController *detail = [[MsgCategoryDetailViewController alloc] initWithNibName:nil bundle:nil];
    detail.delegate = self;
    detail.cateId = [dic objectForKey:@"id"];
    detail.titleStr = [dic objectForKey:@"categoryName"];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}

- (void)selectMsgDetail:(NSDictionary *)infoDic
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectMsgDetail:)])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate selectMsgDetail:infoDic];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
