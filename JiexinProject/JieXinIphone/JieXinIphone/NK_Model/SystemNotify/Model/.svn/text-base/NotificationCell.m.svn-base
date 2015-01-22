//
//  NotificationCell.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-6.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "NotificationCell.h"
#import "NotificationModel.h"
#import "GTMBase64.h"

@implementation NotificationCell
@synthesize timeLabel;
@synthesize titleLabel;
@synthesize lineLabel;
@synthesize bgImage;
@synthesize accessImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        bgImage=[[UIImageView alloc] init];
        bgImage.image=[UIImage imageNamed:@"cellbg"];
        [self.contentView addSubview:bgImage];
        
        titleLabel=[[UILabel alloc] init];
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        lineLabel=[[UIImageView alloc] init];
        lineLabel.image=[UIImage imageNamed:@"chatCellLine"];
        [self.contentView addSubview:lineLabel];
        
        timeLabel=[[UILabel alloc] init];
        timeLabel.font=[UIFont systemFontOfSize:10];
        timeLabel.textColor=[UIColor colorWithRed:98/255.0f green:98/255.0f blue:98/255.0f alpha:1];
        timeLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:timeLabel];
        
        accessImage=[[UIImageView alloc] init];
        accessImage.image=[UIImage imageNamed:@"uitableviewcell_06_image_01"];
        [self.contentView addSubview:accessImage];
    }
    return self;
}

-(void)setNotificationFrame:(NotificationFrame *)Frame{
    
    _notificationFrame=Frame;
    NotificationModel *model  =  Frame.model;
    
    NSString * msg_title = [[NSString alloc] initWithData:[GTMBase64 decodeData:[model.title dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding] ;
    
    titleLabel.text=msg_title;
    titleLabel.frame=Frame.titleRect;
    
    lineLabel.frame=CGRectMake( titleLabel.frame.origin.x-5,  titleLabel.frame.origin.y+ titleLabel.frame.size.height+10, CellWidth-5-5, 1);
    
    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *timeStr=  [dateformat_02 stringFromDate:[dateformat_01 dateFromString:model.time]];
    
    timeLabel.text=timeStr;
    timeLabel.frame=Frame.timeRect;
    
    accessImage.frame=CGRectMake(CellWidth, timeLabel.frame.origin.y+15, 10, 10);
    
    bgImage.frame=CGRectMake(titleLabel.frame.origin.x-5-5, titleLabel.frame.origin.y-5-5, CellWidth, titleLabel.frame.origin.y+titleLabel.frame.size.height+timeLabel.frame.size.height-5);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
