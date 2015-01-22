//
//  searchRecordCell_new.h
//  JieXinIphone
//
//  Created by macOne on 14-5-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchRecordCell_new : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *label_01;
@property (retain, nonatomic) IBOutlet UILabel *label_02;
@property (retain, nonatomic) IBOutlet UILabel *label_03;
@property (retain, nonatomic) IBOutlet UILabel *label_04;
@property (retain, nonatomic) IBOutlet UILabel *label_05;
@property (retain, nonatomic) IBOutlet UILabel *label_06;
@property (retain, nonatomic) IBOutlet UILabel *label_07;
@property (retain, nonatomic) IBOutlet UILabel *label_08;
@property (retain, nonatomic) IBOutlet UIView *view_background;

@property (assign, nonatomic) IBOutlet UITableView *tableview_01;


//-(void)click_action;
@property (retain, nonatomic) NSDictionary *dictionary;

-(void)fillValue:(NSDictionary *)dic;

@end
