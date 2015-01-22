//
//  companyNewsViewController.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "companyNewsViewController.h"
#import "HttpServiceHelper.h"
#import "companyNewsCell.h"
#import "companyNewsDetailView.h"
#import "ImageDataHelper.h"
#import "UIImage-Extensions.h"
@interface companyNewsViewController ()

@end

@implementation companyNewsViewController
@synthesize fModeArr;
@synthesize currentPage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentPage=1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self requestDataForServer:1];
    fModeArr = [[NSMutableArray alloc]init];
    [self loadlistView];//加载财务管理视图
	
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
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(on_BtnReturn_Colik) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:_backBtn];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(320/2.0-150/2.0,self.iosChangeFloat, 150, 40)];
    _label.text = @"政企新闻";
    _label.font = [UIFont systemFontOfSize:17.0f];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    //创建UITableView
    _listTable= [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320,kScreen_Height-44-self.iosChangeFloat) style:UITableViewStylePlain];
    //    _array= [[UIFont familyNames ]retain];//数据源
    _listTable.dataSource = self;//设置数据源
    _listTable.delegate = self;//设置代理
    _listTable.pullDelegate=self;
    _listTable.backgroundColor = [UIColor whiteColor];
    if (IOSVersion>=7) {
        _listTable.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    
    [baseView addSubview:_listTable];
}//加载财务管理视图


//////////////////////////////////////////////////////////////////////

- (void)requestDataForServer:(int)pageNumber{
    int pageCount=10;
    [[HttpServiceHelper sharedService] requestForType:kQuerynews info:@{@"pageNumber":[NSString stringWithFormat:@"%d",pageNumber],@"pageCount":[NSString stringWithFormat:@"%d",pageCount]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    
    
}// 请求数据
- (void)requestFinished:(NSDictionary *)datas
{
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString * str = [[NSString alloc]init];
    if ([domain isEqualToString:@"111.11.28.30"]) {
        str = domain;
    }else{
        str = @"111.11.28.9";
    }
    NSArray * BigArr = [datas objectForKey:@"data"];
    totalPage=[[datas objectForKey:@"totalPage"]intValue];
    [fModeArr addObjectsFromArray:BigArr];
    for (int i=0; i<[fModeArr count]; i++) {
         NSString * picStr = [NSString stringWithFormat:@"http://%@:8087/newszq/page/titleImg/%@",str,[[fModeArr objectAtIndex:i] objectForKey:@"summary"]];
       UIImage*image= [self loagImageIndex:i];
        [[ImageDataHelper sharedService] storeWithImage:image imageName:picStr];
    }
    [_listTable reloadData];
    
}
-(UIImage*)loagImageIndex:(int)index{
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString * str = [[NSString alloc]init];
    if ([domain isEqualToString:@"111.11.28.30"]) {
        str = domain;
    }else{
        str = @"111.11.28.9";
    }

     NSString * picStr = [NSString stringWithFormat:@"http://%@:8087/newszq/page/titleImg/%@",str,[[fModeArr objectAtIndex:index] objectForKey:@"summary"]];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]];
    UIImage* result = [UIImage imageWithData:data];
    return result;
}
-(NSString*)setTime:(NSString*)time{
    time=[time substringToIndex:16];
    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *timeStr=  [dateformat_02 stringFromDate:[dateformat_01 dateFromString:time]];
    return timeStr;
}
#pragma mark 请求网络失败
- (void)requestFailed:(id)sender
{
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
    //检查是否有闲置单元格
    companyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //创建单元格
    if (cell == nil) {
        cell = [[[companyNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
//    UIImage*image1 = [UIImage imageWithData:data];
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString * str = [[NSString alloc]init];
    if ([domain isEqualToString:@"111.11.28.30"]) {
        str = domain;
    }else{
        str = @"111.11.28.9";
    }
    

    NSString * picStr = [NSString stringWithFormat:@"http://%@:8087/newszq/page/titleImg/%@",str,[[fModeArr objectAtIndex:indexPath.row] objectForKey:@"summary"]];
    NSLog(@"pic%@",picStr);
    NSString* partmentName = [NSString stringWithFormat:@"%@",[[fModeArr objectAtIndex:indexPath.row] objectForKey:@"url"]];
    //UIImage* image = [UIImage imageNamed:picStr];
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:[self setTime:[fModeArr[indexPath.row] objectForKey:@"date"]],@"time",[fModeArr[indexPath.row] objectForKey:@"title"],@"titleStr",picStr,@"image",partmentName,@"partmentLableText", nil];
    UIImage* image = [[ImageDataHelper sharedService] getImageWithName:picStr];
  //image.size = CGSizeMake(imageSize.width, imageSize.height);
    UIImage* image1=[UIImage image:image fitInSize:CGSizeMake(280, (image.size.height/image.size.width)*280)];
    [cell setCellWithDic:dic withIamge:image1];
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
    companyNewsDetailView *cView = [[companyNewsDetailView alloc] initWithcourseid:[fModeArr[indexPath.row] objectForKey:@"courseid"]];
    [self.navigationController pushViewController:cView animated:YES];
}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel* lable = [self fitLable:[fModeArr[indexPath.row] objectForKey:@"title"] and_x:10 and_y:5 and_width:280];
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString * str = [[NSString alloc]init];
    if ([domain isEqualToString:@"111.11.28.30"]) {
        str = domain;
    }else{
        str = @"111.11.28.9";
    }
    

    NSString * picStr = [NSString stringWithFormat:@"http://%@:8087/newszq/page/titleImg/%@",str,[[fModeArr objectAtIndex:indexPath.row] objectForKey:@"summary"]];
    if ([picStr isEqualToString:@"http://111.11.28.30:8087/newszq/page/titleImg/"]||[picStr isEqualToString:@"http://111.11.28.9:8087/newszq/page/titleImg/"]) {
         return 100+lable.frame.size.height+partmentLableHeigh-20;
    }
    else{
        UIImage* image = [[ImageDataHelper sharedService] getImageWithName:picStr];
        //image.size = CGSizeMake(imageSize.width, imageSize.height);
        UIImage* image1=[UIImage image:image fitInSize:CGSizeMake(280, (image.size.height/image.size.width)*280)];
        return 100+lable.frame.size.height+image1.size.height+partmentLableHeigh-20;}
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
    [self requestDataForServer:1];
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
    [_NavigaBG release],_NavigaBG = nil;
    [_backBtn release],_backBtn = nil;
    [_label release],_label = nil;
    [_listTable release],_listTable = nil;
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];

}


@end
