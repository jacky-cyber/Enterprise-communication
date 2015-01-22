//
//  NotificationFrame.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-6.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//



#import "NotificationFrame.h"

@implementation NotificationFrame
@synthesize cellHeight;

-(void)setModel:(NotificationModel *)m{

    _model=m;
    
    
    CGSize titleSize=[m.title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(CellWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];

    _titleRect=CGRectMake(LeftMargin+15, TopLargin, CellWidth, titleSize.height);
    
    _timeRect=CGRectMake(LeftMargin+15, TopLargin+titleSize.height+5, CellWidth, 40);
    
    cellHeight=_titleRect.origin.y+_titleRect.size.height+_timeRect.size.height+15;
}
@end
