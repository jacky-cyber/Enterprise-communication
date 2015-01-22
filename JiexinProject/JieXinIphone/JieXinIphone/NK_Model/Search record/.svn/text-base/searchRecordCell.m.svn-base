//
//  searchRecordCell.m
//  JieXinIphone
//
//  Created by macOne on 14-4-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "searchRecordCell.h"

@implementation searchRecordCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) fillValue:(NSDictionary *) dic
{
    _view_background.layer.cornerRadius = 10.0f;
    _label_01.text = [NSString stringWithFormat:@"名称:%@",[dic valueForKey:@"filename"]];
    _label_02.text = [NSString stringWithFormat:@"编号:%@",[dic valueForKey:@"filenum"]];
    _label_03.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"fileid"]];
    _label_04.text = [NSString stringWithFormat:@"年度:%@",[dic valueForKey:@"year"]];
    _label_05.text = [NSString stringWithFormat:@"存放位置:%@",[dic valueForKey:@"place"]];
    _label_06.text = [NSString stringWithFormat:@"是否归档:%@",[dic valueForKey:@"iftwo"]];
    _label_07.text = [NSString stringWithFormat:@"保存期限:%@",[dic valueForKey:@"deadline"]];
    _label_08.text = [NSString stringWithFormat:@"文档类型:%@",[dic valueForKey:@"type"]];
}

- (void)dealloc {
    [_label_01 release];
    [_label_02 release];
    [_label_03 release];
    [_label_04 release];
    [_label_05 release];
    [_label_06 release];
    [_label_07 release];
    [_label_08 release];
    [_view_background release];
    [super dealloc];
}
@end
