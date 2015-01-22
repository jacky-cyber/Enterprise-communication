//
//  NotificationDetailVC.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-4.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "NotificationDetailVC.h"
#import "NGLABAL_DEFINE.h"
#import "GTMBase64.h"

@interface NotificationDetailVC ()

@end

@implementation NotificationDetailVC

@synthesize sTitle = _sTitle;
@synthesize sTime = _sTime;
@synthesize sBody = _sBody;

@synthesize rootView = _rootView;
@synthesize view_01 = _view_01;
@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;
@synthesize label_03 = _label_03;

@synthesize scrollview_01 = _scrollview_01;

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
 
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.sTitle = nil;
    self.sTime = nil;
    self.sBody = nil;
    self.rootView = nil;
    [super dealloc];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) ON_COMMAND:(NSDictionary *)wParam
{
    NSInteger nComandId = [[wParam valueForKey:PARAMTER_KEY_COMMAND_ID] integerValue];
    
    if(nComandId == COMMAND_INITIALIZE_USER_INFORMATIOIN){
        NSString * urlstr = [wParam valueForKey:@"url"] ;
        NSString * courseid =[wParam valueForKey:@"courseid"] ;
        
        NSString *dizhi = [[NSString stringWithFormat:@"%@cmd=querycoursedetail&courseid=%@",urlstr,courseid] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:dizhi];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //    [request release];
        NSDictionary *dic = [[NSDictionary alloc] init];
        if(received!=nil)//有数据
        {
           dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        }

        self.sTitle = dic[@"title"];
        NSString *timeStr=dic[@"date"];
        self.sTime = [timeStr substringToIndex:timeStr.length-2];
        self.sBody = dic[@"content"] ;
      
    
        CGSize title_size = [self.sTitle sizeWithFont:[self.label_01 font] constrainedToSize:CGSizeMake(310.0f, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGFloat pos_y = 5.0f;
        
        [self.label_01 setText:self.sTitle];
        [self.label_01 setFrame:CGRectMake(0, pos_y, 320.0, title_size.height)];
        
        pos_y += title_size.height - 2;
        [self.label_02 setFrame:CGRectMake(133.0f, pos_y, 181.0f, 21.0f)];
        [self.label_02 setText:[NSString stringWithFormat:@"发布时间：%@", self.sTime]];
        
        pos_y += 24.0f;
        [self.view_01 setFrame:CGRectMake(0, pos_y, 320.0f, 1.0f)];
        
        pos_y += 1;
        CGSize text_size = [self.sBody sizeWithFont:[self.label_03 font] constrainedToSize:CGSizeMake(310.0f, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
     
        UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, pos_y, self.view.frame.size.width, CGRectGetHeight(self.scrollview_01.frame)-pos_y)];
        webView.scalesPageToFit=YES;
        webView.backgroundColor=[UIColor whiteColor];
        
    
        NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        NSString *replaceStr=@"";
        if([string isEqualToString:@"111.11.28.41"])
        {
          replaceStr=@"http://111.11.28.9:8087/noticezq/page/img/postImg";
        }
        else
        {
            replaceStr=@"http://111.11.28.30:8087/notice/page/img/postImg";
        }


        
        
        self.sBody = [self.sBody stringByReplacingOccurrencesOfString:@"page/img/postImg" withString:replaceStr];
        
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %d;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>", 30, self.sBody];
        
        [webView loadHTMLString:jsString baseURL:nil];
        [self.scrollview_01 addSubview:webView];
        
        pos_y += text_size.height + 5.0f;
        self.scrollview_01.scrollEnabled = NO;
//        [self.scrollview_01 setContentSize:CGSizeMake(320.0, pos_y)];
        
        //[self.textview_01 setText:self.sBody];
        
     
        
        
    }
}

@end
