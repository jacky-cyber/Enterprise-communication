//
//  FinanciaCell.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-3-31.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "FinanciaCell.h"
#import "ConnetViewController.h"
@implementation FinanciaCell
@synthesize _contentLable,_courseid,_titleLable,_yeatLaber,_title,_connectView,departLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];//初始化子视图
    
//        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边有个小箭头
    }
    return self;
}

- (void)initSubviews
{
//
    //内容背景
    _connectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellbg"]];
    _connectView.frame = CGRectMake(10,10, 300, 80);
    _connectView.userInteractionEnabled=YES;
    [self.contentView addSubview:_connectView];
    NSLog(@"%f%f",self.frame.size.height,_connectView.frame.size.height);
    
    //标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,280, 0)];
    [_title setNumberOfLines:0];
    _title.text = @"";
    _title.font = [UIFont systemFontOfSize:17.0];
    _title.tag=100;
    // label1.textColor = [UIColor redColor];
    [_title sizeToFit];
    [_connectView addSubview:_title];
    
    
    
    //分割线
    _fengeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    _fengeView.frame = CGRectMake(5,_connectView.height/2, _connectView.width-10, 1);
    [_connectView addSubview:_fengeView];
    

    //子定义小箭头
    _jiantou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    _jiantou.frame = CGRectMake(280, _fengeView.bottom+15, 8, 13);
    [_connectView addSubview:_jiantou];
    
    departLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
    departLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    //_yeatLaber.textAlignment = NSTextAlignmentCenter;
    departLabel.backgroundColor = [UIColor clearColor];
    departLabel.textColor = [UIColor grayColor];
    [_connectView addSubview:departLabel];
   
    //发布时间
    _yeatLaber  = [[UILabel alloc] initWithFrame:CGRectZero];
     _yeatLaber.frame = CGRectMake(10, _jiantou.frame.origin.y-10, 160, 30);
    _yeatLaber.font = [UIFont boldSystemFontOfSize:12.0f];
    //_yeatLaber.textAlignment = NSTextAlignmentCenter;
    _yeatLaber.backgroundColor = [UIColor clearColor];
    _yeatLaber.textColor = [UIColor grayColor];
    [_connectView addSubview:_yeatLaber];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellTitle:(NSString*)title andTime:(NSString*)time andDepart:(NSString *)depart{
 
   
    _title.frame= CGRectMake(10, 5,280, 0);
    _title.backgroundColor=[UIColor clearColor];
    [_title setNumberOfLines:0];
    _title.text = title;
    [_title sizeToFit];
    
     _fengeView.frame =CGRectMake(5,_title.bottom+10, _connectView.width-10, 1);
    
    departLabel.frame=CGRectMake(10, _fengeView.frame.origin.y, 310, 30);
    departLabel.text=depart;
    
    _connectView.frame = CGRectMake(10,10, 300, 80+_title.frame.size.height-20);
   
      _jiantou.frame = CGRectMake(280, _fengeView.bottom+15, 8, 13);
     _yeatLaber.frame = CGRectMake(10, departLabel.bottom-14, 160, 30);
    _yeatLaber.text = time;
    
}


-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.font = [UIFont systemFontOfSize:17.0];
    label1.tag=100;
   // label1.textColor = [UIColor redColor];
    [label1 sizeToFit];
    return label1;
}

- (void)dealloc
{
    [super dealloc];
    [_titleLable release],_titleLable = nil;
    [_contentLable release],_contentLable = nil;
    [_yeatLaber release],_yeatLaber = nil;
}

@end
