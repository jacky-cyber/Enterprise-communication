//
//  LoginView.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LoginView.h"
#import "KxMenu.h"
#import "UIViewCtrl_Password_Recovery.h"


@interface LoginView ()<UITextFieldDelegate>

@property (nonatomic, retain) UIView *mainBgView;
@property (nonatomic, retain) UIView *mainBgImageView;
@property (nonatomic, retain) UITextField *accountField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *rememberBt;
@property (nonatomic, retain) UIButton *autoLoginBt;

@end

@implementation LoginView
{
    //记录用户的登录状态
    UserStatus _userStatus;
    UIButton *_userStatusBt;
    BOOL _isSelfLogin;
    //登录是否返回结果
    BOOL _isLoginReturnResult;
}
@synthesize customAlertView;

- (void)dealloc
{
    self.mainBgView = nil;
    self.mainBgImageView = nil;
    self.accountField = nil;
    self.passwordField = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginFinishData object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //增加监听，获取登录成功数据的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:kLoginFinishData
                                                   object:nil];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        //连接失败
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveLoginDisConnect)
                                                     name:kDisconnect object:nil];
        [self initDefaultDatas];
        [self initSubviews];

    }
    return self;
}

- (void)initDefaultDatas
{
    _isLoginReturnResult = NO;
    BOOL isNotInitStatus = [[NSUserDefaults standardUserDefaults] boolForKey:kIsNotInitStatus];
    if(!isNotInitStatus)
    {
        _userStatus = Status_Online;
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",_userStatus] forKey:kUserStatus];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsNotInitStatus];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        _userStatus = (UserStatus)[[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue];
    }
}
- (void)initSubviews
{
    UIView *aView = [[UIView alloc] initWithFrame:self.bounds];
    aView.backgroundColor = [UIColor whiteColor];
    aView.clipsToBounds = YES;
    self.mainBgView = aView;
    [aView release];
    [self addSubview:_mainBgView];
    
//    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:_mainBgView.bounds];
//    aImageView.clipsToBounds = YES;
//    aImageView.userInteractionEnabled = YES;
//    aImageView.image = [UIImage imageNamed:@"loginMainBg.png"];
//    self.mainBgImageView = aImageView;
//    [aImageView release];
//    [_mainBgView addSubview:_mainBgImageView];
    

    UIImage *loginImage = nil;
    if (kScreen_Height>480) {
        loginImage = [UIImage imageNamed:@"login_bg_P5.png"];
    }
    else
    {
        loginImage = [UIImage imageNamed:@"login_bg_P5.png"];
    }
    UIImageView *loginBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    loginBg.userInteractionEnabled = YES;
    loginBg.image = loginImage;
    [_mainBgView addSubview:loginBg];
    [loginBg release];
    
    CGFloat leftMargin = 38;
    UIImage *logoImage = [UIImage imageNamed:@"login_logo2.png"];

    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, 40, logoImage.size.width/2, logoImage.size.height/2)];
    logo.image = logoImage;
    [loginBg addSubview:logo];
    [logo release];
    
    UIImage *frameImage = [UIImage imageNamed:@"loginFrame.png"];
    UIImageView *loginFrame = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(logo.frame)+10, frameImage.size.width/2, frameImage.size.height/2)];
    loginFrame.userInteractionEnabled  = YES;
    loginFrame.image = frameImage;
    [loginBg addSubview:loginFrame];
    [loginFrame release];
    
    
    UITextField *aTextField = [[UITextField alloc] initWithFrame:CGRectMake(28, 3, 200, 41)];
    aTextField.borderStyle = UITextBorderStyleNone;
    aTextField.returnKeyType = UIReturnKeyDone;
    aTextField.delegate = self;
    aTextField.placeholder = @"帐号";
    aTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.accountField = aTextField;
    [aTextField release];
    [loginFrame addSubview:_accountField];
    
    UIImage *statusImage = [self getStatusImage:_userStatus];
    _userStatusBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userStatusBt addTarget:self action:@selector(chooseUserStatus:) forControlEvents:UIControlEventTouchUpInside];
    [_userStatusBt setImage:statusImage forState:UIControlStateNormal];
    _userStatusBt.frame = CGRectMake(228, 82, 50, 50);
    _userStatusBt.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    
    //[userStatusBt setTitle:@"状态" forState:UIControlStateNormal];
    [loginBg addSubview:_userStatusBt];

    UITextField *bTextField = [[UITextField alloc] initWithFrame:CGRectMake(28, 45, 200, 43)];
    bTextField.borderStyle = UITextBorderStyleNone;
    bTextField.returnKeyType = UIReturnKeyDone;
    bTextField.delegate = self;
    bTextField.placeholder = @"密码";
    bTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    bTextField.secureTextEntry = YES;
    self.passwordField = bTextField;
    [bTextField release];
    [loginFrame addSubview:_passwordField];
    
    UIImage *loginBtImage = [UIImage imageNamed:@"loginBt2.png"];
    UIButton *loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBt addTarget:self action:@selector(doLoginConnect:) forControlEvents:UIControlEventTouchUpInside];
    [loginBt setImage:loginBtImage forState:UIControlStateNormal];
    loginBt.frame = CGRectMake(leftMargin, CGRectGetMaxY(loginFrame.frame)+15, loginBtImage.size.width/2, loginBtImage.size.height/2);
    [loginBg addSubview:loginBt];
    
//    UIImage *autoLoginImage = [UIImage imageNamed:@"fuxuan_1.png"];
//    UIImage *autoLoginSelectedImage = [UIImage imageNamed:@"fuxuan_2.png"];
//
//    self.autoLoginBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_autoLoginBt setImage:autoLoginImage forState:UIControlStateNormal];
//    [_autoLoginBt setImage:autoLoginSelectedImage forState:UIControlStateSelected];
//    _autoLoginBt.frame = CGRectMake(leftMargin, CGRectGetMaxY(loginBt.frame)+15, 100, autoLoginImage.size.height/2);
//    [_autoLoginBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(_autoLoginBt.frame)-autoLoginImage.size.width/2)];
//    [_autoLoginBt addTarget: self action:@selector(onAutoLoginBtTap:) forControlEvents:UIControlEventTouchUpInside];
//    [loginBg addSubview:_autoLoginBt];
//
////    全通用“登录”，政企用“登录”
//    NSString *textStr = @"自动登录";
//    if ([kSERVER_IP isEqualToString:@"111.11.28.29"]) {
//        textStr = @"自动登录";
//    }
//    CGFloat font = 14.0f;
//    CGSize size = [textStr sizeWithFont:[UIFont systemFontOfSize:font]];
//
//    UILabel *autoLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_autoLoginBt.frame)+autoLoginImage.size.width/2+8, CGRectGetMinY(_autoLoginBt.frame)+(CGRectGetHeight(_autoLoginBt.frame)-size.height)/2, 80,size.height)];
//    autoLoginLabel.text = textStr;
//    autoLoginLabel.font = [UIFont systemFontOfSize:font];
//    autoLoginLabel.contentMode = UIViewContentModeCenter;
//    autoLoginLabel.backgroundColor = [UIColor clearColor];
//    autoLoginLabel.textColor = [UIColor grayColor];
//    [loginBg addSubview:autoLoginLabel];
//    [autoLoginLabel release];
    

    
    
//    UIImage *rememberImage = [UIImage imageNamed:@"fuxuan_1.png"];
//    UIImage *rememberSelectedImage = [UIImage imageNamed:@"fuxuan_2.png"];
//    self.rememberBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_rememberBt setImage:rememberImage forState:UIControlStateNormal];
//    [_rememberBt setImage:rememberSelectedImage forState:UIControlStateSelected];
//    _rememberBt.frame = CGRectMake(leftMargin, CGRectGetMaxY(loginBt.frame)+15, 100, autoLoginImage.size.height/2);
//    [_rememberBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(_rememberBt.frame)-rememberImage.size.width/2)];
//    [_rememberBt addTarget: self action:@selector(onRememberBtTap:) forControlEvents:UIControlEventTouchUpInside];
//    [loginBg addSubview:_rememberBt];
//    
//    NSString *textStr = @"记住密码";
//    CGFloat font = 14.0f;
//    CGSize size = [textStr sizeWithFont:[UIFont systemFontOfSize:font]];
//
//    UILabel *rememberLabel =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_rememberBt.frame)+autoLoginImage.size.width/2+8, CGRectGetMinY(_rememberBt.frame)+(CGRectGetHeight(_rememberBt.frame)-size.height)/2, 80,size.height)];
//    rememberLabel.text = textStr;
//    rememberLabel.font = [UIFont systemFontOfSize:font];
//    rememberLabel.contentMode = UIViewContentModeCenter;
//    rememberLabel.backgroundColor = [UIColor clearColor];
//    rememberLabel.textColor = [UIColor grayColor];
//    [loginBg addSubview:rememberLabel];
//    [rememberLabel release];

    
    UIButton *loginSetBt = [UIButton buttonWithType:UIButtonTypeCustom];
    loginSetBt.frame = CGRectMake(170, 400, 100, 30);
    [loginSetBt setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    loginSetBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    loginSetBt.font = [UIFont systemFontOfSize:16.0f];
    if ([kSERVER_IP isEqualToString:@"111.11.28.29"]) {
        [loginSetBt setTitle:@"登录设置" forState:UIControlStateNormal];
    }
    else
    {
        [loginSetBt setTitle:@"登录设置" forState:UIControlStateNormal];
    }

    [loginSetBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginSetBt addTarget:self action:@selector(onLoginSetBtTap:) forControlEvents:UIControlEventTouchUpInside];
    [loginBg addSubview:loginSetBt];
    
    UILabel *labspan = [[[UILabel alloc] initWithFrame:CGRectMake(150.0f, 400.0f, 20.0f, 30.0f)] autorelease];
    [labspan setFont:[UIFont systemFontOfSize:16.0f]];
    [labspan setTextAlignment:NSTextAlignmentCenter];
    [labspan setTextColor:[UIColor grayColor]];
    [labspan setText:@"|"];
    [loginBg addSubview:labspan];
     
    UIButton *forgetPwdBt = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBt.frame = CGRectMake(50, 400, 100, 30);
    [forgetPwdBt setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    forgetPwdBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [forgetPwdBt setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetPwdBt addTarget:self action:@selector(onBtnForgetPwd_Click:) forControlEvents:UIControlEventTouchUpInside];
    [loginBg addSubview:forgetPwdBt];

//    
//    BOOL isRemember = [[NSUserDefaults standardUserDefaults] boolForKey:kIsRemember];
//    
//    if (isRemember)
//    {
//        _rememberBt.selected = YES;
//        _accountField.text = [[NSUserDefaults standardUserDefaults] objectForKey:User_Key];
//        _passwordField.text = [[NSUserDefaults standardUserDefaults] objectForKey:Password_Key];
//    }
//    else
//    {
//        _rememberBt.selected = NO;
//    }
    
    
    _accountField.text = [[NSUserDefaults standardUserDefaults] objectForKey:User_Key];
    _passwordField.text = [[NSUserDefaults standardUserDefaults] objectForKey:Password_Key];
    
//    BOOL isAuto = [[NSUserDefaults standardUserDefaults] boolForKey:kIsAutoLogin];
//    if (isAuto)
//    {
//        _autoLoginBt.selected = YES;
//        
//        //如果是自动登录就选择记住密码
//        _rememberBt.selected = YES;
//
//
//        
////        BOOL isExecuteAutoLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kIsExecuteAutoLogin];
////        if (isExecuteAutoLogin) {
////            [self performSelector:@selector(doLoginConnect:) withObject:nil afterDelay:0.1];
////        }
//    }
//    else
//    {
//        _autoLoginBt.selected = NO;
//    }

}

#pragma mark - 点击操作
- (void)onRememberBtTap:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)onAutoLoginBtTap:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)onLoginSetBtTap:(UIButton *)sender
{
    LoginSetView *setView = [[LoginSetView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_mainBgView.frame), 0, CGRectGetWidth(_mainBgView.frame), CGRectGetHeight(self.mainBgView.bounds))];
    [self.mainBgView addSubview:setView];
    [setView release];
    
    [UIView animateWithDuration:.5f
                     animations:^{
                         setView.frame = self.mainBgView.bounds;
                     }completion:^(BOOL finished){

                     }];
    
}

//选择状态的
- (void)chooseUserStatus:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"在线"
                     image:[self getStatusImage:Status_Online]
                    target:self
                    action:@selector(pushMenuItem:) index:Status_Online],
      
//      [KxMenuItem menuItem:@"忙碌"
//                     image:[self getStatusImage:Status_Busy]
//                    target:self
//                    action:@selector(pushMenuItem:) index:Status_Busy],
//      
//      [KxMenuItem menuItem:@"隐身"
//                     image:[self getStatusImage:Status_Hidden]
//                    target:self
//                    action:@selector(pushMenuItem:) index:Status_Hidden],
      
//      [KxMenuItem menuItem:@"离开"
//                     image:[self getStatusImage:Status_Leave]
//                    target:self
//                    action:@selector(pushMenuItem:) index:Status_Leave],
      ];
    
    //KxMenuItem *first = menuItems[0];
    //first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+15, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
}

- (UIImage *)getStatusImage:(UserStatus)status
{
    UIImage *image = nil;
    switch (status)
    {
        case Status_Online:
        {
            image = [UIImage imageNamed:@"online2.png"];
        }break;
        case Status_Leave:
        {
            image = [UIImage imageNamed:@"not_onle2.png"];
        }break;
        case Status_Busy:
        {
            image = [UIImage imageNamed:@"busy2.png"];
        }break;
        case Status_Hidden:
        {
            image = [UIImage imageNamed:@"yinshen2.png"];
        }break;
        default:
            break;
    }
    
    return image;
}

- (void)setUserStatus:(UserStatus)status
{
    _userStatus = status;
}

#pragma mark - 状态回调
- (void) pushMenuItem:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        KxMenuItem *item = (KxMenuItem *)sender;
        UserStatus status = (UserStatus)item.index;
        
        [_userStatusBt setImage:item.image forState:UIControlStateNormal];
        [self setUserStatus:status];
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",status] forKey:kUserStatus];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}
-(void)doLoginConnect:(NSDictionary *)dic
{
    _isSelfLogin = YES;
    //    [_delegate loginSuccessfully:nil];
    if([_accountField.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入帐号"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else if ([_passwordField.text length]==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入密码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
		
    }
    //帐号密码全部输入后再与服务器连接
    else if ([_accountField.text length] > 0 && [_passwordField.text length] > 0)
    {
        [self endEditing:YES];
		[self login];
    }
}

#pragma mark -登录请求  首先请求新闻的分类 然后去根据列表去请求
- (void)login
{
    _isLoginReturnResult = NO;
    [[STHUDManager sharedManager] showHUDInView:self];
    [self performSelector:@selector(loginOverTimeTenSeconds) withObject:nil afterDelay:11.0f];
    NSString *status = [NSString stringWithFormat:@"%d",_userStatus];
    NSString *username = _accountField.text;
    NSString *clientDbVersion = @"0";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kLocalVersion])
    {
        clientDbVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalVersion];
    }
    NSString *userPsw = [_passwordField.text md5];
//    NSString *loginType = [NSString stringWithFormat:@"%d",kiPhoneLoginType];
//    NSString *domain = [NSString stringWithFormat:@"%d",]
    //loginType  1代表iPhone 0 是安卓
//    NSArray *loginArr = @[@{@"cmd":@"login"},@{@"status": status},@{@"domain": @"9000"},@{@"userName": username},@{@"clientDbVersion": clientDbVersion},@{@"userPsw": userPsw},@{@"type": @"req"},@{@"loginType": loginType}];
    
    NSDictionary *logDic = [NSDictionary dictionaryWithObjectsAndKeys:status,@"status",username,@"username",clientDbVersion,@"clientDbVersion",userPsw,@"userPsw", nil];

//    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:loginArr]];
    [[YiXinScoketHelper sharedService] setLoginDatas:logDic];
    [[YiXinScoketHelper sharedService] connect];
}

//登录超过10
- (void)loginOverTimeTenSeconds
{
    [[STHUDManager sharedManager] hideHUDInView:self];
    if (!_isLoginReturnResult) {
        [ShowAlertView showAlertViewStr:@"登录超时"];
//        [[STHUDManager sharedManager] showHUDWithLabel:@"登录超时"];
//        [[STHUDManager sharedManager] hideHUDWithLabel:@"登录超时" afterDelay:1.0f];
    }
}

- (void)receiveDataNotification:(NSNotification *)notification
{
    _isLoginReturnResult = YES;
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {

        [[NSUserDefaults standardUserDefaults] setBool:_rememberBt.selected forKey:kIsRemember];
        [[NSUserDefaults standardUserDefaults] setBool:_autoLoginBt.selected forKey:kIsAutoLogin];
        
        [[NSUserDefaults standardUserDefaults] setValue:_accountField.text forKey:User_Key];
        [[NSUserDefaults standardUserDefaults] setValue:_passwordField.text  forKey:Password_Key];
        
        
        //这里要增加下载数据库的逻辑 下载数据库的后要保存版本
        [_delegate loginSuccessfully:infoDic];
    }
    else
    {
//        "0:succeed","1:input error","2:db exe error","3:empty dataset"
        if ([[infoDic objectForKey:@"err"] hasPrefix:@"1"])
        {
            [ShowAlertView showAlertViewStr:@"输入错误!"];
        }
        else if ([[infoDic objectForKey:@"err"] hasPrefix:@"2"])
        {
            [ShowAlertView showAlertViewStr:@"域名错误!"];
        }
        else if ([[infoDic objectForKey:@"err"] hasPrefix:@"3"])
        {
            [ShowAlertView showAlertViewStr:@"用户不存在!"];

        }
        else if ([[infoDic objectForKey:@"err"] hasPrefix:@"4"])
        {
            [ShowAlertView showAlertViewStr:@"帐号密码错误!!"];
            
        }

        else
        {
            
            if ([kSERVER_IP isEqualToString:@"111.11.28.29"]) {
                [ShowAlertView showAlertViewStr:@"登录失败,请重新登录"];

            }
            else
            {
                [ShowAlertView showAlertViewStr:@"登录失败,请重新登录"];
            }

        }
    }
}

- (void)receiveLoginDisConnect
{
    if (_isSelfLogin) {
//        _isLoginReturnResult = YES;
//        [[STHUDManager sharedManager] hideHUDInView:self];
//        [ShowAlertView showAlertViewStr:@"登录失败"];
    }
}

#pragma mark - uitextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//#pragma mark - ChooseStatusDelegate && popverDelegate
//- (void) chooseStatusFinish:(NSDictionary *)dic
//{
//    NSLog(@"%@",dic);
//    _userStatus = (UserStatus)[[dic objectForKey:kStatusValue]integerValue];
//}

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
}


#pragma mark - keyboardDelegate
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
//    [UIView animateWithDuration:0.4f
//                     animations:^{
//                         _mainBgImageView.frame = CGRectMake(0, -220, CGRectGetWidth(_mainBgImageView.frame), CGRectGetHeight(_mainBgImageView.frame));
//                     }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    [UIView animateWithDuration:0.4f
//                     animations:^{
//                         _mainBgImageView.frame = CGRectMake(0, 0, CGRectGetWidth(_mainBgImageView.frame), CGRectGetHeight(_mainBgImageView.frame));
//                     }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)onBtnForgetPwd_Click:(id)sender{
    UIViewCtrl_Password_Recovery *tmp_view = [[[UIViewCtrl_Password_Recovery alloc] initWithNibName:@"UIViewCtrl_Password_Recovery" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

@end
