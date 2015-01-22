//
//  UIViewCtrl_Password_Recovery.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Password_Recovery.h"

@interface UIViewCtrl_Password_Recovery ()

@end

@implementation UIViewCtrl_Password_Recovery

@synthesize textfield_01 = _textfield_01;
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
    CGRect RectTextField_01 = [self.textfield_01 frame];
    RectTextField_01.size.height = 45.0f;
    [self.textfield_01 setFrame:RectTextField_01];
    UIImage *image_01 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
    UIImage *image_02 = [image_01 resizableImageWithCapInsets:UIEdgeInsetsMake(image_01.size.height /2, image_01.size.width / 2, image_01.size.height / 2 , image_01.size.width / 2)];
    [self.button_01 setBackgroundImage:image_02 forState:UIControlStateNormal];
    [self.button_01 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:@"RE_SET_PSW" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}


- (IBAction)Close_KeyBroad:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onBtnSubmit_Click:(id)sender
{
    if ([[[self.textfield_01 text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] compare:@""] == NSOrderedSame) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请输入您的用户帐号！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }else{
        [[STHUDManager sharedManager] showHUDInView:self.view];
        NSArray *msg_packet = @[@{@"type":@"req"},@{@"username":[[self.textfield_01 text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]}, @{@"cmd": @"RE_SET_PSW"}];
        NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
        [[YiXinScoketHelper sharedService] getGetPasswordXmlWithStr:xmlStr];
        [[YiXinScoketHelper sharedService] connect];
    }
}

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([wParam.name compare:@"RE_SET_PSW"] == NSOrderedSame) {        if ([((NSString *)[wParam.userInfo valueForKey:@"result"]) compare:@"0"] == NSOrderedSame) {
            [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
        }else if ([((NSString *)[wParam.userInfo valueForKey:@"result"]) compare:@"1"] == NSOrderedSame) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"密码找回失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
            [alert show];
        }else if ([((NSString *)[wParam.userInfo valueForKey:@"result"]) compare:@"2"] == NSOrderedSame) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您输入的用户名不存在！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
            [alert show];
        }else if ([((NSString *)[wParam.userInfo valueForKey:@"result"]) compare:@"3"] == NSOrderedSame) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您注册的手机号码有误！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
            [alert show];
        }
    }
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

@end
