//
//  STTabBarHomeView.m
//  STTabbarDemo
//
//  Created by Xiaoming Han on 12-6-4.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import "STTabBarHomeView.h"
#import "STTabBarItem.h"

#define TextColor [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0]
@interface STTabBarHomeView (private)

- (void)onButtonTouched:(id)sender;

@end

@implementation STTabBarHomeView
@synthesize contentArray = _contentArray;
@synthesize items;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_contentArray release];
    [items release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withContent:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.items = [NSMutableArray array];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        // Initialization code
        self.contentArray = array;
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreen_Height)];
        if (kScreen_Height == 480) {
            aImageView.image = [UIImage imageNamed:@"icon_menu_bg.png"];
        }
        else
        {
            aImageView.image = [UIImage imageNamed:@"icon_menu_bg_5.png"];
        }
        
        [self addSubview:aImageView];
        [aImageView release];
        
                
        self.alpha = 0.0;
        //Raik modify
        UIScrollView *scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kScreen_Height - 20 - 49 - 5)];
        [scrollView setUserInteractionEnabled:YES];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = NO;
        [self addSubview:scrollView];
        [scrollView release];
        
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 183, 44)];
        logoImageView.image = [UIImage imageNamed:@"homeViewLogo"];
        [scrollView addSubview:logoImageView];
        [logoImageView release];
        
        
        
        //准备参数
        int firstNum = 6;
        int secondNum = 5;
        int thirdNum = 2;
        int forthNum = 2;

        NSArray *titleArray = [NSArray arrayWithObjects:@"加油卡服务",@"直批购油",@"网站用户",@"会员服务", nil];
        NSArray *menuArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:firstNum],[NSNumber numberWithInt:secondNum],[NSNumber numberWithInt:thirdNum], [NSNumber numberWithInt:forthNum],nil];
        
        int numOfRow = 4;
        float topMargin = 55.0f;
        int itemIndex = 0;
        
        for (int j = 0; j < [menuArray count]; j++) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, topMargin, 200, 15)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = [titleArray objectAtIndex:j];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:14.0f];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [scrollView addSubview:titleLabel];
            [titleLabel release];
            
            int numOfModule = [[menuArray objectAtIndex:j] integerValue];
            UIImageView *imageViewBg = [[UIImageView alloc] init];
            if ([[menuArray objectAtIndex:j] integerValue] > 4 ) {
                imageViewBg.frame = CGRectMake(6, titleLabel.frame.size.height + titleLabel.frame.origin.y + 6, 308, 181);
                imageViewBg.image = [UIImage imageNamed:@"homeSegmentBg_high.png"];

            }
            else
            {
                imageViewBg.frame = CGRectMake(6, titleLabel.frame.size.height + titleLabel.frame.origin.y + 6, 308, 102);
                imageViewBg.image = [UIImage imageNamed:@"homeSegmentBg.png"];

            }
            
            imageViewBg.userInteractionEnabled = YES;
            [scrollView addSubview:imageViewBg];
            [imageViewBg release];
            
            //这里已经凌乱了 这里分为单个
            for (int i = 0; i < numOfModule; i++)
            {
                int row = i / numOfRow;
                int column = i % numOfRow;
                
                
                if (i <[array count])
                {
                    NSDictionary *dic = [array objectAtIndex:itemIndex + i];
                    NSString *title = [dic objectForKey:kItemTitle];
                    
                    CGRect itemFrame = CGRectMake(6 +column * (125.0/2 + 14), 8 + row * (125.0/2 + 25), 125.0/2, 125.0/2 + 20);
                    UIView *itemBgView = [[UIView alloc] initWithFrame:itemFrame];
                    [imageViewBg addSubview:itemBgView];
                    [self.items addObject:itemBgView];
                    [itemBgView release];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(0, 0, 125.0/2, 125.0/2);
                    NSString *imageName = [dic objectForKey:@"icon"];//[NSString stringWithFormat:@"menu_%@.png",title];
                    UIImage *normlImage = UIImageGetImageFromName(imageName);
                    if(!normlImage)
                    {
                        normlImage = UIImageGetImageFromName(@"menu_demo.png");
                    }
                    [button setImage:normlImage forState:UIControlStateNormal];
                    button.tag = itemIndex + i;
                    [button addTarget:self action:@selector(onButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
                    [itemBgView addSubview:button];
                    
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125.0/2, 125.0/2, 20)];
                    titleLabel.backgroundColor = [UIColor clearColor];
                    titleLabel.textColor = [UIColor blackColor];
                    titleLabel.font = [UIFont systemFontOfSize:12.0f];
                    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                    titleLabel.text = title;
                    titleLabel.textAlignment = UITextAlignmentCenter;
                    [itemBgView addSubview:titleLabel];
                    [titleLabel release];
                }
            }

            itemIndex += numOfModule;
            topMargin = CGRectGetMinY(imageViewBg.frame) + CGRectGetHeight(imageViewBg.frame)+ 6;
            if (j == [menuArray count] -1) {
                scrollView.contentSize = CGSizeMake( 308,CGRectGetMinY(imageViewBg.frame) + CGRectGetHeight(imageViewBg.frame));
            }
        }
        //注册一个通知，更新会员图标
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMemberIcon:) name:kChangeMemberBtnNotice object:nil];
    }
    return self;
}

- (void)show
{
    [UIView animateWithDuration:0.0 animations:^{
        self.alpha = 1;//0.85;
    } completion:^(BOOL finished){
        
    }];
}

- (void)hide
{
    [self removeFromSuperview];
}

- (void)onButtonTouched:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_ButtonTouched object:sender];
}

-(void)changeMemberIcon:(NSString *)iconName;
{
    UIButton *btn = (UIButton *)[self viewWithTag:13];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
}

- (void)showBadgeValue:(NSNotification *)notification
{
    NSDictionary *info = [notification object];
    for(int i = 0; i < [self.items count]; i++)
    {
        UIView *aview = [self.items objectAtIndex:i];
        
        int count = [[info objectForKey:[NSNumber numberWithInt:i]] intValue];
        if(count != 0)
        {
            UIImageView *bvIv = (UIImageView *)[aview viewWithTag:120];
            if(bvIv)
            {
                [bvIv removeFromSuperview];
            }
            
            UIImage *bvImage = UIImageGetImageFromName(@"iphone-tishi.png");
            bvIv = [[[UIImageView alloc] initWithFrame:CGRectMake(aview.bounds.size.width - 20, -10, 30, 30)] autorelease];
            bvIv.tag = 120;
            bvIv.image = bvImage;
            
            UILabel *badgeValue =  [[[UILabel alloc] initWithFrame:bvIv.bounds] autorelease];
            [badgeValue setBackgroundColor:[UIColor clearColor]];
            [badgeValue setTextColor:[UIColor whiteColor]];
            [badgeValue setFont:[UIFont boldSystemFontOfSize:11.0f]];
            [badgeValue setTextAlignment:UITextAlignmentCenter];
            [badgeValue setText:[NSString stringWithFormat:@"%d",count]];
            [bvIv addSubview:badgeValue];
            [aview addSubview:bvIv];
        }
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
