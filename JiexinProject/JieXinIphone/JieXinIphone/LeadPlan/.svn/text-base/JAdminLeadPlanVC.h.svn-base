//
//  JAdminLeadPlanVC.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "JButton.h"
#import "JTitleLabel.h"
#import "JCheckUser.h"
#import "JDatePickerView.h"
#import "JReceiceLeadPlan.h"

@interface JAdminLeadPlanVC : BaseViewController<UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,JDatePickerViewDelegate>{
    int selectPlanType;//会议类型
    int sureTime;//是否为确定时间
    int selectPonson[20];
    int currentTimeSelect;//当前选择的时间
    BOOL isEditLeadPlan;
}
@property(nonatomic,copy)NSString*UpdateMessage;
@property(nonatomic,retain)JCheckUser *checkUser;
@property(nonatomic,retain)JReceiceLeadPlan *leadPlan;
@property(nonatomic,retain)UIScrollView *mainBgView;
@property(nonatomic,copy)NSString* currentStartTime,*currentEndTime;
-(void)loadAddLeadPlan;
- (void)onBtnReturn_Click;
@end
