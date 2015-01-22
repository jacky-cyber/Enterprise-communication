//
//  MsgSendBtnsView.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-4.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "MsgSendBtnsView.h"

@interface MsgSendBtnsView()

@property (nonatomic, retain) UIImageView *unReadCountImageView;

@end
@implementation MsgSendBtnsView

- (void)dealloc
{
    self.unReadCountImageView = nil;
    self.msgBtn = nil;
    self.duanxinBtn = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubviews];
        // Initialization code
    }
    return self;
}

- (void)initSubviews
{
    self.msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_msgBtn addTarget:self action:@selector(msgBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    _msgBtn.frame = CGRectMake(320-65, 0, 28, 25);
    [self.msgBtn setImage:[UIImage imageNamed:@"msgBtn3.png"] forState:UIControlStateNormal];
    [self.msgBtn setImage:[UIImage imageNamed:@"msgBtn4.png"] forState:UIControlStateSelected];
    [self addSubview:_msgBtn];
    
    self.duanxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_duanxinBtn addTarget:self action:@selector(duanxinBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    _duanxinBtn.frame = CGRectMake(320-30, 0, 28, 25);
    [self.duanxinBtn setImage:[UIImage imageNamed:@"msgBtn1.png"] forState:UIControlStateNormal];
    [self.duanxinBtn setImage:[UIImage imageNamed:@"msgBtn2.png"] forState:UIControlStateSelected];
    [self addSubview:_duanxinBtn];
    
//    UIImage *unReadImage = [[UIImage imageNamed:@"unRead.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:10];
    UIImage *unReadImage = [UIImage imageNamed:@"unRead.png"];
    self.unReadCountImageView = [[[UIImageView alloc] init] autorelease];
    _unReadCountImageView.userInteractionEnabled = YES;
    _unReadCountImageView.contentMode = UIViewContentModeRedraw;
    _unReadCountImageView.frame = CGRectMake(10, 1, 30, 24);
    _unReadCountImageView.image = unReadImage;
    [self addSubview:_unReadCountImageView];
    _unReadCountImageView.hidden = YES;
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = _unReadCountImageView.bounds;
    clearBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [clearBtn addTarget:self action:@selector(clearBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [_unReadCountImageView addSubview:clearBtn];
}

- (void)duanxinBtnTap:(UIButton *)sender
{
    sender.selected = YES;
    _msgBtn.selected = NO;
    
    if (self.delegate) {
        [self.delegate duanxinBtnTap];
    }

}

- (void)msgBtnTap:(UIButton *)sender
{
    sender.selected = YES;
    _duanxinBtn.selected = NO;
    if (self.delegate) {
        [self.delegate msgBtnTap];
    }

}

- (void)clearBtnTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clearUnReadCountImageView)]) {
        [self.delegate clearUnReadCountImageView];
    }
}

//设置未读消息的数目
- (void)setUnReadCountView:(NSInteger)count
{
    if (count == 0) {
        _unReadCountImageView.hidden = YES;
    }
    else
    {
        _unReadCountImageView.hidden = NO;
        [_unReadCountImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSString *unReadStr = [NSString stringWithFormat:@"%ld",(long)count];
        CGSize size = [unReadStr sizeWithFont:[UIFont systemFontOfSize:15.0f]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.text = unReadStr;
        label.font = [UIFont systemFontOfSize:15.0f];
        [_unReadCountImageView addSubview:label];
        [label release];
        
        _unReadCountImageView.frame = CGRectMake(CGRectGetMinX(_unReadCountImageView.frame), CGRectGetMinY(_unReadCountImageView.frame), size.width+10, CGRectGetHeight(_unReadCountImageView.frame));
        label.center = CGPointMake(CGRectGetWidth(_unReadCountImageView.frame)/2, 10);
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
