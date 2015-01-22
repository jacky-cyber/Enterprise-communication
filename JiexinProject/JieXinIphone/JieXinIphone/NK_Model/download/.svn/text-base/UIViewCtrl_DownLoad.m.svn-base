//
//  UIViewCtrl_DownLoad.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_DownLoad.h"
enum{
    BUTTON_BACK=3252,
    TITLE_TAG
};
@interface UIViewCtrl_DownLoad ()

@end

@implementation UIViewCtrl_DownLoad
@synthesize mainBgView;
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
    [super createCustomNavBarWithoutLogo];
    [self loadBackView];
    [self loadDataSource];
}
#pragma mark 界面处理部分
-(void)loadBackView{
    self.mainBgView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height- 20-46)] ;
    [self.mainBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_caledar_bg.png"]]];
    
    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:BUTTON_BACK];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:@"软件下载" rect:CGRectMake(15, self.iosChangeFloat, 150,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    [self.view addSubview:titleView];
    titleView.tag=TITLE_TAG;
    [titleView release];

}
-(void)loadDataSource{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSURL *urlStr=nil;
    if([headStr isEqualToString:@"111.11.28.29"] || [headStr isEqualToString:@"111.11.28.30"]){
        urlStr=[NSURL URLWithString:@"http://uc.cmccsi.cn/"];
    }
    else if([headStr isEqualToString:@"111.11.28.41"]){
        urlStr=[NSURL URLWithString:@"http://uczq.cmccsi.cn/"];
    }
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:urlStr];
    [self.mainBgView loadRequest:request];
    [request release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.mainBgView=nil;
    [super dealloc];
}
-(void)onBtnReturn_Click{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}
@end
