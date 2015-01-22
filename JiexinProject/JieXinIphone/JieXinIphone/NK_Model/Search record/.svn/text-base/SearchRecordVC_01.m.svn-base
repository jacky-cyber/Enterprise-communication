//
//  SearchRecordVC_01.m
//  JieXinIphone
//
//  Created by macOne on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchRecordVC_01.h"
#import "SearchRecordDetailVC.h"
@interface SearchRecordVC_01 ()

@end

@implementation SearchRecordVC_01

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
    [self initType];
    [self initScrollView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initScrollView
{
    self.scrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self initViewForType];
    [self.view_01 addSubview: self.scrollView];
    
//    UIView *
}
-(void)initViewForType
{
    float line = 20.0;
    for(int i=0;i<[self.typeArray count];i++)
    {
        UIView *view_tmp= [[[UIView alloc]initWithFrame:CGRectMake(15, line, 290, 70)]autorelease];
        view_tmp.tag = (i+1)*10;
        [view_tmp.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
        [view_tmp.layer setBorderWidth:0.7f];
        [view_tmp.layer setCornerRadius:5.0f];
        [self.scrollView addSubview:view_tmp];
        //
        UIView *redPoint = [[[UIView alloc]initWithFrame:CGRectMake(-4, -4, 16, 16)]autorelease];
        [redPoint.layer setCornerRadius:8.0];
        redPoint.tag = view_tmp.tag+1;
        redPoint.layer.backgroundColor=[[UIColor redColor]CGColor];
        [view_tmp addSubview:redPoint];
        //
        UILabel  *label_01 = [[[UILabel alloc]initWithFrame:CGRectMake(18, 16, 240, 30)]autorelease];
        label_01.backgroundColor = [UIColor clearColor];
        label_01.font = [UIFont boldSystemFontOfSize:18.0];
        label_01.text = [NSString stringWithFormat:@"%@",[self.typeArray objectAtIndex:i]];
        label_01.textColor = [UIColor blackColor];
        [label_01 setNumberOfLines:0];
        label_01.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize titleSize = [label_01.text sizeWithFont:label_01.font constrainedToSize:CGSizeMake(label_01.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        [label_01 setFrame:CGRectMake(label_01.frame.origin.x, label_01.frame.origin.y, label_01.frame.size.width, titleSize.height)];
        [view_tmp addSubview:label_01];
        //
        UIImageView *imageView_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uitableviewcell_06_image_01"]];
        [imageView_arrow setFrame:CGRectMake(260, label_01.frame.origin.y+4, 15, 15)];
        [view_tmp addSubview:imageView_arrow];
        
        [view_tmp setFrame:CGRectMake(view_tmp.frame.origin.x, view_tmp.frame.origin.y, view_tmp.frame.size.width, label_01.frame.size.height+label_01.frame.origin.y+15)];
        //
        UIButton *button_action = [UIButton buttonWithType:UIButtonTypeCustom];
        button_action.tag = view_tmp.tag+2;
        [button_action setFrame:CGRectMake(0, 0, view_tmp.frame.size.width, view_tmp.frame.size.height)];
        [button_action addTarget:self action:@selector(click_action:) forControlEvents:UIControlEventTouchUpInside];
        [view_tmp addSubview:button_action];
        //
        line = line+view_tmp.frame.size.height+20;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, line);
}

-(void)click_action:(UIButton *)button
{
    UIView *view = (UIView *)[button superview];
    UIView *view_point = (UIView *)[self.view viewWithTag:(button.tag-1)];
    if(view_point.hidden==NO)
    {
        view_point.hidden = YES;
    }
    int index= view.tag/10-1;
    NSLog(@"%d %@",index,[self.typeArray objectAtIndex:index]);
    SearchRecordDetailVC *searchDetaiVC = [[SearchRecordDetailVC alloc]initWithNibName:@"SearchRecordDetailVC" bundle:nil];
    searchDetaiVC.queryby= [NSString stringWithFormat:@"%d",index];
    searchDetaiVC.titleString = [self.typeArray objectAtIndex:index];
    [self.navigationController pushViewController:searchDetaiVC animated:YES];
    [searchDetaiVC release];
}
-(NSString *)getHeadStr
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *headString= @"";
    if([string isEqualToString:@"111.11.28.30"])
    {
        headString=@"111.11.28.30:8083";
    }
    else
    {
        headString=@"111.11.28.9:8089";
    }
    return headString;
}
-(void)initType
{
    self.typeArray = [NSMutableArray array];
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=queryalltype",headStr];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]integerValue]==0)
        {
            NSString *strAll = [[[dic valueForKey:@"date"]valueForKey:@"type"]objectAtIndex:0];
            NSArray *array_one = [strAll componentsSeparatedByString:@";"];
            for(int j=0;j<[array_one count];j++)
            {
                NSString *str_add = [[[array_one objectAtIndex:j] componentsSeparatedByString:@","]objectAtIndex:1];
                [self.typeArray addObject:str_add];
            }
        }
    }
    else
    {
        NSLog(@"没数据");
    }
    
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)topRightCornerAction:(id)sender {
}
- (void)dealloc {
    [_view_01 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setView_01:nil];
    [super viewDidUnload];
}
@end
