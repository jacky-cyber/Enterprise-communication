//
//  STTabBarItem.m
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import "STTabBarItem.h"

@implementation STTabBarItem
@synthesize title = _title;
@synthesize bgImageName = _bgImageName;
@synthesize bgImageSelectedName = _bgImageSelectedName;

- (void)dealloc
{
    [_title release];
    [_bgImageName release];
    [_bgImageSelectedName release];
    [_bgImageView release];
    [_titleLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withItemInfo:(NSDictionary *)infoDic
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = (NSString *)[infoDic objectForKey:kItemTitle];
        self.bgImageName = (NSString *)[infoDic objectForKey:kItemBgNormal];
        self.bgImageSelectedName = (NSString *)[infoDic objectForKey:kItemBgSelected];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_bgImageName ofType:nil]];
        
        [self addSubview:_bgImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTitleOffsetX, kTitleOffsetY, kTitleWidth, kTitleHeight)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:kTitleFontSize]];
        [_titleLabel setText:_title];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)changeState:(BOOL)selected
{
    [self setSelected:selected];
    NSString *imageUrl = nil;
    if (selected) {
        imageUrl = [[NSBundle mainBundle] pathForResource:_bgImageSelectedName ofType:nil];
    } else {
        imageUrl = [[NSBundle mainBundle] pathForResource:_bgImageName ofType:nil];
    }
    _bgImageView.image = [UIImage imageWithContentsOfFile:imageUrl];

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
