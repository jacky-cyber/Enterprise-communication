//
//  UIViewCtrl_Software_Status.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Software_Status.h"
#import "AppDelegate.h"
#import "UIViewCtrl_Auto_Reply.h"
#import "NGLABAL_DEFINE.h"

@interface UIViewCtrl_Software_Status ()

@end

@implementation UIViewCtrl_Software_Status

@synthesize tableview_01 = _tableview_01;
@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;

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

    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"pushUserStatus" object:nil];
    
    NSString *sStatus = kUserRunStatusOnline;
 
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Online) {
        sStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Busy) {
        sStatus = kUserRunStatusObusyline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Leave) {
        sStatus = kUserRunStatusLeave;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Hidden) {
        sStatus = kUserRunStatusHidden;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_AndroidOnLine) {
        sStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_IosOnLine) {
        sStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_WebOnLine) {
        sStatus = kUserRunStatusOnline;
    }
    
    if ([sStatus compare:kUserRunStatusOnline] == NSOrderedSame) {

        m_nSelIndex = 0;
    }else if ([sStatus compare:kUserRunStatusHidden] == NSOrderedSame){
        m_nSelIndex = 1;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


#pragma label -
#pragma label UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_uiview_software_status_cell_identifier_01 = @"software_status_cell_identifier_01";
    static NSString *str_uiview_software_status_cell_identifier_03 = @"software_status_cell_identifier_03";
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:str_uiview_software_status_cell_identifier_01];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_uiview_software_status_cell_identifier_01] autorelease];
            UIImage *image_01 = [UIImage imageNamed:@"nuiview_software_status_01.png"];
            [cell.imageView setImage:image_01];
        }
        
        cell.textLabel.text = @"在线";

    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:str_uiview_software_status_cell_identifier_03];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_uiview_software_status_cell_identifier_03] autorelease];
            UIImage *image_01 = [UIImage imageNamed:@"nuiview_software_status_02.png"];
            [cell.imageView setImage:image_01];
        }
        
        cell.textLabel.text = @"隐身";

    }
    
    if (indexPath.row == m_nSelIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma label -
#pragma label UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_nSelIndex = indexPath.row;
    [tableView reloadData];
    if (indexPath.section == 0 && indexPath.row == 0) {

        [[NSUserDefaults standardUserDefaults] setValue:kUserRunStatusOnline forKey:kUserRunStatus];
        [self changeStatus:@{@"status":@"1"}];

    }else if (indexPath.section == 0 && indexPath.row == 1) {

        [[NSUserDefaults standardUserDefaults] setValue:kUserRunStatusHidden forKey:kUserRunStatus];
        [self changeStatus:@{@"status":@"4"}];
    }
    
    
}

- (void)changeStatus:(NSDictionary *)dic
{
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSMutableArray *msg_packet = [NSMutableArray arrayWithObjects:@{@"type":@"req"}, @{@"sessionID":sessionId}, @{@"cmd":@"pushUserStatus"}, @{@"loginType": @"1"}, nil];
    [msg_packet addObject:dic];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:msg_packet];
    NSLog(@"%@", xmlStr);
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];

}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_RELOAD_DATA object:nil];
    [[AppDelegate shareDelegate].rootNavigation popToRootViewControllerAnimated:YES];
}

- (IBAction)onBtnAutoReply_Click:(id)sender{
    
    UIViewCtrl_Auto_Reply *tmp_view = [[[UIViewCtrl_Auto_Reply alloc] initWithNibName:@"UIViewCtrl_Auto_Reply" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}


@end
