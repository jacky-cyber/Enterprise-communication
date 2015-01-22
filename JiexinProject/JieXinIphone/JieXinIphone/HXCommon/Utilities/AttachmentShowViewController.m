//
//  AttachmentShowViewController.m
//  SunboxSoft
//
//  Created by 雷 克 on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AttachmentShowViewController.h"

@interface AttachmentShowViewController ()

@end

@implementation AttachmentShowViewController
@synthesize conentWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)removeWaiting
{
    UIView *bgView = (UIView *)[self.view viewWithTag:346];
    if (bgView)
    {
        [bgView removeFromSuperview];
        
    }
}

- (void)showWaiting
{
	[self removeWaiting];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIView *waittingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];// self.bounds];
        waittingView.backgroundColor = [UIColor blackColor];
        waittingView.userInteractionEnabled = NO;
        
        waittingView.alpha = 0.3;
        waittingView.tag = 346;
        //waittingView.layer.cornerRadius = 10.0;
        //[self.view  insertSubview:waittingView aboveSubview:self.dailyView];
        [self.view addSubview:waittingView];
        [waittingView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(waittingView.center.x, waittingView.center.y, 400, 60)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setCenter:CGPointMake(waittingView.bounds.size.width /2.0 +135, waittingView.bounds.size.height / 2.0 +60)];
        
        [label setText:@"正在加载....."];
        [label setFont:[UIFont systemFontOfSize:28.0f]];
        [waittingView addSubview:label];
        [label release];
        
        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        active.center = CGPointMake(waittingView.bounds.size.width/2.0,waittingView.bounds.size.height/2.0);
        [waittingView addSubview:active];
        active.tag = 345;
        [active startAnimating];
        [active release];
    }
    else
    {
        UIView *waittingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 367)];// self.bounds];
        waittingView.backgroundColor = [UIColor blackColor];
        waittingView.userInteractionEnabled = NO;
        
        waittingView.alpha = 0.3;
        waittingView.tag = 346;
        //waittingView.layer.cornerRadius = 10.0;
        [self.view  addSubview:waittingView];
        [waittingView release];
        
        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        active.center = CGPointMake(waittingView.bounds.size.width/2.0,waittingView.bounds.size.height/2.0);
        [waittingView addSubview:active];
        active.tag = 345;
        [active startAnimating];
        [active release];
    }	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    NSLog(@"%@",@"sdfsdfsd");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
    [self showWaiting];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end");
    [self removeWaiting];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self removeWaiting];
}


- (void)loadContent:(NSString *)contentUrl
{
    NSURL *requestUrl = nil;
    if([contentUrl hasPrefix:@"http"])
    {
        requestUrl = [NSURL URLWithString:contentUrl];
        
    } else {
        requestUrl = [NSURL fileURLWithPath:contentUrl];
    }
    
    if(requestUrl)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];	
        [contentWebView loadRequest:request];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(50, 0, 1024-100, 768)];
        [self.view addSubview:contentWebView];
        //contentWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        contentWebView.scalesPageToFit = YES;
        contentWebView.delegate = self;
        [contentWebView release];
        
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        toolBar.tag = 1101;
        [toolBar setBarStyle:UIBarStyleBlack];
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        [self.view addSubview:toolBar];
        ////--Raik Add--
        UIImage *buttonImage = [UIImage imageNamed:@"返回.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 0, 53, 44);
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:button];
        [toolBar release];
        ////--end--
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-300, 2, 600, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.text = @"附件";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [toolBar addSubview:titleLabel];
        [titleLabel release];
    }
    else
    {
        contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreen_Height-110)];
        [self.view addSubview:contentWebView];
        //contentWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        contentWebView.scalesPageToFit = YES;
        contentWebView.delegate = self;
        [contentWebView release];
        
        [self.navigationItem setTitle:@"附件"];
    } 
}

-(void)doBack
{
	//isCanceled = YES;
	//[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];
    //	if(_searchPopover)
    //	{
    //		[_searchPopover dismissPopoverAnimated:NO];
    //	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
