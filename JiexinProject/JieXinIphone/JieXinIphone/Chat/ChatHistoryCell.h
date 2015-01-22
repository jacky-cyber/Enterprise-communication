//
//  ChatHistoryCell.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessagesFeed.h"
#import "ChatDataHelper.h"
#import  "BubbleView.h"
#define kHistoryNameFont 15.0
#define kHistoryTimeFont 11.0
#define kHistoryMessageFont 13.0
@interface ChatHistoryCell : UITableViewCell

@property (nonatomic,retain) UILabel *timeAndNameLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain)UILabel *messageLabel;

//@property (nonatomic,)
- (void)setDatas:(ChatMessagesFeed *)feed;
+ (CGFloat)heiForText:(NSString *)txt;
+ (CGSize)textSizeForText:(NSString *)txt;


@end
