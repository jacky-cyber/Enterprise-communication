//
//  EditHeKaViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "EditHeKaViewController.h"
#import "EditContentViewController.h"

@interface EditHeKaViewController ()<SaveHeKaContentDelegate>

@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *contentLabel;

@end

@implementation EditHeKaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isCanEdit = YES;
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.titleLabel = nil;
    self.delegate = nil;
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
    
    if (self.isCanEdit)
    {
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(kScreen_Width -110, self.iosChangeFloat, 100, kNavHeight);
        [sureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [sureBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sureBtn setTitleColor:RGBCOLOR(1, 165, 228) forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(onSendBtnTap) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
    }
    
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    if (self.isCanEdit) {
        _titleLabel.text = @"编辑贺卡";
    }
    else
    {
        _titleLabel.text = @"贺卡";
    }
    [self.view addSubview:_titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, kScreen_Width, kScreen_Height-20-44)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:imageView];
    [imageView release];
    
    self.contentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(imageView.frame)-150, kScreen_Width-20, 100)] autorelease];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:@"Heiti SC Medium" matrix:matrix];
    _contentLabel.font = [UIFont fontWithDescriptor:desc size:19];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _contentLabel.text = _greetingStr;
    [imageView addSubview:_contentLabel];
    
    
    UIButton *editContentBt = [UIButton buttonWithType:UIButtonTypeCustom];
    editContentBt.frame = _contentLabel.frame;
    editContentBt.enabled = self.isCanEdit;
    [editContentBt addTarget:self action:@selector(editContent) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:editContentBt];
    
}

- (void)editContent
{
    EditContentViewController *edit = [[EditContentViewController alloc] initWithNibName:nil bundle:nil];
    edit.delegate = self;
    edit.content = self.contentLabel.text;
    [self.navigationController pushViewController:edit animated:YES];
    [edit release];
}


- (void)saveHeKaContent:(id)sender
{
    if ([sender isKindOfClass:[NSString class]])
    {
        self.contentLabel.text = (NSString *)sender;
        
    }
}
- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSendBtnTap
{
    [self.navigationController popViewControllerAnimated:NO];

    if (self.delegate && [self.delegate respondsToSelector:@selector(sendHeKaWith:)])
    {
//        %Greeting%card_big_1#祝福绕，人欢笑，生活好，步步高%Greeting%
        NSRange range = [self.imageName rangeOfString:@".jpg"];
        NSString *name = self.imageName;
        if (range.location != NSNotFound)
        {
            name = [self.imageName substringToIndex:range.location];
        }
        NSString *str = [NSString stringWithFormat:@"%@%@#%@%@",@"%Greeting%",name,_contentLabel.text,@"%Greeting%"];
        [self.delegate sendHeKaWith:str];
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
