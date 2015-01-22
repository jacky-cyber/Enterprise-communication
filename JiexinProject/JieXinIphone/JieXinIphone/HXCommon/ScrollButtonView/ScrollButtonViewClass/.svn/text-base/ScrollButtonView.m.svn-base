//
//  ScrollButtonView.m
//  DownloadPdf
//
//  Created by 云鹤 张 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define kScrollWidth    298
#define kTopImage       @"jinling_top_bg.png"
#define kSelectedImage  @"select_i.png"
#define kTopLeftImage   @"hu_leftpng.png"
#define kTopRightImage  @"hu_right.png"
#define kScrollButtonBaseTag    150
#define kScrollLabelBaseTag     222


#import "ScrollButtonView.h"

@implementation ScrollButtonView
@synthesize mainScroller;
@synthesize selectedIndex;
@synthesize totalCount;
@synthesize delegate;

- (void) dealloc
{
    [mainScroller release];
    [delegate release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        UIImage *topImage = [UIImage imageNamed:kTopImage];
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0  ,0  ,320 ,topImage.size.height)];
        imageView1.image = topImage;
        [self addSubview: imageView1];
        
        UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(5,0, kScrollWidth, topImage.size.height)];
        aScrollView.pagingEnabled =NO;
        aScrollView.backgroundColor=[UIColor clearColor];
        aScrollView.showsHorizontalScrollIndicator = NO;
        aScrollView.showsVerticalScrollIndicator = NO;
        //aScrollView.delegate = self;
        self.mainScroller=aScrollView;
        [self.mainScroller setScrollEnabled:YES];
        [self addSubview: self.mainScroller];
        [aScrollView release];
        
        UIImage *leftImage = [UIImage imageNamed:kTopLeftImage];
        UIImageView *topLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
        topLeftImage.image = leftImage;
        [self addSubview:topLeftImage];
        [topLeftImage release];
        
        UIImage *rightImage = [UIImage imageNamed:kTopRightImage];
        UIImageView *topRightImage = [[UIImageView alloc] initWithFrame:CGRectMake(305, 0, rightImage.size.width, rightImage.size.height)];
        topRightImage.image = rightImage;
        [self addSubview:topRightImage];
        [topRightImage release];

    }
    return self;
}

- (void) creatView:(NSMutableArray *)titleArray
{
    UIImage *selectedImage = [UIImage imageNamed:kSelectedImage];
    totalCount = [titleArray count];
    
    self.mainScroller.contentSize = CGSizeMake(totalCount*selectedImage.size.width+30,mainScroller.frame.size.height);
    NSLog(@"array======%@",titleArray);
    for (int i = 0; i<totalCount; i++) 
    {
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.frame = CGRectMake(0, 0, selectedImage.size.width, selectedImage.size.height);
        aButton.center  = CGPointMake(53+selectedImage.size.width*i, 22);
        aButton.tag = kScrollButtonBaseTag+i;
        [aButton setImage:selectedImage forState:UIControlStateSelected];
        [aButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        
       
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.frame = CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height);
        aLabel.text = [[titleArray objectAtIndex:i] objectForKey:@"Title"];
        aLabel.font = [UIFont systemFontOfSize:15];
        aLabel.textAlignment = UITextAlignmentCenter;
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.tag = kScrollLabelBaseTag+i;
        [aButton addSubview:aLabel];
        [aLabel release];
        //默认选中第一个
        if (i==0) {
            aButton.selected = YES;
            aLabel.textColor = [UIColor colorWithRed:195/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
            [aLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        }
        
        [self.mainScroller addSubview:aButton];
    }
}

- (void) selectedButton: (id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    for (int i = 0; i < totalCount; i++) 
    {
        UIButton *button = (UIButton *)[self.mainScroller viewWithTag:kScrollButtonBaseTag+i];
        if (btn == button) {
            [btn setSelected:YES];
            self.selectedIndex = btn.tag - kScrollButtonBaseTag;
            UILabel *aLabel = (UILabel *)[btn viewWithTag:kScrollLabelBaseTag+i];
            [aLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            aLabel.textColor = [UIColor colorWithRed:195/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
           
        }
        else {
            [button setSelected:NO];
            UILabel *aLabel = (UILabel *)[button viewWithTag:kScrollLabelBaseTag+i];
            aLabel.textColor = [UIColor blackColor];
            aLabel.font = [UIFont systemFontOfSize:15];
            
        }
    }
    
    if (delegate && [delegate respondsToSelector:@selector(ScrollButtonViewDidSelectedIndex:)]) 
    {
        [delegate ScrollButtonViewDidSelectedIndex:self.selectedIndex];
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
