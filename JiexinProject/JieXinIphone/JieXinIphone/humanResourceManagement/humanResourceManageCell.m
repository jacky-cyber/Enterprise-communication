//
//  humanResourceManageCell.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "humanResourceManageCell.h"

@implementation humanResourceManageCell

@synthesize titleLabe;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addinitSubView];
    }
    return self;
}
-(void)addinitSubView{
    
    //titleLable
    titleLabe = [[UILabel alloc]init];
    titleLabe.frame = CGRectMake(10, 5, 200, 20);
    
    //子定义小箭头
    UIImageView* arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_commit.png"]];
    arrowView.alpha=0.5;
    arrowView.frame = CGRectMake(263, 5, 8, 13);
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
-(void)dealloc{
    self.titleLabe=nil;
    [super dealloc];
}

@end
