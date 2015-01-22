//
//  UIViewCtrl_Password_Modify.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-2-26.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "UIViewCtrl_Password_Modify.h"
#import "AppDelegate.h"

@interface UIViewCtrl_Password_Modify ()

@end

@implementation UIViewCtrl_Password_Modify

@synthesize view_01 = _view_01;
@synthesize textfield_01 = _textfield_01;
@synthesize textfield_02 = _textfield_02;
@synthesize textfield_03 = _textfield_03;
@synthesize button_01 = _button_01;

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
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.textfield_01 setBorderStyle:UITextBorderStyleNone];
    [self.textfield_02 setBorderStyle:UITextBorderStyleNone];
    [self.textfield_03 setBorderStyle:UITextBorderStyleNone];
    
    [self.textfield_01 setText:@"旧密码"];
    [self.textfield_02 setText:@"新密码"];
    [self.textfield_03 setText:@"再次输入新密码"];
    
    UIImage *image_01 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
    UIImage *image_02 = [image_01 resizableImageWithCapInsets:UIEdgeInsetsMake(image_01.size.height /2, image_01.size.width / 2, image_01.size.height / 2 , image_01.size.width / 2)];
    [self.button_01 setBackgroundImage:image_02 forState:UIControlStateNormal];
    //[self.button_01 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    UIImage *image_03 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
//    UIImage *image_04 = [image_03 resizableImageWithCapInsets:UIEdgeInsetsMake(image_03.size.height /2, image_03.size.width / 2, image_03.size.height / 2 , image_03.size.width / 2)];
//    [self.button_01 setBackgroundImage:image_04 forState:UIControlStateHighlighted];
//    [self.button_01 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.sOldPwd = nil;
    self.sNewPwd = nil;
    self.sAgainPwd = nil;
    
    [super dealloc];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnPwdModify_Click:(id)sender{
    [self.view endEditing:YES];
    if (self.sOldPwd == nil || self.sOldPwd.length < 1) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您旧密码不能为空，请输入！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }else if (self.sNewPwd == nil || self.sNewPwd.length < 1){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您新输入的密码不能为空，请输入！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }else if (self.sAgainPwd == nil || self.sAgainPwd.length < 1){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您再次输入的新密码不能为空，请输入！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    
    if ([self.sNewPwd compare:self.sAgainPwd] != NSOrderedSame) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您两次输入的密码不一致，请重新输入！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    
    if ([self.sNewPwd compare:self.sOldPwd] == NSOrderedSame) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能将新密码设置的与旧密码相同！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd": @"SetPSW"}, @{@"curpassword": self.sOldPwd }, @{@"newpassword": self.sNewPwd}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"SetPSW" object:nil];
    
}

- (IBAction)onTextField_BeginEdit:(id)sender
{
    UITextField *tmp_text_Field = sender;
    if ( (tmp_text_Field == self.textfield_01 && (self.sOldPwd == nil || self.sOldPwd.length < 1))
        || (tmp_text_Field == self.textfield_02 && (self.sNewPwd == nil || self.sNewPwd.length < 1))
        || (tmp_text_Field == self.textfield_03 && (self.sAgainPwd == nil || self.sAgainPwd.length < 1)) ){
        [tmp_text_Field setText:@""];
        [tmp_text_Field setSecureTextEntry:YES];
        [tmp_text_Field setTextColor:[UIColor blackColor]];
    }
    [tmp_text_Field setBorderStyle:UITextBorderStyleRoundedRect];
    
}

- (IBAction)onTextField_EndEdit:(id)sender
{
    UITextField *tmp_text_Field = sender;
    [tmp_text_Field setBorderStyle:UITextBorderStyleNone];
     
    if (tmp_text_Field == self.textfield_01 ) {
        self.sOldPwd = [tmp_text_Field text];
        if (self.sOldPwd == nil || self.sOldPwd.length < 1){
            [tmp_text_Field setSecureTextEntry:NO];
            [tmp_text_Field setTextColor:[UIColor grayColor]];
            [tmp_text_Field setText:@"旧密码"];
        }
    }
    
    if (tmp_text_Field == self.textfield_02 ) {
        self.sNewPwd = [tmp_text_Field text];
        if (self.sNewPwd == nil || self.sNewPwd.length < 1){
            [tmp_text_Field setSecureTextEntry:NO];
            [tmp_text_Field setTextColor:[UIColor grayColor]];
            [tmp_text_Field setText:@"新密码"];
        }
    }
    
    if (tmp_text_Field == self.textfield_03 ) {
        self.sAgainPwd = [tmp_text_Field text];
        if (self.sAgainPwd == nil || self.sAgainPwd.length < 1){
            [tmp_text_Field setSecureTextEntry:NO];
            [tmp_text_Field setTextColor:[UIColor grayColor]];
            [tmp_text_Field setText:@"再次输入新密码"];
        }
    }
}

- (IBAction)Close_KeyBoard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)receiveDataNotification:(NSNotification *)wParam
{
    if ([wParam.name compare:@"SetPSW"] == NSOrderedSame) {
        if ([[wParam.userInfo valueForKey:@"result"] integerValue] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"密码已修改成功！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            [alert release];
            [self.textfield_01 setSecureTextEntry:NO];
            [self.textfield_01 setTextColor:[UIColor grayColor]];
            [self.textfield_01 setText:@"旧密码"];
            
            [self.textfield_02 setSecureTextEntry:NO];
            [self.textfield_02 setTextColor:[UIColor grayColor]];
            [self.textfield_02 setText:@"新密码"];
            
            [self.textfield_03 setSecureTextEntry:NO];
            [self.textfield_03 setTextColor:[UIColor grayColor]];
            [self.textfield_03 setText:@"再次输入新密码"];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"修改密码失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


@end
