//
//  integratedNewCell.m
//  JieXinIphone
//
//  Created by macOne on 14-5-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "integratedNewCell.h"

@implementation integratedNewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)fillValue:(NSDictionary *)tmp_dic
{
    NSString *msg_title = [tmp_dic valueForKey:@"title"];
    
    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    _view_01 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 290, 70)];
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    [self addSubview:_view_01];
    
    _label_01 = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, 240, 21)];
    _label_01.backgroundColor = [UIColor clearColor];
    _label_01.font = [UIFont systemFontOfSize:17.0];
    _label_01.textColor = [UIColor blackColor];
    //    _label_01.textColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0];
    
    [_label_01 setText:msg_title];
    [_label_01 setNumberOfLines:0];
    _label_01.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize titleSize = [_label_01.text sizeWithFont:_label_01.font constrainedToSize:CGSizeMake(_label_01.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [_label_01 setFrame:CGRectMake(_label_01.frame.origin.x, _label_01.frame.origin.y, _label_01.frame.size.width, titleSize.height)];
    [_view_01 addSubview:_label_01];
    
    
    UIImageView *imageView_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uitableviewcell_06_image_01"]];
    [imageView_arrow setFrame:CGRectMake(270, _label_01.frame.origin.y+4, 15, 15)];
    [_view_01 addSubview:imageView_arrow];
    
    [_view_01 setFrame:CGRectMake(_view_01.frame.origin.x, _view_01.frame.origin.y, _view_01.frame.size.width, _label_01.frame.size.height+_label_01.frame.origin.y+15)];
    
//    _redPoint = [[[UIView alloc]initWithFrame:CGRectMake(_view_01.frame.origin.x-6,_view_01.frame.origin.y-6, 12, 12)]autorelease];
//    [_redPoint.layer setCornerRadius:6.0];
////    redPoint.tag = view_tmp.tag+1;
//    _redPoint.backgroundColor=[UIColor redColor];
//    [self addSubview:_redPoint];
    
    UIButton *button_action = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_action setFrame:CGRectMake(0, 0, _view_01.frame.size.width, _view_01.frame.size.height)];
    [button_action addTarget:self action:@selector(click_action) forControlEvents:UIControlEventTouchUpInside];
    [_view_01 addSubview:button_action];
    
//    NSLog(@"_view_01.frame.size.height=%f",_view_01.frame.size.height);
}
-(void)click_action
{
    NSIndexPath *indexPath = [self.tableview_01 indexPathForCell:self];
    if (self.tableview_01.delegate != nil) {
        [self.tableview_01.delegate tableView:self.tableview_01 accessoryButtonTappedForRowWithIndexPath:indexPath];
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
