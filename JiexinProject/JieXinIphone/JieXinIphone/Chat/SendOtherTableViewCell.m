//
//  SendOtherTableViewCell.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-13.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SendOtherTableViewCell.h"
#import "SynUserIcon.h"
#import "ChatDataHelper.h"

@implementation SendOtherTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imageView.image = UIImageWithName(@"headImage.png");
        self.headImageView = imageView;
        [imageView release];
        [self.contentView addSubview:_headImageView];

        self.relativeNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+3, 15, 170, 20)] autorelease];
        _relativeNameLabel.backgroundColor = [UIColor clearColor];
        _relativeNameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_relativeNameLabel];

        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSendOtherCellHeight-1, kScreen_Width, 1)];
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
    _relativeNameLabel.text = feed.relativeName;
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

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
