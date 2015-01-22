//
//  UIViewCtrl_Software_Status.h
//  JieXinIphone
//
//  Created by gabriella on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_Software_Status : FrameBaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger m_nSelIndex;
}

@property (strong, nonatomic) NSString *m_sAutoReplayText;

@property (assign, nonatomic) IBOutlet UITableView *tableview_01;
@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UILabel *label_02;

- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction)onBtnAutoReply_Click:(id)sender;

@end
