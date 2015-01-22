//
//  EmployeesDetailViewController.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//
#define SCREENRECT [UIScreen mainScreen].bounds

#import "EmployeesDetailViewController.h"
#import "Emoji_Translation.h"
#import "MessageView.h"


@interface EmployeesDetailViewController ()

@property (nonatomic,strong) UITableView *dataTable;
@property (nonatomic) int faceLabelHeight;

@end

@implementation EmployeesDetailViewController
@synthesize dataTable;
@synthesize dataDic;
@synthesize faceLabelHeight;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        faceLabelHeight=0;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [super createCustomNavBarWithoutLogo];
    [self initNavView];
    [self initTableView];
    [self initBottomView];
    
}

- (void)initNavView
{
    
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat, SCREENRECT.size.width, 44)];
    [self.view addSubview:baseView];
    //baseView.backgroundColor = [UIColor redColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,2, 40, 40);
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:backBtn];
    
    NSString *titleStr=@"详情";
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.frame.origin.x+backBtn.frame.size.width,2, 120, 40)];
    label.text = titleStr;
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:label];
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame = CGRectMake(SCREENRECT.size.width-40-10,2, 40, 40);
    [typeBtn setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_06.png"] forState:UIControlStateNormal];
  
    [typeBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:typeBtn];
    
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)refresh:(id)sender
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    //    [self.array_up removeAllObjects];
    //    [self.array_remark removeAllObjects];
    //    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    //    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    //    [wParam setValue:[row_item valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
    //    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:wParam] autorelease];
    //    [tmp_thread start];
    //    
}


-(void)initBottomView{
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0,  SCREENRECT.size.height-36, SCREENRECT.size.width, 36)];
    bottomView.tag=1001;
    [self.view addSubview:bottomView];

    UILabel *linelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENRECT.size.width, 1)];
    linelabel.backgroundColor=[UIColor lightGrayColor];
    [bottomView addSubview:linelabel];
    
    UIButton *praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    praiseBtn.frame=CGRectMake(20, 4, 70, 30);
    [praiseBtn setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_03"] forState:UIControlStateNormal];
    [praiseBtn addTarget:self action:@selector(praise:) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:praiseBtn];
    
    UIButton *commentsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    commentsBtn.frame=CGRectMake(120, 4, 70, 30);
    [commentsBtn setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_02"] forState:UIControlStateNormal];
    [commentsBtn addTarget:self action:@selector(comments:) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:commentsBtn];
    
    UIButton *chatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chatBtn.frame=CGRectMake(242, 4, 70, 30);
    [chatBtn setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_01"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:chatBtn];

    
}

-(void)praise:(UIButton *)sender{

}

-(void)comments:(UIButton *)sender{
    
}

-(void)chat:(UIButton *)sender{
    
}
-(void)initTableView{
    
    CGFloat y=self.iosChangeFloat+44;
    CGFloat height=SCREENRECT.size.height-y-36 ;
    dataTable=[[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREENRECT.size.width, height)];
    dataTable.backgroundColor=[UIColor lightGrayColor];
    dataTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    // _tableview.separatorInset=  UIEdgeInsetsMake(0, 15, 0, 15);
    dataTable.dataSource=self;
    dataTable.delegate=self;
    dataTable.tableHeaderView=[self createHeadView];
    [self.view addSubview:dataTable];
}

-(UIView *)createHeadView{
    UIView *headView=[[UIView alloc] init];
    headView.frame=CGRectMake(0, 0, SCREENRECT.size.width, 80);
    headView.backgroundColor=[UIColor redColor];
    
    UIImageView *headImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    headImage.image=dataDic[@"HEAD_IMAGE"];
    [headView addSubview:headView];
    
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(58, 10, 252, 21)];
    nameLabel.text=dataDic[@"USER_ACCOUNT"];
    nameLabel.textColor=[UIColor colorWithRed:45/255.0f green:180/255.0f blue:246/255.0f alpha:1];
    [headView addSubview:nameLabel];
    
    MessageView *messageView=[[MessageView alloc] initWithFrame:CGRectMake(58, 29, 250, faceLabelHeight)];
    
    
    return headView;
}

-(void)setDataDic:(NSDictionary *)data{
    dataDic=data;
    
//    NSString *sSrcContent=data[@"MESSAGE_CONTENT"];
//    NSString *sDestContent=[Emoji_Translation EmojiWithQixin:sSrcContent ];
//    NSMutableArray * faceArr = [[NSMutableArray alloc]init];
//    [self getImageRange:sDestContent :faceArr];
//    int faceCnt =[self faceArr:faceArr];
//    NSLog(@"faceCnt = %d",faceCnt);
//    NSString*ss = [sDestContent substringToIndex:sDestContent.length-faceCnt*10];
//    UILabel * ll = [self fitLable:ss and_x:0 and_y:0 and_width:250];
//   
//    headLabelHeight=ll.frame.size.height;
    
}

//将表情和字符串分离
-(NSArray*)getImageRange:(NSString*)message : (NSMutableArray*)array {
    //    mainViewController * mainView = [[mainViewController alloc]init];
    //    mainView.chatDelegate = self;
    NSString * str = @"<&";
    NSString * str1 = @"&>";
    NSRange range=[message rangeOfString:str];
    NSRange range1=[message rangeOfString:str1];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            if(![[message substringToIndex:range.location] isEqualToString:@""])
            {
                [array addObject:[message substringToIndex:range.location]];
            }
            if(![[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)] isEqualToString:@""])
            {
                [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)]];
            }
            NSString *str=[message substringFromIndex:range1.location+str1.length];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+str1.length];
                [self getImageRange:str :array];
            }else {
                return array;
            }
        }
        
    } else if (message != nil&&![message isEqualToString:@""]) {
        [array addObject:message];
        return array;
    }
    return array;
}
//计算表情的个数
-(int)faceArr:(NSMutableArray*)faceArray{
    NSString * beginStr = @"<&";
    NSString * endStr = @"&>";
    
    int cnt=0;
    for (int i=0; i<[faceArray count]; i++) {
        NSRange range=[[faceArray objectAtIndex:i] rangeOfString:beginStr];
        NSRange range1=[[faceArray objectAtIndex:i] rangeOfString:endStr];
        if (range.length==2&&range1.length==2) {
            cnt++;
        }
    }
    return cnt;
}
//lable自适应
-(UILabel*)fitLable:(NSString*)str and_x:(CGFloat)x and_y:(CGFloat)y and_width:(CGFloat)width{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 0)];
    [label1 setNumberOfLines:0];
    label1.text = str;
    label1.font = [UIFont systemFontOfSize:16.0];
    label1.tag=100;
    // label1.textColor = [UIColor redColor];
    [label1 sizeToFit];
    return label1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
