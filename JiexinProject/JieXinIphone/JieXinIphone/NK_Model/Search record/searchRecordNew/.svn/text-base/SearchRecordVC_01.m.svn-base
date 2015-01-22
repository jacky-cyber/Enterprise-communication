//
//  SearchRecordVC_01.m
//  JieXinIphone
//
//  Created by macOne on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchRecordVC_01.h"
#import "SearchRecordDetailVC.h"
#import "documentDataHelp.h"
@interface SearchRecordVC_01 ()

@end

@implementation SearchRecordVC_01


@synthesize button_search;
@synthesize textField_search;

#define HEADVIEWTAG 999  //头部的view tag直

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
    self.queryby = @"";
    self.queryway = 0;
    [self initType];
    [self initScrollView];
    [self initRedPoint];
    
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
    
}
//删除无用的categoryid,异常处理
-(void)deleteErrorCategoryidWithDbArray:(NSArray*)dbArray andWithListArray:(NSArray*)listArray andWithSysId:(NSString*)sysid{
    for (int i=0; i<[dbArray count]; i++) {
        BOOL isHaveID = NO;
        
        NSString* dbTag=[NSString stringWithFormat:@"%@",[dbArray[i] objectForKey:@"categoryid"]];
        for (int j=0; j<[listArray count]; j++) {
            NSString* realTag=[NSString stringWithFormat:@"%@",[listArray[j] objectForKey:@"categoryid"]];
            if ([dbTag isEqualToString:realTag]) {
                isHaveID = YES;
                break;
            }
            
        }
        if (!isHaveID) {
            [[documentDataHelp sharedService] deleteTestList:sysid withCategoryid:dbTag];
        }
        
    }
    
}
-(void)initRedPoint
{
    //判断哪里该显示红点
    self.pointArr = [NSMutableArray array];//保存哪里该显示红点的
    NSMutableArray *array = [[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    for(NSDictionary *dic in array){
        int newsId=[dic[@"sysid"] intValue];
        if(newsId==8)
        {
            NSString  *str = dic[@"categoryid"];
            [self.pointArr addObject:str];
        }
    }
    NSLog(@"剔除无效数据前所有数据%@",self.pointArr);
    //剔除无效数据
    if([self.pointArr count]>0)
    {
        for(int i=0;i<[self.pointArr count];i++)
        {
            int numId = [[self.pointArr objectAtIndex:i]intValue];
            if(numId>=0&&numId<[self.pointArr count])
            {
                
            }
            else
            {
               // [self.pointArr removeObjectAtIndex:i];
                [[documentDataHelp sharedService] deleteTestList:@"08" withCategoryid:[self.pointArr objectAtIndex:i]];
            }
            //
//            BOOL IsCOntent = NO;
//            int skId = [[self.pointArr objectAtIndex:i]intValue];
//            for(int j=0;j<[self.pointArr count];j++)
//            {
//                if(j==skId)
//                {
//                    IsCOntent = YES;
//                    break;
//                }
//            }
//            if(IsCOntent==NO)
//            {
//                [self.pointArr removeObjectAtIndex:i];
//                [[documentDataHelp sharedService] deleteTestList:@"08" withCategoryid:[NSString stringWithFormat:@"%d",skId]];
//            }
            
        }
    }
    //
    NSLog(@"红点数量=%d",[self.pointArr count]);
    //显示红点
    if(self.pointArr>0)
    {
        for(int i=0;i<[self.pointArr count];i++)
        {
            int index = [[self.pointArr objectAtIndex:i]intValue];
            NSLog(@"显示红点的地方%d",(index+1)*10+1);
            UIView *view_point = (UIView *)[self.view_01 viewWithTag:((index+1)*10+1)];
            if(view_point)
            {
//                NSLog(@"存在");
                view_point.hidden =NO;
            }
            else
            {
//                NSLog(@"不存在");
            }

        }
    }

}
-(void)deletePointFromTableAtIndex:(int)index
{
     [[documentDataHelp sharedService] deleteTestList:@"08" withCategoryid:[NSString stringWithFormat:@"%d",index]];
    NSLog(@"删除了小红点");
}
-(void)initViewForType
{
    float line = 0.0;
    NSLog(@"initViewForType有%d个数组",[self.typeArray count]);
    NSLog(@"%@",self.typeArray);
    for(int i=0;i<[self.typeArray count];i++)
    {
//        UIView *view_tmp= [[[UIView alloc]initWithFrame:CGRectMake(15, line, 290, 70)]autorelease];
//        view_tmp.tag = (i+1)*10;
//        [view_tmp.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
//        [view_tmp.layer setBorderWidth:0.7f];
//        [view_tmp.layer setCornerRadius:5.0f];
//        [self.scrollView addSubview:view_tmp];
//        //
//        UIView *redPoint = [[[UIView alloc]initWithFrame:CGRectMake(view_tmp.frame.origin.x-4,view_tmp.frame.origin.y-4, 16, 16)]autorelease];
//        redPoint.hidden = YES;
//        [redPoint.layer setCornerRadius:8.0];
//        redPoint.tag = view_tmp.tag+1;
//        redPoint.backgroundColor=[UIColor redColor];
//        [self.scrollView addSubview:redPoint];
//        //
//        UILabel  *label_01 = [[[UILabel alloc]initWithFrame:CGRectMake(18, 16, 240, 30)]autorelease];
//        label_01.backgroundColor = [UIColor clearColor];
//        label_01.font = [UIFont systemFontOfSize:18.0];
//        label_01.text = [NSString stringWithFormat:@"%@",[self.typeArray objectAtIndex:i]];
//        label_01.textColor = [UIColor blackColor];
//        [label_01 setNumberOfLines:0];
//        label_01.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize titleSize = [label_01.text sizeWithFont:label_01.font constrainedToSize:CGSizeMake(label_01.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        [label_01 setFrame:CGRectMake(label_01.frame.origin.x, label_01.frame.origin.y, label_01.frame.size.width, titleSize.height)];
//        [view_tmp addSubview:label_01];
//        //
//        UIImageView *imageView_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uitableviewcell_06_image_01"]];
//        [imageView_arrow setFrame:CGRectMake(260, label_01.frame.origin.y+4, 15, 15)];
//        [view_tmp addSubview:imageView_arrow];
//        
//        [view_tmp setFrame:CGRectMake(view_tmp.frame.origin.x, view_tmp.frame.origin.y, view_tmp.frame.size.width, label_01.frame.size.height+label_01.frame.origin.y+15)];
//        //
//        UIButton *button_action = [UIButton buttonWithType:UIButtonTypeCustom];
//        button_action.tag = view_tmp.tag+2;
//        [button_action setFrame:CGRectMake(0, 0, view_tmp.frame.size.width, view_tmp.frame.size.height)];
//        [button_action addTarget:self action:@selector(click_action:) forControlEvents:UIControlEventTouchUpInside];
//        [view_tmp addSubview:button_action];
//        //
//        line = line+view_tmp.frame.size.height+20;
        //
        UIView *view_tmp= [[[UIView alloc]initWithFrame:CGRectMake(0, line, 320, 70)]autorelease];
        view_tmp.tag = (i+1)*10;
        [self.scrollView addSubview:view_tmp];
        //
        UIView *redPoint = [[[UIView alloc]initWithFrame:CGRectMake(view_tmp.frame.origin.x-4,view_tmp.frame.origin.y-4, 16, 16)]autorelease];
        redPoint.hidden = YES;
        [redPoint.layer setCornerRadius:8.0];
        redPoint.tag = view_tmp.tag+1;
        redPoint.backgroundColor=[UIColor redColor];
        [self.scrollView addSubview:redPoint];
        //
        UILabel  *label_01 = [[[UILabel alloc]initWithFrame:CGRectMake(18, 16, 240, 30)]autorelease];
        label_01.backgroundColor = [UIColor clearColor];
        label_01.font = [UIFont systemFontOfSize:18.0];
        label_01.text = [NSString stringWithFormat:@"%@",[self.typeArray objectAtIndex:i]];
        label_01.textColor = [UIColor blackColor];
        [label_01 setNumberOfLines:0];
        label_01.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize titleSize = [label_01.text sizeWithFont:label_01.font constrainedToSize:CGSizeMake(label_01.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        [label_01 setFrame:CGRectMake(label_01.frame.origin.x, label_01.frame.origin.y, label_01.frame.size.width, titleSize.height)];
        [view_tmp addSubview:label_01];
        //
        UIImageView *imageView_arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uitableviewcell_06_image_01"]];
        [imageView_arrow setFrame:CGRectMake(280, label_01.frame.origin.y+4, 15, 15)];
        [view_tmp addSubview:imageView_arrow];
        
        [view_tmp setFrame:CGRectMake(view_tmp.frame.origin.x, view_tmp.frame.origin.y, view_tmp.frame.size.width, label_01.frame.size.height+label_01.frame.origin.y+15)];
        //
        UIImageView *imageV_line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
        [imageV_line setFrame:CGRectMake(0, view_tmp.frame.size.height-1, 320, 1)];
        [view_tmp addSubview:imageV_line];
        //
        UIButton *button_action = [UIButton buttonWithType:UIButtonTypeCustom];
        button_action.tag = view_tmp.tag+2;
        [button_action setFrame:CGRectMake(0, 0, view_tmp.frame.size.width, view_tmp.frame.size.height)];
        [button_action addTarget:self action:@selector(click_action:) forControlEvents:UIControlEventTouchUpInside];
        [view_tmp addSubview:button_action];
        
        //
        line = line+view_tmp.frame.size.height+0;
        //
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, line);

}

-(void)click_action:(UIButton *)button
{
    UIView *view = (UIView *)[button superview];
    UIView *view_point = (UIView *)[self.view_01 viewWithTag:(button.tag-1)];
    if(view_point.hidden==NO)
    {
        view_point.hidden = YES;
           //删除小红点
        [self deletePointFromTableAtIndex:((view_point.tag-1)/10-1)];
    }
    int index= view.tag/10-1;
//    NSLog(@"%d %@",index,[self.typeArray objectAtIndex:index]);
    SearchRecordDetailVC *searchDetaiVC = [[SearchRecordDetailVC alloc]initWithNibName:@"SearchRecordDetailVC" bundle:nil];
    searchDetaiVC.queryby= [NSString stringWithFormat:@"%d",index];
    searchDetaiVC.queryway = 3;
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
//    NSLog(@"类型=%@",url);
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
    //右上角添加的功能(插入搜索)
    UIView *view = [self.view_01 viewWithTag:HEADVIEWTAG];
    if(!view)
    {
        [self insertSearch];
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y+44, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        view.hidden = YES;
    }
    else
    {
        if(view.hidden==YES)
        {
            view.hidden = NO;
            [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y+44, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        }
        else
        {
            view.hidden = YES;
            [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y-44, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        }
    }
    if(self.view_02.hidden==NO)
    {
        self.view_02.hidden=YES;
    }
}
-(void)insertSearch
{
    UIView *headerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)]autorelease];
    headerView.tag = HEADVIEWTAG;
    [self.view_01 addSubview:headerView];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    //    220, 3, 90, 36
    UIImageView *view_left = [[[UIImageView alloc]initWithFrame:CGRectMake(100, 3, 210, 36)]autorelease];
    view_left.layer.cornerRadius = 18.0;
    view_left.userInteractionEnabled = YES;
    view_left.image = [UIImage imageNamed:@"searchReord-search_01.png"];
    [headerView addSubview:view_left];
    //
    textField_search = [[[UITextField alloc]initWithFrame:CGRectMake(5, 0, 170, 36)]autorelease];
    [textField_search setBackgroundColor:[UIColor clearColor]];
    textField_search.placeholder = @"  输入内容";
    [textField_search setText:self.queryby];
    textField_search.delegate = self;
    textField_search.font = [UIFont systemFontOfSize:15];
    [view_left addSubview:textField_search];
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(170, textField_search.frame.origin.y, 30, textField_search.frame.size.height)];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [view_left addSubview:btn];
    //    5, 3, 210, 36
    UIImageView *view_right = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 90, 36)]autorelease];
    view_right.layer.cornerRadius = 18.0;
    view_right.userInteractionEnabled = YES;
    view_right.image = [UIImage imageNamed:@"searchReord-search_02.png"];
    [headerView addSubview:view_right];
    //
    button_search = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_search setFrame:CGRectMake(5, 0, 50, 36)];
    [button_search setBackgroundColor:[UIColor clearColor]];
    [button_search setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button_search.titleLabel.font = [UIFont systemFontOfSize:15];
    if(self.queryway==0)
    {
        [button_search setTitle:@"名称" forState:UIControlStateNormal];
    }
    else if(self.queryway==1)
    {
        [button_search setTitle:@"年份" forState:UIControlStateNormal];
    }
    else if(self.queryway==2)
    {
        [button_search setTitle:@"编号" forState:UIControlStateNormal];
    }
    else
    {
        [button_search setTitle:@"名称" forState:UIControlStateNormal];
    }
    [view_right addSubview:button_search];
    //
    UIButton *btn_choose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_choose setFrame:CGRectMake(65, button_search.frame.origin.y, 20, button_search.frame.size.height)];
    //    [btn_choose setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
    [btn_choose setBackgroundColor:[UIColor clearColor]];
    [btn_choose addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [view_right addSubview:btn_choose];
    //
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapBtn setFrame:CGRectMake(0, 0, view_right.frame.size.width, view_right.frame.size.height)];
    [tapBtn addTarget:self action:@selector(chooseQueryway) forControlEvents:UIControlEventTouchUpInside];
    [view_right addSubview:tapBtn];
    
    self.queryway = 0;
    [self.nameBtn addTarget:self action:@selector(selectName) forControlEvents:UIControlEventTouchUpInside];
    [self.yearBtn addTarget:self action:@selector(selectYear) forControlEvents:UIControlEventTouchUpInside];
    [self.numberBtn addTarget:self action:@selector(selectNumber) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)selectName
{
    self.queryway = 0;
    self.view_02.hidden = YES;
    [button_search setTitle:@"名称" forState:UIControlStateNormal];
}
-(void)selectYear
{
    self.queryway = 1;
    self.view_02.hidden = YES;
    [button_search setTitle:@"年份" forState:UIControlStateNormal];
}
-(void)selectNumber
{
    self.queryway = 2;
    self.view_02.hidden = YES;
    [button_search setTitle:@"编号" forState:UIControlStateNormal];
}
-(void)chooseQueryway
{
    if(self.view_02.hidden == YES)
    {
        [self.view_01 addSubview:self.view_02];
        self.view_02.hidden = NO;
    }
    else
    {
        self.view_02.hidden = YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.queryby = textField_search.text;
    [textField resignFirstResponder];
    [self goToNextVC];
    return YES;
}
-(void)goSearch
{
    self.queryby = textField_search.text;
    if([textField_search isFirstResponder])
    {
        [textField_search resignFirstResponder];
    }
    [self goToNextVC];
}
-(void)goToNextVC
{
    //跳转到下个界面
    //
    SearchRecordDetailVC *searchDetaiVC = [[SearchRecordDetailVC alloc]initWithNibName:@"SearchRecordDetailVC" bundle:nil];
    searchDetaiVC.queryby= self.queryby;
    searchDetaiVC.queryway = self.queryway;
    searchDetaiVC.titleString = self.queryby;
    [self.navigationController pushViewController:searchDetaiVC animated:YES];
    [searchDetaiVC release];
}

- (void)dealloc {
    [_view_01 release];
    [_view_02 release];
    [_nameBtn release];
    [_yearBtn release];
    [_numberBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setView_01:nil];
    [self setView_02:nil];
    [self setNameBtn:nil];
    [self setYearBtn:nil];
    [self setNumberBtn:nil];
    [super viewDidUnload];
}
@end
