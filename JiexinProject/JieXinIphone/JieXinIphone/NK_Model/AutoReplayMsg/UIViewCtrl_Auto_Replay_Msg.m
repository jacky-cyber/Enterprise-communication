//
//  UIViewCtrl_Auto_Replay_Msg.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Auto_Replay_Msg.h"
#import "AppDelegate.h"
#import "NGLABAL_DEFINE.h"

@interface UIViewCtrl_Auto_Replay_Msg ()

@end

@implementation UIViewCtrl_Auto_Replay_Msg

@synthesize textview_01 = _textview_01;
@synthesize m_sAutoReplayText = _m_sAutoReplayText;

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
    if(self.m_sAutoReplayText != nil){
        [self.textview_01 setText:self.m_sAutoReplayText];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Do any additional setup after loading the view from its nib.
    self.m_sAutoReplayText = nil;
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFinish_Click:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:self.textview_01.text forKey:kAutoReplayText];
    [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_RELOAD_DATA object:nil];
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)Close_KeyBoard:(id)sender{
    [self.view endEditing:YES];
}

- (void)ON_COMMAND:(NSDictionary *)wParam
{
    NSInteger nCommandId = [[wParam valueForKey:PARAMTER_KEY_COMMAND_ID] integerValue];
    if (nCommandId == COMMAND_INITIALIZE_USER_STATUS) {
        NSInteger nStatus = [[wParam valueForKey:PARAMTER_KEY_USER_STATUS] integerValue];
        NSInteger nAutoReplayStatus = [[wParam valueForKey:PARAMTER_KEY_AUTO_REPLAY_STATUS] integerValue];
        NSInteger nAutoReplayValue = [[wParam valueForKey:PARAMTER_KEY_AUTO_REPLAY_VALUE] integerValue];
        NSString *sAutoReplayText = [wParam valueForKey:PARAMTER_KEY_AUTO_REPLAY_TEXT];
        
        m_nUserStatus = nStatus;
        m_nAutoReplayStatus = nAutoReplayStatus;
        m_nAutoReplayValue = nAutoReplayValue;
        if (sAutoReplayText != nil) {
            self.m_sAutoReplayText = sAutoReplayText;
        }
        
    }
    
}

@end
