//
//  ISTTableFooterView.m
//  ISTPetsV2
//
//  Created by 陈 爱彬 on 13-3-6.
//  Copyright (c) 2013年 陈 爱彬. All rights reserved.
//

#import "ISTTableFooterView.h"

@implementation ISTTableFooterView
@synthesize activityIndicator = _activityIndicator;
@synthesize infoLabel = _infoLabel;
@synthesize state = _state;
@synthesize loading = _loading;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        //info
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.font = [UIFont systemFontOfSize:12.0f];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.textColor = RGBCOLOR(87, 108, 137);
        self.infoLabel = tempLabel;
        [self addSubview:self.infoLabel];
        [tempLabel release];
        //****
        UIActivityIndicatorView *tempActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator = tempActivity;
        [self addSubview:self.activityIndicator];
        [tempActivity release];

    }
    return self;
}
- (void)setState:(ISTPullRefreshState)state
{
    _state = state;
    if (_state == ISTPullRefreshStateLoading) {
        //Loading
        _loading = YES;
        [self setFlashMessage:@"努力加载中" withShowActivityIndicator:YES];
        
    }else if (_state == ISTPullRefreshStatePulling && !_loading){
        //Scrolling
        [self setFlashMessage:@"上拉加载更多" withShowActivityIndicator:NO];
    }else if (_state == ISTPullRefreshStateNormal && !_loading){
        //Reset
        [self setFlashMessage:@"上拉加载更多" withShowActivityIndicator:NO];
    }else if (_state == ISTPullRefreshStateTheEnd){
        //End
        [self setFlashMessage:@"已经到底了" withShowActivityIndicator:NO];
    }
}
- (void)stopLoadAnimation
{
    if (self.activityIndicator.hidden == NO) {
        [self.activityIndicator stopAnimating];
    }
}
- (void)setFlashMessage:(NSString *)_msg withShowActivityIndicator:(BOOL)_bool
{
    if (_bool) {
        //显示加载动画
        self.activityIndicator.hidden = NO;
        self.activityIndicator.center = CGPointMake((self.frame.size.width - [_msg sizeWithFont:self.infoLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping].width)*0.5 - 15, self.frame.size.height*0.5);
        self.infoLabel.text = _msg;
        [self.activityIndicator startAnimating];
    } else {
        //不显示加载动画，只显示文字
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        self.infoLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.infoLabel.text = _msg;
    }
}

- (void)dealloc
{
    [_activityIndicator stopAnimating];
    RELEASE_SAFELY(_activityIndicator);
    RELEASE_SAFELY(_infoLabel);
    [super dealloc];
}
@end
