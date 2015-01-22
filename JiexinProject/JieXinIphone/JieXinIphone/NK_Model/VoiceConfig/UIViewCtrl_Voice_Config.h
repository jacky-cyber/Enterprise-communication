//
//  UIViewCtrl_Voice_Config.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface UIViewCtrl_Voice_Config : FrameBaseViewController

@property (assign, nonatomic) IBOutlet UIImageView *image_01;
@property (assign, nonatomic) IBOutlet UIImageView *image_02;
@property (assign, nonatomic) IBOutlet UIImageView *image_03;
@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UIButton *button_02;
@property (assign, nonatomic) IBOutlet UIButton *button_03;
@property (assign, nonatomic) IBOutlet UIButton *button_04;
@property (assign, nonatomic) IBOutlet UIButton *button_05;
@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UIView *view_02;
@property (assign, nonatomic) IBOutlet UIView *view_03;
@property (assign, nonatomic) IBOutlet UISwitch *switch_01;
@property (assign, nonatomic) IBOutlet UISwitch *switch_02;
@property (retain, nonatomic) IBOutlet UILabel *soundTypeLab;
@property (retain,nonatomic) AVAudioPlayer *player;

- (IBAction)onBtnSelectVoice_Click:(id)sender;
- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction) onBtnSwitchSkin_Click:(id)sender;
- (IBAction)soundAlertSwitch:(id)sender;
- (IBAction)aibrationAlertSwitch:(id)sender;


@end
