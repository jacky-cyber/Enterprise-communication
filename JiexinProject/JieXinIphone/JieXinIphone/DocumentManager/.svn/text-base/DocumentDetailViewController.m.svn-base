//
//  DocumentDetailViewController.m
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-4-1.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//

#import "DocumentDetailViewController.h"
#import "documentDataHelp.h"
#import "filestatisticsModel.h"
#import "HttpServiceHelper.h"
#import "SVProgressHUD.h"
#import "ReadViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kdocumentMange_IP @"111.11.28.20"
#define SCREENRECT [UIScreen mainScreen].bounds

@interface DocumentDetailViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *imgArr;

@end

@implementation DocumentDetailViewController
//@synthesize fileid;
@synthesize dataArray;
@synthesize progress;
@synthesize imgArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"文档详细";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super createCustomNavBarWithoutLogo];
    
    [self  initNavView];
    
    [self initLabelFrame];
    
    imgArr = [[NSMutableArray alloc] initWithCapacity:10];
}

- (void)initNavView
{
    
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat, SCREENRECT.size.width, 44)];
    [self.view addSubview:baseView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,2, 40, 40);
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:backBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.frame.origin.x+backBtn.frame.size.width,2, 120, 40)];
    label.text = @"文档详情";
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:label];
    
}


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initLabelFrame{
    
    NSDictionary *infoDic=dataArray[0];
    NSDictionary *statDic=dataArray[1];
    
//    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , self.iosChangeFloat+44+5,SCREENRECT.size.width, 0)];
//    nameLabel.textAlignment=NSTextAlignmentCenter;
//    [nameLabel setNumberOfLines:0];
//    nameLabel.text = infoDic[@"name"];
//    nameLabel.font = [UIFont systemFontOfSize:20.0];
//    nameLabel.textColor = [UIColor blackColor];
//    [nameLabel sizeToFit];
//    [self.view addSubview:nameLabel];
//    
//    CGRect rect=nameLabel.frame;
//    rect.origin.x=(SCREENRECT.size.width-rect.size.width)/2;
//    nameLabel.frame=rect;
//    
    
    NSArray * titleArr =@[@"标   题",@"上传者",@"阅读量",@"下载量",@"描   述"];
    NSArray * contentArr = @[infoDic[@"title"],infoDic[@"uploaderid"],statDic[@"readcount"],statDic[@"downloadcount"],infoDic[@"filedesc"]];
    CGFloat _y=0;
    CGFloat h=self.iosChangeFloat+44+10;
    for(int i=0;i<5;i++){
        
        UILabel * lable = [self fitLable:[titleArr objectAtIndex:i] and_x:20 and_y:h+_y and_width:50];
        
        
        UILabel * lable1 = [self fitLable:[contentArr objectAtIndex:i] and_x:76 and_y:h+_y and_width:200];

        UILabel *verLabel=[[UILabel alloc] initWithFrame:CGRectMake(lable1.frame.origin.x -10, lable1.frame.origin.y-10, 1, lable1.frame.size.height+20)];
        verLabel.backgroundColor=[UIColor lightGrayColor];
        [self.view addSubview:verLabel];
        
        UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,lable.frame.origin.y +lable.frame.size.height+10, SCREENRECT.size.width, 1)];
        lineLabel.backgroundColor=[UIColor lightGrayColor];
          [self.view addSubview:lineLabel];
        
        _y =_y+lable1.frame.size.height+20;
        
        [self.view addSubview:lable];
        [self.view addSubview:lable1];
      
    }
    
        UIButton *readBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        readBtn.frame=CGRectMake(10, _y+h, 140, 40);
       [readBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
        [readBtn addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:readBtn];
    
        UIButton *downBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame=CGRectMake(readBtn.frame.origin.x+readBtn.frame.size.width+20, _y+h, 140, 40);
    [downBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
       [downBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:downBtn];
    
        progress=[[UIProgressView alloc] initWithFrame:CGRectMake(0, downBtn.frame.origin.y+downBtn.frame.size.height+10, SCREENRECT.size.width, 20)];
        progress.hidden=YES;
        [self.view addSubview:progress];

    
    
}

-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.textColor=[UIColor lightTextColor];
    label1.font = [UIFont systemFontOfSize:14.0];
    label1.textColor = [UIColor blackColor];
    [label1 sizeToFit];
    return label1;
    
}

-(void)read:(UIButton *)sender{
    
     NSDictionary *infoDic=dataArray[0];
    
    ReadViewController *readController =[[ReadViewController alloc] init];
    readController.allPage=[[infoDic objectForKey:@"jpgCount"] intValue];
    if([imgArr count]!=0){
    readController.imgArr=imgArr;
    }else{
    readController.urlStr=[infoDic objectForKey:@"jpgStr"];
    }
    [self.navigationController pushViewController:readController animated:YES];
    
}

-(void)download:(UIButton *)sender{
    NSString *str=sender.titleLabel.text;
    if([str isEqualToString:@"取消"]){
    [sender setTitle:@"下载" forState:UIControlStateNormal];
        progress.hidden=YES;
        [[self networkQueue] cancelAllOperations];
    }else{
     [sender setTitle:@"取消" forState:UIControlStateNormal];
        NSDictionary *infoDic=dataArray[0];
        NSString *jpgPath=[infoDic objectForKey:@"jpgStr"];
        int count=[[infoDic objectForKey:@"jpgCount"] intValue];
        NSString *urlStr=[[NSString   alloc] initWithFormat:@"http://%@/FileShare%@" ,kdocumentMange_IP,jpgPath]  ;
        
        NSMutableArray *pathArr=[[NSMutableArray alloc] initWithCapacity:count];
        for(int i=0;i<count;i++){
            [pathArr addObject:[NSString stringWithFormat:@"%@/%d.jpg",urlStr,i+1]];
        }
        
        [self doNetworkOperations:pathArr];
    }
    
    
}


- (void)doNetworkOperations:(NSArray *)requestArr
{
    // Stop anything already in the queue before removing it
    [[self networkQueue] cancelAllOperations];
    
    // Creating a new queue each time we use it means we don't have to worry about clearing delegates or resetting progress tracking
    [self setNetworkQueue:[ASINetworkQueue queue]];
    [[self networkQueue] setDelegate:self];
    [[self networkQueue] setRequestDidFinishSelector:@selector(requestFinished:)];
    [[self networkQueue] setRequestDidFailSelector:@selector(requestFailed:)];
    [[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
    [[self networkQueue] setDownloadProgressDelegate:progress];
    progress.hidden=NO;
    [[self networkQueue] setShowAccurateProgress:YES];
    
    int i;
    for (i=0; i<[requestArr count]; i++) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestArr[i] ]];
        [[self networkQueue] addOperation:request];
    }
    
    [[self networkQueue] go];
}

-(void)closeView:(UIButton *)sender{
 
    [sender.superview removeFromSuperview];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // You could release the queue here if you wanted
    if ([[self networkQueue] requestsCount] == 0) {
        
        // Since this is a retained property, setting it to nil will release it
        // This is the safest way to handle releasing things - most of the time you only ever need to release in your accessors
        // And if you an Objective-C 2.0 property for the queue (as in this example) the accessor is generated automatically for you
        [self setNetworkQueue:nil];
    }
    
    [imgArr addObject:[UIImage imageWithData:request.responseData]];
    
    //... Handle success
    NSLog(@"Request finished");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    // You could release the queue here if you wanted
    if ([[self networkQueue] requestsCount] == 0) {
        [self setNetworkQueue:nil];
    }
    
    //... Handle failure
    NSLog(@"Request failed");
}


- (void)queueFinished:(ASINetworkQueue *)queue
{
    // You could release the queue here if you wanted
    if ([[self networkQueue] requestsCount] == 0) {
        [self setNetworkQueue:nil];
    }
    
    UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"提示" message:@"下载完成" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
    
    [alertView show];
    
    NSLog(@"Queue finished");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    progress.hidden=YES;
    
 }

-(void)close:(UIButton *)sender{
    
    UIView *bgView=[self.view viewWithTag:1001];
    UIWebView *web=(UIWebView *)[bgView viewWithTag:10011];
    web=nil;
    [bgView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
