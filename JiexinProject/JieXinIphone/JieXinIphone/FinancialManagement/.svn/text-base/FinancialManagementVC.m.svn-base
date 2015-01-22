//
//  FinancialManagementVC.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-3-31.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "FinancialManagementVC.h"
#import "UIViewCtrl_News.h"
#import "JFinanicaCell.h"
#import "HttpServiceHelper.h"
#import "ConnetViewController.h"
#import "JButton.h"
#import "JTitleLabel.h"
@interface FinancialManagementVC (){
    int currentPage;
    BOOL refreshData;
    int RequestTag;
    NSString *nameTitle;
}
@end
@implementation FinancialManagementVC
@synthesize fModeArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        nameTitle=@"营改增手机报";
        currentPage=1;
        refreshData=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    fModeArr = [[NSMutableArray alloc]init];
    [self loadlistView];//加载财务管理视图
    [self requestDataForServer:1];
	
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentPage=1;
}
-(void)setRequestTag:(int)tag name:(NSString*)name{
    RequestTag=tag;
    if(!name||![name isEqualToString:@""]){
        nameTitle=name;
    }
}
#pragma mark - Private Method
- (void)loadlistView
{
    
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kScreen_Height-44-self.iosChangeFloat)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    [baseView release];
    
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:110];
    [backButton addTarget:self action:@selector(on_BtnReturn_Colik) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:nameTitle rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    
    
    
    //创建UITableView
    _listTable= [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320,kScreen_Height-44-self.iosChangeFloat) style:UITableViewStylePlain];
//    _array= [[UIFont familyNames ]retain];//数据源
    _listTable.dataSource = self;//设置数据源
    _listTable.delegate = self;//设置代理
    _listTable.pullDelegate=self;
    _listTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    _listTable.backgroundColor = [UIColor whiteColor];
    if (IOSVersion>=7) {
        _listTable.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    }

    [baseView addSubview:_listTable];
}//加载财务管理视图
-(void)loadNoMessage:(NSArray*)arr{
    if(arr==nil||[arr count]==0){
        JTitleLabel *titleLabe=[[JTitleLabel alloc]initJTitleLabel:@"暂时没有内容" rect:CGRectMake(80,230,150,30) fontSize:17 fontColor:RGBCOLOR(100, 100, 100)];
        [self. view addSubview:titleLabe];
        [titleLabe release];
    }
}

//////////////////////////////////////////////////////////////////////

- (void)requestDataForServer:(int)pageNumber{
    int pageCount=10;
    [[STHUDManager sharedManager]showHUDInViewToMySelf:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQuerycourselista info:@{@"pageNumber":[NSString stringWithFormat:@"%d",pageNumber],@"pageCount":[NSString stringWithFormat:@"%d",pageCount],@"category":[NSString stringWithFormat:@"%d",RequestTag]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    
   
}// 请求数据
- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
    NSArray * BigArr = [datas objectForKey:@"data"];
    totalPage=[[datas objectForKey:@"totalPage"]intValue];
    if(refreshData){
        refreshData=NO;
        [fModeArr release];
        fModeArr = [[NSMutableArray alloc]init];
    }
    [fModeArr addObjectsFromArray:BigArr];
    [_listTable reloadData];
    [self loadNoMessage:BigArr];
       
}

#pragma mark 请求网络失败
- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
    NSLog(@"%@",sender);
}

#pragma mark 返回事件
- (void)on_BtnReturn_Colik
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark TableDateSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fModeArr count];
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //定义一个静态标识符
    static NSString *cellIdentifier = @"cell";
    JFinanicaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[JFinanicaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    [cell settitle:[fModeArr[indexPath.row] objectForKey:@"title"] date: [fModeArr[indexPath.row] objectForKey:@"date"]  content:[fModeArr[indexPath.row] objectForKey:@"summary"]];
    return cell;
}
-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.font = [UIFont systemFontOfSize:17.0];
    label1.tag=100;
    [label1 sizeToFit];
    return label1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConnetViewController *connetVC = [[ConnetViewController alloc] initWithcourseid:[fModeArr[indexPath.row] objectForKey:@"courseid"]];
    [self.navigationController pushViewController:connetVC animated:YES];
}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel* lable = [self fitLable:[fModeArr[indexPath.row] objectForKey:@"title"] and_x:10 and_y:5 and_width:270];
    return 120+lable.frame.size.height;
}
#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
    
}
-(void)refreshTable{
    //添加刷新代码
    refreshData=YES;
    currentPage=1;
    [self requestDataForServer:currentPage];
    _listTable.pullLastRefreshDate = [NSDate date];
    _listTable.pullTableIsRefreshing = NO;
}
-(void)loadMoreDataToTable{
    currentPage++;
    if(currentPage<=totalPage)
        [self requestDataForServer:currentPage];
    _listTable.pullTableIsLoadingMore = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [super dealloc];
    [_NavigaBG release],_NavigaBG = nil;
    [_listTable release],_listTable = nil;
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
}

@end
