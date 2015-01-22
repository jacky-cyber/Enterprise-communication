//
//  JFinanicaCell.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTitleLabel.h"
@interface JFinanicaCell : UITableViewCell
@property(nonatomic,retain)JTitleLabel *titleLabe,*dateLabel,*contentLabel;
@property(nonatomic,retain)UIView *baseView;

-(void)settitle:(NSString*)title date:(NSString*)date content:(NSString*)content;
@end
