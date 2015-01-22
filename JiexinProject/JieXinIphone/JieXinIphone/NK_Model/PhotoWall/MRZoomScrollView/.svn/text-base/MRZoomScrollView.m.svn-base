//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)


@interface MRZoomScrollView (Utility)


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;


@end

@implementation MRZoomScrollView

@synthesize imageView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    // The imageView can be zoomed largest size
    imageView.frame = CGRectMake(0, 0, MRScreenWidth * 2.5, MRScreenHeight * 2.5);
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView release];
    
    // Add gesture,double tap zoom imageView.
    float minimumScale = self.frame.size.width / imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}
#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale animated:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentSize.width!=320.0)
    {
        UIScrollView *scr = (UIScrollView *)scrollView.superview;
        scr.scrollEnabled = NO;
    }
    else
    {
        UIScrollView *scr = (UIScrollView *)scrollView.superview;
        scr.scrollEnabled = YES;
    }
}
#pragma mark - View cycle
- (void)dealloc
{
    [super dealloc];
}

@end
