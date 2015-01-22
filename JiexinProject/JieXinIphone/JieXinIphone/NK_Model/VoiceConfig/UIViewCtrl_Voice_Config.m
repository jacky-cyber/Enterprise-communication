//
//  UIViewCtrl_Voice_Config.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "UIViewCtrl_Voice_Config.h"
#import "AppDelegate.h"
#import "PlaySound.h"

@interface UIViewCtrl_Voice_Config ()

@end

@implementation UIViewCtrl_Voice_Config

@synthesize image_01 = _image_01;
@synthesize image_02 = _image_02;
@synthesize image_03 = _image_03;
@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize button_03 = _button_03;
@synthesize button_04 = _button_04;
@synthesize button_05 = _button_05;
@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize view_03 = _view_03;
@synthesize switch_01 = _switch_01;
@synthesize switch_02 = _switch_02;
@synthesize player = player;

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
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];
    
    [self.view_03.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_03.layer setBorderWidth:1.0f];
    [self.view_03.layer setCornerRadius:5.0f];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsPalySound])
    {
        self.switch_01.on =YES;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    else
    {
        self.switch_01.on = NO;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsCanShake])
    {
        self.switch_02.on = YES;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    else
    {
        self.switch_02.on = NO;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }

    
    NSString *soundPath = [[NSUserDefaults standardUserDefaults] objectForKey:kSoundPath];
    if ([soundPath isEqualToString:@"office"]) {
        [self.image_01 setHidden:NO];
        [self.image_02 setHidden:YES];
        [self.image_03 setHidden:YES];

    }
    else if ([soundPath isEqualToString:@"classic"])
    {
        [self.image_01 setHidden:YES];
        [self.image_02 setHidden:NO];
        [self.image_03 setHidden:YES];
    }
    else
    {
        [self.image_01 setHidden:YES];
        [self.image_02 setHidden:YES];
        [self.image_03 setHidden:NO];

    }

    
    [self soundAlertSwitch:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods

-(void)Sound:(NSString *)soundName Type:(NSString *)type
{
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:soundName ofType:type];
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath];
    player=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [player prepareToPlay];
    [soundUrl release];
    [player play];
}

- (IBAction)onBtnSelectVoice_Click:(id)sender
{
    if (sender == [self button_01]) {
        [self.image_01 setHidden:NO];
        [self.image_02 setHidden:YES];
        [self.image_03 setHidden:YES];
        [self Sound:@"office" Type:@"mp3"];
        [[NSUserDefaults standardUserDefaults] setValue:@"office" forKey:kSoundPath];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [PlaySound sharedService].soundPath = @"office";
    }else if (sender == [self button_02]){
        [self.image_01 setHidden:YES];
        [self.image_02 setHidden:NO];
        [self.image_03 setHidden:YES];
        [self Sound:@"classic" Type:@"mp3"];
        [[NSUserDefaults standardUserDefaults] setValue:@"classic" forKey:kSoundPath];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [PlaySound sharedService].soundPath = @"classic";

    }else if (sender == [self button_03]){
        [self.image_01 setHidden:YES];
        [self.image_02 setHidden:YES];
        [self.image_03 setHidden:NO];
        AudioServicesPlayAlertSound(1007);
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kSoundPath];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [PlaySound sharedService].soundPath = nil;


    }
    
}

- (void)dealloc {
    [_soundTypeLab release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSoundTypeLab:nil];
    [super viewDidUnload];
}

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)soundAlertSwitch:(id)sender {
    
      CGRect rect = self.view_03.frame;
    if(self.switch_01.on == NO)
    {
        self.view_02.hidden = YES;
        self.soundTypeLab.hidden = YES;
        [self.view_03 setFrame:CGRectMake(rect.origin.x, 62.0f, rect.size.width, rect.size.height)];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsPalySound];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    else
    {
        self.view_02.hidden = NO;
        self.soundTypeLab.hidden = NO;
        [self.view_03 setFrame:CGRectMake(rect.origin.x, 229.0f, rect.size.width, rect.size.height)];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsPalySound];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_04 setBackgroundImage:image_01 forState:UIControlStateHighlighted];

    }
}

- (IBAction)aibrationAlertSwitch:(id)sender{
    if(((UISwitch *)sender).on == YES){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsCanShake];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsCanShake];
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_05 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction) onBtnSwitchSkin_Click:(id)sender{
    if (sender == self.button_04) {
        self.switch_01.on = !self.switch_01.on;
        
        [self soundAlertSwitch:self.switch_01];
    }else if (sender == self.button_05) {
        self.switch_02.on = !self.switch_02.on;
        
        [self aibrationAlertSwitch:self.switch_02];
    }
    
}


@end
