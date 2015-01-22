//
//  UIViewCtrl_Channel_Show_01.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Channel_Show_01.h"
#import "UITableViewCell_03.h"
#import "UIViewCtrl_Channel_Reply_01.h"
#import "UIViewCtrl_Channel_Picture_01.h"
#import "UIViewCtrl_Channel_Create_01.h"
#import "UIViewCtrl_Channel_Detail_01.h"
#import "SynUserIcon.h"
#import "NGLABAL_DEFINE.h"
#import "Emoji_Translation.h"
#import "LinkDateCenter.h"
#import "FaceStrUtils.h"

#import "EmployeesDetailViewController.h"

@interface UIViewCtrl_Channel_Show_01 ()<UIAlertViewDelegate>

@property (assign, nonatomic) IBOutlet UITableView *tableview_01;
@property (assign,nonatomic) IBOutlet UIButton *allMessageBtn;
@property (assign,nonatomic) IBOutlet UIButton *myMessageBtn;
@property (assign,nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSMutableArray * array_weblog;
@property (strong, nonatomic) UIView *view_01;
@property (strong, nonatomic) UIView *view_02;
@property (strong, nonatomic) UILabel *label_01;
@property (strong,nonatomic) UIButton *clickBtn;

@property (nonatomic,strong) NSString * delID;
@property (nonatomic,strong) NSDictionary *insertDic;
@property (nonatomic,strong) id delegate;
@end

@implementation UIViewCtrl_Channel_Show_01

@synthesize array_weblog = _array_weblog;
@synthesize tableview_01 = _tableview_01;
@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize label_01 = _label_01;
@synthesize from;
@synthesize clickBtn;
@synthesize delID;
@synthesize delegate;
@synthesize insertDic;

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
    self.array_weblog = [NSMutableArray array];
    self.view_01 = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view_02 = [[[UIView alloc] initWithFrame:CGRectMake(115.0f, 200.0f, 90.0f, 30.0f)] autorelease];
    self.label_01 = [[[UILabel alloc] initWithFrame:CGRectMake(115.0f, 200.0f, 90.0f, 30.0f)] autorelease];
    
    [self.view_02 setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
    [self.view_02.layer setCornerRadius:5.0f];
    [self.label_01 setTextColor:[UIColor whiteColor]];
    [self.label_01 setTextAlignment:NSTextAlignmentCenter];
    [self.label_01 setFont:[UIFont systemFontOfSize:16.0f]];
    [self.label_01 setBackgroundColor:[UIColor clearColor]];
    [self.view_01 addSubview:self.view_02];
    [self.view_01 addSubview:self.label_01];
    [self.tableview_01 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if(from==TypeMe){
        self.allMessageBtn.hidden=YES;
        self.myMessageBtn.hidden=YES;
        self.titleLabel.text=@"我的帖子";
    }else{
        self.allMessageBtn.hidden=NO;
        self.myMessageBtn.hidden=NO;
        self.titleLabel.text=@"员工园地";
    }
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
   
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:nil] autorelease];
    [tmp_thread start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:PARAMTER_KEY_NOTIFY_REFRESH_DATA object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.array_weblog = nil;
    self.view_01 = nil;
    self.view_02 = nil;
    self.label_01 = nil;
    [super dealloc];
}

#pragma label -
#pragma label UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_weblog count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sId = @"uiviewctrl_channel_show_01_cell_01";
    
    UITableViewCell_03 *cell = [tableView dequeueReusableCellWithIdentifier:sId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"UITableViewCell_03" owner:self.tableview_01 options:nil];
        for (id oneObject in nibs){
            if ([oneObject isKindOfClass:[UITableViewCell_03 class]])
                cell = (UITableViewCell_03 *)oneObject;
        }
    }
    
    
    [[cell button_01] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_02] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_03] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_04] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_05] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_06] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_07] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_08] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_09] addTarget:self action:@selector(onBtnFun01_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [[cell button_10] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
    [[cell button_11] addTarget:self action:@selector(onBtnFun03_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:[indexPath row]];
    if (row_item != nil && [row_item valueForKeyPath:@"HEAD_IMAGE"] != nil) {
        [[cell imageview_10] setImage:[row_item valueForKeyPath:@"HEAD_IMAGE"]];
    }
    
    if (row_item != nil && [row_item valueForKeyPath:@"USER_ACCOUNT"] != nil) {
        [[cell label_01] setText:[row_item valueForKeyPath:@"USER_ACCOUNT"]];
    }
    
    int height=[cell label_02].frame.origin.y;
    if (row_item != nil && [row_item valueForKeyPath:@"MESSAGE_CONTENT"] != nil) {
        
        NSString *sContent = [row_item valueForKeyPath:@"MESSAGE_CONTENT"];
        
        
        [[cell label_02] showMessage:[row_item valueForKeyPath:@"MESSAGE_CONTENT"] withWidth:244];
//               [cell label_02].backgroundColor=[UIColor redColor];
        
        FaceStrUtils *utils=[[FaceStrUtils alloc] init];
        int faceStrHeight=[utils getFaceStrViewHeight:sContent withWidth:244];
        [[cell label_02] setFrame:CGRectMake([cell label_02].frame.origin.x, [cell label_02].frame.origin.y+5, [cell label_02].frame.size.width+10, faceStrHeight)];
        NSInteger pos_y = [[cell label_02] frame].origin.y + [[cell label_02] frame].size.height + 6;
        height+=faceStrHeight+5;
        
        [cell.imageview_01 setFrame:CGRectMake(56.0f , pos_y,          65.0f, 65.0f)];
        [cell.imageview_02 setFrame:CGRectMake(129.0f, pos_y,          65.0f, 65.0f)];
        [cell.imageview_03 setFrame:CGRectMake(202.0f, pos_y,          65.0f, 65.0f)];
        [cell.imageview_04 setFrame:CGRectMake(56.0f , pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.imageview_05 setFrame:CGRectMake(129.0f, pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.imageview_06 setFrame:CGRectMake(202.0f, pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.imageview_07 setFrame:CGRectMake(56.0f , pos_y + 146.0f, 65.0f, 65.0f)];
        [cell.imageview_08 setFrame:CGRectMake(129.0f, pos_y + 146.0f, 65.0f, 65.0f)];
        [cell.imageview_09 setFrame:CGRectMake(202.0f, pos_y + 146.0f, 65.0f, 65.0f)];
        
        [cell.button_01 setFrame:CGRectMake(56.0f,  pos_y,          65.0f, 65.0f)];
        [cell.button_02 setFrame:CGRectMake(129.0f, pos_y,          65.0f, 65.0f)];
        [cell.button_03 setFrame:CGRectMake(202.0f, pos_y,          65.0f, 65.0f)];
        [cell.button_04 setFrame:CGRectMake(56.0f,  pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.button_05 setFrame:CGRectMake(129.0f, pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.button_06 setFrame:CGRectMake(202.0f, pos_y + 73.0f,  65.0f, 65.0f)];
        [cell.button_07 setFrame:CGRectMake(56.0f,  pos_y + 146.0f, 65.0f, 65.0f)];
        [cell.button_08 setFrame:CGRectMake(129.0f, pos_y + 146.0f, 65.0f, 65.0f)];
        [cell.button_09 setFrame:CGRectMake(202.0f, pos_y + 146.0f, 65.0f, 65.0f)];
    }
    
    if (row_item != nil && [row_item valueForKeyPath:@"SEND_TIME"] != nil) {
        [[cell label_03] setText:[row_item valueForKeyPath:@"SEND_TIME"]];
    }
    
    if (row_item != nil && [row_item valueForKeyPath:@"UP_MSG_COUNT"] != nil) {
        [[cell button_10] setTitle:[NSString stringWithFormat:@" %@",[row_item valueForKeyPath:@"UP_MSG_COUNT"]] forState:UIControlStateNormal];
        if([row_item valueForKey:@"IS_PRAISED"]){
            [cell.button_10 setImage:[UIImage imageNamed:@"uiview_channel_show_01_image_05"] forState:UIControlStateNormal];
        }
    }
    
    if (row_item != nil && [row_item valueForKeyPath:@"REPLY_COUNT"] != nil) {
        [[cell button_11] setTitle:[NSString stringWithFormat:@" %@",[row_item valueForKeyPath:@"REPLY_COUNT"]] forState:UIControlStateNormal];
        
    }
    
    
    NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
    if ([[row_item valueForKey:@"IS_PRAISED"] integerValue] == 0) {
        [cell.button_10 setImage:[UIImage imageNamed:@"uiview_channel_show_01_image_03.png"] forState:UIControlStateNormal];
    }else {
        [cell.button_10 setImage:[UIImage imageNamed:@"uiview_channel_show_01_image_05.png"] forState:UIControlStateNormal];
    }
    
    if (tmp_image != nil && [tmp_image count] > 0) {
        [[cell imageview_01] setHidden:NO];
        [[cell button_01] setHidden:NO];
        [[cell imageview_01] setImage:[tmp_image objectAtIndex:0]];
        height+=73;
    }else{
        [[cell imageview_01] setHidden:YES];
        [[cell button_01] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 1) {
        [[cell imageview_02] setHidden:NO];
        [[cell button_02] setHidden:NO];
        [[cell imageview_02] setImage:[tmp_image objectAtIndex:1]];
        
    }else{
        [[cell imageview_02] setHidden:YES];
        [[cell button_02] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 2) {
        [[cell imageview_03] setHidden:NO];
        [[cell button_03] setHidden:NO];
        [[cell imageview_03] setImage:[tmp_image objectAtIndex:2]];
    }else{
        [[cell imageview_03] setHidden:YES];
        [[cell button_03] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 3) {
        [[cell imageview_04] setHidden:NO];
        [[cell button_04] setHidden:NO];
        [[cell imageview_04] setImage:[tmp_image objectAtIndex:3]];
        height+=73;
    }else{
        [[cell imageview_04] setHidden:YES];
        [[cell button_04] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 4) {
        [[cell imageview_05] setHidden:NO];
        [[cell button_05] setHidden:NO];
        [[cell imageview_05] setImage:[tmp_image objectAtIndex:4]];
        
    }else{
        [[cell imageview_05] setHidden:YES];
        [[cell button_05] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 5) {
        [[cell imageview_06] setHidden:NO];
        [[cell button_06] setHidden:NO];
        [[cell imageview_06] setImage:[tmp_image objectAtIndex:5]];
    }else{
        [[cell imageview_06] setHidden:YES];
        [[cell button_06] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 6) {
        [[cell imageview_07] setHidden:NO];
        [[cell button_07] setHidden:NO];
        [[cell imageview_07] setImage:[tmp_image objectAtIndex:6]];
        height+=73;
    }else{
        [[cell imageview_07] setHidden:YES];
        [[cell button_07] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 7) {
        [[cell imageview_08] setHidden:NO];
        [[cell button_08] setHidden:NO];
        [[cell imageview_08] setImage:[tmp_image objectAtIndex:7]];
        
    }else{
        [[cell imageview_08] setHidden:YES];
        [[cell button_08] setHidden:YES];
    }
    
    if (tmp_image != nil && [tmp_image count] > 8) {
        [[cell imageview_09] setHidden:NO];
        [[cell button_09] setHidden:NO];
        [[cell imageview_09] setImage:[tmp_image objectAtIndex:8]];
    }else{
        [[cell imageview_09] setHidden:YES];
        [[cell button_09] setHidden:YES];
    }
    
    if(from==TypeMe){
        [cell button_10].frame=CGRectMake(169+4+4, cell.button_10.frame.origin.y, cell.button_10.frame.size.width, cell.button_10.frame.size.height);
        [cell button_11].frame=CGRectMake(229+4, cell.button_11.frame.origin.y, cell.button_11.frame.size.width, cell.button_11.frame.size.height-3);
        [cell showOrHiddenDelBtn:NO];
        cell.delBtn.frame=CGRectMake(cell.button_11.frame.origin.x+cell.button_11.frame.size.width+4, height+5, 25, 20);
        [cell.delBtn addTarget:self action:@selector(delCurrentPost:) forControlEvents:UIControlEventTouchDown];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma label -
#pragma label UITableViewDataSource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float fHeight = 44.0f;
    if ([self.array_weblog objectAtIndex:indexPath.row] != nil) {
        fHeight = [[[self.array_weblog objectAtIndex:indexPath.row] valueForKey:@"CELL_HEIGHT"] floatValue];
    }
    return fHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewCtrl_Channel_Detail_01 *tmp_view = [[[UIViewCtrl_Channel_Detail_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Detail_01" bundle:nil]autorelease];
    [tmp_view.array_weblog addObject:[self.array_weblog objectAtIndex:indexPath.row]];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

-(void)setDelID:(NSString *)delid{
    
    delID=delid;
      NSPredicate *predicate = [NSPredicate predicateWithFormat:@"WEBLOG_ID == %@",delid];
    NSArray *arr  =[self.array_weblog filteredArrayUsingPredicate:predicate];
    if ([arr count]) {
        id object = [arr objectAtIndex:0];
        int index = [self.array_weblog indexOfObject:object];
        [self.tableview_01 beginUpdates];
        [self.array_weblog removeObjectAtIndex:index];
        [self.tableview_01 deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableview_01 endUpdates];
 
    }
    

}

-(void)setInsertDic:(NSDictionary *)insertDic{



}


-(void)setDelegate:(id)delegateone{
    delegate=delegateone;
}

-(void)delCurrentPost:(id)sender{
    
    clickBtn=(UIButton*)sender;
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该帖子？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1){
      
        NSString *baseUrl_01;
        NSString *headStr1;
        
        NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        if([headStr compare:@"111.11.28.29"] == NSOrderedSame) { //正式全通
            baseUrl_01 = @"http://111.11.28.9:8088";
            headStr1 = @"http://111.11.28.9:8088/staffCorner/phoneInterface.action";
        }else if([headStr compare:@"111.11.29.65"] == NSOrderedSame) { //正式全通
            baseUrl_01 = @"http://111.11.29.65:8080";
            headStr1 = @"http://111.11.29.65:8080/staffCorner/phoneInterface.action";
        }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){ //正式政企
            baseUrl_01 = @"http://111.11.28.9:8088";
            headStr1 = @"http://111.11.28.9:8088/staffCornerzq/phoneInterface.action";
        }else if ([headStr compare:@"111.11.28.53"] == NSOrderedSame){ //正式政企
            baseUrl_01 = @"http://111.11.28.53:8088";
            headStr1 = @"http://111.11.28.53:8088/staffCornerzq/phoneInterface.action";
        }else if ([headStr compare:@"111.11.28.1"] == NSOrderedSame){ //正式政企
            baseUrl_01 = @"http://111.11.28.1:8080";
            headStr1 = @"http://111.11.28.1:8080/staffCorner/phoneInterface.action";
        }else {
            baseUrl_01 = @"http://111.11.28.30:8091";
            headStr1 = @"http://111.11.28.30:8091/staffCorner/phoneInterface.action";
        }
        
        //                 baseUrl_01 = @"http://10.120.145.55:8080";
        //                headStr1 = @"http://10.120.145.55:8080/staffCorner/phoneInterface.action";
        
        
        UITableViewCell_03 *cell=  (UITableViewCell_03 *) clickBtn.superview.superview.superview;
        NSIndexPath *indexPath=[self.tableview_01 indexPathForCell:cell];
     
        NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:[indexPath row]];
        
        if([delegate respondsToSelector:@selector(setDelID:)]){
            
            [delegate setValue:row_item[@"WEBLOG_ID"] forKey:@"delID"];
            
        }

        
        NSString *dizhi= [NSString stringWithFormat:@"%@?cmd=deleteStatus&postId=%@",headStr1,row_item[@"WEBLOG_ID"]];
        
        
        NSURL *url = [NSURL URLWithString:dizhi];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [request release];
        if(received!=nil)//有数据
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
            
            if([dic[@"resultcode"] isEqualToString:@"0"]){
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"删除成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil,nil];
                [alertView show];
           
                [self.array_weblog removeObjectAtIndex:indexPath.row];
                [self.tableview_01 reloadData];
            }
            NSLog(@"%@",dic);
        }
        
        
    }
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFun01_Click:(id)sender
{
    for(int i = 0; i < [self.tableview_01 numberOfRowsInSection:0]; i ++)
    {
        UITableViewCell_03 *cell = (UITableViewCell_03 *)[self.tableview_01 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        
        if (sender == [cell button_01]) {
            NSLog(@"onBtnFun01_Click, %@", [NSNumber numberWithInteger:i]);
            
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:0]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_02]) {
            NSLog(@"onBtnFun02_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:1]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_03]) {
            NSLog(@"onBtnFun03_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:2]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_04]) {
            NSLog(@"onBtnFun04_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:3]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_05]) {
            NSLog(@"onBtnFun05_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:4]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_06]) {
            NSLog(@"onBtnFun06_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:5]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_07]) {
            NSLog(@"onBtnFun07_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:6]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_08]) {
            NSLog(@"onBtnFun08_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:7]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
        
        if (sender == [cell button_09]) {
            NSLog(@"onBtnFun09_Click, %@", [NSNumber numberWithInteger:i]);
            UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
            NSDictionary * row_item = [self.array_weblog objectAtIndex:i];
            NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
            [tmp_view setArr_images:tmp_image];
            [tmp_view setShowIdx:[NSNumber numberWithInteger:8]];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
    }
}

- (IBAction)onBtnFun02_Click:(id)sender
{
    for(int i = 0; i < [self.tableview_01 numberOfRowsInSection:0]; i ++)
    {
        UITableViewCell_03 *cell = (UITableViewCell_03 *)[self.tableview_01 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (sender == [cell button_10]) {
            
            [self.label_01 setText:@"点赞成功"];
            [self.view addSubview:self.view_01];
            [self performSelector:@selector(Close_Message:) withObject:nil afterDelay:0.8];
            
            NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:i];
            NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
            
            if ([[row_item valueForKey:@"IS_PRAISED"] integerValue] != 0) {
                [self.label_01 setText:@"您已赞过"];
                [self.view addSubview:self.view_01];
                [self performSelector:@selector(Close_Message:) withObject:nil afterDelay:0.8];
                break;
            }
            [wParam setValue:[row_item valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
            
            [wParam setValue:[NSNumber numberWithInteger:i] forKey:@"WEBLOG_INDEX"];
            [row_item setValue:[NSNumber numberWithInteger:1] forKey:@"IS_PRAISED"];
            [[STHUDManager sharedManager] showHUDInView:self.view];
            
            NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_02:) object:wParam] autorelease];
            [tmp_thread start];
            break;
        }
    }
}

- (IBAction)onBtnFun03_Click:(id)sender
{
    for(int i = 0; i < [self.tableview_01 numberOfRowsInSection:0]; i ++)
    {
        UITableViewCell_03 *cell = (UITableViewCell_03 *)[self.tableview_01 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (sender == [cell button_11]) {
            NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:i];
            UIViewCtrl_Channel_Reply_01 *tmp_view = [[[UIViewCtrl_Channel_Reply_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Reply_01" bundle:nil]autorelease];
            tmp_view.sWeblog_Id = [row_item valueForKey:@"WEBLOG_ID"];
            tmp_view.headImage=[row_item valueForKey:@"HEAD_IMAGE"];
            [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
            break;
        }
    }
}

- (IBAction)onBtnFun04_Click:(id)sender
{
    UIViewCtrl_Channel_Create_01 *tmp_view = [[[UIViewCtrl_Channel_Create_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Create_01" bundle:nil]autorelease];
    tmp_view.delegate=self;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

-(IBAction)onMyListBtn_Click:(id)sender{
    
    UIViewCtrl_Channel_Show_01 *myListViewController=[[[UIViewCtrl_Channel_Show_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Show_01" bundle:nil] autorelease];
    myListViewController.from=TypeMe;
    myListViewController.delegate=self;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:myListViewController animated:YES];
    
}

- (void) Close_Message:(id)wParam
{
    [self.view_01 removeFromSuperview];
}

- (void) THREAD_PROC_01:(id)wParam
{
    //    UIFont *font = [UIFont systemFontOfSize:16.0f];
    //    CGSize maxLabelSize = CGSizeMake(248.0f, 2000.0f);
    
    //正式全通
    NSString *baseUrl_01;
    NSString *headStr1;
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr compare:@"111.11.28.29"] == NSOrderedSame) { //正式全通
        baseUrl_01 = @"http://111.11.28.9:8088";
        headStr1 = @"http://111.11.28.9:8088/staffCorner/phoneInterface.action";
    }else if([headStr compare:@"111.11.29.65"] == NSOrderedSame) { //正式全通
        baseUrl_01 = @"http://111.11.29.65:8080";
        headStr1 = @"http://111.11.29.65:8080/staffCorner/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){ //正式政企
        baseUrl_01 = @"http://111.11.28.9:8088";
        headStr1 = @"http://111.11.28.9:8088/staffCornerzq/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.53"] == NSOrderedSame){ //正式政企
        baseUrl_01 = @"http://111.11.28.53:8088";
        headStr1 = @"http://111.11.28.53:8088/staffCornerzq/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.1"] == NSOrderedSame){ //正式政企
        baseUrl_01 = @"http://111.11.28.1:8080";
        headStr1 = @"http://111.11.28.1:8080/staffCorner/phoneInterface.action";
    }else {
        baseUrl_01 = @"http://111.11.28.30:8091";
        headStr1 = @"http://111.11.28.30:8091/staffCorner/phoneInterface.action";
    }
    //     baseUrl_01 = @"http://10.120.145.55:8080";
    //    headStr1 = @"http://10.120.145.55:8080/staffCorner/phoneInterface.action";
    
    NSString *dizhi;
    NSString *str_userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    
    if(from==TypeAll){
        dizhi = [NSString stringWithFormat:@"%@?cmd=queryStatusList&pageNumber=1&pageCount=20&isMyPost=1&userId=%@",headStr1,str_userid];
    }else{
        dizhi = [NSString stringWithFormat:@"%@?cmd=queryStatusList&pageNumber=1&pageCount=20&isMyPost=0&userId=%@",headStr1,str_userid];
    }
    
    
    
    //     dizhi = [NSString stringWithFormat:@"%@?cmd=queryStatusList&pageNumber=1&pageCount=20&userId=%@",headStr1,str_userid];
    
    
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr_data = [dic valueForKey:@"data"];
        [self.array_weblog removeAllObjects];
        for (NSInteger i = 0; i < [arr_data count]; i++) {
            
            NSDictionary *dic_item = [arr_data objectAtIndex:i];
            
            
            NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[dic_item valueForKey:@"userId"]]];
            
            
            NSMutableDictionary *row_item = [NSMutableDictionary dictionary];
            [row_item setValue:[dic_item valueForKey:@"id"]  forKey:@"WEBLOG_ID"];
            
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath] != NO)
            {
                [row_item setValue:[UIImage imageWithContentsOfFile:filePath] forKey:@"HEAD_IMAGE"];
            }else{
                NSString *userId = [dic_item valueForKey:@"userId"];
                User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userId];
                if([user.sex isEqualToString:@"0"])
                {
                    [row_item setValue:[UIImage imageNamed:@"fm_online.png"] forKey:@"HEAD_IMAGE"];
                }
                else
                {
                    [row_item setValue:[UIImage imageNamed:@"m_online.png"] forKey:@"HEAD_IMAGE"];
                }
            }
            
            NSString *sSrcContent = [dic_item valueForKey:@"content"];
            
            [row_item setValue:[dic_item valueForKey:@"userName"] forKey:@"USER_ACCOUNT"];
            [row_item setValue:sSrcContent forKey:@"MESSAGE_CONTENT"];
            [row_item setValue:[[dic_item valueForKey:@"publishTime"] substringWithRange:NSMakeRange(5, 11)] forKey:@"SEND_TIME"];
            [row_item setValue:[dic_item valueForKey:@"good"] forKey:@"UP_MSG_COUNT"];
            [row_item setValue:[dic_item valueForKey:@"commentCount"] forKey:@"REPLY_COUNT"];
            [row_item setValue:[dic_item valueForKey:@"isPraised"] forKey:@"IS_PRAISED"];
            [row_item setValue:[dic_item valueForKey:@"userId"] forKey:@"AUTHER_ID"];
            NSMutableArray *item_array = [NSMutableArray array];
            NSArray *arr_pics = [[dic_item valueForKey:@"picName"] componentsSeparatedByString:@","];
            
            for (NSInteger j = 0; j < [arr_pics count]; j++) {
                NSURL *url = [NSURL URLWithString:[baseUrl_01 stringByAppendingString:[[dic_item valueForKey:@"picAddress"] stringByAppendingString:[arr_pics objectAtIndex:j]]]];
                NSData *data_img = [NSData dataWithContentsOfURL:url];
                UIImage *img_tmp = [UIImage imageWithData:data_img];
                if (img_tmp != nil) {
                    [item_array addObject:img_tmp];
                }
            }
            
            [row_item setValue:item_array forKey:@"WEBLOG_IMAGE"];
            
            
            
            FaceStrUtils *utils=[[FaceStrUtils alloc] init];
            int faceStrHeight=[utils getFaceStrViewHeight:sSrcContent withWidth:244];
            
            if (0 < [item_array count] && [item_array count] <= 3) {
                [row_item setValue:[NSNumber numberWithFloat:76.0f + faceStrHeight + 73.0f] forKey:@"CELL_HEIGHT"];
            }else if (3 < [item_array count] && [item_array count] <= 6) {
                [row_item setValue:[NSNumber numberWithFloat:76.0f +faceStrHeight+ 73.0f * 2.0f] forKey:@"CELL_HEIGHT"];
            }else if (6 < [item_array count] && [item_array count] <= 9) {
                [row_item setValue:[NSNumber numberWithFloat:76.0f + faceStrHeight + 73.0f * 3.0f] forKey:@"CELL_HEIGHT"];
            }else{
                [row_item setValue:[NSNumber numberWithFloat:76.0f + faceStrHeight-10] forKey:@"CELL_HEIGHT"];
            }
            
            [self.array_weblog addObject:row_item];
        }
        
    }
    else //没数据
    {
        NSLog(@"员工园地没有数据");
    }
  
    NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
    [lParam setValue:[NSNumber numberWithInteger:1] forKey:@"COMMAND_ID"];
    [self performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
}


- (void) THREAD_PROC_02:(id)wParam
{
    NSString *headStr1;
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr compare:@"111.11.28.29"] == NSOrderedSame) { //正式全通
        headStr1 = @"http://111.11.28.9:8088/staffCorner/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){ //正式政企
        headStr1 = @"http://111.11.28.9:8088/staffCornerzq/phoneInterface.action";
    } else {
        headStr1 = @"http://111.11.28.30:8091/staffCorner/phoneInterface.action";
    }
    //        headStr1 = @"http://10.120.145.55:8080/staffCorner/phoneInterface.action";
    
    
    NSString *str_userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    NSString *str_nickname = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];
    NSString *str_body = [NSString stringWithFormat:@"cmd=publishGood&postId=%@&userId=%@&userName=%@", [wParam valueForKey:@"WEBLOG_ID"], str_userid,str_nickname];
    
    NSURL *url = [NSURL URLWithString:headStr1];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSData *data = [str_body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error = nil;
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if ([[dic valueForKey:@"resultcode"] integerValue] == 0) {
            NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:[[wParam valueForKey:@"WEBLOG_INDEX"] integerValue]];
            
            [row_item setValue:[dic valueForKey:@"goodCount"] forKey:@"UP_MSG_COUNT"];
            
            NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
            [lParam setValue:[NSNumber numberWithInteger:2] forKey:@"COMMAND_ID"];
            [self performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
        }else{
            NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
            [lParam setValue:[NSNumber numberWithInteger:3] forKey:@"COMMAND_ID"];
            [self performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
        }
        
    }
    else //没数据
    {
        NSLog(@"员工园地没有数据");
        NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
        [lParam setValue:[NSNumber numberWithInteger:3] forKey:@"COMMAND_ID"];
        [self performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
    }
    
}


- (void) ON_COMMAND:(id)wParam
{
    NSInteger ncmdid = [[wParam valueForKey:@"COMMAND_ID"] integerValue];
    if (ncmdid == 1) {
        [self.tableview_01 reloadData];
        [[STHUDManager sharedManager] hideHUDInView:self.view];
    }else if (ncmdid == 2) {
        [self.tableview_01 reloadData];
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        [self.label_01 setText:@"点赞成功"];
        [self.view addSubview:self.view_01];
        [self performSelector:@selector(Close_Message:) withObject:nil afterDelay:0.8];
        
    }else if (ncmdid == 3) {
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        [self.label_01 setText:@"点赞失败"];
        [self.view addSubview:self.view_01];
        [self performSelector:@selector(Close_Message:) withObject:nil afterDelay:0.8];
    }
}

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:PARAMTER_KEY_NOTIFY_REFRESH_DATA] == NSOrderedSame) {
        [[STHUDManager sharedManager] showHUDInView:self.view];
        [self.array_weblog removeAllObjects];
        NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:wParam] autorelease];
        [tmp_thread start];
    }
}
//commentCount = 0;
//content = Qqqq;
//good = 0;
//id = ef8b9c9e4621caa30146230fb8c4003a;
//isPraised = 0;
//picAddress = "/staffCorner/upload/2807504/";
//picName = "";
//publishTime = "2014-05-22 16:32:51";
//userId = 2807504;
//userName = "\U674e\U5f3a";
@end
