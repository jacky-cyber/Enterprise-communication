//
//  JFinanicaCell.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JFinanicaCell.h"

@implementation JFinanicaCell
@synthesize titleLabe,dateLabel,contentLabel,baseView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addinitSubView];
    }
    return self;
}
-(void)addinitSubView{
    baseView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300,self.height)];
   self. baseView.layer.borderColor=[RGBCOLOR(193, 193, 193)CGColor];
    self.baseView.layer.borderWidth=0.8f;
    self.baseView.layer.cornerRadius=5.0f;
    [self addSubview:self.baseView];
    
    titleLabe=[[JTitleLabel alloc]initJTitleLabel:nil   rect:CGRectZero fontSize:17 fontColor:nil];
    self.titleLabe.textAlignment=NSTextAlignmentLeft;
    [self.titleLabe setNumberOfLines:0];
    [baseView addSubview:self.titleLabe];
    
    dateLabel=[[JTitleLabel alloc]initJTitleLabel:nil  rect:CGRectZero fontSize:12 fontColor:RGBCOLOR(117, 117, 117)];
    [self.dateLabel setNumberOfLines:1];
    self.dateLabel.textAlignment=NSTextAlignmentLeft;
    [baseView addSubview:self.dateLabel];
    
    contentLabel=[[JTitleLabel alloc]initJTitleLabel:nil  rect:CGRectZero fontSize:15 fontColor:RGBCOLOR(23, 23, 23)];
    [self.contentLabel setNumberOfLines:1];
    self.contentLabel.clipsToBounds=NO;
    self.contentLabel.textAlignment=NSTextAlignmentLeft;
    [baseView addSubview:self.contentLabel];

    //分割线
    UIImageView *fenImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    fenImageView.frame = CGRectMake(5,0, 270, 1);
    [contentLabel addSubview:fenImageView];
    [fenImageView release];
    
    //子定义小箭头
     UIImageView* jiantou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_commit.png"]];
    jiantou.alpha=0.5;
    jiantou.frame = CGRectMake(263, contentLabel.bottom+15, 8, 13);
    [contentLabel addSubview:jiantou];
    [jiantou release];

}
-(void)settitle:(NSString*)title date:(NSString*)date content:(NSString*)content{
    self.titleLabe.frame= CGRectMake(10, 15,270, 0);
    self.titleLabe.text = title;
    [self.titleLabe sizeToFit];
    self.dateLabel.frame=CGRectMake(18, self.titleLabe.bottom+10, 270, 20);
    self.dateLabel.text=[self setTime:date];
    self.contentLabel.frame=CGRectMake(10, self.dateLabel.bottom+10, 260, 40);
    self.contentLabel.text=content;
    self.baseView.frame=CGRectMake(self.baseView.left, self.baseView.top, self.baseView.frame.size.width, self.contentLabel.bottom);
}
-(NSString*)setTime:(NSString*)time{
    time=[time substringToIndex:16];
    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *timeStr=  [dateformat_02 stringFromDate:[dateformat_01 dateFromString:time]];
    return timeStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
-(void)dealloc{
    self.titleLabe=nil;
    self.dateLabel=nil;
    self.contentLabel=nil;
    [super dealloc];
}

@end
