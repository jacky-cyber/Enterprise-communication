//
//  statisticsVC.m
//  JieXinIphone
//
//  Created by apple on 14-4-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "statisticsVC.h"
#import "ISTStaticDef.h"
#import "statisticalCell.h"
#import "Car_helper.h"
#import "SVProgressHUD.h"


//导航高度
#define kNavigation_height  44
//搜索框背景高度
#define kBG_height  90
#define kleftMargin 15
#define ktextWidth  250
#define kTag 1000
#define pageCap 10

@interface statisticsVC ()
{

    UITextField *startTim;
    UITextField *endtTim;
    NSString *company;//车辆公司
    BOOL isStartTime;
    NSInteger  nstag ;
    
    NSInteger currentPage;

}

@property(nonatomic,strong) UIButton *back_Btn;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *bg;//搜索框背景
@property(nonatomic,strong) UITextField *selectTime;//选择时间
@property(nonatomic,strong) UIButton *searchBtn;//搜索框
@property(nonatomic,strong) PullTableView *listTabelView;//搜索按钮
@property(nonatomic,strong) NSMutableArray *sourceArray;//装统计数据
@property(nonatomic,strong) UITextField *startTim;//开始时间
@property(nonatomic,strong) UITextField *endtTim;//


@end

@implementation statisticsVC
@synthesize companyDic,endtTim,startTim;
@synthesize listTabelView;
@synthesize sourceArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isStartTime = YES;
//        companyDic = [[NSMutableDictionary alloc]init];
        currentPage = 1;
        self.sourceArray = [[[NSMutableArray alloc] init] autorelease];
    
    }
    return self;
}

- (void)loadView {
    
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [baseView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:baseView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createCustomNavBarWithoutLogo];//导航

    
    //返回按钮
    _back_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _back_Btn.frame = CGRectMake(0,self.iosChangeFloat, 60, 44);
    [_back_Btn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [_back_Btn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:_back_Btn];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,self.iosChangeFloat+10, 150, 24)];
    _titleLabel.text = @"统计";
    _titleLabel.textColor = [UIColor colorWithRed:35.0/255.0 green:24.0/255.0 blue:20.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_titleLabel];
  
    
    //背景
    _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"] ];
    [_bg setFrame:CGRectMake(0, self.iosChangeFloat+ kNavigation_height, 320, kBG_height)];
    [self.view addSubview:_bg];
    
   
    for (int i =0;  i<2; i++) {
        UIImageView *images =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchLink_bg.png"]];
        [images setFrame:CGRectMake(5, self.iosChangeFloat+44+5+40*i, 265, 40)];
        [self.view addSubview:images];
        
    }
    
    //选择时间
    NSArray *timeName = [NSArray arrayWithObjects:@"起始时间",@"结束时间", nil];
    startTim = [[UITextField alloc] initWithFrame:CGRectMake(kleftMargin,_back_Btn.bottom, ktextWidth, 50)];
    startTim.placeholder = timeName[0];
    startTim.text = @"";
    [startTim setFont:[UIFont systemFontOfSize:12.0]];
    startTim.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [startTim setTextAlignment:NSTextAlignmentCenter];
    startTim.delegate = self;
    startTim.tag = 100;
    [self.view addSubview:startTim];
   
    endtTim = [[UITextField alloc] initWithFrame:CGRectMake(kleftMargin, _back_Btn.bottom+42, ktextWidth, 50)];
    endtTim.placeholder = timeName[1];
    endtTim.text = @"";
    [endtTim setFont:[UIFont systemFontOfSize:12.0]];
    [endtTim setTextAlignment:NSTextAlignmentCenter];
    endtTim.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    endtTim.delegate = self;
    endtTim.tag = 101;
    [self.view addSubview:endtTim];

    //点击搜索按钮
    _searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_searchBtn setFrame:CGRectMake(270, self.iosChangeFloat+kNavigation_height+14, 30, 30)];
    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"searchLink.png"] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchBtn];
    
    //初始化表视图
    self.listTabelView = [[[PullTableView alloc] initWithFrame:CGRectMake(0, _bg.bottom, kScreen_Width, kScreen_Height-20-kNavHeight-_bg.frame.size.height) style:UITableViewStylePlain] autorelease];
    listTabelView.rowHeight = 50;
    listTabelView.dataSource = self;
    listTabelView.delegate   = self;
    listTabelView.pullDelegate = self;
    [listTabelView configRefreshType:OnlyFooterRefresh];
    // 设置表视图的分割线的风格
    listTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 设置表视图的头部视图(headView 添加子视图)
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    //    headerView.backgroundColor = [UIColor redColor];
    // 添加子视图
    UILabel *headText = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 30)];
    headText.text = @"提供车辆的公司";
    [headText setTextColor:[UIColor grayColor]];
    headText.numberOfLines = 0;
    [headerView addSubview:headText];
    [headText release];
    
    for (int i = 0; i<2; i++) {
        //横分割线
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        [line setFrame:CGRectMake(0, 0+i*49, 320, 1)];
        [headerView addSubview:line];
        [line release];
    }
    
    
    //纵分割线
    UIImageView *line1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    [line1 setFrame:CGRectMake(230, 0, 1, 50)];
    [headerView addSubview:line1];
    [line1 release];
    
    
    //用车次数
    UILabel *textCount = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 50, 30)];
    [textCount setText:@"次数"];
    [textCount setTextAlignment:NSTextAlignmentLeft];
    listTabelView.tableHeaderView = headerView;
    [headerView release];
    [headerView addSubview:textCount];
    [self.view addSubview:listTabelView];
    [textCount release];
    
    [self requestCarData];//请求数据
    
    
}

//开始编辑时取消键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
   
//    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
//    datePicker.backgroundColor = [UIColor whiteColor];
//    // 设置时区
//    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    // 设置当前显示时间
//    [datePicker setDate:[NSDate date] animated:YES];
//    // 设置显示最大时间（此处为当前时间）
////    [datePicker setMaximumDate:[NSDate date]];
//    // 设置UIDatePicker的显示模式
//    [datePicker setDatePickerMode:UIDatePickerModeDate];
//    // 当值发生改变的时候调用的方法
//    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:datePicker];
//    [datePicker release];
    
    nstag = textField.tag;
    JDatePickerView *datePickers = [[JDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    datePickers.delegate = self;
    [self.view addSubview:datePickers];
    [datePickers release];

    return NO;
}

//- (void)datePickerValueChanged:(id)sender
//{
//    NSLog(@"ads");
//}

//UIDataPocker 方法
//- (void)datePicker:(JDatePickerView *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)componen {
//    NSString *CurrentDate = [picker getDate];
//    if (nstag == 100) {
//        [startTim setText:CurrentDate];
//    
//    } else if (nstag == 101){
//        
//        [endtTim setText:CurrentDate];
//    }
//
//}

- (void)selectDateFinish:(NSString *)dateStr
{
    if (nstag == 100) {
        [startTim setText:dateStr];
        
    } else if (nstag == 101){
        
        [endtTim setText:dateStr];
    }
}
//////////////////////////////////////////////////////////////////////////////

- (void)requestMoreCar
{
    NSInteger cap = pageCap;
    
    [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"startTime":startTim.text,@"endTime":endtTim.text,@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestMoreFinished:" failedSel:@"requestMoreFailed:"];
    
//    if(startTim.text.length == 0||endtTim.text.length == 0 ){
//        //默认申请全部数据
//        [SVProgressHUD show];
//        [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestMoreFinished:" failedSel:@"requestMoreFailed:"];
//    }
//    else{
//        //搜索时间段内的数据
//        [SVProgressHUD show];
//        [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"startTime":startTim.text,@"endTime":endtTim.text,@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestMoreFinished:" failedSel:@"requestMoreFailed:"];
//    }
}

//请求完成
- (void)requestMoreFinished:(NSDictionary *)datas {
    [SVProgressHUD dismiss];
    //    [companyDic setValuesForKeysWithDictionary:datas];
    [sourceArray addObjectsFromArray:[datas objectForKey:@"list"]];
    
    if ([sourceArray count] < pageCap * currentPage) {
        [listTabelView configRefreshType:NoRefresh];
    }
    
    [listTabelView reloadData];
    NSLog(@"请求成功");
}
//请求失败
- (void)requestMoreFailed:(id)sender {
    [SVProgressHUD dismiss];
    
    NSLog(@"请求失败");
}


//请求数据
- (void)requestCarData {
    currentPage = 1;
    NSInteger cap =pageCap;
    
    if (startTim.text.length == 0 || endtTim.text.length == 0) {
        
        if (startTim.text.length == 0 && endtTim.text.length == 0) {
            
            [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"startTime":startTim.text,@"endTime":endtTim.text,@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
        }
        else
        {
            [ShowAlertView showAlertViewStr:@"请输入查询条件"];
        }
    }
    else
    {
        [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"startTime":startTim.text,@"endTime":endtTim.text,@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    }
//    if(startTim.text.length == 0 && endtTim.text.length == 0 ){
//        //默认申请全部数据
//        [SVProgressHUD show];
//        [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
//    }
//    else{
//        //搜索时间段内的数据
//        [SVProgressHUD show];
//    [[Car_helper sharedService] requestForType:kCarManager_statistical info:@{@"startTime":startTim.text,@"endTime":endtTim.text,@"nowPage":[NSString stringWithFormat:@"%d",currentPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
//    }
}
//请求完成
- (void)requestFinished:(NSDictionary *)datas {
    [SVProgressHUD dismiss];
//    [companyDic setValuesForKeysWithDictionary:datas];
    
    [sourceArray removeAllObjects];
    [sourceArray addObjectsFromArray:[datas objectForKey:@"list"]];
    
    if ([sourceArray count] < pageCap * currentPage) {
        [listTabelView configRefreshType:NoRefresh];
    }
    
    [listTabelView reloadData];
    NSLog(@"请求成功");
}
//请求失败
- (void)requestFailed:(id)sender {
    [SVProgressHUD dismiss];
    
    NSLog(@"请求失败");
}

#pragma mark -
#pragma mark Refresh and load more Methods

- (void)refreshTable
{
    //刷新代码
    NSLog(@"刷新");
    self.listTabelView.pullLastRefreshDate = [NSDate date];
    self.listTabelView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    //加载代码
    currentPage ++;
    [self requestMoreCar];
    
    NSLog(@"加载");
    self.listTabelView.pullTableIsLoadingMore = NO;
}

#pragma mark -
#pragma mark PullTableViewDelegate Methods

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [sourceArray count];
} // section 中包含row的数量

// indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    statisticalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[statisticalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

    NSDictionary *dic = [sourceArray objectAtIndex:indexPath.row];

    if ([dic objectForKey:@"carcompany"]) {
        cell.comLabel.text =[dic objectForKey:@"carcompany"];
    }
    else
    {
        cell.comLabel.text =@"未安排车辆的申请";
    }
    
    cell.countLabel.text = [[dic objectForKey:@"amount"] stringValue];

    
    return cell;
    
} // 创建单元格

#pragma - Private Action  - 选择时间
- (void)selectorTime:(UIButton *) sender {
    
}
//统计
- (void)searchAction:(UIButton *) button {
    [self requestCarData];
    
}

//返回
- (void)backBtn_Click {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
