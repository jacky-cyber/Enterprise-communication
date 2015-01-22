//
//  UIViewCtrl_Message_Config.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_Message_Config : FrameBaseViewController

@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UIView *view_02;
@property (assign, nonatomic) IBOutlet UIView *view_03;
@property (assign, nonatomic) IBOutlet UISwitch *switch_01;
@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UIButton *button_02;
@property (assign, nonatomic) IBOutlet UIScrollView *scrollview_01;
@property (retain, nonatomic) IBOutlet UISwitch *groupMessageSwitch;
@property (strong, nonatomic) NSMutableArray *arrgroupinfo;

- (IBAction) onBtnReturn_Click:(id)sender;
- (IBAction) onSwtich_ValueChange:(id) sender;
- (IBAction) onBtnSwitchSkin_Click:(id)sender;
- (void)requestGroupList;
- (void)receiveGroupListDataNotification:(NSNotification *)notification;
- (void)insertGroupToDB:(NSDictionary *)dic;
- (void)updateDB:(NSDictionary *)dic;

@end
