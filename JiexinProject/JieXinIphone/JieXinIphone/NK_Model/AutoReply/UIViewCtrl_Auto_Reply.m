//
//  UIViewCtrl_Auto_Reply.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Auto_Reply.h"
#import "AppDelegate.h"
#import "UIViewCtrl_Auto_Replay_Msg.h"
#import "NGLABAL_DEFINE.h"

@interface UIViewCtrl_Auto_Reply ()

@end

@implementation UIViewCtrl_Auto_Reply

@synthesize imageview_05 = _imageview_05;
@synthesize imageview_06 = _imageview_06;
@synthesize imageview_07 = _imageview_07;

@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize button_03 = _button_03;
@synthesize button_04 = _button_04;

@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;
@synthesize label_03 = _label_03;
@synthesize label_04 = _label_04;
@synthesize switch_01 = _switch_01;

@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize view_03 = _view_03;
@synthesize view_04 = _view_04;

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
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];
    
    [self.view_03.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_03.layer setBorderWidth:1.0f];
    [self.view_03.layer setCornerRadius:5.0f];

    [self.view_04.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_04.layer setBorderWidth:1.0f];
    [self.view_04.layer setCornerRadius:5.0f];
    
    [self.imageview_06 setHidden:YES];
    [self.imageview_07 setHidden:YES];
    
//#define kEnableAutoReplay    @"kEnableAutoReplay"
//#define kAutoReplayTmpId     @"kAutoReplayTmpId"
//#define kAutoReplayText      @"kAutoReplayText"
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:kEnableAutoReplay]);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kEnableAutoReplay] == nil)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:kEnableAutoReplay];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kEnableAutoReplay] boolValue] == YES) {
        [self.view_01 setHidden:NO];
        [self.view_02 setHidden:NO];
        [self.view_03 setHidden:NO];
        [self.label_04 setFrame:CGRectMake(self.label_04.frame.origin.x, 320.0f, self.label_04.frame.size.width, self.label_04.frame.size.height)];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        self.switch_01.on = YES;
    }else{
        [self.view_01 setHidden:YES];
        [self.view_02 setHidden:YES];
        [self.view_03 setHidden:YES];
        [self.label_04 setFrame:CGRectMake(self.label_04.frame.origin.x, 100.0f, self.label_04.frame.size.width, self.label_04.frame.size.height)];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        self.switch_01.on = NO;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayTmpId] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:1] forKey:kAutoReplayTmpId];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayTmpId] integerValue] == 1) {
        [self.imageview_05 setHidden:NO];
        [self.imageview_06 setHidden:YES];
        [self.imageview_07 setHidden:YES];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayTmpId] integerValue] == 2) {
        [self.imageview_05 setHidden:YES];
        [self.imageview_06 setHidden:NO];
        [self.imageview_07 setHidden:YES];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayTmpId] integerValue] == 3) {
        [self.imageview_05 setHidden:YES];
        [self.imageview_06 setHidden:YES];
        [self.imageview_07 setHidden:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayText] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"您好，我现在不方便回复，稍后再和您联系！" forKey:kAutoReplayText];
    }
    
    [self.label_03 setText:[[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayText]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:PARAMTER_KEY_NOTIFY_RELOAD_DATA object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnSelectText_Click:(id)sender
{
    if (sender == self.button_01) {
        [self.imageview_05 setHidden:NO];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:1] forKey:kAutoReplayTmpId];
    }else{
        [self.imageview_05 setHidden:YES];
    }
    
    if (sender == self.button_02) {
        [self.imageview_06 setHidden:NO];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:2] forKey:kAutoReplayTmpId];
    }else{
        [self.imageview_06 setHidden:YES];
    }
    
    if (sender == self.button_03) {
        [self.imageview_07 setHidden:NO];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:3] forKey:kAutoReplayTmpId];
        UIViewCtrl_Auto_Replay_Msg *tmp_view = [[[UIViewCtrl_Auto_Replay_Msg alloc] initWithNibName:@"UIViewCtrl_Auto_Replay_Msg" bundle:nil] autorelease];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }else{
        [self.imageview_07 setHidden:YES];
    }
}

- (IBAction) onBtnSwitchSkin_Click:(id)sender{
    self.switch_01.on = !self.switch_01.on;
    
    [self onSwitchAutoReplay_ValueChange:self.switch_01];
}

- (IBAction)onSwitchAutoReplay_ValueChange:(id)sender
{
   
    UISwitch *tmp_switch = sender;
    if (tmp_switch.on ==YES) {
        [self.view_01 setHidden:NO];
        [self.view_02 setHidden:NO];
        [self.view_03 setHidden:NO];
        [self.label_04 setFrame:CGRectMake(self.label_04.frame.origin.x, 320.0f, self.label_04.frame.size.width, self.label_04.frame.size.height)];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }else{
        [self.view_01 setHidden:YES];
        [self.view_02 setHidden:YES];
        [self.view_03 setHidden:YES];
        [self.label_04 setFrame:CGRectMake(self.label_04.frame.origin.x, 100.0f, self.label_04.frame.size.width, self.label_04.frame.size.height)];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:tmp_switch.on] forKey:kEnableAutoReplay];
}


- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:PARAMTER_KEY_NOTIFY_RELOAD_DATA] == NSOrderedSame) {
        [self.label_03 setText:[[NSUserDefaults standardUserDefaults] objectForKey:kAutoReplayText]];
    }
}

@end
