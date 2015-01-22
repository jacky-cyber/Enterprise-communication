//
//  humanResourceManageCell.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "humanResourceLists.h"

@implementation humanResourceLists

@synthesize titleLabe;
@synthesize redLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addinitSubView];
    }
    return self;
}
-(void)addinitSubView{
    
    //    self.layer.borderColor=[RGBCOLOR(200, 200, 200)CGColor];
    //    self.layer.cornerRadius=5.f;
    //    self.layer.borderWidth=0.8f;
    self.backgroundColor=RGBCOLOR(255, 255, 255);
    redLabel=[[UILabel alloc] init];
    redLabel.frame=CGRectMake(0, 0, 10, 10);
    redLabel.hidden=YES;
    redLabel.layer.cornerRadius=5;
    redLabel.layer.masksToBounds = YES;
    redLabel.backgroundColor=[UIColor redColor];
    [self addSubview:redLabel];
    
    self.titleLabe=[[myTitleLabel alloc]initTitleLabel:nil   rect:CGRectZero fontSize:17 fontColor:RGBCOLOR(26, 26,26)];
    self.titleLabe.textAlignment=NSTextAlignmentLeft;
    [self.titleLabe setNumberOfLines:1];
    [self addSubview:self.titleLabe];
    
    //子定义小箭头
    UIImageView* jiantou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_commit.png"]];
    jiantou.tag=323;
    jiantou.frame = CGRectZero;
    jiantou.alpha=0.5;
    [self addSubview:jiantou];
    [jiantou release];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagTheView:)];
    [self addGestureRecognizer:tap];
    [tap release];
    
}
-(void)setTitleLabel:(NSString*)title{
    self.titleLabe.frame= CGRectMake(20, 15, 270, 30);
    self.titleLabe.numberOfLines=0;
    self.titleLabe.text = title;
    [self.titleLabe sizeToFit];
    if(self.titleLabe.size.height>30)
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.titleLabe.frame.size.height+25);
    
    UIImageView *imageView=(UIImageView*)[self viewWithTag:323];
    imageView.frame=CGRectMake(286, self.titleLabe.bottom/2, 10, 13);
}
-(void)tagTheView:(UITapGestureRecognizer*)sender{
    if([self.delegate respondsToSelector:@selector(tapTheViewToSuper:)]){
        [self.delegate tapTheViewToSuper:self.tag];
    }
}

-(void)showOrHiddenRedLabel:(BOOL)flag{
    redLabel.hidden=flag;
}


@end
