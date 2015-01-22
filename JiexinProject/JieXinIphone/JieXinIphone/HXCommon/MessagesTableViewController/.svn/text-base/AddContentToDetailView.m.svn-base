//
//  AddContentToDetailView.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AddContentToDetailView.h"

@interface AddContentToDetailView()

@property (nonatomic, retain) NSMutableArray *listArr;

@end

@implementation AddContentToDetailView

- (void)dealloc
{
    self.listArr = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.listArr = [NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:heKa_BtnType],@"type",@"heka.png",@"image",@"贺卡",@"name", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:duanXin_BtnType],@"type", @"duanxin.png",@"image",@"短信",@"name", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:album_BtnType],@"type",@"album.png",@"image", @"相册",@"name",nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:camera_BtnType],@"type",@"camera.png",@"image",@"相机",@"name", nil], nil];
//        self.listArr = [NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:duanXin_BtnType],@"type", @"duanxin.png",@"image", nil], nil];
        
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.backgroundColor = RGBACOLOR(213.0f, 213.0f, 213.0f, 1);
    [self addSubview:bgImageView];
    [bgImageView release];
    
    for (int i = 0; i < [_listArr count]; i++) {
        NSDictionary *infoDic = [_listArr objectAtIndex:i];
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10+50*i, 10, 40, 40)];
        [bt setImage:[UIImage imageNamed:[infoDic objectForKey:@"image"]] forState:UIControlStateNormal];
        bt.tag = [[infoDic objectForKey:@"type"] intValue];
        [bt addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(bt.frame), CGRectGetMaxY(bt.frame)+5, 40, 20)];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.backgroundColor = [UIColor clearColor];
        label.text = [infoDic objectForKey:@"name"];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
    }
    
}

- (void)onBtnTap:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectBtnTap:)])
    {
        [self.delegate selectBtnTap:(AddToDetailBtnTag)btn.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
