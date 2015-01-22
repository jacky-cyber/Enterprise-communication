//
//  STTabBarView.m
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import "STTabBarView.h"
#import "STTabBarItem.h"
#import "STTabBarHomeView.h"

@interface STTabBarView (private)

- (void)onHomeButtonTouched:(id)sender;
- (void)onTabbarItemTouched:(id)sender;
- (void)onReceiveButtonNotification:(NSNotification *)sender;

- (void)initMoreItemIndicator;
- (void)showMoreIndicator;
- (void)showHomeButtonView;
@end

@implementation STTabBarView
{
    NSString *_memberIconName;
    BOOL isMemberIconChange;
}
@synthesize contentArray = _contentArray;
@synthesize delegate = _delegate;
@synthesize homeItemDic = _homeItemDic;
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_scrollView release];
    if (_homeButton != nil) {
        [_homeButton release];
        [_homeItemDic release];
    }
    
    [_contentArray release];
    [_leftIndicator release];
    [_rightIndicator release];
    
//    [_bgImageView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withContent:(NSArray *)array homeItemDic:(NSDictionary *)homeItemDic
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _isHomeShown = NO;
        self.contentArray = array;
        _homeButton = nil;
        
        float margin = 0;
        float offset = margin;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.homeItemDic = homeItemDic;
        if (self.homeItemDic != nil) {
            _homeButton = [[STTabBarItem alloc] initWithFrame:CGRectMake(margin, 0, kHomeButtonWidth, kTabbarHeight) withItemInfo:homeItemDic];
            _homeButton.tag = -1;
            [self addSubview:_homeButton];
            [_homeButton addTarget:self action:@selector(onHomeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
            offset += kHomeButtonWidth;
        }
        float scrollWidth = frame.size.width - offset - margin;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(offset, 0, scrollWidth, kTabbarHeight)];
        _scrollView .delegate = self;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.canCancelContentTouches = NO;
        _scrollView.clipsToBounds = NO;
        _scrollView.scrollEnabled = YES;
            
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
//        _scrollView.alpha = 0.6;
        
        [self addSubview:_scrollView];
        
        for (int i = 0; i < _contentArray.count; i++) {
            NSDictionary *dic = (NSDictionary *)[array objectAtIndex:i];
           
            //Raik modify
            STTabBarItem* barItem = [[STTabBarItem alloc] initWithFrame:CGRectMake(kTabbarItemWidth*i, 0, kTabbarItemWidth, kTabbarHeight) withItemInfo:dic];
            barItem.tag = i;

            [barItem addTarget:self action:@selector(onTabbarItemTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            [_scrollView addSubview:barItem];
            [barItem release];

        }
        //Raik modify
        [_scrollView setContentSize:CGSizeMake(_contentArray.count*kTabbarItemWidth, frame.size.height)];
        [self initMoreItemIndicator];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveButtonNotification:) name:kNotification_ButtonTouched object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMemberIcon:) name:kChangeMemberBtnNotice object:nil];
        
        
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        topLine.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:topLine];
        [topLine release];
        [self bringSubviewToFront:_homeButton];
    }
    return self;
}

- (void)reloadContentData
{
    
}
- (void)performHomeButtonTapped
{
    if (_homeButton) {
        [self performSelector:@selector(onHomeButtonTouched:) withObject:_homeButton];
    }
}

- (void)setSelectedIndex:(int)index animated:(BOOL)animated
{
    if (index < 0 || index > _contentArray.count - 1) {
        return;
    }
    STTabBarItem *item = [_scrollView.subviews objectAtIndex:index];
    [self onTabbarItemTouched:item];
    [_scrollView scrollRectToVisible:item.frame animated:animated];
}

- (NSArray *)getItemArray
{
    NSArray *array = [NSArray arrayWithArray:_scrollView.subviews];
    return array;
}

#pragma private methods
- (void)initMoreItemIndicator
{
    UIImage *lImage = UIImageGetImageFromName(kMoreItemLeft);
    _leftIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.frame.origin.x, 0, 21, 49)];
    _leftIndicator.image = lImage;
    [self addSubview:_leftIndicator];
   
    UIImage *rImage = UIImageGetImageFromName(kMoreItemRight);
    _rightIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.frame.origin.x + _scrollView.bounds.size.width - 21, 0, 21, 49)];
    _rightIndicator.image = rImage;
    [self addSubview:_rightIndicator];
    
    [self showMoreIndicator];

}
- (void)showMoreIndicator
{
    float contentOffsetx = _scrollView.contentOffset.x;
    if(contentOffsetx <= 0)
    {
        //Raik modify
        //_leftIndicator.alpha = 0.0;
    }
    else
    {
        _leftIndicator.alpha = 1.0;
    }
    if(contentOffsetx >= _scrollView.contentSize.width - _scrollView.bounds.size.width)
    {
        //Raik modify
        //_rightIndicator.alpha = 0.0;
    }
    else
    {
        _rightIndicator.alpha = 1.0;
    }
}

- (void)showHomeButtonView
{
    _isHomeShown = !_isHomeShown;
    [_homeButton changeState:_isHomeShown];
    
    if (_isHomeShown) 
    {
        _homeView = [[STTabBarHomeView alloc] initWithFrame:CGRectMake(0, 0, kHomeViewWidth, kHomeViewHeight - kTabbarHeight) withContent:_contentArray];
        
        [self.superview insertSubview:_homeView belowSubview:self];
        
        //用户图标更改
        NSString *loginStatus = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus];
        //如果用户没用登录，则显示为普通用户状态图标
        if (![loginStatus isEqualToString:HasLogin])
        {
            _memberIconName = @"hyxx.png";
            isMemberIconChange = YES;
        }
        
        if(isMemberIconChange)
        {
            [_homeView changeMemberIcon:_memberIconName];
            //isMemberIconChange = NO;
        }
        [_homeView show];
        
        
    } else {
        [_homeView hide];
        [_homeView release];
        _homeView = nil;
    }    
}

- (void)onHomeButtonTouched:(id)sender
{
    STTabBarItem *bt = (STTabBarItem *)sender;
    NSLog(@"tag:%d",bt.tag);
    
    STTabBarItem *item = [_scrollView.subviews objectAtIndex:_selectedIndex];
    [item changeState:_isHomeShown];
    
    [self showHomeButtonView];

    [self.delegate didTabbarHomeButtonTouched:sender];
}

- (void)onTabbarItemTouched:(id)sender
{
    STTabBarItem *item = (STTabBarItem *)sender;

    if (!item.selected) {
        
        for (STTabBarItem *view in _scrollView.subviews) {
            if (view.selected) {
                [view changeState:NO];
            }
        }

        [item changeState:YES];
        _selectedIndex = item.tag;
    }
    NSLog(@"bool:%@",_isHomeShown ? @"YES" : @"NO");
    if (_isHomeShown) {
        [self showHomeButtonView];
    }
    [self.delegate didTabbarViewButtonTouched:sender];
}

- (void)onReceiveButtonNotification:(NSNotification *)sender
{
    UIButton *button = (UIButton *)sender.object;
    NSLog(@"%d",button.tag);
    [self setSelectedIndex:button.tag animated:YES];
    if (_isHomeShown) {
        [self showHomeButtonView];
    }
   
}

-(void)changeMemberIcon:(NSNotification *)notification
{
    isMemberIconChange = YES;
//    NSString *customerLevel = [[notification.object objectForKey:@"res"] objectForKey:@"customerLevel"];
//    [[NSUserDefaults standardUserDefaults] setValue:customerLevel forKey:kUserLevel];
//    if([customerLevel isEqualToString:@"普卡"])
//    {
//        _memberIconName = @"hyxx.png";
//    }
//    else if([customerLevel isEqualToString:@"金卡"])
//    {
//        _memberIconName = @"hyxx_gold.png";
//    }
//    else if([customerLevel isEqualToString:@"银卡"])
//    {
//        _memberIconName = @"hyxx_sliver.png";
//    }
//    else
//    {
//        _memberIconName = @"hyxx.png";
//    }
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self showMoreIndicator];
}

@end
