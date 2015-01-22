//
//  AdminDispatch.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-4-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AdminDispatch.h"
#import "Car_helper.h"
#import "CarManagementVC.h"
#import "KxMenu.h"

#define ConstantValue 6172836

@interface AdminDispatch ()
{
    BOOL _isCompanyArranger;
}

@property (nonatomic, retain) NSArray *companys;
@property (nonatomic, retain) NSArray *companyArranger;
@property (nonatomic, retain) NSArray *carLicense;

@end

@implementation AdminDispatch
{
    UIView *_baseView;
    carOrderModel *_carOrderModel;
    NSString *_formId;
    //@"司机",@"司机联系方式",@"车牌号",@"提供车辆公司"
    NSString *_driver;
    NSString *_driverTel;
    NSString *_carNumber;
    NSString *_carCompany;
    UIScrollView *_scrollow;
    UITextField *_temptextField;
    
    NIDropDown *dropDown;
}
@synthesize companys;
@synthesize companyArranger;
@synthesize carLicense;

- (void)dealloc
{
    self.carLicense = nil;
    self.companys = nil;
    self.companyArranger = nil;
    RELEASE_SAFELY(_carOrderModel);
    [super dealloc];
}

- (id)initWithInfo:(carOrderModel *)carOrder andFormId:(NSString *)idString
{
    self = [super init];
    if (self) {
        // Custom initialization
        _carOrderModel = [[carOrderModel alloc] init];
        _carOrderModel = carOrder;
        _formId = idString;
        _isCompanyArranger = NO;
       
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, kScreen_Width, kScreen_Height - 44-20)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    [_baseView release];
    
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [backBtn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.right,self.iosChangeFloat, 150, 40)];
    titleLabel.text = @"管理员分派";
    titleLabel.textColor = kDarkerGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //提交按钮
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionBtn setFrame:CGRectMake(250, self.iosChangeFloat+10, 50, 22.5)];
    [actionBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [actionBtn setTitle:@"分派" forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionBtn];
}

- (void)loadSubviews
{
    _scrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(_baseView.frame))];
    _scrollow.contentSize = CGSizeMake(320, kScreen_Height-20-44);
    [_baseView addSubview:_scrollow];
    
    NSArray *laberArr = [NSArray arrayWithObjects:@"提供车辆公司",@"司机",@"司机联系方式",@"车牌号", nil];
  
    int _y = 5;
    for (int j=0; j<1; j++) {
        
        for(int index = 0; index <[laberArr count]; index++ ) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 120, 35)];
            label.font = [UIFont boldSystemFontOfSize:16.0f];
            label.textAlignment= NSTextAlignmentLeft;
            label.text = [laberArr objectAtIndex:index];
            [_scrollow addSubview:label];
            
            UITextField*  textField = [[UITextField alloc] initWithFrame:CGRectMake(10, _y+35, 300, 35)];
            [textField.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];//设置边框
            textField.layer.cornerRadius = 5.0f;
            [textField.layer setBorderWidth:1.0f];
            textField.delegate=self;
            textField.borderStyle = UITextBorderStyleLine;
            textField.font = [UIFont systemFontOfSize:12.0f];
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.tag = index + ConstantValue;
            NSLog(@"TextField.tag==%d",textField.tag);
            [_scrollow addSubview:textField];
            [textField release];
        
            
            if (kDeviceHeight > 480)
            {
                _y+=80;
            }else
            {
                _y+=80;
            }
            
        }
        
    }
    if (kDeviceHeight > 480) {
        _y=90;
    }else{
        _y=27;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self loadSubviews];
    [self getCompanys];
}

- (void)backBtn_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 获取数据

- (void)setTextFiledConnect
{
    for (int index = 0; index < 4; ++index)
    {
        UITextField *textField = (UITextField *) [self.view viewWithTag:index+ConstantValue];
        switch (index)
        {
            case 0:
            {
                _carCompany = [textField.text retain];
            }break;
            case 1:
            {
                _driver = [textField.text retain];
            }break;
            case 2:
            {
                _driverTel = [textField.text retain];
            }break;
            case 3:
            {
                _carNumber = [textField.text retain];
            }break;
                
            default:
                break;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_isCompanyArranger) {
        if (textField.tag == ConstantValue + 1) {
            
            NSMutableArray *menu = [NSMutableArray array];
            for(int i=0;i<[self.companyArranger count];i++){
                KxMenuItem *item=   [KxMenuItem menuItem:[self.companyArranger[i] objectForKey:@"name"]
                                                   image:nil
                                                  target:self
                                                  action:@selector(selectorDriver:) index:i];
                [menu addObject:item];
            }
            
            [KxMenu showMenuInView:_scrollow  fromRect:CGRectMake(textField.frame.size.width-4, textField.frame.origin.y-_scrollow.contentOffset.y, textField.frame.size.width, textField.frame.size.height) menuItems:menu];
            
            return NO;

        }
        else if (textField.tag == ConstantValue + 2)
        {
//            if (textField.text.length == 0) {
//                return YES;
//            }
            return NO;
        }
        else if (textField.tag == ConstantValue + 3)
        {
            NSMutableArray *menu = [NSMutableArray array];
            for(int i=0;i<[self.carLicense count];i++){
                NSString *showString = [NSString stringWithFormat:@"%@:%@",[self.carLicense[i] objectForKey:@"cartype"],[self.carLicense[i] objectForKey:@"number"]];
                KxMenuItem *item=   [KxMenuItem menuItem:showString
                                                   image:nil
                                                  target:self
                                                  action:@selector(selectorCarNumber:) index:i];
                [menu addObject:item];
            }
            
            [KxMenu showMenuInView:_scrollow  fromRect:CGRectMake(textField.frame.size.width-4, textField.frame.origin.y-_scrollow.contentOffset.y, textField.frame.size.width, textField.frame.size.height) menuItems:menu];
            
            return  NO;
        }
        else if(textField.tag==ConstantValue+0){
            if(dropDown == nil) {
                CGFloat f = 160;
                //最多显示4个，超过4个滑动
                if ([self.companys count] < 4) {
                    f = [self.companys count] * 40;
                }
                dropDown = [[NIDropDown alloc]showDropDown:textField andHeight:f andArray:self.companys];
                dropDown.delegate = self;
                if (CGRectGetMaxY(dropDown.frame) > CGRectGetHeight(_scrollow.frame)) {
                    _scrollow.contentSize = CGSizeMake(kScreen_Width,CGRectGetMaxY(dropDown.frame));
                }
                
            }
            else {
                [dropDown hideDropDown:textField];
                _scrollow.contentSize = CGSizeMake(kScreen_Width, _scrollow.frame.size.height);
                [self rel];
            }
            return NO;
        }
    }
    else
    {
        if(textField.tag==ConstantValue+0){
            if(dropDown == nil) {
                CGFloat f = 160;
                //最多显示4个，超过4个滑动
                if ([self.companys count] < 4) {
                    f = [self.companys count] * 40;
                }
                dropDown = [[NIDropDown alloc]showDropDown:textField andHeight:f andArray:self.companys];
                dropDown.delegate = self;
                if (CGRectGetMaxY(dropDown.frame) > CGRectGetHeight(_scrollow.frame)) {
                    _scrollow.contentSize = CGSizeMake(kScreen_Width,CGRectGetMaxY(dropDown.frame));
                }
                
            }
            else {
                [dropDown hideDropDown:textField];
                _scrollow.contentSize = CGSizeMake(kScreen_Width, _scrollow.frame.size.height);
                [self rel];
            }
            return NO;
        }
    }
    return YES;
}

- (void)selectorDriver:(KxMenuItem*) sender {
    UITextField*textField=(UITextField*)[_scrollow viewWithTag:ConstantValue+1];
    UITextField*textField1=(UITextField*)[_scrollow viewWithTag:ConstantValue+2];
    
    int index = sender.index;
    textField.text = [[self.companyArranger objectAtIndex:index] objectForKey:@"name"];
    textField1.text = [[self.companyArranger objectAtIndex:index] objectForKey:@"phone"];
}

- (void)selectorCarNumber:(KxMenuItem*) sender {
    UITextField*textField=(UITextField*)[_scrollow viewWithTag:ConstantValue+3];
    
    int index = sender.index;
    textField.text =  [NSString stringWithFormat:@"%@:%@",[self.carLicense[index] objectForKey:@"cartype"],[self.carLicense[index] objectForKey:@"number"]];
}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender withIndex:(NSInteger)index{
    
    [_scrollow endEditing:YES];
    
    if ([[[self.companys objectAtIndex:index] objectForKey:@"supplier"] isEqualToString:@"302"])
    {
        _isCompanyArranger = YES;
        
        UITextField*textField=(UITextField*)[_scrollow viewWithTag:ConstantValue+1];
        UITextField*textField1=(UITextField*)[_scrollow viewWithTag:ConstantValue+2];
        UITextField*textField2=(UITextField*)[_scrollow viewWithTag:ConstantValue+3];
        
        textField.text = @"";
        textField1.text = @"";
        textField2.text = @"";
        
        [self getDrivers];
    }
    else
    {
        _isCompanyArranger = NO;
    }
    [self rel];
}

-(void)rel{
    [dropDown release];
    dropDown = nil;
}

- (NSString *)getCompanyId:(NSString *)comName
{
    NSString *supplierid = @"";
    for (NSDictionary *dic in self.companys) {
        if ([[dic objectForKey:@"name"] isEqualToString:comName]) {
            supplierid = [dic objectForKey:@"supplier"];
            break;
        }
    }
    
    return supplierid;
}

- (void)getCompanys
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    NSString *userName=[[NSUserDefaults standardUserDefaults]objectForKey:User_Name];
    
    [[Car_helper  sharedService] requestForType:kCarGetCompanys info:@{@"loginname":userName} target:self successSel:@"getCompanysFinished:" failedSel:@"getCompanysFailed:"];
}

- (void)getCompanysFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    if([[datas objectForKey:@"resultcode"]isEqualToString:@"0"]){
        self.companys = [datas objectForKey:@"list"];
    }
}

- (void)getCompanysFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void)getDrivers
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    [[Car_helper sharedService] requestForType:kCarGetDrivers info:nil target:self successSel:@"getDriversFinished:" failedSel:@"getDriversFailed:"];
}

- (void)getDriversFinished:(NSDictionary *)datas
{
    if([[datas objectForKey:@"resultcode"]isEqualToString:@"0"]){
        self.companyArranger = [datas objectForKey:@"list"];
    }
    
    //继续获取车牌号信息
     [[Car_helper sharedService] requestForType:kCarGetCarNumber info:nil target:self successSel:@"getCarNumbersFinished:" failedSel:@"getCarNumbersFailed:"];
}

- (void)getDriversFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void)getCarNumbersFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    if([[datas objectForKey:@"resultcode"]isEqualToString:@"0"]){
        self.carLicense = [datas objectForKey:@"list"];
    }
}

- (void)getCarNumbersFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void) requestData
{
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:User_id];
    NSString *userName=[[NSUserDefaults standardUserDefaults]objectForKey:User_Name];
    
    [self setTextFiledConnect];
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    [[Car_helper  sharedService] requestForType:kCarCommitByAdmin info:@{@"userId":userId,@"userName":userName,@"id":_formId,@"handState":@"4",@"driver":_driver,@"driverTel":_driverTel,@"carNum":_carNumber,@"carcompany":[self getCompanyId:_carCompany]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];

}

- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
   
    if([[datas objectForKey:@"resultcode"]isEqualToString:@"0"]){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    }else if ([[datas objectForKey:@"resultcode"] isEqualToString:@"93"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前数据已过期！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else {
        [ShowAlertView showAlertViewStr:@"提交失败"];
    }
}
//分派
- (void)commitAction:(UIButton *)sender
{
//    NSLog(@"viewControllers==%@",self.navigationController.viewControllers);

    for (int i=0; i<4; i++) {
        UITextField *tempTextFiled = (UITextField *)[_scrollow viewWithTag:ConstantValue+i];
        if (tempTextFiled.text.length==0) {
            [ShowAlertView showAlertViewStr:@"填写资料不完整或格式不正确"];
            return;
        }
    }
        [self requestData];
    //[self.navigationController popViewControllerAnimated:YES];
    
   }

- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

#pragma mark - 提示框代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    [[NSNotificationCenter defaultCenter] postNotificationName:KRefreshData object:nil];
    UIViewController * carOrderView = (UIViewController*)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:carOrderView animated:YES ];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
