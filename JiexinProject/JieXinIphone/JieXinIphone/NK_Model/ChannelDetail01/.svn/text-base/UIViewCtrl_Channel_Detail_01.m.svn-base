//
//  UIViewCtrl_Channel_Detail_01.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Channel_Detail_01.h"
#import "UITableViewCell_04.h"
#import "UITableViewCell_05.h"
#import "UITableViewCell_07.h"
#import "UITableViewCell_08.h"
#import "UIViewCtrl_Channel_Reply_01.h"
#import "UIViewCtrl_Channel_Picture_01.h"
#import "NGLABAL_DEFINE.h"
#import "CustomAlertView.h"
#import "LinkDateCenter.h"
#import "Emoji_Translation.h"
#import "SynUserIcon.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "FaceStrUtils.h"

@interface UIViewCtrl_Channel_Detail_01 () <CustomeAlertViewDelegate>
{
    NSInteger nDisplayType;
}

@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UIButton *button_02;
@property (assign, nonatomic) IBOutlet UIButton *button_03;
@property (assign, nonatomic) IBOutlet UITableView *tableview_01;

@property (strong, nonatomic) NSMutableArray * array_remark;
@property (strong, nonatomic) NSMutableArray * array_up;
@property (strong, nonatomic) UIView *view_01;
@property (strong, nonatomic) UIView *view_02;
@property (strong, nonatomic) UILabel *label_01;

@end

@implementation UIViewCtrl_Channel_Detail_01

@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize button_03 = _button_03;
@synthesize tableview_01 = _tableview_01;
@synthesize array_weblog = _array_weblog;
@synthesize array_remark = _array_remark;
@synthesize array_up = _array_up;
@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize label_01 = _label_01;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.array_weblog = [NSMutableArray array];
        self.array_remark = [NSMutableArray array];
        self.array_up = [NSMutableArray array];
        nDisplayType = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
   // [self.tableview_01 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if(IOSVersion>=7.0){
    self.tableview_01.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    [wParam setValue:[row_item valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:wParam] autorelease];
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
    self.array_remark = nil;
    self.array_up = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma label -
#pragma label UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row_count = 2 + [self.array_up count];
    if (nDisplayType == 0) {
         row_count = 2 + [self.array_remark count];
        
    }
    return row_count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sId_01 = @"uiviewctrl_channel_detail_01_cell_01";
    static NSString *sId_02 = @"uiviewctrl_channel_detail_01_cell_02";
    static NSString *sId_03 = @"uiviewctrl_channel_detail_01_cell_03";
    static NSString *sId_04 = @"uiviewctrl_channel_detail_01_cell_04";
    
    if (indexPath.row == 0) {
        NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
        UITableViewCell_04 *cell = [tableView dequeueReusableCellWithIdentifier:sId_01];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"UITableViewCell_04" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:sId_01];
            cell = [tableView dequeueReusableCellWithIdentifier:sId_01];
        }
        
        [[cell button_01] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_02] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_03] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_04] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_05] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_06] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_07] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_08] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[cell button_09] addTarget:self action:@selector(onBtnFun02_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.chatBtn addTarget:self action:@selector(onBtnFun06_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [[cell button_10] setHidden:YES];
        
        
        if (row_item != nil && [row_item valueForKeyPath:@"HEAD_IMAGE"] != nil) {
            [[cell imageview_10] setImage:[row_item valueForKeyPath:@"HEAD_IMAGE"]];
        }
        
        if (row_item != nil && [row_item valueForKeyPath:@"USER_ACCOUNT"] != nil) {
            [[cell label_01] setText:[row_item valueForKeyPath:@"USER_ACCOUNT"]];
        }
        
        if (row_item != nil && [row_item valueForKeyPath:@"MESSAGE_CONTENT"] != nil) {
         
            UIFont *font = [UIFont systemFontOfSize:16.0f];
            NSString *sContent = [row_item valueForKeyPath:@"MESSAGE_CONTENT"];

            [[cell label_02] showMessage:[row_item valueForKeyPath:@"MESSAGE_CONTENT"] withWidth:252];
//            cell.label_02.backgroundColor=[UI Color redColor];
            FaceStrUtils *utils=[[FaceStrUtils alloc] init];
            int faceStrHeight=[utils getFaceStrViewHeight:sContent withWidth:252];

            [[cell label_02] setFrame:CGRectMake(58, 33, [cell label_02].frame.size.width+15, faceStrHeight)];
            
            NSInteger pos_y = [[cell label_02] frame].origin.y + [[cell label_02] frame].size.height + 6;
            
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
            [self.button_01 setTitle:[NSString stringWithFormat:@" %@",[row_item valueForKeyPath:@"UP_MSG_COUNT"]] forState:UIControlStateNormal];
        }
        
        if ([[row_item valueForKey:@"IS_PRAISED"] integerValue] == 0) {
            [self.button_01 setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_03.png"] forState:UIControlStateNormal];
        }else {
            [self.button_01 setImage:[UIImage imageNamed:@"uiview_channel_detail_01_image_05.png"] forState:UIControlStateNormal];
        }
        
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        
        if (tmp_image != nil && [tmp_image count] > 0) {
            [[cell imageview_01] setImage:[tmp_image objectAtIndex:0]];
        }else{
            [[cell imageview_01] setHidden:YES];
            [[cell button_01] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 1) {
            [[cell imageview_02] setImage:[tmp_image objectAtIndex:1]];
        }else{
            [[cell imageview_02] setHidden:YES];
            [[cell button_02] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 2) {
            [[cell imageview_03] setImage:[tmp_image objectAtIndex:2]];
        }else{
            [[cell imageview_03] setHidden:YES];
            [[cell button_03] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 3) {
            [[cell imageview_04] setImage:[tmp_image objectAtIndex:3]];
        }else{
            [[cell imageview_04] setHidden:YES];
            [[cell button_04] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 4) {
            [[cell imageview_05] setImage:[tmp_image objectAtIndex:4]];
        }else{
            [[cell imageview_05] setHidden:YES];
            [[cell button_05] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 5) {
            [[cell imageview_06] setImage:[tmp_image objectAtIndex:5]];
        }else{
            [[cell imageview_06] setHidden:YES];
            [[cell button_06] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 6) {
            [[cell imageview_07] setImage:[tmp_image objectAtIndex:6]];
        }else{
            [[cell imageview_07] setHidden:YES];
            [[cell button_07] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 7) {
            [[cell imageview_08] setImage:[tmp_image objectAtIndex:7]];
        }else{
            [[cell imageview_08] setHidden:YES];
            [[cell button_08] setHidden:YES];
        }
        
        if (tmp_image != nil && [tmp_image count] > 8) {
            [[cell imageview_09] setImage:[tmp_image objectAtIndex:8]];
        }else{
            [[cell imageview_09] setHidden:YES];
            [[cell button_09] setHidden:YES];
        }
        
        UILongPressGestureRecognizer *longPressGR = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headViewLongpress:)] autorelease];
        longPressGR.minimumPressDuration = 0.5f;
        [cell.imageview_10 addGestureRecognizer:longPressGR];
        [cell.imageview_10 setUserInteractionEnabled:YES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 1) {
        UITableViewCell_07 *cell = [tableView dequeueReusableCellWithIdentifier:sId_02];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"UITableViewCell_07" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:sId_02];
            cell = [tableView dequeueReusableCellWithIdentifier:sId_02];
        }
        [cell.button_01 addTarget:self action:@selector(onBtnFun04_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button_02 addTarget:self action:@selector(onBtnFun05_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.label_01 setText:[[NSNumber numberWithInteger:[self.array_remark count]] stringValue]];
        [cell.label_02 setText:[[NSNumber numberWithInteger:[self.array_up count]] stringValue]];
        if (nDisplayType == 0) {
            [cell.button_01 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell.button_02 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [cell.button_01 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [cell.button_02 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row > 1 && nDisplayType == 0){
        
        NSMutableDictionary *row_item = [self.array_remark objectAtIndex:[indexPath row] - 2];
        UITableViewCell_05 *cell = [tableView dequeueReusableCellWithIdentifier:sId_03];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"UITableViewCell_05" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:sId_03];
            cell = [tableView dequeueReusableCellWithIdentifier:sId_03];
        }
        if (row_item != nil && [row_item valueForKeyPath:@"USER_ACCOUNT"] != nil) {
            [[cell label_01] setText:[row_item valueForKeyPath:@"USER_ACCOUNT"]];
        }
        
        if (row_item != nil && [row_item valueForKeyPath:@"SEND_TIME"] != nil) {
            [[cell label_02] setText:[row_item valueForKeyPath:@"SEND_TIME"]];
        }
        
        if (row_item != nil && [row_item valueForKeyPath:@"MESSAGE_CONTENT"] != nil) {
            NSString *sContent = [row_item valueForKeyPath:@"MESSAGE_CONTENT"];
            [[cell label_03] showMessage:[row_item valueForKeyPath:@"MESSAGE_CONTENT"] withWidth:self.view.frame.size.width-20];
            FaceStrUtils *utils=[[FaceStrUtils alloc] init];
            int faceStrHeight=[utils getFaceStrViewHeight:sContent withWidth:self.view.frame.size.width-20];
            [[cell label_03] setFrame:CGRectMake([cell label_03].frame.origin.x, [cell label_03].frame.origin.y, [cell label_03].frame.size.width,faceStrHeight)];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row > 1 && nDisplayType == 1){
        
        NSMutableDictionary *row_item = [self.array_up objectAtIndex:[indexPath row] - 2];
        UITableViewCell_08 *cell = [tableView dequeueReusableCellWithIdentifier:sId_04];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"UITableViewCell_08" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:sId_04];
            cell = [tableView dequeueReusableCellWithIdentifier:sId_04];
        }
        if (row_item != nil && [row_item valueForKeyPath:@"USER_ID"] != nil) {
            NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[row_item valueForKey:@"USER_ID"]]];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath] != NO)
            {
                [[cell imageview_01] setImage:[UIImage imageWithContentsOfFile:filePath]];
            }else{
                NSString *userId = [row_item valueForKey:@"USER_ID"];
                User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userId];
                if([user.sex isEqualToString:@"0"])
                {
                    [[cell imageview_01] setImage:[UIImage imageNamed:@"fm_online.png"]];
                }
                else
                {
                   [[cell imageview_01] setImage:[UIImage imageNamed:@"m_online.png"]];
                }
            }
            
            
        }
        [cell.label_01 setText:[row_item valueForKey:@"USER_ACCOUNT"]];
        [cell.label_02 setText:[row_item valueForKey:@"SEND_TIME"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    
    }
    return nil;
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
    if (indexPath.row == 0 && [self.array_weblog objectAtIndex:indexPath.row] != nil) {
        fHeight = [[[self.array_weblog objectAtIndex:0] valueForKey:@"CELL_HEIGHT"] floatValue]-10;
    }else if (indexPath.row == 1){
        fHeight = 32.0f;
    }else if (indexPath.row > 1 && nDisplayType == 0){
        fHeight = [[[self.array_remark objectAtIndex:indexPath.row - 2] valueForKey:@"CELL_HEIGHT"] floatValue]+10;
    }else if (indexPath.row > 1 && nDisplayType == 1){
        fHeight = [[[self.array_up objectAtIndex:indexPath.row - 2] valueForKey:@"CELL_HEIGHT"] floatValue];
    }
    return fHeight;
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFun01_Click:(id)sender
{
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    UIViewCtrl_Channel_Reply_01 *tmp_view = [[[UIViewCtrl_Channel_Reply_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Reply_01" bundle:nil]autorelease];
    tmp_view.sWeblog_Id = [row_item valueForKey:@"WEBLOG_ID"];
    tmp_view.headImage= [row_item valueForKey:@"HEAD_IMAGE"];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    
}
- (IBAction)onBtnFun02_Click:(id)sender
{
    UITableViewCell_04 *cell = (UITableViewCell_04 *)[self.tableview_01 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (sender == [cell button_01]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_02]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_03]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_04]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_05]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_06]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_07]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_08]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
    
    if (sender == [cell button_09]) {
        UIViewCtrl_Channel_Picture_01 *tmp_view = [[[UIViewCtrl_Channel_Picture_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Picture_01" bundle:nil]autorelease];
        NSDictionary * row_item = [self.array_weblog objectAtIndex:0];
        NSArray *tmp_image = [row_item valueForKey:@"WEBLOG_IMAGE"];
        [tmp_view setArr_images:tmp_image];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }
}

- (IBAction)onBtnFun03_Click:(id)sender
{
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    if ([[row_item valueForKey:@"IS_PRAISED"] integerValue] != 0) {
        [self.label_01 setText:@"您已赞过"];
        [self.view addSubview:self.view_01];
        [self performSelector:@selector(Close_Message:) withObject:nil afterDelay:0.8];
        return;
    }
    [wParam setValue:[row_item valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    [self.array_up removeAllObjects];
    [self.array_remark removeAllObjects];
    
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_02:) object:wParam] autorelease];
    [tmp_thread start];
    
}

- (IBAction)onBtnFun04_Click:(id)sender
{
    nDisplayType = 0;
//    NSMutableArray *IndexArr=[[NSMutableArray alloc] initWithCapacity:1];
//    for(int i=2;i<){
//    
//    }
     [self.tableview_01 reloadData];
}

- (IBAction)onBtnFun05_Click:(id)sender
{
    nDisplayType = 1;
    [self.tableview_01 reloadData];
}

- (void)onBtnFun06_Click:(id)sender
{
    
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    NSString *groupid = [row_item valueForKey:@"AUTHER_ID"];
    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
    ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    //这里要传群组的id
    feed.relativeId = [groupid intValue];
    feed.isGroup = 0;
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    detail.conFeed = feed;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
    [detail release];
}

- (IBAction)onBtnFun07_Click:(id)sender
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    [self.array_up removeAllObjects];
    [self.array_remark removeAllObjects];
    NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
    NSMutableDictionary *wParam = [NSMutableDictionary dictionary];
    [wParam setValue:[row_item valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:wParam] autorelease];
    [tmp_thread start];
    
}
- (void) Close_Message:(id)wParam
{
    [self.view_01 removeFromSuperview];
}

- (void) THREAD_PROC_01:(id)wParam
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
    
    NSString *dizhi = [NSString stringWithFormat:@"%@?cmd=getCommentList&statusId=%@&pageNumber=1&pageCount=20",headStr1, [wParam valueForKey:@"WEBLOG_ID"]];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        CGSize maxLabelSize = CGSizeMake(252.0f, 2000.0f);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr_data = [dic valueForKey:@"data"];
        for (int i = 0; i < [arr_data count]; i ++) {
            NSDictionary *dic_item = [arr_data objectAtIndex:i];
            
            NSString *sSrcContent = [dic_item valueForKey:@"content"];
            NSString *sDestContent=[Emoji_Translation EmojiWithQixin:sSrcContent ];
//            NSMutableArray * faceArr = [[NSMutableArray alloc]init];
//            [self getImageRange:sDestContent :faceArr];
//            int faceCnt =[self faceArr:faceArr];
//            NSLog(@"faceCnt = %d",faceCnt);
//            NSString*ss = [sDestContent substringToIndex:sDestContent.length-faceCnt*10];
//            UILabel * ll = [self fitLable:ss and_x:0 and_y:0 and_width:250];
            NSMutableDictionary *row_item = [NSMutableDictionary dictionary];
            [row_item setValue:[dic_item valueForKey:@"userName"] forKey:@"USER_ACCOUNT"];
            [row_item setValue:sDestContent forKey:@"MESSAGE_CONTENT"];
            [row_item setValue:[dic_item valueForKey:@"time"] forKey:@"SEND_TIME"];
            FaceStrUtils *utils=[[FaceStrUtils alloc] init];
            int faceStrHeight=[utils getFaceStrViewHeight:sDestContent withWidth:self.view.frame.size.width];
            [row_item setValue:[NSNumber numberWithFloat:40.0f +faceStrHeight] forKey:@"CELL_HEIGHT"];
            [self.array_remark addObject:row_item];
        }
        
    }
    else //没数据
    {
        NSLog(@"员工园地没有数据");
    }
    
    dizhi = [NSString  stringWithFormat:@"%@?cmd=queryPraiseUsers&statusId=%@&pageNumber=1&pageCount=120",headStr1, [wParam valueForKey:@"WEBLOG_ID"]];
    NSString *myencodeUrlStr = [dizhi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    url = [NSURL URLWithString:myencodeUrlStr];
    request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    response = nil;
    error = nil;
    received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arr_data = [dic valueForKey:@"data"];
        for (int i = 0; i < [arr_data count]; i ++) {
            
            NSDictionary *dic_item = [arr_data objectAtIndex:i];
            NSMutableDictionary *row_item = [NSMutableDictionary dictionary];
            [row_item setValue:[dic_item valueForKey:@"userName"] forKey:@"USER_ACCOUNT"];
            [row_item setValue:[dic_item valueForKey:@"userId"] forKey:@"USER_ID"];
            [row_item setValue:[dic_item valueForKey:@"time"] forKey:@"SEND_TIME"];
            [row_item setValue:[NSNumber numberWithFloat:44.0f] forKey:@"CELL_HEIGHT"];
            [self.array_up insertObject:row_item atIndex:0];
        }
    }
    else //没数据
    {
        NSLog(@"员工园地没有数据 - 点赞列表");
    }
    
    NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
    [lParam setValue:[NSNumber numberWithInteger:1] forKey:@"COMMAND_ID"];
    [self performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
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
            NSMutableDictionary *row_item = [self.array_weblog objectAtIndex:0];
            
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
        NSMutableDictionary *row_item_01 = [self.array_weblog objectAtIndex:0];
        [row_item_01 setValue:[NSNumber numberWithInteger:1] forKeyPath:@"IS_PRAISED"];
        
        [self.tableview_01 reloadData];
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_REFRESH_DATA object:nil];
        
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
        NSDictionary *tmp_dic = [[self.array_weblog objectAtIndex:0] retain];
        [self.array_weblog removeAllObjects];
        [self.array_weblog addObject:tmp_dic];
        [self.tableview_01 reloadData];
        [tmp_dic release];
        NSMutableDictionary *lParam = [NSMutableDictionary dictionary];
        [lParam setValue:[tmp_dic valueForKey:@"WEBLOG_ID"] forKey:@"WEBLOG_ID"];
        [self.array_up removeAllObjects];
        [self.array_remark removeAllObjects];
        [self.tableview_01 reloadData];
        NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:lParam] autorelease];
        [tmp_thread start];
    }
}

-(void)headViewLongpress:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if(![self.view viewWithTag:kAlertShowTag])
    {
        //UIImageView *img_gesture = (UIImageView*)gestureRecognizer.view;
        //UIView *view_img = (UIView *)[img_gesture superview];
        NSString *sender = [[self.array_weblog objectAtIndex:0]valueForKey:@"AUTHER_ID"];
        if (sender && [sender isKindOfClass:[NSString class]])
        {
            User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:sender];
            CustomAlertView *customAllertView = [[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:user];
            [self.view addSubview:customAllertView];
            customAllertView.delegate = self;
            customAllertView.tag = kAlertShowTag;
            [customAllertView release];
        }
    }
}

@end
