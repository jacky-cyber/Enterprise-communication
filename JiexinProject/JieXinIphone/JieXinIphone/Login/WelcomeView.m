//
//  WelcomeView.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-29.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "WelcomeView.h"
#define kPageCount 6

@interface WelcomeView()<UIScrollViewDelegate>
@property (nonatomic,retain) UIScrollView *mainScrollView;
@property (nonatomic,retain) UIPageControl *mainPageControl;
@end

@implementation WelcomeView

- (void)

{
    self.mainScrollView = nil;
    self.mainPageControl = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    [self initialMainScroll];
    [self initialMainPageControl];
//    [self initialBtns];
}

- (void)initialMainScroll
{
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, CGRectGetHeight(self.frame))];
    aScrollView.delegate = self;
    aScrollView.pagingEnabled=YES;
    aScrollView.backgroundColor = [UIColor clearColor];
    aScrollView.showsHorizontalScrollIndicator=NO;
    aScrollView.showsVerticalScrollIndicator=NO;
    aScrollView.scrollsToTop=NO;
    aScrollView.clipsToBounds = YES;
    aScrollView.bounces = NO;
    aScrollView.contentSize = CGSizeMake(kScreen_Width*kPageCount, CGRectGetHeight(aScrollView.frame));
    self.mainScrollView = aScrollView;
    [aScrollView release];
    [self addSubview:_mainScrollView];
    
    for (int i= 0 ; i < kPageCount; i++) {
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, CGRectGetHeight(self.frame))];
        aImageView.userInteractionEnabled = YES;
        if (kScreen_Height < 568) {
            aImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner%d.png",i+1]];
        }
        else
        {
            aImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hbanner%d.png",i+1]];
        }
        [_mainScrollView addSubview:aImageView];
        [aImageView release];

        if (i == kPageCount-1) {
            UIImage *enterImage1 = [UIImage imageNamed:@"enterLogin1.png"];
            UIImage *enterImage2 = [UIImage imageNamed:@"enterLogin2.png"];
            
            UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [enterBtn setImage:enterImage1 forState:UIControlStateNormal];
            [enterBtn setImage:enterImage2 forState:UIControlStateHighlighted];
            enterBtn.frame = CGRectMake(0, 0, enterImage1.size.width/2, enterImage1.size.height/2);
            enterBtn.center = CGPointMake(kScreen_Width/2, kScreen_Height-130-enterImage1.size.height/4);
            [enterBtn addTarget:self action:@selector(enterLogin) forControlEvents:UIControlEventTouchUpInside];
            [aImageView addSubview:enterBtn];
        }
    }
    
}

- (void)initialMainPageControl
{
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    pageControl.pageIndicatorTintColor = RGBCOLOR(0, 165, 227);
    pageControl.currentPageIndicatorTintColor = RGBCOLOR(0, 102, 140);
    pageControl.center = CGPointMake(kScreen_Width/2.0, CGRectGetHeight(self.frame) - 60);
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    pageControl.numberOfPages = kPageCount;
    pageControl.currentPage = 0;
    self.mainPageControl = pageControl;
    [pageControl release];
    
    [self addSubview:_mainPageControl];
}

#pragma mark - btnsTap

- (void)enterLogin
{
    if (self.delegate) {
        [self.delegate hideWelcomeView];
    }
}
- (void)changePage:(id)sender
{
    int page = _mainPageControl.currentPage;
    [self loadScrollViewWithPage:page];
    
    CGRect frame = _mainScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_mainScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - UIscrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _mainScrollView)
    {
        CGFloat pageWidth = CGRectGetWidth(_mainScrollView.frame);
        int page = floor((_mainScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [self loadScrollViewWithPage:page];
    }
}

- (void)loadScrollViewWithPage:(int)page
{
    if(page < 0)
        return;
    _mainPageControl.currentPage = page;
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
