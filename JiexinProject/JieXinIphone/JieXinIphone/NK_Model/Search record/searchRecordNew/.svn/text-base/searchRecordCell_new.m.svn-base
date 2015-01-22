//
//  searchRecordCell_new.m
//  JieXinIphone
//
//  Created by macOne on 14-5-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "searchRecordCell_new.h"

@implementation searchRecordCell_new

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


-(void)fillValue:(NSDictionary *)dic
{
    
    _view_background = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 200)];
    _view_background.backgroundColor = [UIColor colorWithRed:249.0f / 255.0f green:249.0f / 255.0f blue:249.0f / 255.0f alpha:1.0];
    _view_background.layer.borderColor = [UIColor grayColor].CGColor;
    _view_background.layer.borderWidth = 0.5;
    _view_background.layer.cornerRadius = 10.0f;
    [self addSubview:_view_background];
    //
    _label_01 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 280, 20)];
    _label_01.backgroundColor = [UIColor clearColor];
    _label_01.textColor = [UIColor blackColor];
    _label_01.font = [UIFont systemFontOfSize:16];
    _label_01.textAlignment = UITextAlignmentLeft;
    _label_01.text = [NSString stringWithFormat:@"名称:%@",[dic valueForKey:@"filename"]];
    [_label_01 setNumberOfLines:0];
//    _label_01.lineBreakMode = NSLineBreakByWordWrapping;
    _label_01.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize titleSize1 = [_label_01.text sizeWithFont:_label_01.font constrainedToSize:CGSizeMake(_label_01.frame.size.width, MAXFLOAT) lineBreakMode:_label_01.lineBreakMode];
    [_label_01 setFrame:CGRectMake(_label_01.frame.origin.x, _label_01.frame.origin.y, _label_01.frame.size.width, titleSize1.height)];
    [_view_background addSubview:_label_01];
    //
    _label_02 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_01.frame.origin.y+_label_01.frame.size.height+5, 280, 20)];
    _label_02.backgroundColor = [UIColor clearColor];
    _label_02.textColor = [UIColor blackColor];
    _label_02.font = [UIFont systemFontOfSize:16];
    _label_02.textAlignment = UITextAlignmentLeft;
    _label_02.text = [NSString stringWithFormat:@"编号:%@",[dic valueForKey:@"filenum"]];
    [_label_02 setNumberOfLines:0];
//    _label_02.lineBreakMode = NSLineBreakByWordWrapping;
    _label_02.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize titleSize2 = [_label_02.text sizeWithFont:_label_02.font constrainedToSize:CGSizeMake(_label_02.frame.size.width, MAXFLOAT) lineBreakMode:_label_02.lineBreakMode];
    [_label_02 setFrame:CGRectMake(_label_02.frame.origin.x, _label_02.frame.origin.y, _label_02.frame.size.width, titleSize2.height)];
    [_view_background addSubview:_label_02];
    //
//    _label_03 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_02.frame.origin.y+_label_02.frame.size.height+5, 280, 20)];
//    _label_03.backgroundColor = [UIColor clearColor];
//    _label_03.textColor = [UIColor lightGrayColor];
//    _label_03.font = [UIFont boldSystemFontOfSize:15];
//    _label_03.textAlignment = UITextAlignmentCenter;
//    _label_03.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"fileid"]];
//    [_view_background addSubview:_label_03];
    //
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
    imageV.frame = CGRectMake(0, _label_02.frame.origin.y+_label_02.frame.size.height+4, 300, 1);
    [_view_background addSubview:imageV];
    //
    _label_04 = [[UILabel alloc]initWithFrame:CGRectMake(10, imageV.frame.origin.y+imageV.frame.size.height+5, 280, 20)];
    _label_04.backgroundColor = [UIColor clearColor];
    _label_04.textColor = [UIColor blackColor];
    _label_04.font = [UIFont systemFontOfSize:16];
    _label_04.textAlignment = UITextAlignmentLeft;
    [_view_background addSubview:_label_04];
    //
    _label_05 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_04.frame.origin.y+_label_04.frame.size.height+5, 280, 20)];
    _label_05.backgroundColor = [UIColor clearColor];
    _label_05.textColor = [UIColor blackColor];
    _label_05.font = [UIFont systemFontOfSize:16];
    _label_05.textAlignment = UITextAlignmentLeft;
    [_view_background addSubview:_label_05];
    //
    _label_06 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_05.frame.origin.y+_label_05.frame.size.height+5, 280, 20)];
    _label_06.backgroundColor = [UIColor clearColor];
    _label_06.textColor = [UIColor blackColor];
    _label_06.font = [UIFont systemFontOfSize:16];
    _label_06.textAlignment = UITextAlignmentLeft;
    [_view_background addSubview:_label_06];
    //
    _label_07 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_06.frame.origin.y+_label_06.frame.size.height+5, 280, 20)];
    _label_07.backgroundColor = [UIColor clearColor];
    _label_07.textColor = [UIColor blackColor];
    _label_07.font = [UIFont systemFontOfSize:16];
    _label_07.textAlignment = UITextAlignmentLeft;
    [_view_background addSubview:_label_07];
    //
    _label_08 = [[UILabel alloc]initWithFrame:CGRectMake(10, _label_07.frame.origin.y+_label_07.frame.size.height+5, 280, 20)];
    _label_08.backgroundColor = [UIColor clearColor];
    _label_08.textColor = [UIColor blackColor];
    _label_08.font = [UIFont systemFontOfSize:16];
    _label_08.textAlignment = UITextAlignmentLeft;
    [_view_background addSubview:_label_08];
    
    [_view_background setFrame:CGRectMake(_view_background.frame.origin.x, _view_background.frame.origin.y, _view_background.frame.size.width, _label_08.frame.origin.y+_label_08.frame.size.height+10)];
//    NSLog(@"高度=%f",_view_background.frame.size.height);

    _label_04.text = [NSString stringWithFormat:@"年度:%@",[dic valueForKey:@"year"]];
    _label_05.text = [NSString stringWithFormat:@"存放位置:%@",[dic valueForKey:@"place"]];
    _label_06.text = [NSString stringWithFormat:@"是否归档:%@",[dic valueForKey:@"iftwo"]];
    _label_07.text = [NSString stringWithFormat:@"保存期限:%@",[dic valueForKey:@"deadline"]];
    _label_08.text = [NSString stringWithFormat:@"文档类型:%@",[dic valueForKey:@"type"]];
    
//    NSString *msg_title = [tmp_dic valueForKey:@"title"];
//    
//    NSDateFormatter *dateformat_01 = [[[NSDateFormatter alloc] init] autorelease];
//    NSDateFormatter *dateformat_02 = [[[NSDateFormatter alloc] init] autorelease];
//    [dateformat_01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateformat_02 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//    
//    _view_01 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 290, 70)];
//    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
//    [self.view_01.layer setBorderWidth:1.0f];
//    [self.view_01.layer setCornerRadius:5.0f];
//    [self addSubview:_view_01];
//    
//    _label_01 = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, 240, 21)];
//    _label_01.backgroundColor = [UIColor clearColor];
//    _label_01.font = [UIFont systemFontOfSize:17.0];
//    _label_01.textColor = [UIColor blackColor];
//    //    _label_01.textColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0];
//    
//    [_label_01 setText:msg_title];
//    [_label_01 setNumberOfLines:0];
//    _label_01.lineBreakMode = NSLineBreakByWordWrapping;
//    CGSize titleSize = [_label_01.text sizeWithFont:_label_01.font constrainedToSize:CGSizeMake(_label_01.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    [_label_01 setFrame:CGRectMake(_label_01.frame.origin.x, _label_01.frame.origin.y, _label_01.frame.size.width, titleSize.height)];
//    [_view_01 addSubview:_label_01];
//
//    
//    UIImageView *imageView_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uitableviewcell_06_image_01"]];
//    [imageView_arrow setFrame:CGRectMake(270, _label_01.frame.origin.y+4, 15, 15)];
//    [_view_01 addSubview:imageView_arrow];
//    
//    [_view_01 setFrame:CGRectMake(_view_01.frame.origin.x, _view_01.frame.origin.y, _view_01.frame.size.width, _label_01.frame.size.height+_label_01.frame.origin.y+15)];
//    
//    //    _redPoint = [[[UIView alloc]initWithFrame:CGRectMake(_view_01.frame.origin.x-6,_view_01.frame.origin.y-6, 12, 12)]autorelease];
//    //    [_redPoint.layer setCornerRadius:6.0];
//    ////    redPoint.tag = view_tmp.tag+1;
//    //    _redPoint.backgroundColor=[UIColor redColor];
//    //    [self addSubview:_redPoint];
//    
//    UIButton *button_action = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button_action setFrame:CGRectMake(0, 0, _view_01.frame.size.width, _view_01.frame.size.height)];
//    [button_action addTarget:self action:@selector(click_action) forControlEvents:UIControlEventTouchUpInside];
//    [_view_01 addSubview:button_action];
//    
//    //    NSLog(@"_view_01.frame.size.height=%f",_view_01.frame.size.height);
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
