//
//  UITableViewCell_06.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UITableViewCell_06.h"

@implementation UITableViewCell_06

@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;
@synthesize label_03 = _label_03;
@synthesize label_04 = _label_04;
@synthesize view_01 = _view_01;
@synthesize tableview_01 = _tableview_01;


- (void)awakeFromNib
{
    // Initialization code
 
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    [self.label_01.layer setCornerRadius:5.0f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Custom Method

- (IBAction)onBtnFun01_Click:(id)sender
{
    NSIndexPath *indexPath = [self.tableview_01 indexPathForCell:self];
    if (self.tableview_01.delegate != nil) {
        [self.tableview_01.delegate tableView:self.tableview_01 accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

@end
