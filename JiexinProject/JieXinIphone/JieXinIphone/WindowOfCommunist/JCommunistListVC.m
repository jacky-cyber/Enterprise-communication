//
//  JCommunistListVC.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JCommunistListVC.h"
#import "JTitleLabel.h"
#import "JButton.h"
#import "HttpServiceHelper.h"
#import "JFinanicaCell.h"
#import "JDetailForCommunistVC.h"
//#define kQuerycourselist @"querycourselist"
//#define kQuerycoursedetail @"querycoursedetail"

@interface JCommunistListVC (){
    int pageCount;
    int totalPage;
    int currentPage;
    BOOL refreshData;
 
 
}
@property(nonatomic,retain)PullTableView *mainBgView;
@property(nonatomic,retain)NSMutableArray *data;
@end

@implementation JCommunistListVC
@synthesize mainBgView=_mainBgView;
@synthesize data=_data,RequestName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pageCount=10;
        totalPage=0;
        currentPage=1;
        RequestName=@"党务视窗";
        refreshData=NO;
        _data=[[NSMutableArray alloc]initWithCapacity:10];
    }
    return self;
}
-(void)setRequestTag:(int)tag name:(NSString*)name{
    if(!name||![name isEqualToString:@""]){
        RequestName=name;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self loadBackView];
    

}
#pragma mark 通知获取数据
-(void)receivecourseList:(NSNotification*)notification{
    NSLog(@"%@",notification);
}
#pragma mark 加载请求数据
-(int)requestDataForServer:(int)pageNumber{
      // NSString *mainDomain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain] ;
    [[STHUDManager sharedManager]showHUDInViewToMySelf:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQuerycourselist info:@{@"pageNumber":[NSString stringWithFormat:@"%d",pageNumber],@"pageCount":[NSString stringWithFormat:@"%d",pageCount],@"category":RequestName} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
        return 1;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentPage =1;
    [self requestDataForServer:currentPage];
    self.data=nil;
    _data=[[NSMutableArray alloc]initWithCapacity:10];
}
- (void)requestFinished:(NSDictionary *)datas
{
    if(refreshData==YES){
        refreshData=NO;
        self.data=nil;
        _data=[[NSMutableArray alloc]initWithCapacity:10];
    }
    int counts=[[datas objectForKey:@"data"] count];
    for(int i=0;i<counts;i++){
      [self.data addObject:[[datas objectForKey:@"data"] objectAtIndex:i]];
    }
    totalPage=[[datas objectForKey:@"totalPage"]intValue];
    [self.mainBgView reloadData];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void)requestFailed:(id)sender
{
     [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSLog(@"%@",sender);
}

#pragma mark 加载视图
//加载返回按钮
-(void)loadBackView{
    self.mainBgView = [[[PullTableView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height-65)] autorelease];
    self.mainBgView.pullTableIsLoadingMore = NO;
    self.mainBgView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.mainBgView configRefreshType:BothRefresh];
    [self.mainBgView setBackgroundColor:[UIColor whiteColor]];
    self.mainBgView.delegate=self;
    self.mainBgView.dataSource=self;
    self.mainBgView.pullDelegate=self;
    if (IOSVersion>=7) {
        self.mainBgView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    

    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:110];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];

    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:RequestName rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    
    
}
#pragma mark uitableview delegete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(![[self.data objectAtIndex:[indexPath row]] objectForKey:@"courseid"])
        return;
    JDetailForCommunistVC *detail=[[JDetailForCommunistVC alloc]init];
    detail.courseId=[[self.data objectAtIndex:[indexPath row]] objectForKey:@"courseid"];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];

}

//自适应lable
-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.font = [UIFont systemFontOfSize:17.0];
    // label1.textColor = [UIColor redColor];
    [label1 sizeToFit];
    return label1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel* lable = [self fitLable:[self.data[indexPath.row] objectForKey:@"title"] and_x:10 and_y:5 and_width:270];
    return 120+lable.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //定义一个静态标识符
    static NSString *cellIdentifier = @"cell";
    JFinanicaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[JFinanicaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell settitle:[self.data[indexPath.row] objectForKey:@"title"] date: [self.data[indexPath.row] objectForKey:@"date"]  content:[self.data[indexPath.row] objectForKey:@"summary"]];
    return cell;
}
-(NSString*)setTime:(NSString*)time{
    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];

    return [dateformat_02 stringFromDate:[dateformat_01 dateFromString:time]];;
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
    currentPage=1;
    refreshData=YES;
    [self requestDataForServer:currentPage];
    self.mainBgView.pullLastRefreshDate = [NSDate date];
    self.mainBgView.pullTableIsRefreshing = NO;
}
-(void)loadMoreDataToTable{
    currentPage++;
    refreshData=NO;
    if(currentPage<=totalPage)
        [self requestDataForServer:currentPage];
    self.mainBgView.pullTableIsLoadingMore = NO;
}
#pragma mark 触发的事件
- (void)onBtnReturn_Click
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}
-(void)dealloc{
    self.data=nil;
    self.mainBgView=nil;
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

@end
