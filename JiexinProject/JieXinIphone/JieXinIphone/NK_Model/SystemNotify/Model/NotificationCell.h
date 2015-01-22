//
//  NotificationCell.h
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-6.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationFrame.h"

@interface NotificationCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *bgImage;
@property (nonatomic,strong) UIImageView *lineLabel;
@property (nonatomic,strong) UIImageView *accessImage;

@property (nonatomic,strong) NotificationFrame *notificationFrame;
@end
