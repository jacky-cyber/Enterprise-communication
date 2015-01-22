//
//  NetworkSetViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-5.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "NetworkSetViewController.h"

@interface NetworkSetViewController ()
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat iosChangeFloat;

@end

@implementation NetworkSetViewController
- (void)dealloc
{
    self.titleLabel = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDefaultDatas];
        // Custom initialization
    }
    return self;
}

- (void)initDefaultDatas
{
    if (IOSVersion >= 7.0)
    {
        self.iosChangeFloat = 20;
    }
    else
    {
        self.iosChangeFloat = 0;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBarWithoutLogo];
    [self initSubViews];
    // Do any additional setup after loading the view.
}

- (void)createCustomNavBarWithoutLogo{
    if (self.iosChangeFloat) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    UIImageView *navBarImgView = [[UIImageView alloc] initWithImage:UIImageWithName(@"top_bar_bg.png")];
    //    navBarImgView.backgroundColor = [UIColor grayColor];
    navBarImgView.frame = CGRectMake(0, self.iosChangeFloat, kScreen_Width, kNavHeight);
    navBarImgView.userInteractionEnabled = YES;
    [self.view addSubview:navBarImgView];
    [navBarImgView release];
}


- (void)initSubViews
{
//    self.view.backgroundColor = RGBACOLOR(229.5, 229.5, 229.5, 1.0);
    self.view.backgroundColor = [UIColor whiteColor];
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"normalBack.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"网络无法连接";
    [self.view addSubview:_titleLabel];
    
//    UIImage *image = [UIImage imageNamed:@"netWorkSet.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavHeight+self.iosChangeFloat, image.size.width, image.size.height)];
//    imageView.image = image;
//    [self.view addSubview:imageView];
//    [imageView release];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.iosChangeFloat+44+10, kScreen_Width - 20, 115)];
//    imageView.userInteractionEnabled = YES;
//    [imageView.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
//    [imageView.layer setBorderWidth:1.0f];
//    [imageView.layer setCornerRadius:5.0f];
//    [self.view addSubview:imageView];
//    [imageView release];
    
    [self initContentView];
}

- (void)initContentView
{
    CGFloat leftMargin = 10;
    NSString *title = @"建议按照以下方法检查网络连接";
    CGSize titleSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:CGSizeMake(kScreen_Width-2*leftMargin,MAXFLOAT)];
    UILabel *methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, self.iosChangeFloat+kNavHeight+ 20, titleSize.width, titleSize.height)];
    methodLabel.backgroundColor = [UIColor clearColor];
    methodLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    methodLabel.text = title;
    [self.view addSubview:methodLabel];
    [methodLabel release];
    
    NSString *oneMethodStr = @"1.打开手机“设置”并把“Wi-Fi”开关保持开启状态";
    CGSize oneMethodSize = [oneMethodStr sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(kScreen_Width-2*leftMargin,MAXFLOAT)];
    UILabel *oneMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(methodLabel.frame)+ 20, oneMethodSize.width, oneMethodSize.height)];
    oneMethodLabel.numberOfLines = 0;
    oneMethodLabel.backgroundColor = [UIColor clearColor];
    oneMethodLabel.font = [UIFont systemFontOfSize:15.0f];
    oneMethodLabel.text = oneMethodStr;
    [self.view addSubview:oneMethodLabel];
    [oneMethodLabel release];
    
    NSString *twoMethodStr = @"2.打开手机“设置”-“通用”-“蜂窝移动网络设置”并把“蜂窝移动数据”开关保持开启状态";
    CGSize twoMethodSize = [twoMethodStr sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(kScreen_Width-2*leftMargin,MAXFLOAT)];
    UILabel *twoMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(oneMethodLabel.frame)+ 20, twoMethodSize.width, twoMethodSize.height)];
    twoMethodLabel.numberOfLines = 0;
    twoMethodLabel.backgroundColor = [UIColor clearColor];
    twoMethodLabel.font = [UIFont systemFontOfSize:15.0f];
    twoMethodLabel.text = twoMethodStr;
    [self.view addSubview:twoMethodLabel];
    [twoMethodLabel release];
}

- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
