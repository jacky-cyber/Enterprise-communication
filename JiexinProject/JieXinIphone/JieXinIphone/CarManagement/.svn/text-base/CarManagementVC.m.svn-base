 //
//  CarManagementVC.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CarManagementVC.h"
#import "CarDetailViewController.h"
#import "CarOrderVC.h"
#import "KxMenu.h"
#import "statisticsVC.h"
#import "Car_helper.h"
#import "SearchViewController.h"
#import "ShowAlertView.h"

#define ConstantValue 111231

@interface CarManagementVC ()
{
    UIView  *_baseView;
    UIButton *_backBtn;
    UIButton *_shenqingBtn;
    UILabel  *_label;
    
    CarConlumType _conlumType;
}

@property (nonatomic, retain) NSString *loginname;
@end

@implementation CarManagementVC
@synthesize sourceArray;
@synthesize listView;

- (void)dealloc
{
    [[Car_helper sharedService] cancelRequestForDelegate:self];
    self.listView = nil;
    self.sourceArray= nil;
    self.loginname = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (iOSVersion < 7.0) {
            self.iosChangeFloat = 0;
        }else{
            self.iosChangeFloat = 20.f;
        }
        
        _conlumType = Car_daishen;
        self.sourceArray = [[[NSMutableArray alloc] init] autorelease];
        [self initalizeSubviews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doRefresh)
                                                     name:KRefreshData
                                                   object:nil];
    }
    return self;
}

- (void)initalizeSubviews
{
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, kScreen_Width, kScreen_Height-20-44)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    [_baseView release];

    
    //返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [_backBtn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [_backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    
    //添加头部标题
    _label = [[UILabel alloc] initWithFrame:CGRectMake(40, self.iosChangeFloat, 100, _backBtn.height)];
    _label.text = @"车辆预订";
    _label.textColor = kDarkerGray;
    _label.font = [UIFont boldSystemFontOfSize:16.0f];
    _label.textAlignment = NSTextAlignmentLeft;
//    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label];
    [_label release];
    
    //申请
    _shenqingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shenqingBtn.frame = CGRectMake(270, self.iosChangeFloat+8, 35, 25);
    [_shenqingBtn setTitle:@"申请" forState:UIControlStateNormal];
    [_shenqingBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
    _shenqingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_shenqingBtn addTarget:self action:@selector(shenqingBtn_Click:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:_shenqingBtn];
    
//    [[STHUDManager sharedManager] showHUDInView:self.view];
}

- (void)loadCustomNavigationBar
{
    NSArray *arr = nil;
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    if ([power isEqualToString:@"0"])
    {
        arr = [NSArray arrayWithObjects:@"待审批",@"已撤销",@"未通过",@"已审批",@"已完成",nil];       
    }
    else
    {
         arr = [NSArray arrayWithObjects:@"待审批",@"未通过",@"已审批",@"已完成",nil];
    }
    float _x = 0.0f;
    for (int index = 0; index<[arr count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0+_x, 0, 317.0/[arr count], 34);
        button.tag = ConstantValue + index;
        [button setTitleColor:kDarkerGray forState:UIControlStateNormal];
        [button setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFont];
        NSString *str = [arr objectAtIndex:index];
        [button setTitle:str forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (index == 0)
        {
            button.selected = YES;
        }
        [_baseView addSubview:button];
        _x+=320.0/[arr count];
    }
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0,34, kScreen_Width,1)];
    line.image = [UIImage imageNamed:@"line.png"];
    [_baseView addSubview:line];
    [line release];
}


- (void)loadlistTableView
{
    if (!self.listView)
    {
        self.listView = [[[PullTableView alloc] initWithFrame:CGRectMake(0, 35, kScreen_Width, CGRectGetHeight(_baseView.frame)-35) style:UITableViewStylePlain] autorelease];
        [listView configRefreshType:OnlyHeaderRefresh];
        listView.delegate = self;
        listView.dataSource = self;
        listView.pullDelegate = self;
        [_baseView addSubview:self.listView];
//        [listView release];
    }
    else
    {
        [self.listView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];

    [self loginCarManager];
}

- (void)resetBtnState
{
    for (id elem in _baseView.subviews)
    {
        if ([elem isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)elem;
            btn.selected = NO;
        }
    }
}

#pragma mark -
#pragma mark 申请按钮方法

//申请页面返回按钮
-(void)shenqingBtn_Click:(UIButton *)sender
{
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    if ([power isEqualToString:@"0"])
    {
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"申请用车"
                         image:nil
                        target:self
                        action:@selector(applyForCar:) index:0],
          
          [KxMenuItem menuItem:@"统计"
                         image:nil
                        target:self
                        action:@selector(statisticsForCar:) index:1],
          
          [KxMenuItem menuItem:@"查找"
                         image:nil
                        target:self
                        action:@selector(searchForCar:) index:2],
          
//          [KxMenuItem menuItem:@"退出"
//                         image:nil
//                        target:self
//                        action:@selector(quitForCar:) index:3]
          ];
        
        
        [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
    }
    else
    {
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"申请用车"
                         image:nil
                        target:self
                        action:@selector(applyForCar:) index:0],
          
//          [KxMenuItem menuItem:@"退出"
//                         image:nil
//                        target:self
//                        action:@selector(quitForCar:) index:1]
          ];
        
        [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
    }
}

- (void)applyForCar:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        CarDetailViewController *carDetailVC = [[CarDetailViewController alloc] init];
//        [self  presentViewController:carDetailVC animated:YES completion:NULL];
        [self.navigationController pushViewController:carDetailVC animated:YES];
        [carDetailVC release];
    }
}

- (void)doRefresh
{
    [self requestData];
}


- (void)quitForCar:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {

    }
}


- (void)searchForCar:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        SearchViewController *searchVC = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
        [searchVC release];
    }
}

- (void)statisticsForCar:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        statisticsVC *statiisVC = [[statisticsVC alloc] init];
        [self.navigationController pushViewController:statiisVC animated:YES];
        [statiisVC release];
    }
}

- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSArray *array = [dateString componentsSeparatedByString:@"."];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
  
    NSDate *destDate= [dateFormatter dateFromString:[array objectAtIndex:0]];
    
    [dateFormatter release];
    
    return destDate;
    
}

#pragma mark -
#pragma mark 按钮触发方法

- (void)buttonPressed:(UIButton *)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower] isEqualToString:@"0"]) {
        _conlumType = sender.tag - ConstantValue;
           }
    else
    {
        switch (sender.tag - ConstantValue) {
            case 0:
            {
                _conlumType = Car_daishen;
            }break;
            case 1:
            {
                _conlumType = Car_weitong;
            }break;
            case 2:
            {
                _conlumType = Car_yishen;
            }break;
            case 3:
            {
                _conlumType = Car_yiwan;
            }break;
                
            default:
                break;
        }

    }
    [self resetBtnState];
    sender.selected = YES;
    [self requestData];
}


- (void)backBtn_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate and Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    Car_customCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Car_customCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.conlumType = _conlumType;
        cell.commitBtn.tag = indexPath.row + ConstantValue;
        cell.cancelBtn.tag = indexPath.row + ConstantValue;
    }
    
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    NSString *useTime = [[sourceArray objectAtIndex:indexPath.row] objectForKey:@"useTime"];
    NSDate *useDate = [self dateFromString:useTime];
    NSTimeInterval time=[useDate timeIntervalSinceDate:[NSDate date]];
    
//    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:User_id];
    
    switch (_conlumType) {
           
        case Car_daishen:
        {
            if ([power isEqualToString:@"0"])
            {
//                if ([userid isEqualToString:@"10012"]) {
//                    [cell.commitBtn setTitle:@"申请中" forState:UIControlStateNormal];
//                    [cell setCommitBtnState:NO andCancelBtn:YES];
//                    [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
//                    
//                    cell.commitBtn.enabled = NO;
//                }
                
                    [cell.commitBtn setTitle:@"申请中" forState:UIControlStateNormal];
                    [cell setCommitBtnState:NO andCancelBtn:YES];
                    [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
                    
                    cell.commitBtn.enabled = NO;


            }
            else if ([power isEqualToString:@"1"]) {
                [cell.commitBtn setTitle:@"申请中" forState:UIControlStateNormal];
                
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
                
                if (time < 4*60*60)
                {
                    [cell setCommitBtnState:NO andCancelBtn:NO];
                }

                cell.commitBtn.enabled = NO;
            }
            else
            {
                [cell.commitBtn setTitle:@"审批" forState:UIControlStateNormal];
                [cell setCommitBtnState:YES andCancelBtn:NO];
                [cell.commitBtn setFrame:CGRectMake(240, 20, 60, 30)];
                
            }
        }
            break;
            
        case Car_yiche:
        {
            [cell setCommitBtnState:NO andCancelBtn:NO];
        }
            break;
            
        case Car_weitong:
        {
            
            [cell setCommitBtnState:NO andCancelBtn:YES];
            [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
        }
            break;
            
        case Car_yishen:
        {
            if ([power isEqualToString:@"0"])
            {
                [cell.commitBtn setTitle:@"分派" forState:UIControlStateNormal];
                cell.commitBtn.enabled = YES;
                [cell setCommitBtnState:YES andCancelBtn:YES];
                [cell.commitBtn setFrame:CGRectMake(240, 2.5, 60, 30)];
                [cell.cancelBtn setFrame:CGRectMake(240, 37.5, 60, 30)];

                
            }
            else if ([power isEqualToString:@"1"]) {
                
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
                
                if (time < 4*60*60)
                {
                     [cell setCommitBtnState:NO andCancelBtn:NO];
                }
            }
            else  {
                
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
                
                if (time < 4*60*60)
                {
                    [cell setCommitBtnState:NO andCancelBtn:NO];
                }
            }

        }
            break;
            
        case Car_yiwan:
        {
            if ([power isEqualToString:@"0"])
            {
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
                
            }
            else if ([power isEqualToString:@"1"]) {
                
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
            }
            else  {
                
                [cell setCommitBtnState:NO andCancelBtn:YES];
                [cell.cancelBtn setFrame:CGRectMake(240, 20, 60, 30)];
            }

        }
            break;
            
        default:
            break;
    }
    
    cell.listName.text = [[sourceArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.userName.text = [[sourceArray objectAtIndex:indexPath.row] objectForKey:@"userName"];
    cell.useTime.text = [[sourceArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    return cell;
}

//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *formId = [[self.sourceArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    CarOrderVC *carOrder = [[CarOrderVC alloc] initWithFormId:formId andType:Car_custom andConlum:_conlumType];
    [self.navigationController pushViewController:carOrder animated:YES];
    [carOrder release];
    
}

#pragma mark -
#pragma mark 登录车辆预订

- (void)loginCarManager
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:User_Name];
    if(userName==nil){return;}
    [[Car_helper sharedService] requestForType:kCarManager_Login info:@{@"userName":userName} target:self successSel:@"loginRequestFinished:" failedSel:@"loginRequestFailed:"];
}

- (void)loginRequestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSString *jurisdiction = [datas objectForKey:@"jurisdiction"];
    NSString *userid = [datas objectForKey:@"userId"];
    self.loginname = [datas objectForKey:@"loginname"];
    [[NSUserDefaults standardUserDefaults] setObject:jurisdiction forKey:User_CarPower];
    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:User_id];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (userid.length == 0 || userid == nil) {
          _shenqingBtn.enabled = NO;
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return;
            }
   
    [self  loadCustomNavigationBar];
    [self requestData];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSLog(@"登录车辆预订失败:%@",sender);
}

#pragma mark -
#pragma mark 获取数据

- (void) requestData
{
    NSString *state = [NSString stringWithFormat:@"%d",_conlumType];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:User_id];
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    int nowPage = 1,cap =10;
    if([userId isEqualToString:@""]){
      
        return;
    }
//    [[STHUDManager sharedManager] showHUDInView:self.view];
    [[Car_helper  sharedService] requestForType:kQuerycourseCarManager info:@{@"userId":userId,@"nowPage":[NSString stringWithFormat:@"%d",nowPage],@"cap":[NSString stringWithFormat:@"%d",cap],@"power":power,@"state":state} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}

- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [self.sourceArray removeAllObjects];
    
    NSArray *listArray = [NSArray arrayWithArray:[datas objectForKey:@"list"]];

//    if ([listArray count] == 0) {
//        return;
//    }
    
    for (NSDictionary *form in listArray)
    {
        [self.sourceArray addObject:form];
    }
    
    [self loadlistTableView];
}

- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSLog(@"请求车辆预订数据失败:%@",sender);
}

#pragma mark -
#pragma mark 撤销订单

- (void)cancelListRequest:(NSString *)formid
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:User_id];
    
//    [[STHUDManager sharedManager] showHUDInView:self.view];
    [[Car_helper sharedService] requestForType:kCarManager_cancel info:@{@"id":formid,@"userId":userId} target:self successSel:@"cancelRequestFinished:" failedSel:@"cancelRequestFailed:"];
}

- (void)cancelRequestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if ([[datas objectForKey:@"resultcode"]isEqualToString:@"92"]) {
        [ShowAlertView showAlertViewStr:@"不能撤销订单"];
    }
    else if ([[datas objectForKey:@"resultcode"] isEqualToString:@"93"]){
        [ShowAlertView showAlertViewStr:@"当前数据已过期！"];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"撤销成功"];
    }
    [self requestData];
}

- (void)cancelRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"撤销失败"];

    NSLog(@"撤销失败");
}

#pragma mark -
#pragma mark cellDelegate methods

-(void)commitCellWithConlum:(CarConlumType)type andBtnTag:(int)tag
{
    NSString *formId = [[self.sourceArray objectAtIndex:tag-ConstantValue] objectForKey:@"id"];
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    if ([power isEqualToString:@"0"])
    {
        CarOrderVC *carOrder = [[CarOrderVC alloc] initWithFormId:formId andType:Car_commitByAdmin andConlum:_conlumType];
        [self.navigationController pushViewController:carOrder animated:YES];
        [carOrder release];
    }
    else
    {
        CarOrderVC *carOrder = [[CarOrderVC alloc] initWithFormId:formId andType:Car_commitByLeader andConlum:_conlumType];
        [self.navigationController pushViewController:carOrder animated:NO];
        [carOrder release];
    }
}

-(void)cancelCellWithConlum:(CarConlumType)type andBtnTag:(int)tag
{
    NSString *formId = [[self.sourceArray objectAtIndex:tag - ConstantValue] objectForKey:@"id"];
    [self cancelListRequest:formId];
}

#pragma mark - Refresh and load more methods
- (void) refreshTable
{
    //添加刷新代码
    [self requestData];
    self.listView.pullLastRefreshDate = [NSDate date];
    self.listView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    //添加加载代码
    NSLog(@"加载");
    self.listView.pullTableIsLoadingMore = NO;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated {

}

@end
