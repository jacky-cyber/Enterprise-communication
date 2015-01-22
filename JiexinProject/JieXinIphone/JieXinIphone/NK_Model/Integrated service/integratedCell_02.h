//
//  integratedCell_02.h
//  JieXinIphone
//
//  Created by macOne on 14-5-6.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integratedCell_02 : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UILabel *label_02;
@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UITableView *tableview_01;

-(void)click_action;

-(void)fillValue:(NSDictionary *)tmp_dic;

@end
