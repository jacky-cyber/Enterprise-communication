//
//  UIViewCtrl_My_Signature.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-2-26.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "AppDelegate.h"
#import "NGLABAL_DEFINE.h"
#import "UIViewCtrl_My_Signature.h"
#import "SynUserInfo.h"
#import "FMDatabase.h"

@interface UIViewCtrl_My_Signature ()

@end

@implementation UIViewCtrl_My_Signature

@synthesize textview_01 = _textview_01;
@synthesize m_sSignatureText = _m_sSignatureText;

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
    [self.textview_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.textview_01.layer setBorderWidth:1.0f];
    [self.textview_01.layer setCornerRadius:5.0f];
    [self.textview_01 setText:[[NSUserDefaults standardUserDefaults] valueForKey:kUserSignature]];
    if ([[self.textview_01 text] length] < 1) {
        [self.textview_01 setText:@"这个人很懒，什么也没留下！"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFinish_Click:(id)sender
{
    NSMutableDictionary *wParam = [[[NSMutableDictionary alloc] init] autorelease];
    [wParam setValue:self.textview_01.text forKey:PARAMTER_KEY_SIGNATURE_TEXT];
    [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_SIGNATURE_TXTCHG object:wParam];
   
    [[NSUserDefaults standardUserDefaults] setValue:self.textview_01.text forKey:kUserSignature];
    
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *sqlStr = @"update im_users set field_char1=? where userid=?";
    [distanceDataBase executeUpdate:sqlStr, self.textview_01.text, userid];
    
    [distanceDataBase close];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"signature":self.textview_01.text},@{@"cmd": @"MODIFY_SIGNATURE"}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
     [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
    
    
}

- (IBAction)Close_KeyBoard:(id)sender{
    [self.view endEditing:YES];
}

- (void)ON_COMMAND:(NSDictionary *)wParam
{
    
    NSInteger nCommandId = [[wParam valueForKey:PARAMTER_KEY_COMMAND_ID] integerValue];
    if (nCommandId == COMMAND_INITIALIZE_USER_INFORMATIOIN) {
        NSString *sSignatureText = [wParam valueForKey:PARAMTER_KEY_SIGNATURE_TEXT];
        
        if (sSignatureText != nil) {
            self.m_sSignatureText = sSignatureText;
        }
        
    }
    
}


@end
