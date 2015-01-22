//
//  UIViewCtrl_System_Notify.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-4.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "UIViewCtrl_System_Notify.h"
#import "UITableViewCell_02.h"
#import "UITableViewCell_06.h"
#import "AppDelegate.h"
#import "NotificationDetailVC.h"
#import "ISTPullRefreshTableView.h"
#import "NGLABAL_DEFINE.h"
#import "NotificationDataHelper.h"

#import "GTMBase64.h"

#import "NotificationCell.h"
#import "NotificationModel.h"
#import "NotificationFrame.h"
#import "FinanciaCell.h"

@interface UIViewCtrl_System_Notify ()
    @property (nonatomic, retain) PullTableView *tableview_01;
@property (nonatomic,strong) NSMutableArray *allFrameArray;
@end

@implementation UIViewCtrl_System_Notify

@synthesize view_01 = _view_01;
@synthesize arrayData = _arrayData;
@synthesize allFrameArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allFrameArray=[[NSMutableArray alloc] initWithCapacity:100];
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"getAllSysMsg" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"getSysMsgContent" object:nil];

    self.arrayData = [[NSMutableArray alloc] init];
    
//    //发送
//    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
//    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd":@"getAllSysMsg"},@{@"MaxLocalMsgId": @"getAllSysMsg"}];
//    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
//    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    
   
    
    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view_01.layer.frame.size.width, self.view_01.layer.frame.size.height) style:UITableViewStylePlain];
    aTableView.pullTableIsLoadingMore = NO;
    [aTableView configRefreshType:OnlyHeaderRefresh];
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
    aTableView.layer.borderWidth = 1;
    aTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if(iOSVersion>=7){
        aTableView.separatorInset=UIEdgeInsetsMake(0, -10, 0, 0);
    }
    
    [aTableView setBackgroundColor:[UIColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1.0f]];
    self.tableview_01 = aTableView;
    [self.view_01 addSubview:self.tableview_01];

  
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
       [self initData];
}

-(NSString *)getHeadStr
{
    NSString *headStr1;
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr compare:@"111.11.28.29"] == NSOrderedSame) {
        headStr1 = @"http://111.11.28.9:8087/notice/phoneInterface.action?";
    }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){
        headStr1 = @"http://111.11.28.9:8087/noticezq/phoneInterface.action?";
    } else if ([headStr compare:@"111.11.28.1"] == NSOrderedSame){
        headStr1 = @"http://111.11.28.1:8087/notice/phoneInterface.action?";
    } else if ([headStr compare:@"111.11.29.71"] == NSOrderedSame){
        headStr1 = @"http://111.11.29.71:8087/noticezq/phoneInterface.action?";
    }else {
        headStr1 = @"http://111.11.28.30:8087/notice/phoneInterface.action?";
    }
    return headStr1;
}

-(void)initData
{
    NSString *dizhi = [[NSString stringWithFormat:@"%@cmd=querycourselist&pageNumber=%d&pageCount=%d",[self getHeadStr],1,12] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
  
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]intValue]==0)
        {
            //正确数据
            _arrayData = [NSMutableArray arrayWithArray:[dic valueForKey:@"data"]];
//             [self addNotifictionFrame];
            [self.tableview_01 reloadData];
            [[STHUDManager sharedManager] hideHUDInView:self.view];
        }
    }
    else
    {
        NSLog(@"没数据");
    }
     [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma label -
#pragma label UITableViewDataSource Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *CellIdentifier = @"Cell";
    FinanciaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[FinanciaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
   
    NSDictionary *dic=[_arrayData objectAtIndex:indexPath.row];
    NSString * msg_title = [dic objectForKey:@"title"] ;
    NSString* msg_time = [self setTime:[dic objectForKey:@"date"]];
    NSString *msg_depart=[NSString stringWithFormat:@"发布部门:%@" ,dic[@"url"]];
    
    [cell setCellTitle:msg_title andTime:msg_time andDepart:msg_depart];
    return cell;
}
-(NSString*)setTime:(NSString*)time1{
    
    NSString *time =[time1 substringToIndex:time1.length-2];
    NSDateFormatter *dateformat_01 = [[NSDateFormatter alloc] init] ;
    NSDateFormatter *dateformat_02 = [[NSDateFormatter alloc] init] ;
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *timeStr=  [dateformat_02 stringFromDate:[dateformat_01 dateFromString:time]];
    return timeStr;
}

#pragma label -
#pragma label UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NotificationFrame *frame  =  allFrameArray[indexPath.row];
    
     NSString * msg_title = [[self.arrayData objectAtIndex:indexPath.row] objectForKey:@"title"]  ;
    
       UILabel* lable = [self fitLable:msg_title and_x:10 and_y:5 and_width:280];
    return 100+lable.frame.size.height-20;
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayData == nil) {
        return;
    }
    NSDictionary *tmp_dic = [self.arrayData objectAtIndex:indexPath.row];
    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    [wParam setValue:[NSNumber numberWithInteger:COMMAND_INITIALIZE_USER_INFORMATIOIN] forKey:PARAMTER_KEY_COMMAND_ID];
    
    [wParam setValue:[tmp_dic valueForKey:@"msgtitle"] forKey:@"msgtitle"];
    [wParam setValue:[tmp_dic valueForKey:@"msgtime"] forKey:@"msgtime"];
    [wParam setValue:[tmp_dic valueForKey:@"msg"] forKey:@"msg"];
    NotificationDetailVC *notificationVC = [[NotificationDetailVC alloc]initWithNibName:@"NotificationDetailVC" bundle:nil] ;
    [notificationVC performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:wParam waitUntilDone:NO];
   
    [NSThread sleepForTimeInterval:0.1];
    [self.navigationController pushViewController:notificationVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.arrayData == nil) {
        return;
    }
    NSDictionary *tmp_dic = [_arrayData objectAtIndex:indexPath.row];
    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    [wParam setValue:[NSNumber numberWithInteger:COMMAND_INITIALIZE_USER_INFORMATIOIN] forKey:PARAMTER_KEY_COMMAND_ID];
    
    [wParam setValue:[self getHeadStr] forKey:@"url"];
    [wParam setValue:[tmp_dic valueForKey:@"courseid"] forKey:@"courseid"];
    NotificationDetailVC *notificationVC = [[NotificationDetailVC alloc]init];
   [notificationVC performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:wParam waitUntilDone:NO];
    
    [notificationVC addObserver:self forKeyPath:@"a" options:0 context:@"aaa"];
    
    [NSThread sleepForTimeInterval:0.1];
    [self.navigationController pushViewController:notificationVC animated:YES];
    
}




#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
//    self.listArr = [[ChatDataHelper sharedService] readConversationsList];
//    [_listTableView reloadData];
//    [[STHUDManager sharedManager] showHUDInView:self.view];
//    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
//    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd":@"getAllSysMsg"},@{@"MaxLocalMsgId": @"getAllSysMsg"}];
//    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
//    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    
    NSString *dizhi = [[NSString stringWithFormat:@"%@cmd=querycourselist&pageNumber=%d&pageCount=%d",[self getHeadStr],1,12] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]intValue]==0)
        {
            //正确数据
            _arrayData = [NSMutableArray arrayWithArray:[dic valueForKey:@"data"]];
            [self.tableview_01 reloadData];
            [[STHUDManager sharedManager] hideHUDInView:self.view];
        }
    }
    else
    {
        NSLog(@"没数据");
    }

    
    self.tableview_01.pullLastRefreshDate = [NSDate date];
    self.tableview_01.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    //加载代码
    self.tableview_01.pullTableIsLoadingMore = NO;
}

#pragma mark -
#pragma mark PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

//- (void) receiveDataNotification:(NSNotification *) wParam
//{
//    if (self.arrayData == nil) {
//        return;
//    }
//    if ([wParam.name compare:@"getAllSysMsg"] == NSOrderedSame) {
//  
//        NSString *msgIds = [[wParam userInfo] valueForKey:@"SysMsgIds"];
//        if ([[msgIds substringFromIndex:[msgIds length] - 1] compare:@","] == NSOrderedSame) {
//            msgIds = [msgIds substringToIndex:[msgIds length] - 1];
//        }
//        NSLog(@"%@", msgIds);
//        if (msgIds == nil || [msgIds length] < 1) {
//            [self.arrayData removeAllObjects];
//            [self.arrayData addObjectsFromArray:[[NotificationDataHelper sharedService] getAllNotification]];
//            [self addNotifictionFrame];
//            [self.tableview_01 reloadData];
//            [[STHUDManager sharedManager] hideHUDInView:self.view];
//        }else{
//            NSMutableString *query_ids = [[NSMutableString alloc] init];
//            NSArray *arrIds = [msgIds componentsSeparatedByString:@","];
//            for (NSInteger i = 0; i < [arrIds count]; i ++) {
//                if ([[NotificationDataHelper sharedService] notificationExist:[arrIds objectAtIndex:i]] == NO) {
//                    if (query_ids.length > 0) {
//                        [query_ids appendString:@","];
//                    }
//                    [query_ids appendString:[arrIds objectAtIndex:i]];
//                };
//            }
//            if ([query_ids length] > 0) {
//                NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
//                NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd":@"getSysMsgContent"},@{@"msgIDs": query_ids}];
//                NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
//                NSLog(@"%@", xmlStr);
//                [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
//        
//            }else{
//                
//                [self.arrayData removeAllObjects];
//                [self.arrayData addObjectsFromArray:[[NotificationDataHelper sharedService] getAllNotification]];
//                [self addNotifictionFrame];
//                [self.tableview_01 reloadData];
//                [[STHUDManager sharedManager] hideHUDInView:self.view];
//            }
//            
////            [query_ids release];
//        }
//    }
//    
//    
//    if ([wParam.name compare:@"getSysMsgContent"] == NSOrderedSame) {
//        [self.arrayData removeAllObjects];
//        if ([((NSString *)[wParam.userInfo valueForKey:@"err"]) compare:@"0:succeed"] == NSOrderedSame) {
//           id arrNotify = [[wParam.userInfo valueForKey:@"list"] valueForKey:@"sysmsg"];
//            NSMutableArray *returnArr = [NSMutableArray array];
//            
//            if([arrNotify isKindOfClass:[NSArray class]])
//            {
//                returnArr = [NSMutableArray arrayWithArray:arrNotify];
//            }
//            else if([arrNotify isKindOfClass:[NSDictionary class]])
//            {
//                returnArr = [NSMutableArray arrayWithObject:arrNotify];
//            }
//            for (int i = 0; i < [returnArr count]; i ++) {
//                NSDictionary *sysmsg_item = [returnArr objectAtIndex:i];
//
//                NSString * msg_title = [[[NSString alloc] initWithData:[GTMBase64 encodeData:[[sysmsg_item valueForKey:@"msgtitle"] dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding] autorelease];
//                NSString * msg_body = [[[NSString alloc] initWithData:[GTMBase64 encodeData:[[sysmsg_item valueForKey:@"msg"] dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding] autorelease];
//                NSString * msg_intro = [[[NSString alloc] initWithData:[GTMBase64 encodeData:[[sysmsg_item valueForKey:@"msgintro"] dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding] autorelease];
//                
//                NSMutableDictionary *tmp_dic = [[[NSMutableDictionary alloc] init] autorelease];
//                [tmp_dic setValue:[sysmsg_item valueForKey:@"msgid"] forKey:@"msgid"];
//                [tmp_dic setValue:[sysmsg_item valueForKey:@"msgtime"] forKey:@"msgtime"];
//                [tmp_dic setValue:msg_title forKey:@"msgtitle"];
//                [tmp_dic setValue:msg_intro forKey:@"msgintro"];
//                [tmp_dic setValue:msg_body forKey:@"msg"];
//                [tmp_dic setValue:[sysmsg_item valueForKey:@"msgurl"] forKey:@"msgurl"];
//                [[NotificationDataHelper sharedService] appendNotification:tmp_dic];
//                
//            }
//            
//            [self.arrayData addObjectsFromArray:[[NotificationDataHelper sharedService] getAllNotification]];
//            
//            
//        }
//        [self addNotifictionFrame];
//        [self.tableview_01 reloadData];
//        [[STHUDManager sharedManager] hideHUDInView:self.view];
//        
//    }
//    
//}
//
//-(void)addNotifictionFrame{
//    
//    for(NSDictionary *dic in self.arrayData){
//    
//        NotificationFrame *frame=[[NotificationFrame alloc] init];
//        NotificationModel *model=[[NotificationModel alloc] init];
//      
//        [model setModelDic: [ [NSDictionary alloc] initWithObjectsAndKeys:dic[@"title"],@"title",dic[@"msgtime"],@"time", nil]];
//        
//        [frame setModel:model];
//        
//        [allFrameArray addObject:frame];
//    }
//    
//    
//}

@end
