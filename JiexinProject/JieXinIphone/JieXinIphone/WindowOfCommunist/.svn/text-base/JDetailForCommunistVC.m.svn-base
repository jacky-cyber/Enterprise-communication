//
//  JDetailForCommunistVC.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JDetailForCommunistVC.h"
#import "JTitleLabel.h"
#import "JButton.h"
#import "HttpServiceHelper.h"
@interface JDetailForCommunistVC ()
@property(nonatomic,retain)UIWebView *mainBgView;

@end

@implementation JDetailForCommunistVC
@synthesize content=_content,contentUrl=_contentUrl,courseId;
@synthesize mainBgView=_mainBgView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadDetailView{
    [[STHUDManager sharedManager] showHUDInView:self.mainBgView];
    [[HttpServiceHelper sharedService]requestForType:KQuerycoursedetail info:@{@"courseid":self.courseId} target:self successSel:@"requestSeccussDetail:" failedSel:@"requestfaileDetail:"];
    
   }
-(void)requestSeccussDetail:(NSDictionary *)data{
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([domain isEqualToString:kQIXINSERVER_IP]){
        self.contentUrl=[NSURL URLWithString:@"http://111.11.28.9:8087/partyViewzq/"];
    }else{
        self.contentUrl=[NSURL URLWithString:@"http://111.11.28.30:8087/partyViewzq/"];
    }
    [self.mainBgView loadHTMLString:[data objectForKey:@"content"] baseURL:self.contentUrl];
    [[STHUDManager sharedManager] hideHUDInView:self.mainBgView];

}
-(void)requestfaileDetail:(id)sender{
    [[STHUDManager sharedManager] hideHUDInView:self.mainBgView];
    NSLog(@"%@",sender);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDetailView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[super createCustomNavBarWithoutLogo];
    [self loadBackView];
    
}
#pragma mark 加载视图
//加载返回按钮
-(void)loadBackView{
    _mainBgView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height-self.iosChangeFloat-50)] autorelease];
    [self.mainBgView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.mainBgView];
    //返回按 钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:110];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    NSString *date=[NSString stringWithFormat:@"党群工作详情"];
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:date rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    [titleView release];
    
}
#pragma mark uialertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self onBtnReturn_Click];
}
#pragma mark 触发的事件
- (void)onBtnReturn_Click
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.mainBgView=nil;
    self.contentUrl=nil;
    self.content=nil;
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

@end
