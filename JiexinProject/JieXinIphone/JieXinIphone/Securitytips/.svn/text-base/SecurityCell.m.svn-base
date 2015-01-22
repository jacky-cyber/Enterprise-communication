//
//  SecurityCell.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SecurityCell.h"
#import "UIImage-Extensions.h"
@implementation SecurityCell
@synthesize bgImageView,picImageView,title,fengeView,jiantou,yearLable,partmentLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
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
- (void)initSubviews
{
    //
    //内容背景
    UIImage * iamge = [UIImage imageNamed:@"cellbg"];
    bgImageView = [[UIImageView alloc] initWithImage:[iamge stretchableImageWithLeftCapWidth:iamge.size.width/2 topCapHeight:iamge.size.height/2+10]];
    bgImageView.frame = CGRectMake(10,10, 300,picImageViewHeigh+ 80+partmentLableHeigh);
    bgImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:bgImageView];
    NSLog(@"%f%f",self.frame.size.height,bgImageView.frame.size.height);
    picImageView = [[UIImageView alloc]init];
    picImageView.frame = CGRectMake(10, 5, 280 , picImageViewHeigh);
    // picImageView.backgroundColor = [UIColor redColor];
    [bgImageView addSubview:picImageView];
    
    //标题
    title = [[UILabel alloc] initWithFrame:CGRectMake(10,picImageView.height+10,280, 0)];
    [title setNumberOfLines:0];
    title.text = @"";
    title.font = [UIFont systemFontOfSize:17.0];
    title.tag=100;
    // label1.textColor = [UIColor redColor];
    [title sizeToFit];
    [bgImageView addSubview:title];
    
    //分割线
    fengeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    fengeView.frame = CGRectMake(5,bgImageView.height/2, bgImageView.width-10, 1);
    [bgImageView addSubview:fengeView];
    
    
    //子定义小箭头
    jiantou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    jiantou.frame = CGRectMake(280+5, fengeView.bottom-10-title.height/2, 8, 13);
    [bgImageView addSubview:jiantou];
    
    
    
    //发布时间
    yearLable  = [[UILabel alloc] initWithFrame:CGRectZero];
    yearLable.frame = CGRectMake(10, /*jiantou.frame.origin.y-10*/fengeView.bottom+5, 160, 30);
    yearLable.font = [UIFont boldSystemFontOfSize:12.0f];
    //_yeatLaber.textAlignment = NSTextAlignmentCenter;
    yearLable.backgroundColor = [UIColor clearColor];
    yearLable.textColor = [UIColor grayColor];
    [bgImageView addSubview:yearLable];
    
    partmentLable = [[UILabel alloc]initWithFrame:CGRectZero];
    partmentLable.frame = CGRectMake(10, yearLable.bottom+5, 300, partmentLableHeigh-10);
    //partmentLable.text = @"供稿部门:综合部";
    partmentLable.font = [UIFont systemFontOfSize:14.0f];
    partmentLable.backgroundColor = [UIColor clearColor];
    [bgImageView addSubview:partmentLable];
    
}
-(void)setCellWithDic:(NSDictionary*)dic withIamge:(UIImage*)image{
    if ([[dic objectForKey:@"image"] isEqualToString:@"http://111.11.28.30:8087/saferzq/page/titleImg/"]||[[dic objectForKey:@"image"] isEqualToString:@"http://111.11.28.9:8087/saferzq/page/titleImg/"]) {
        picImageView.frame = CGRectMake(10, 5, 280, 0);
        title.frame= CGRectMake(10, 0+10,280, 0);
        [title setNumberOfLines:0];
        title.text = [dic objectForKey:@"titleStr"];
        [title sizeToFit];
        bgImageView.frame = CGRectMake(10,10, 300, 80+title.frame.size.height-20+30);
    }
    else{
        picImageView.frame = CGRectMake(10, 5, 280, image.size.height);
        
        image = [UIImage image:image fitInSize:CGSizeMake(280, image.size.height)];
        [picImageView setImage:image];
        title.frame= CGRectMake(10, picImageView.height+10,280, 0);
        [title setNumberOfLines:0];
        title.text = [dic objectForKey:@"titleStr"];
        [title sizeToFit];
        bgImageView.frame = CGRectMake(10,10, 300, 80+title.frame.size.height-20+image.size.height+30);
    }
    
    fengeView.frame =CGRectMake(5,title.bottom+5, bgImageView.width-10, 1);
    jiantou.frame = CGRectMake(280+5, fengeView.bottom-10-title.height/2, 8, 13);
    yearLable.frame = CGRectMake(10, /*jiantou.frame.origin.y-10*/fengeView.bottom+5, 160, 30);
    yearLable.text = [dic objectForKey:@"time"];
    partmentLable.frame = CGRectMake(10, yearLable.bottom+5, 300, partmentLableHeigh-10);
    partmentLable.text = [NSString stringWithFormat:@"供稿部门:%@", [dic objectForKey:@"partmentLableText"]];
    
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
    
}

@end
