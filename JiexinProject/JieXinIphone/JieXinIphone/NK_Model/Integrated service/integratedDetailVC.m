//
//  integratedDetailVC.m
//  JieXinIphone
//
//  Created by macOne on 14-4-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "integratedDetailVC.h"

@interface integratedDetailVC ()

@end

@implementation integratedDetailVC

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
    NSLog(@"view Did load");
    [super viewDidLoad];
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    [self initWeb];
    self.titleLabel.text = [self.dictionary valueForKey:@"title"];
    // Do any additional setup after loading the view from its nib.
}
-(NSString *)getHeadStr
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *headString= @"";
    if([string isEqualToString:@"111.11.28.30"])
    {
        headString=@"111.11.28.30:8087";
    }
    else
    {
        headString=@"111.11.28.9:8087";
    }
    return headString;
}
-(void)initWeb
{
    UIWebView *webView = [[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    [self.view_01 addSubview:webView];
//    NSString *headStr = @"http://111.11.28.9:8087/integratedSzq/phoneInterface.action?";
    NSString *headStr = [NSString stringWithFormat:@"http://%@/integratedSzq/phoneInterface.action?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=querycoursedetail&courseid=%@&category=%@",headStr,[self.dictionary valueForKey:@"courseid"],[self.dictionary valueForKey:@"category"]];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
//    NSLog(@"综合url=%@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        [webView loadHTMLString:[dic objectForKey:@"content"] baseURL:url];
    }
    else
    {
        NSLog(@"没数据");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_view_01 release];
    [_titleLabel release];
    [super dealloc];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
@end
