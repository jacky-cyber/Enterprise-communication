//
//  UITableViewCell_06.h
//  JieXinIphone
//
//  Created by gabriella on 14-4-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell_06 : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UILabel *label_02;
@property (assign, nonatomic) IBOutlet UILabel *label_03;
@property (assign, nonatomic) IBOutlet UILabel *label_04;
@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UITableView *tableview_01;

- (IBAction)onBtnFun01_Click:(id)sender;

@end
