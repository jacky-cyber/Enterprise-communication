//
//  HeKaViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "HeKaViewController.h"
#import "EditHeKaViewController.h"
#import "HeKaBtn.h"

@interface HeKaViewController ()<EditHeKaDelegate>

@property (nonatomic, retain)UIScrollView *bgScrollView;
@property (nonatomic, retain)UIImageView *selectImageView;
@property (nonatomic, retain) UILabel *titleLabel;

@end

@implementation HeKaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    self.bgScrollView = nil;
    self.selectImageView = nil;
    self.titleLabel = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
	// Do any additional setup after loading the view.
}


- (void)initSubViews
{
    CGFloat changeFloat = 0;
    if (IOSVersion >= 7.0) {
        changeFloat = 20;
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, changeFloat, kScreen_Width, kNavHeight)];
    header.image = UIImageWithName(@"top_bar_bg.png");
    header.userInteractionEnabled = YES;
    [self.view addSubview:header];
    [header release];
    
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"normalBack.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, changeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"贺卡";
    [self.view addSubview:_titleLabel];

    
    self.bgScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight)] autorelease];
    _bgScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgScrollView];
    
    [self initScrollDatas];
}

- (void)initScrollDatas
{
    NSArray *arr = [NSArray arrayWithObjects:@"元旦",@"春节",@"元宵节",@"情人节",@"清明节",@"妇女节",@"植树节",@"劳动节",@"青年节",@"端午节",@"儿童节",@"建军节",@"教师节",@"中秋节",@"国庆节",@"感恩节", nil];
    //行数
    float topMargin = 10;
    float imageWidth = 90;
    float imageHeight = 100;
    float sideMargin = 15;
    
    for (int i = 0; i < [arr count]; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, topMargin,  kScreen_Width - 20, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = [arr objectAtIndex:i];
        [_bgScrollView addSubview:label];
        [label  release];
        topMargin += 20+5;
        //列数
        for (int j = 0; j < 3; j ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(imageWidth+sideMargin)*j, topMargin, imageWidth, imageHeight)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"card_small_%d.jpg",i*3+j+1]];
            imageView.userInteractionEnabled = YES;
            [_bgScrollView addSubview:imageView];
            [imageView release];
            
            HeKaBtn *imageBtn = [HeKaBtn buttonWithType:UIButtonTypeCustom];
            
            imageBtn.index = i;
            imageBtn.heKaImageStr = [NSString stringWithFormat:@"card_small_%d.jpg",i*3+j+1];
            [imageBtn addTarget:self action:@selector(editHeKa:) forControlEvents:UIControlEventTouchUpInside];
            imageBtn.frame = imageView.bounds;
            [imageView addSubview:imageBtn];
        }
        topMargin += imageHeight+5;
    }
    _bgScrollView.contentSize = CGSizeMake(kScreen_Width, topMargin+1);
}

//- (void)
- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)editHeKa:(HeKaBtn *)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"heka" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    EditHeKaViewController *edit = [[EditHeKaViewController alloc] initWithNibName:nil bundle:nil];
    edit.delegate = self;
    edit.imageName = sender.heKaImageStr;
    edit.greetingStr = [arr objectAtIndex:sender.index];
    [self.navigationController pushViewController:edit animated:YES];
    [edit release];
}
- (void)sendHeKaWith:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

    if ([sender isKindOfClass:[NSString class]]) {
        NSLog(@"%@",(NSString *)sender);
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendCardWith:)])
        {
            [self.delegate sendCardWith:(NSString *)sender];
        }
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
