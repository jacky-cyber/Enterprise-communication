//
//  UIViewCtrl_Software_Help.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewCtrl_Software_Help.h"

@interface UIViewCtrl_Software_Help ()

@end

@implementation UIViewCtrl_Software_Help

@synthesize webview_01 = _webview_01;

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
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *filePath =nil;
    if([headStr isEqualToString:@"111.11.28.29"]||[headStr isEqualToString:@"111.11.28.30"]){
         filePath = [[NSBundle mainBundle] pathForResource:@"UserHelp" ofType:@"html"];
    }else if([headStr isEqualToString:@"111.11.28.41"]){
        filePath = [[NSBundle mainBundle] pathForResource:@"UserHelpzq" ofType:@"html"];
    }
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.webview_01.delegate=self;
    [self.webview_01 loadHTMLString:contents baseURL:baseUrl];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[request URL]]);
    if([[NSString stringWithFormat:@"%@",[request URL]] isEqualToString:@"http://uczq.cmccsi.cn/"] ||[[NSString stringWithFormat:@"%@",[request URL]] isEqualToString:@"http://uc.cmccsi.cn/"]){
        return ![[UIApplication sharedApplication]openURL:[request URL]];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

@end
