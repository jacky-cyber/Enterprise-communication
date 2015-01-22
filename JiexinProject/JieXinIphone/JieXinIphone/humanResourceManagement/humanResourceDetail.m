//
//  ConnetViewController.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-1.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "humanResourceDetail.h"
#import "humanResourceManagementVC.h"
#import "HttpServiceHelper.h"
#import "myButton.h"
#import "myTitleLabel.h"
@interface humanResourceDetail ()

- (void)resquestData:(NSString*)courseid; //请求财务详情数据
@end

@implementation humanResourceDetail
@synthesize gl_courseid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//请求财务详情数据
-(id)initWithcourseid:(NSString*)courseid{
    self = [super init];
    if (self) {
        // Custom initialization
        gl_courseid = courseid;
    }
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super createCustomNavBarWithoutLogo];//自定义导航
    //基视图
    UIWebView  *baseView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kDeviceHeight-44)];
    baseView.tag = 101;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    //返回按钮
    myButton *backButton=[[myButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tags:110];
    [backButton addTarget:self action:@selector(on_BtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    myTitleLabel *titleView=[[myTitleLabel alloc]initTitleLabel:@"人力资源详情" rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    [self resquestData:gl_courseid]; //请求财务详情数据
    
}
- (void)resquestData:(NSString *)courseid{
    [[STHUDManager sharedManager]showHUDInView:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQuerycoursehumanResourceDetial info:@{@"courseid":[NSString stringWithFormat:@"%@",courseid] } target:self successSel:@"requestDetailFinished:" failedSel:@"requestDetailFailed:"];
}//请求财务详情数据
-(void)requestDetailFinished:(NSDictionary *)datas{
    UIWebView *webWiew = (UIWebView *)[self.view viewWithTag:101];
    [[STHUDManager sharedManager]hideHUDInView:self.view];
    
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *replaceStr=@"";
    if([string isEqualToString:@"111.11.28.41"])
    {
        replaceStr = [NSString stringWithFormat:@"http://111.11.28.9:8087/%@/page/img/postImg",applyName];
    }
    else
    {
        replaceStr = [NSString stringWithFormat:@"http://111.11.28.9:8087/%@/page/img/postImg",applyName];
    }
    
    NSString *htmlStr=[datas objectForKey:@"content"] ;
    
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"page/img/postImg" withString:replaceStr];
    
    [webWiew loadHTMLString:htmlStr baseURL:nil];
}
-(void)requestDetailFailed:( id)sender{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
}
- (void)on_BtnReturn_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
