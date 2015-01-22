//
//  UIViewCtrl_Channel_Reply_01.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#define statusBar      (CGFloat)(iOSVersion<7.0? 0:20)

#import "UIViewCtrl_Channel_Reply_01.h"
#import "EmojiKeyBoardView.h"
#import "ASIFormDataRequest.h"
#import "NGLABAL_DEFINE.h"
#import "Emoji_Translation.h"
#import "EmotionView.h"
#import "FaceKeyBoardDeal.h"

@interface UIViewCtrl_Channel_Reply_01 ()<EmojiKeyboardViewDelegate, UITextViewDelegate,EmotionDelegate>

@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UITextView *textview_01;
@property (strong, nonatomic) EmotionView *emojiKeyboardView;
@property (strong, nonatomic) ASIFormDataRequest *request_form;
@property (nonatomic) int selectIndex;

@end

@implementation UIViewCtrl_Channel_Reply_01

@synthesize label_01 = _label_01;
@synthesize view_01 = _view_01;
@synthesize textview_01 = _textview_01;
@synthesize emojiKeyboardView = _emojiKeyboardView;
@synthesize sWeblog_Id = _sWeblog_Id;
@synthesize request_form = _request_form;
@synthesize selectIndex;
@synthesize headImage;

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
    [self.textview_01.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.textview_01.layer setBorderWidth:1.0f];
    [self.textview_01.layer setCornerRadius:5.0f];
    [self.textview_01 becomeFirstResponder];
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTextView:)];
//    [self.textview_01 addGestureRecognizer:tap];
    
    
    selectIndex=0;
    float iosFolat = 0;
    if (IOSVersion>=7.0) {
        iosFolat = 20;
    }
    EmotionView *aEmotion = [[EmotionView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 216-(20-iosFolat), self.view.frame.size.width, 216)];
    aEmotion.hidden = YES;
    aEmotion.delegate = self;
    self.emojiKeyboardView = aEmotion;
    [self.view addSubview:_emojiKeyboardView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillHideNotification object:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setHeadImage:(UIImage *)head{
    headImage=head;
    UIImageView *headImg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 52+statusBar, 32, 32)];
    headImg.image=head;
    
    [self.view addSubview:headImg];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.emojiKeyboardView = nil;
    self.sWeblog_Id = nil;
    self.request_form = nil;
    [super dealloc];
}

#pragma label -
#pragma label UITextViewDelegate Methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"%@",text);
    NSString *str=[NSString stringWithFormat:@"%@%@",textView.text,text];
    
    if(str.length>141){
        NSString *subStr=[str substringToIndex:140];
        textView.text= subStr;
        return NO;
    }
    
    if([text isEqualToString:@""]){
        if ( range.length > 1 || range.location != textView.text.length-1) {
            return YES;
        }else {
            [FaceKeyBoardDeal faceBackDeal:textView];
            [self textViewDidChange:textView];
            return NO;
        }
    }else if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
    }
    return YES;
}


-(void)textViewDidChange:(UITextView *)textView{
    selectIndex=textView.selectedRange.location;
    NSString *str=textView.text;
    
    if(str.length>140){
        str=[str substringToIndex:140];
        textView.text= str;
        selectIndex=140;
    }
    [self.label_01 setText:[NSString stringWithFormat:@"%d / 140",str.length]];
    
}

-(void)clickTextView:(UIGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    self.textview_01.inputView = nil;
    [self.textview_01 becomeFirstResponder];
    
}


#pragma label -
#pragma label EmojiKeyboardViewDelegate Methods

- (void)emojiKeyBoardView:(EmojiKeyBoardView *)emojiKeyBoardView didUseEmoji:(NSString *)emoji {
    
    if ([self.textview_01.text length] + [emoji length] > 140) {
        return;
    }
    [self.textview_01 setText:[NSString stringWithFormat:@"%@%@", [self.textview_01 text], emoji]];
    [self.label_01 setText:[NSString stringWithFormat:@"%@ / 140", [NSNumber numberWithInteger:[self.textview_01.text length]]]];
}

- (void)emojiKeyBoardViewDidPressBackSpace:(EmojiKeyBoardView *)emojiKeyBoardView {
    [self.textview_01 deleteBackward];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFun01_Click:(id)sender
{
//    [self.view endEditing:YES];
//    self.textview_01.inputView = nil;
//    [self.textview_01 becomeFirstResponder];
}

- (IBAction)onBtnFun02_Click:(id)sender
{
    self.emojiKeyboardView.hidden = NO;
    [self.view endEditing:YES];
    
    [self.view_01 setFrame:CGRectMake(self.view_01.frame.origin.x,
                                      self.view_01.frame.origin.y,
                                      self.view_01.frame.size.width,
                                      kScreen_Height - CGRectGetHeight(self.emojiKeyboardView.frame)-10)];
//    self.textview_01.inputView = self.emojiKeyboardView;
//    [self.textview_01 becomeFirstResponder];
}

- (void)selectEmotionFinish:(NSDictionary *)infoDic
{
    NSLog(@"%@",infoDic);
    
    NSString *faceStr=[infoDic objectForKey:@"image"];
    NSString *textStr=self.textview_01.text;
    NSString *str1=[textStr substringToIndex:selectIndex];
    NSString *str2=[textStr substringFromIndex:selectIndex];
    NSString *str3=[NSString stringWithFormat:@"%@%@",str1,faceStr];
    NSString *str4=[NSString stringWithFormat:@"%@%@",str3,str2];
    NSLog(@"%@",str4);
    
    selectIndex+=faceStr.length;
    self.textview_01.selectedRange=NSMakeRange(selectIndex, 0);
    self.textview_01.text=str4;
    
     [self textViewDidChange:self.textview_01];
}


- (IBAction)Close_KeyBroad:(id)sender
{
//    [self.view endEditing:YES];
    [self.textview_01 resignFirstResponder];
}

- (IBAction)onBtnFun03_Click:(id)sender
{
    if ([[self.textview_01 text] length] < 1) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能回复空内容！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }else if ([[self.textview_01 text] length] > 140) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您回复内容的长度不能大于140个字符！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    [[STHUDManager sharedManager] showHUDInView:self.view];
   
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:nil] autorelease];
    [tmp_thread start];
    
}

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:UIKeyboardWillShowNotification] == NSOrderedSame) {
        self.emojiKeyboardView.hidden = YES;
        NSDictionary *info = [wParam userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        [self.view_01 setFrame:CGRectMake(self.view_01.frame.origin.x,
                                          self.view_01.frame.origin.y,
                                          self.view_01.frame.size.width,
                                          kScreen_Height - kbSize.height-10)];
        
    }else if ([[wParam name] compare:UIKeyboardWillHideNotification] == NSOrderedSame) {
   
        [self.view_01 setFrame:CGRectMake(self.view_01.frame.origin.x,
                                          self.view_01.frame.origin.y,
                                          self.view_01.frame.size.width,
                                          self.view.frame.size.height - self.view_01.frame.origin.y)];
    }
}

- (void) THREAD_PROC_01:(id)wParam
{
    
    NSString *headStr1;
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr compare:@"111.11.28.29"] == NSOrderedSame) { //正式全通
        headStr1 = @"http://111.11.28.9:8088/staffCorner/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){ //正式政企
        headStr1 = @"http://111.11.28.9:8088/staffCornerzq/phoneInterface.action";
    } else {
        headStr1 = @"http://111.11.28.30:8091/staffCorner/phoneInterface.action";
    }
    
     NSString *sDestContent=[FaceKeyBoardDeal faceSendStr:self.textview_01.text];
    
    
    NSString *str_userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    NSString *str_nickname = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];
    
    NSMutableData *mt_data = [NSMutableData data];
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"cmd\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", @"publishStatusComment"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"statusId\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", self.sWeblog_Id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"userId\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", str_userid] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"userName\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", str_nickname] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"content\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", sDestContent] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (self.request_form != nil) {
        self.request_form.delegate = nil;
    }
    
    self.request_form = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:headStr1]] autorelease];
    
    [self.request_form setTimeOutSeconds:60.0];
    self.request_form.delegate = self;
    [self.request_form addRequestHeader:@"Accept" value:@"text/html"];
    [self.request_form addRequestHeader:@"Content-Type" value:@"multipart/form-data; boundary=---------------------------7de2821190dec"];
    [self.request_form addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:mt_data.length]]];
    [self.request_form setRequestMethod:@"POST"];
    [self.request_form setPostBody:mt_data];
    [self.request_form startAsynchronous];
    [self.request_form setDidFailSelector:@selector(requestBeFailed:)];
    [self.request_form setDidFinishSelector:@selector(requestBeFinished:)];

}



-(void)requestBeFailed:(ASIFormDataRequest *)sender
{
    
    if (self.view == nil) {
        return;
    }
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"评论回复失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
    [alert show];
   
}
-(void)requestBeFinished:(ASIFormDataRequest *)request
{
    
    if (self.view == nil) {
        return;
    }
    
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:nil];
    if([[dic valueForKey:@"resultcode"] intValue]==0) {
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"评论回复成功！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_REFRESH_DATA object:nil];
        [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
    } else {
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"评论回复失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
    }
}

@end
