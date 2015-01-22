//
//  SendOtherTableViewCell.h
//  JieXinIphone
//
//  Created by liqiang on 14-5-13.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatConversationListFeed.h"

#define kSendOtherCellHeight 50

@interface SendOtherTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *relativeNameLabel;

- (void)setDatas:(ChatConversationListFeed *)feed;


@end
