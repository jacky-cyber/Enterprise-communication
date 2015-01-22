//
//  CarDetailViewController.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CarDetailViewController.h"
#import "CarOrderVC.h"
#import "HttpServiceHelper.h"
#import "shenqingModel.h"
#import "Car_helper.h"
#import "JDatePickerView.h"
#import "KxMenu.h"
#import "CarManagementVC.h"
#import "SystemContactVC.h"
#define  ConstantValue  56789

@implementation CarDetailViewController
{
    NSString *_department;//部门
    NSString *_userName;//申请人
    NSString *_carUser;//用车人
    NSString *_userTel;//电话
    int _peopleNum;//人数
    NSString *_carType;//用车类型
    NSString *_useTime;//用车时间
    NSString *_drivePlace;//提车时间
    NSString *_returnTime;//还车时间
    NSString *_returnPlace;//还车地点
    NSString *_reason;// 事由
    NSString *_require;// 用车要求
    NSString *_leader;//领导
    int textFieldUpTag;
    
    BOOL isChangeFrame;
    BOOL isStartTimeToYes;
    UIScrollView *scrollow;
}
@synthesize m_datas;
@synthesize pickerArray;
@synthesize depArray;
@synthesize userArray;
@synthesize currentDepId;

- (void)dealloc
{
    RELEASE_SAFELY(_department);
    RELEASE_SAFELY(_userName);
    RELEASE_SAFELY(_carUser);
    RELEASE_SAFELY(_userTel);
    RELEASE_SAFELY(_carType);
    RELEASE_SAFELY(_useTime);
    RELEASE_SAFELY(_drivePlace);
    RELEASE_SAFELY(_returnTime);
    RELEASE_SAFELY(_returnPlace);
    RELEASE_SAFELY(_reason);
    RELEASE_SAFELY(_require);
    RELEASE_SAFELY(_leader);

    [[Car_helper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isStartTimeToYes=YES;
        isChangeFrame = NO;
        textFieldUpTag=-1;
        //帕萨特-4人，别克商务-6人，丰田商务-16人，考斯特-22人，金龙客车-50人，奥迪A6-4人，奔驰-4人
        self.pickerArray = [NSArray arrayWithObjects:@"帕萨特-4人",@"别克商务-6人",@"丰田商务-16人",@"考斯特-22人",@"金龙客车-50人",@"奥迪A6-4人",@"奔驰-4人", nil];
        self.userArray = [[NSMutableArray alloc] init];
    }
    return self;
}


//laber自动折行设置
-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.font = [UIFont systemFontOfSize:13.0];
    label1.textColor = [UIColor redColor];
    [label1 sizeToFit];
    return [label1 autorelease];
}

- (void)loadView
{
    [super loadView];
    //加载基视图
    baseView = [[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, 320, kDeviceHeight - 44)];
    baseView.backgroundColor = [UIColor whiteColor];
    //给基视图添加单击事件
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeKeyboard)];
//    [baseView addGestureRecognizer:tap];
    [self.view addSubview:baseView];
    [super createCustomNavBarWithoutLogo];
    
    [self loadlistView];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self loadPersonData];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadPersonData];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - Private Method
- (void)loadlistView
{
    //返回按钮
    _back_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _back_Btn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [_back_Btn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [_back_Btn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:_back_Btn];
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_back_Btn.right -5,self.iosChangeFloat, 150, 40)];
    _titleLabel.text = @"车辆预订表单";
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_titleLabel];
    [_titleLabel release];




    //提交
    conmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    conmitBtn.frame = CGRectMake(_titleLabel.right+60, self.iosChangeFloat, 44, 44);
    [conmitBtn setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:146.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [conmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [conmitBtn addTarget:self action:@selector(commitOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:conmitBtn];
    
    //注
    scrollow = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kDeviceHeight)];
    scrollow.contentSize = CGSizeMake(320, kDeviceHeight*2+160);
    [self.view addSubview:scrollow];
  
     NSString *str = @"注：用车时间必须在申请时间后16小时到72小时内,用车前4小时可取消申请";
  
    _heardLabel = [[UILabel alloc] init];
    _heardLabel = [self fitLable:str and_x:10 and_y:5 and_width:300];
    
    [scrollow addSubview:_heardLabel];
    
    
    //***************************************************************************
    //创建车辆申请表单
    
    NSArray *laberArr = [NSArray arrayWithObjects:@"用车部门",@"申请人",@"用车人",@"用车人联系方式",@"用车人数",@"用车类型",@"用车时间",@"出发地",@"还车时间",@"目的地",@"用车事由",@"用车要求",@"审批领导", nil];
 //   NSArray *textFiledArr = [NSArray arrayWithObjects:@"产品事业部",@"黄亮亮",@"",@"",@"商务车",@"",@"",@"",@"",@"",@"",@"2", nil];
    
    int _y = 40;
//    for (int j=0; j<1; j++) {
    
    for(int index = 0; index <[laberArr count]; index++ ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 200, 35)];
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment= NSTextAlignmentLeft;
        label.text = [laberArr objectAtIndex:index];
        [scrollow addSubview:label];
        
        NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
        
        if (index == [laberArr count] - 1)
        {
            
            if ([power isEqualToString:@"2"]) {
                label.hidden = YES;
            }
        }
        
        UITextField *temptextField = [[UITextField alloc] initWithFrame:CGRectMake(10, _y+35, 300, 40)];
        
        if (index == 1) {
            temptextField.enabled = NO;
        }

        if (index == 3) {
            temptextField.keyboardType = UIKeyboardTypeNumberPad;
            temptextField.frame = CGRectMake(10, _y+35, 250, 40);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"txl(1).png"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(270, _y+40, 30, 30);
            [btn addTarget:self action:@selector(getInfo:) forControlEvents:UIControlEventTouchUpInside];
            [scrollow addSubview:btn];
        }
        
        if (index == 4)
        {
            temptextField.keyboardType = UIKeyboardTypeNumberPad;
        }
       
        
       // temptextField.text = [textFiledArr objectAtIndex:index];
        [temptextField.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];//设置边框
        temptextField.layer.cornerRadius = 5.0f;
        [temptextField.layer setBorderWidth:1.0f];
        temptextField.delegate=self;
        temptextField.borderStyle = UITextBorderStyleLine;
        temptextField.font = [UIFont systemFontOfSize:15.0f];
        temptextField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        temptextField.tag = index + ConstantValue;
        [scrollow addSubview:temptextField];
        [temptextField release];
        
        if (index == [laberArr count] - 1)
        {            
            NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
            if ([power isEqualToString:@"2"]) {
                temptextField.enabled = NO;
                temptextField.hidden = YES;
            }
        }

        if (kDeviceHeight > 480)
        {
            _y+=80;
        }else
        {
           _y+=75;
        }
        
      }
    
//    [scrollow setContentSize:CGSizeMake(kScreen_Width, _y + 130)];

//    }
//    if (kDeviceHeight > 480) {
//        _y=90;
//    }else{
//        _y=27;
//    }

}

-(void)loadPersonData{
    [[Car_helper sharedService] requestForType:kQuerycoursecarsqLoad info:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:User_id]} target:self successSel:@"requestLoadFinished:" failedSel:@"requestLoadFailed:"];

}

- (void)getInfo:(UIButton *)sender
{
    if ([self.userArray count] == 0) {
        [ShowAlertView showAlertViewStr:@"无联系人信息"];
        return;
    }
    SystemContactVC *scvc = [[SystemContactVC alloc] initWithData:self.userArray andType:Car_mobileType];
    scvc.selectDelegate = self;
    [self.navigationController pushViewController:scvc animated:YES];
    [scvc release];
}

//- (void)selectContact:(NSString *)phonenumbers
//{
//    UITextField *textField = (UITextField *) [self.view viewWithTag:3+ConstantValue];
//    textField.text = phonenumbers;
//}

- (void)requestData
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSString *cartype=nil;
     //帕萨特-4人，别克商务-6人，丰田商务-16人，考斯特-22人，金龙客车-50人，奥迪A6-4人，奔驰-4人
    if([_carType isEqualToString:@"帕萨特-4人"])
    {
        cartype=@"0";
    }
    else if([_carType isEqualToString:@"别克商务-6人"])
    {
        cartype=@"1";
    }
    else if([_carType isEqualToString:@"丰田商务-16人"])
    {
        cartype=@"2";
    }
    else if([_carType isEqualToString:@"考斯特-22人"])
    {
        cartype=@"3";
    }
    else if([_carType isEqualToString:@"金龙客车-50人"])
    {
        cartype=@"4";
    }
    else if([_carType isEqualToString:@"奥迪A6-4人"])
    {
        cartype=@"5";
    }
    else if([_carType isEqualToString:@"奔驰-4人"])
    {
        cartype=@"6";
    }
    
    if(_userTel == nil){
        _reason=@"";
    }
    else if (_peopleNum == 0) {
      _peopleNum = 0;
    }
    else if (_carType == nil) {
        _carType = @"";
    }else if (_useTime == nil) {
        _useTime = @"";
    }
    else if (_useTime == nil) {
        _useTime = @"";
    }
    else if (_drivePlace == nil) {
        _drivePlace = @"";
    }
    else if (_returnTime == nil) {
        _returnTime = @"";
    }else if (_returnPlace == nil) {
        _returnPlace = @"";
    }else if (_reason == nil) {
        _reason = @"";
    }else  if (_require == nil) {
        _require = @"";
    }
    NSString *powStr=[[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    
    if([powStr isEqualToString:@"0"]||[powStr isEqualToString:@"2"]){
        powStr=@"3";
    }else{
        powStr=@"0";
    }
    //查找到领导的id
    NSArray *idArr=[self.m_datas objectForKey:@"leader"];
    NSString *leaderId=@"";
    for(NSDictionary *dic in idArr){
        if([[dic objectForKey:@"leaderName"] isEqualToString:_leader]){
            leaderId=[dic objectForKey:@"leaderId"];
        }
    }
    
    if ([powStr isEqualToString:@"2"]) {
        leaderId = [[NSUserDefaults standardUserDefaults] objectForKey:User_id];
    }
 
    NSDictionary *infoDic = @{
                              @"userId":[[NSUserDefaults standardUserDefaults] objectForKey:User_id],
                              @"department":_department,
                              @"carusername":_carUser,
                              @"departmentId":[self.m_datas objectForKey:@"departmentId"],
                              @"userName":[self.m_datas objectForKey:@"userName"],
                              @"userTel":_userTel,
                              @"peopleNum":[NSString stringWithFormat:@"%d",_peopleNum],
                              @"carType":cartype,
                              @"useTime":_useTime,
                              @"drivePlace":_drivePlace,
                              @"returnTime":_returnTime,
                              @"returnPlace":_returnPlace,
                              @"reason":_reason,
                              @"require":_require,
                              @"leader":_leader,
                              @"leaderId":leaderId,
                              @"handState":powStr,
                              @"comname":[self.m_datas objectForKey:@"comname"]
                              };
    
    [[Car_helper sharedService] requestForType:kQuerycoursecarsq info:infoDic target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}

//请求完成
-(void)requestLoadFinished:(NSDictionary*)datas{
    self.m_datas = datas;
    self.currentDepId = [datas objectForKey:@"departmentId"];
    [self getCarUser];
    if([[datas objectForKey:@"resultcode"] isEqualToString:@"95"]){
        [ShowAlertView showAlertViewStr:@"周六日及节假日，订车人不能填写申请单" andDlegate:self];
        }
    else
    {
     [self setTextFiledConnect];
    }
    
    [[Car_helper sharedService] requestForType:kQuerycoursecarsqDep info:nil target:self successSel:@"requestDepFinished:" failedSel:@"requestDepFailed:"];
}

//请求失败
-(void)requestLoadFailed:(id)sender{
    NSLog(@"error");
}

-(void)requestDepFinished:(NSDictionary*)datas
{
    if([[datas objectForKey:@"resultcode"] isEqualToString:@"0"]){
        self.depArray = [[NSArray alloc] initWithArray:[datas objectForKey:@"list"]];
    }
}

//请求失败
-(void)requestDepFailed:(id)sender{
    NSLog(@"error");
}

- (void)getCarUser
{
    NSDictionary *infoDic = @{@"name":User_NickName,@"depid":self.currentDepId};
    [[STHUDManager sharedManager] showHUDInView:self.view];
    [[Car_helper sharedService] requestForType:kQuerycoursecarsqUser info:infoDic target:self successSel:@"requestUserFinished:" failedSel:@"requestUserFailed:"];
}

-(void)requestUserFinished:(NSDictionary*)datas{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if([[datas objectForKey:@"resultcode"] isEqualToString:@"0"])
    {
        [self.userArray removeAllObjects];
        [self.userArray addObjectsFromArray:[datas objectForKey:@"list"]];
    }
}

//请求失败
-(void)requestUserFailed:(id)sender{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSLog(@"error");
}

//请求完成
- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    if ([[datas objectForKey:@"resultcode"] isEqualToString:@"0"])
    {
        [ShowAlertView showAlertViewStr:@"提交成功" andDlegate:self];
    }
    else if([[datas objectForKey:@"resultcode"] isEqualToString:@"91"]){
        [ShowAlertView showAlertViewStr:@"用车时间必须在当前16小时之后且在72小时之内！"];
    } else if([[datas objectForKey:@"resultcode"] isEqualToString:@"1"]){
        [ShowAlertView showAlertViewStr:@"服务器异常！"];
    }
    else {
      [ShowAlertView showAlertViewStr:@"提交失败"];
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [[NSNotificationCenter defaultCenter] postNotificationName:KRefreshData object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//请求失败
- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"提交失败"];

    NSLog(@"请求数据失败：%@",sender);
}


#pragma mark -- Bitton Custom Aciton
#pragma mark -- 返回方法
- (void)backBtn_Click
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 提交订单
- (void)commitOrderAction
{
    [self loadCommitOrderData];
    if ([self canCommitList])
    {
        [self requestData];
    }
    
}
-(void)loadCommitOrderData{
    //原因你后面都是使用了_department等属性，所以必须先给它们进行赋值;

    for (int index = 0; index<13; ++index)
    {
        UITextField *textField = (UITextField *) [self.view viewWithTag:index+ConstantValue];
        switch (index)
        {
            case 0:
            {
                _department = textField.text;
                [_department retain];
            }break;
            case 1:
            {
                _userName = textField.text;
                [_userName retain];
            }break;
            case 2:
            {
                _carUser = textField.text;
                [_carUser retain];
            }break;
            case 3:
            {
                _userTel = textField.text;
                [_userTel retain];
            }break;
            case 4:
            {
              _peopleNum = [textField.text intValue];

            }break;
            case 5:
            {
                _carType = textField.text;
                [_carType retain];
            }break;
            case 6:
            {
                _useTime = textField.text;
                [_useTime retain];
            }break;
            case 7:
            {
                _drivePlace = textField.text;
                [_drivePlace retain];
            }break;
            case 8:
            {
                _returnTime = textField.text;
                [_returnTime retain];
            }break;
            case 9:
            {
                _returnPlace = textField.text;
                [_returnPlace retain];
            }break;
            case 10:
            {
                _reason = textField.text;
                [_reason retain];
            }break;
            case 11:
            {
                _require = textField.text;
                [_require retain];
            }break;
            case 12:
            {
                _leader = textField.text;
                [_leader retain];
            }break;
                
            default:
                break;
        }
    }
    
}

//赋值
- (void)setTextFiledConnect
{
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    NSString *leaderName = nil;
    if ([power isEqualToString:@"2"]) {
        leaderName = [m_datas objectForKey:@"userName"];
    }
    else
    {
        leaderName = [[[m_datas objectForKey:@"leader"] objectAtIndex:0]objectForKey:@"leaderName"];
    }
    NSString *dateStr=[[NSString stringWithFormat:@"%@",[NSDate date]]substringToIndex:19];
    if ([power isEqualToString:@"0"]) {
        dateStr = @"";
    }
    NSArray *arr=@[[self.m_datas objectForKey:@"department"],[m_datas objectForKey:@"userName"],@"",@"",@"1",@"帕萨特-4人",dateStr,@"",dateStr,@"",@"",@"",leaderName];
    for (int index = 0; index<13; ++index)
    {
        UITextField *textField = (UITextField *) [self.view viewWithTag:index+ConstantValue];
        textField.text=arr[index];
    }
}
          
- (BOOL)canCommitList
{
    if (![self isMatchedMobile:_userTel])
    {
        [ShowAlertView showAlertViewStr:@"联系方式有误，请输入正确的手机号码"];
        return NO;
    }
          
    if(_peopleNum > 99)
    {
        [ShowAlertView showAlertViewStr:@"人数不能超过99！"];
        return NO;
    }
    
    if (!_carUser || _carUser.length == 0) {
        [ShowAlertView showAlertViewStr:@"请填写用车人"];
        return NO;
    }
    
    NSDate *useDate = [self dateFromString:_useTime];
    NSDate *returnDate = [self dateFromString:_returnTime];
    NSTimeInterval time=[returnDate timeIntervalSinceDate:useDate];
    if (time <= 0) {
        [ShowAlertView showAlertViewStr:@"时间填写错误，还车时间应大于用车时间！"];
        return NO;
    }
    
    return YES;
}

- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSArray *array = [dateString componentsSeparatedByString:@"."];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:[array objectAtIndex:0]];
    
    [dateFormatter release];
    
    return destDate;
    
}


- (void)selectFinish:(NSInteger)index andType:(CarSelectType)type
{
    switch (type) {
        case Car_DepType:
        {
            self.currentDepId = [[self.depArray objectAtIndex:index] objectForKey:@"depid"];
            UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+0];
            textField.text=[[self.depArray objectAtIndex:index] objectForKey:@"deptname"];
            
            UITextField *mobileTextField = (UITextField *) [self.view viewWithTag:3+ConstantValue];
            mobileTextField.text = @"";
            
            [self getCarUser];
        }
            break;
        case Car_mobileType:
        {
            UITextField *textField = (UITextField *) [self.view viewWithTag:3+ConstantValue];
            if ([[[self.userArray objectAtIndex:index] objectForKey:@"mobile"] isKindOfClass:[NSString class]]){
                textField.text = @"";
            }
            else
            {
                textField.text = [[[self.userArray objectAtIndex:index] objectForKey:@"mobile"] stringValue];
            }
        }
            break;
            
        default:
            break;
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"---tag:%d",textField.tag);
//    if(textField.tag - ConstantValue>=5&&textField.tag - ConstantValue<=10){
//        [scrollow setContentOffset:CGPointMake(0, textField.frame.origin.y-30) animated:YES];
//    }else if(textField.tag - ConstantValue>=10){
//        [scrollow setContentOffset:CGPointMake(0, textField.frame.origin.y-160) animated:YES];
//    }
//    textFlid=textField;
    if(textFieldUpTag==-1){
        textFieldUpTag=textField.tag;
        
    }
    
    if(textField.tag==ConstantValue+0)
    {
        if (!depArray || [depArray count] == 0) {
            [ShowAlertView showAlertViewStr:@"无部门信息"];
            return NO;
        }
        
        SystemContactVC *scvc = [[SystemContactVC alloc] initWithData:[NSMutableArray arrayWithArray:self.depArray] andType:Car_DepType];
        scvc.selectDelegate = self;
        [self.navigationController pushViewController:scvc animated:YES];
        [scvc release];
//        NSMutableArray *tmp = [NSMutableArray array];
//        for (int i = 0; i < [self.depArray count]; ++i)
//        {
//            NSDictionary *dic = [self.depArray objectAtIndex:i];
//            [tmp addObject:[KxMenuItem menuItem:[dic objectForKey:@"deptname"]
//                                         image:nil
//                                        target:self
//                                         action:@selector(selectDepartment:) index:i]];
//        }
//        
//        NSArray *menuItems = tmp;
//        
//        [KxMenu showMenuInView:scrollow  fromRect:CGRectMake(textField.frame.size.width-80, textField.frame.origin.y-scrollow.contentOffset.y, textField.frame.size.width, textField.frame.size.height) menuItems:menuItems];
        return NO;
    }
    
    if(textField.tag==ConstantValue+5){
 
        //帕萨特-4人，别克商务-6人，丰田商务-16人，考斯特-22人，金龙客车-50人，奥迪A6-4人，奔驰-4人
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"帕萨特-4人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:0],
          
          [KxMenuItem menuItem:@"别克商务-6人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:1],
          [KxMenuItem menuItem:@"丰田商务-16人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:2],
          [KxMenuItem menuItem:@"考斯特-22人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:3],
          [KxMenuItem menuItem:@"金龙客车-50人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:4],
          [KxMenuItem menuItem:@"奥迪A6-4人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:5],
          [KxMenuItem menuItem:@"奔驰-4人"
                         image:nil
                        target:self
                        action:@selector(selectorCartype:) index:6],
          
          ];
        
        
        [KxMenu showMenuInView:scrollow  fromRect:CGRectMake(textField.frame.size.width-4, textField.frame.origin.y-scrollow.contentOffset.y, textField.frame.size.width, textField.frame.size.height) menuItems:menuItems];
        return NO;
    }
    if(textField.tag==ConstantValue+6 ||textField.tag==ConstantValue+8){
        UITextField *upTextField=(UITextField*)[self.view viewWithTag:textFieldUpTag];
            [upTextField resignFirstResponder];
        [textField endEditing:NO];
        if(textField.tag==ConstantValue+6) isStartTimeToYes=YES;
        else isStartTimeToYes=NO;
        JDatePickerView *datePicker=[[JDatePickerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        datePicker.delegate=self;
        [self.view addSubview:datePicker];
        
        return NO;

    }
    if(textField.tag==ConstantValue+12){
        
        NSArray *array=[self.m_datas objectForKey:@"leader"];
        NSMutableArray *leaderMenu=[NSMutableArray arrayWithCapacity:3];
        for(int i=0;i<[array count];i++){
           KxMenuItem *item=   [KxMenuItem menuItem:[array[i] objectForKey:@"leaderName"]
                           image:nil
                          target:self
                          action:@selector(selectorLeadertype:) index:i];
            [leaderMenu addObject:item];
        }

        [KxMenu showMenuInView:scrollow  fromRect:CGRectMake(textField.frame.size.width-80, textField.frame.origin.y-scrollow.contentOffset.y, textField.frame.size.width, textField.frame.size.height) menuItems:leaderMenu];
        return NO;
    }
    textFieldUpTag=textField.tag;
    return YES;
}

- (void)confirmPressed:(UIButton *)sender
{
    NSInteger row = [_selectCar selectedRowInComponent:0];
    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+5];
    textField.text=[pickerArray objectAtIndex:row];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+5];
    textField.text=[pickerArray objectAtIndex:row];
    return [pickerArray objectAtIndex:row];
}

- (void)datePicker:(JDatePickerView *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    NSString *dateAndTime=[picker getDate];
    UITextField *text=nil;
    if(isStartTimeToYes){
        text=(UITextField*)[self.view viewWithTag:ConstantValue+6];
    }else{
        text=(UITextField*)[self.view viewWithTag:ConstantValue+8];
    }
    text.text=dateAndTime;
}

#pragma mark - 取消键盘
- (void)changeKeyboard
{
//    [textFlid resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 判断该mobile number是否合法
- (BOOL)isMatchedMobile:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(13[0-9]|15[0-9]|17[0-9]|18[0-9])[0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];

    
    //无符号整型数据接受匹配的数据的数目
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    [regularexpression release];
    
    if (numberofMatch == 0) {
        return NO;
    }
	return YES;
}

////判断输入电话号码是否正确
//- (BOOL)isMatchedMobile:(NSString *)mobileNum
//{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}




//选择商务车
- (void)selectorCartype:(KxMenuItem*) sender {
    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+5];
     //帕萨特-4人，别克商务-6人，丰田商务-16人，考斯特-22人，金龙客车-50人，奥迪A6-4人，奔驰-4人
    switch (sender.index) {
        case 0:
        {
            textField.text = @"帕萨特-4人";
        }break;
        case 1:
        {
            textField.text = @"别克商务-6人";
        }break;
        case 2:
        {
            textField.text = @"丰田商务-16人";
        }break;
        case 3:
        {
            textField.text = @"考斯特-22人";
        }break;
        case 4:
        {
            textField.text = @"金龙客车-50人";
        }break;
        case 5:
        {
            textField.text = @"奥迪A6-4人";
        }break;
        case 6:
        {
            textField.text = @"奔驰-4人";
        }break;
            
        default:
            break;
    }
}

-(void)selectorLeadertype:(KxMenuItem*)sender{
    NSArray *array=[self.m_datas objectForKey:@"leader"];
    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+12];
    textField.text=[array[sender.index] objectForKey:@"leaderName"];
}

//-(void)selectDepartment:(KxMenuItem*)sender{
//    self.currentDepId = [self.depArray[sender.index] objectForKey:@"depid"];
//    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+0];
//    textField.text=[self.depArray[sender.index] objectForKey:@"deptname"];
//    
//    [self getCarUser];
//}
//
//-(void)selectMobile:(KxMenuItem*)sender{
//    UITextField*textField=(UITextField*)[scrollow viewWithTag:ConstantValue+3];
//    textField.text=[self.depArray[sender.index] objectForKey:@"mobile"];
//}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (isChangeFrame) {
        scrollow.contentSize = CGSizeMake(scrollow.contentSize.width, scrollow.contentSize.height - 216);
        if (scrollow.contentOffset.y <= 216) {
            [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, 0)];
        }
        else
        {
            [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, scrollow.contentOffset.y - 216)];
        }
        isChangeFrame = NO;
    }
    
    if (textField.frame.origin.y - scrollow.contentOffset.y + 40 > (kScreen_Height - 20 - 44)-216) {
        [UIView animateWithDuration:0.3f animations:^{
            
            scrollow.contentSize = CGSizeMake(scrollow.contentSize.width, scrollow.contentSize.height + 216);
            [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, scrollow.contentOffset.y + 216)];
            isChangeFrame = YES;
        }];
    }
//    if (textField.tag - ConstantValue != 0) {
//        scrollow.contentSize = CGSizeMake(scrollow.contentSize.width, scrollow.contentSize.height + 216);
//        [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, scrollow.contentOffset.y + 216)];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollow endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [scrollow endEditing:YES];
    
    if (isChangeFrame) {
        scrollow.contentSize = CGSizeMake(scrollow.contentSize.width, scrollow.contentSize.height - 216);
        if (scrollow.contentOffset.y <= 216) {
            [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, 0)];
        }
        else
        {
            [scrollow setContentOffset:CGPointMake(scrollow.contentOffset.x, scrollow.contentOffset.y - 216)];
        }
        isChangeFrame = NO;
    }
}


@end
