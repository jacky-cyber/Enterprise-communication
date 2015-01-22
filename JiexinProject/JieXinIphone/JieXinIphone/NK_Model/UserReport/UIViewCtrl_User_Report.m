//
//  UIViewCtrl_User_Report.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewCtrl_User_Report.h"

@interface UIViewCtrl_User_Report ()

@end

@implementation UIViewCtrl_User_Report

@synthesize textview_01 = _textview_01;
@synthesize button_01 = _button_01;
@synthesize label_01 = _label_01;

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
    [self.textview_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.textview_01.layer setBorderWidth:1.0f];
    [self.textview_01.layer setCornerRadius:5.0f];
    
    UIImage *image_01 = [UIImage imageNamed:@"uiview_user_report_pressed.png"];
    [self.button_01 setImage:image_01 forState:UIControlStateHighlighted];
    
    bTextIsEmpty = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"Feedback" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label UITextViewDelegate Methods


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(bTextIsEmpty == YES){
        [textView setText:@""];
    }
    
    [self.textview_01 setTextColor:[UIColor blackColor]];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(bTextIsEmpty == YES){
        [textView setTextColor:[UIColor colorWithRed:191.0f / 255.0f green:191.0f / 255.0f blue:191.0f / 255.0f alpha:1.0f]];
        [textView setText:@"请在此输入您的意见或建议"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger mTxtCount = [textView.text length];
    
    if (mTxtCount < 100) {
        return YES;
    }else{
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
     NSInteger mTxtCount = [textView.text length];
    [self.label_01 setText:[NSString stringWithFormat:@"%@/100", [NSNumber numberWithInteger:mTxtCount]]];
    
    if (mTxtCount > 0) {
        bTextIsEmpty = NO;
    }else{
        bTextIsEmpty = YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma label -
#pragma label UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)Close_KeyBoard:(id)sender{
    [self.view endEditing:YES];
}

- (IBAction)onBtnClear_Click:(id)sender{
    [self.textview_01 setText:@""];
    [self.label_01 setText:@"0/100"];
    bTextIsEmpty = YES;
    [self.textview_01 setTextColor:[UIColor colorWithRed:191.0f / 255.0f green:191.0f / 255.0f blue:191.0f / 255.0f alpha:1.0f]];
    [self.textview_01 setText:@"请在此输入您的意见或建议"];
}

- (IBAction)onBtnSubmit_Click:(id)sender
{
    if ([[self.textview_01 text] length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能提交空内容！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSString *info = [NSString stringWithFormat:@"<![CDATA[%@]]>", [self.textview_01 text]];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd": @"Feedback"}, @{@"info": info}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您反馈的意见已经成功记录，感谢您对我们的支持！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
}

- (void)receiveDataNotification:(NSNotification *)wParam
{
    if ([wParam.name compare:@"Feedback"] == NSOrderedSame) {
        
        
    }
}

@end
