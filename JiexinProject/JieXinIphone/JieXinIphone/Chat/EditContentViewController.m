//
//  EditContentViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "EditContentViewController.h"
#import "CustomTextView.h"

@interface EditContentViewController ()
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)CustomTextView   *contentTextView;

@end

@implementation EditContentViewController

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
    self.titleLabel = nil;
    self.delegate = nil;
    self.contentTextView = nil;
    self.content = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self initSubViews];

    // Do any additional setup after loading the view.
}
- (void)initSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"normalBack.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kScreen_Width -110, self.iosChangeFloat, 100, kNavHeight);
    [sureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [sureBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGBCOLOR(1, 165, 228) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(onSaveBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"编辑贺卡内容";
    [self.view addSubview:_titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.iosChangeFloat+44+10, kScreen_Width - 20, 115)];
    imageView.userInteractionEnabled = YES;
    [imageView.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [imageView.layer setBorderWidth:1.0f];
    [imageView.layer setCornerRadius:5.0f];
    [self.view addSubview:imageView];
    [imageView release];
    
    self.contentTextView = [[[CustomTextView alloc] initWithFrame:CGRectMake(5, 2, CGRectGetWidth(imageView.frame)-10, 110) withPlaceholder:@"请输入贺卡内容"] autorelease];
    _contentTextView.font = [UIFont systemFontOfSize:16.0f];
    self.contentTextView.returnKeyType = UIReturnKeyDone;
    self.contentTextView.text = self.content;
//    self.contentTextView.delegate = self;
    [imageView addSubview:_contentTextView];
}

- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSaveBtnTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveHeKaContent:)])
    {
        [self.delegate saveHeKaContent:self.contentTextView.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
