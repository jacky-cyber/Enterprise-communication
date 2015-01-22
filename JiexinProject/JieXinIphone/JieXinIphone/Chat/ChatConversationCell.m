//
//  ChatConversationCell.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatConversationCell.h"
#import "SynUserIcon.h"
#import "ChatDataHelper.h"

@implementation ChatConversationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        imageView.image = UIImageWithName(@"headImage.png");
//        imageView.backgroundColor =[UIColor blueColor];
        self.headImageView = imageView;
        [imageView release];
        [self.contentView addSubview:_headImageView];
        
        self.unReadCountLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [_unReadCountLabel setBackgroundColor:[UIColor redColor]];
        _unReadCountLabel.layer.cornerRadius = CGRectGetHeight(_unReadCountLabel.frame)/2;
        _unReadCountLabel.layer.masksToBounds = YES;
        [_unReadCountLabel setTextColor:[UIColor whiteColor]];
        [_unReadCountLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [_unReadCountLabel setTextAlignment:NSTextAlignmentCenter];
        [_headImageView addSubview:_unReadCountLabel];

        
        self.relativeNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+3, 8, 170, 20)] autorelease];
        _relativeNameLabel.backgroundColor = [UIColor clearColor];
        _relativeNameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_relativeNameLabel];
        
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+3, 33, 200, 20)];
        aLabel.font = [UIFont systemFontOfSize:14.f];
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.textColor = [UIColor grayColor];
        self.lastMessageLabel = aLabel;
        [aLabel release];
        [self.contentView addSubview:_lastMessageLabel];

        self.timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(230, 8, 80, 20)] autorelease];
        _timeLabel.font = [UIFont systemFontOfSize:11.0f];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, kChatConCellHeight-1, kScreen_Width, 1)];
        line.image = [UIImage imageNamed:@"chatCellLine.png"];
        [self.contentView addSubview:line];
        [line release];
        // Initialization code
    }
    return self;
}

- (void)setDatas:(ChatConversationListFeed *)feed
{
    NSString *filePath = [self getHeadImagePathAtIndexPath:feed.relativeId];
    if (filePath && [filePath length])
    {
        _headImageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
    else
    {
        _headImageView.image = UIImageWithName(@"headImage.png");
    }
    MessageType type = [self getMessageType:feed.last_message];
    if (type == PicMsg) {
        _lastMessageLabel.text = @"[图片]";
    }else if (type == HeKaMsg)
    {
        _lastMessageLabel.text = @"[贺卡]";
    }else if (type == TextMsg)
    {
        _lastMessageLabel.text = [NSString stringWithFormat:@"%@:%@",feed.fromUserName,feed.last_message];
    }
    
    _relativeNameLabel.text = feed.relativeName;
    NSLog(@"%@",feed.msgDate);
    _timeLabel.text = [self getTimeStr:feed.msgDate];
//    _timeLabel.text = feed.msgDate;
    
    if (feed.unread_count > 0) {
        _unReadCountLabel.hidden = NO;
    }
    else
    {
        _unReadCountLabel.hidden = YES;
    }
//    CGSize badgeSize = [[NSString stringWithFormat:@"%d",feed.unread_count] sizeWithFont:[UIFont systemFontOfSize:15.0f]];
//    if (badgeSize.width < badgeSize.height) {
//        badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
//    }
    CGSize badgeSize = CGSizeMake(6, 6);
    _unReadCountLabel.frame = CGRectMake(CGRectGetWidth(_headImageView.bounds)-badgeSize.width, CGRectGetMinX(_headImageView.bounds)-2, badgeSize.width, badgeSize.height);
//    _unReadCountLabel.text = [NSString stringWithFormat:@"%d",feed.unread_count];
    _unReadCountLabel.layer.cornerRadius = CGRectGetHeight(_unReadCountLabel.frame)/2;
}



- (NSString *)getHeadImagePathAtIndexPath:(NSInteger)relativeId
{
    NSString *filePath  = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[NSString stringWithFormat:@"%d",relativeId]]];
    //不存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        return @"";
    }
    else
    {
        return filePath;
    }
    
}

- (MessageType)getMessageType:(NSString *)msgContent
{
    if ([msgContent rangeOfString:@"%Greeting%"].location != NSNotFound)
    {
        return HeKaMsg;
    }
    else if ([msgContent rangeOfString:@"<MsG-PiCtUre>"].location != NSNotFound)
    {
        return PicMsg;
    }
    else
    {
        return TextMsg;
    }
}


- (NSString *)getTimeStr:(NSString *)time
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *MMFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [MMFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDateFormatter *SSSFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [SSSFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSDate *confromTimesp = [formatter dateFromString:time];
    if (!confromTimesp) {
        confromTimesp = [MMFormatter dateFromString:time];
    }
    if (!confromTimesp)
    {
        confromTimesp = [SSSFormatter dateFromString:time];
    }
    NSDateFormatter *formatter1 = [[[NSDateFormatter alloc] init] autorelease];
    [formatter1 setDateFormat:@"MM-dd HH:mm"];

    
    NSString *confromTimespStr = [formatter1 stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
