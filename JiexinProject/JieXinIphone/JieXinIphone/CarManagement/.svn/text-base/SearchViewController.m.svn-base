//
//  SearchViewController.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchViewController.h"
#import "Car_helper.h"
#import "Car_customCell.h"
#import "manageModel.h"
#import "CarOrderVC.h"
#import "PullTableView.h"

#define kCapValue  15
#define kSearchCancelBtnTag 100
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate,cellBtnSelectedDelegate>
{
    int nowPage;
}

@property(nonatomic,retain)PullTableView *listView;
@property(nonatomic,retain) UITextField *searchTextFd;
@property(nonatomic,retain) NSMutableArray *searchArray;
@property(nonatomic,copy) NSString *searchName;

@end

@implementation SearchViewController

- (void)dealloc
{
    self.listView = nil;
    self.searchTextFd = nil;
    self.searchArray = nil;
    self.searchName = nil;
    [[Car_helper sharedService] cancelRequestForDelegate:self];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)initDefaultDatas
{
    nowPage = 1;
    self.searchName = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchArray = [NSMutableArray array];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBarWithoutLogo];
    [self initSubViews];//初始化UI
}

- (void)initSubViews {
  
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [backBtn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //添加头部标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.iosChangeFloat, 100, backBtn.height)];
    titleLabel.text = @"搜索";
    titleLabel.textColor = kDarkerGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    
    UIImageView *searchBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchLink_bg.png"]];
    searchBG.userInteractionEnabled = YES;
    [searchBG setFrame:CGRectMake(0, self.iosChangeFloat+44, 320, 50)];
    [self.view  addSubview:searchBG];
    [searchBG release];
    
    

    
    _searchTextFd = [[UITextField alloc ] initWithFrame:CGRectMake(28, self.iosChangeFloat+44, kScreen_Width -55-28, 50)];
    _searchTextFd.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    _searchTextFd.placeholder = @"请输入申请人名";
    _searchTextFd.delegate = self;
//    [_searchTextFd setClearButtonMode:UITextFieldViewModeAlways];
    _searchTextFd.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_searchTextFd];
    
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(kScreen_Width - 25 - 25 ,(kCommonCellHeight-25)/2.0+2, 25, 25)];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.alpha = 0.8;
    [searchBtn setImage:[UIImage imageNamed:@"searchBt.png"] forState:UIControlStateNormal];
    [searchBG addSubview:searchBtn];
    
    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchTextFd.frame), kScreen_Width, kScreen_Height-20-44-50) style:UITableViewStylePlain];
    [aTableView configRefreshType:OnlyFooterRefresh];
    aTableView.pullTableIsLoadingMore = NO;
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
    self.listView = aTableView;
    [aTableView release];
    [self.view addSubview:_listView];
}

#pragma mark - btnsTap
- (void)search:(UIButton *)sender
{
    if ([_searchTextFd.text length]) {
        [_searchTextFd resignFirstResponder];
        nowPage = 1;
        self.searchName = _searchTextFd.text;
        [self requestData];
    }
}
//返回
- (void)backBtn_Click {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 获取数据
- (void) requestData
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    [[Car_helper  sharedService] requestForType:kQueryByNameCarManage info:@{@"nowPage":[NSString stringWithFormat:@"%d",nowPage],@"cap":[NSString stringWithFormat:@"%d",kCapValue],@"name":_searchName} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}
- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
//    [self.searchArray insertObjects:[datas objectForKey:@"list"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_se], NSUInteger len)]]
    self.listView.pullTableIsLoadingMore = NO;
    if (nowPage == 1) {
        [self.searchArray removeAllObjects];
        self.searchArray = [NSMutableArray array];
    }
    for(NSDictionary *dic in [datas objectForKey:@"list"]) {
        [self.searchArray addObject:dic];
    }
    [_listView reloadData];

}

- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    self.listView.pullTableIsLoadingMore = NO;

    if (nowPage > 1) {
        nowPage -= 1;
    }
    NSLog(@"请求车辆预订数据失败:%@",sender);
}


#pragma mark - textField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField==_searchTextFd){
        [_searchTextFd resignFirstResponder];
    }
    return YES;
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//    
//    return YES;
//}
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    
//    return YES;
//}


- (NSMutableArray *)fuzzyMatching:(NSString *)str withArr:(NSMutableArray *)arr{
    
    NSMutableArray *tempArr=[[NSMutableArray alloc] initWithCapacity:100];
    
    for(int i=0;i<[arr count];i++){
        NSString *name=[[arr objectAtIndex:i] objectForKey:@"userName"];
        if([name isEqualToString:str]){
            [tempArr addObject:[arr objectAtIndex:i]];
        }
    }
    return tempArr;
}


#pragma mark - UITableView delegate  
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"cell";
    
    Car_customCell  *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[Car_customCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier] autorelease];
        cell.delegate = self;
        cell.cancelBtn.tag = indexPath.row + kSearchCancelBtnTag;
    }
    [cell setSearchCellDatas:[_searchArray objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *formId = [[_searchArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    int state = [[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"state"] intValue];
    CarOrderVC *carOrder = [[CarOrderVC alloc] initWithFormId:formId andType:Car_custom andConlum:state];
    [self.navigationController pushViewController:carOrder animated:YES];
    [carOrder release];
}


/////////////////////////////////////////////////////////////////////////////
//- (void)requestData {
//      NSInteger nowPage = 1,cap =10;
//    [[Car_helper sharedService] requestForType:kCarManager_search info:@{@"name":@"glh",@"nowPage":[NSString stringWithFormat:@"%d",nowPage],@"cap":[NSString stringWithFormat:@"%d",cap]} target:self successSel:@"requestFinished:" failedSel:@"requsetFalid:"];
//    
//}
////请求完成
//- (void)requestFinished:(NSDictionary *)datas {
//
//    NSArray *listArray = [NSArray arrayWithArray:[datas objectForKey:@"list"]];
//    for (NSDictionary *form in listArray)
//    {
//        [_searchArray addObject:form];
//    }
//    
//    [_listView reloadData];//
//
//    NSLog(@"请求成功");
//}
////请求失败
//- (void)requestFailed:(id)sender {
//   // [SVProgressHUD dismiss];
//    
//    NSLog(@"请求失败");
//}


#pragma mark - cancel delegate
-(void)cancelCellWithConlum:(CarConlumType)type andBtnTag:(int)tag
{
    NSString *formId = [[_searchArray objectAtIndex:tag - kSearchCancelBtnTag] objectForKey:@"id"];
    [self cancelListRequest:formId];
}

- (void)cancelListRequest:(NSString *)formid
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:User_id];
    [[STHUDManager sharedManager] showHUDInView:self.view];
    [[Car_helper sharedService] requestForType:kCarManager_cancel info:@{@"id":formid,@"userId":userId} target:self successSel:@"cancelRequestFinished:" failedSel:@"cancelRequestFailed:"];
}

- (void)cancelRequestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if ([[datas objectForKey:@"resultcode"]isEqualToString:@"92"]) {
        [ShowAlertView showAlertViewStr:@"不能撤销订单"];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"撤销成功"];
    }
    nowPage = 1;
    [self requestData];
}

- (void)cancelRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"撤销失败"];

    NSLog(@"撤销");
}


#pragma mark -
#pragma mark PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
- (void)loadMoreDataToTable
{
    //加载代码
    NSLog(@"加载");
    nowPage += 1;
    [self requestData];
    self.listView.pullLastRefreshDate = [NSDate date];

}

#pragma mark keyborad
-(void)keyboardWillShow:(NSNotification *)notification{
    
//    NSDictionary *dic=[notification valueForKey:@"userInfo"];
//    NSValue * keyboradValue=[dic objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
//    CGRect keyboradRect;
//    [keyboradValue getValue:&keyboradRect];
}

-(void)keyboardWillHidden:(NSNotification *)notification{}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
