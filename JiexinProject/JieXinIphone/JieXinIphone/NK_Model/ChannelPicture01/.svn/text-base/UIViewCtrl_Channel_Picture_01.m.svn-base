//
//  UIViewCtrl_Channel_Picture_01.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Channel_Picture_01.h"

@interface UIViewCtrl_Channel_Picture_01 () <UIScrollViewDelegate>

@property (assign, nonatomic) IBOutlet UIScrollView *scrollview_01;

@end

@implementation UIViewCtrl_Channel_Picture_01

@synthesize arr_images = _arr_images;
@synthesize scrollview_01 = _scrollview_01;
@synthesize showIdx = _showIdx;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (NSInteger i = 0; i < [self.arr_images count]; i++) {
        UIScrollView *tmp_scrollview = [[[UIScrollView alloc] initWithFrame:CGRectMake(320.0f * i, 0.0f, 320.0f, self.scrollview_01.frame.size.height)] autorelease];
        [tmp_scrollview setMaximumZoomScale:3.0f];
        [tmp_scrollview setMinimumZoomScale:1.0f];
        [tmp_scrollview setDelegate:self];
        UIImageView *tmp_imageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0f, 320.0f, self.scrollview_01.frame.size.height)] autorelease];
        [tmp_imageview setImage:[self.arr_images objectAtIndex:i]];
        [tmp_imageview setContentMode:UIViewContentModeScaleAspectFit];
        [tmp_scrollview addSubview:tmp_imageview];
        
        [self.scrollview_01 addSubview:tmp_scrollview];
    }
    [self.scrollview_01 setContentSize:CGSizeMake([self.arr_images count] * 320.0f, self.scrollview_01.frame.size.height)];
    if (self.showIdx != nil && [self.showIdx integerValue] < [self.arr_images count] ) {
        [self.scrollview_01 setContentOffset:CGPointMake([self.showIdx integerValue] * 320.0f, 0)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.arr_images = nil;
    self.showIdx = nil;
    [super dealloc];
}

#pragma label -
#pragma label UIScrollViewDelegate Methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id subview in scrollView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            return subview;
        }
    }
    
    return nil;
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}



@end
