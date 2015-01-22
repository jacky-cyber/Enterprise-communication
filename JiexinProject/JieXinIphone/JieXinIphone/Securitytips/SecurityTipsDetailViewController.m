//
//  SecurityTipsDetailViewController.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SecurityTipsDetailViewController.h"
#import "HttpServiceHelper.h"
#import "SecurityTipsViewController.h"
@interface SecurityTipsDetailViewController ()
- (void)resquestData:(NSString*)courseid; //请求财务详情数据
@end

@implementation SecurityTipsDetailViewController
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
    [self resquestData:gl_courseid]; //请求财务详情数据
    [super createCustomNavBarWithoutLogo];//自定义导航
    //基视图
	UIWebView  *baseView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kDeviceHeight-44)];
    baseView.tag = 101;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    //返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(on_BtnReturn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:_backBtn];
    
    //返回标题
    _backLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_backBtn.right-15, self.iosChangeFloat, 150, 40)];
    _backLabel.text = @"安全小卫士详情";
    _backLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:_backLabel];
    
}
- (void)resquestData:(NSString *)courseid{
    [[HttpServiceHelper sharedService] requestForType:kQuerySecurityTipsDetail info:@{@"courseid":[NSString stringWithFormat:@"%@",courseid]} target:self successSel:@"requestDetailFinished:" failedSel:@"requestDetailFailed:"];
}//请求财务详情数据
-(void)requestDetailFinished:(NSDictionary *)datas{
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString*sa = [[NSString alloc]init];
    if ([domain isEqualToString:@"111.11.28.30"]) {
        sa=domain;
    }
    else{
        sa = @"111.11.28.9";
    }
    NSString*str = [NSString stringWithFormat:@"http://%@:8087/saferzq/phoneInterface.action",sa];
    NSURL *url = [NSURL URLWithString:str];
    UIWebView *webWiew = (UIWebView *)[self.view viewWithTag:101];
    webWiew.scalesPageToFit =YES;
    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %d;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", 50, [datas objectForKey:@"content"]];
    [webWiew loadHTMLString:jsString baseURL:url];
}
-(void)requestDetailFailed:( id)sender{
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
