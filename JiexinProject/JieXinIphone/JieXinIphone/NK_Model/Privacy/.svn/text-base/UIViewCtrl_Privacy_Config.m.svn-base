//
//  UIView_Privacy_Config.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-2-26.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "UIViewCtrl_Privacy_Config.h"
#import "AppDelegate.h"
#import "UIViewCtrl_Password_Modify.h"
#import "ChatDataHelper.h"
#import "documentDataHelp.h"
@interface UIViewCtrl_Privacy_Config ()

@end

@implementation UIViewCtrl_Privacy_Config

@synthesize m_sTmpFileSize = _m_sTmpFileSize;
@synthesize m_sTmpImageSize = _m_sTmpImageSize;
@synthesize tableview_01 = _tableview_01;

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
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sFilePath = [sPath stringByAppendingPathComponent:@"temp_file"];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    
    
    lTmpFileSize = [self fileSizeForDir:sFilePath];
    lTmpImageSize = [self fileSizeForDir:sImagePath];
    
    if (lTmpFileSize > 1024 * 1024) {
        self.m_sTmpFileSize = [NSString stringWithFormat:@"%.2f MB", lTmpFileSize / (1024.0 * 1024.0)];
    }else if (lTmpFileSize > 1024) {
        self.m_sTmpFileSize = [NSString stringWithFormat:@"%.2f KB", lTmpFileSize / (1024.0)];
    }else {
        self.m_sTmpFileSize = [NSString stringWithFormat:@"%ld B", lTmpFileSize];
    }
    
    if (lTmpImageSize > 1024 * 1024) {
        self.m_sTmpImageSize = [NSString stringWithFormat:@"%.2f MB", lTmpImageSize / (1024.0 * 1024.0)];
    }else if (lTmpImageSize > 1024) {
        self.m_sTmpImageSize = [NSString stringWithFormat:@"%.2f KB", lTmpImageSize / (1024.0)];
    }else {
        self.m_sTmpImageSize = [NSString stringWithFormat:@"%ld B", lTmpImageSize];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Do any additional setup after loading the view from its nib.
    self.m_sTmpFileSize = nil;
    self.m_sTmpImageSize = nil;
}


#pragma label -
#pragma label UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_uiview_more_cell_identifier_01 = @"privacy_config_cell_identifier_01";
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:str_uiview_more_cell_identifier_01];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_uiview_more_cell_identifier_01] autorelease];
       
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"清除图片缓存（%@）" ,self.m_sTmpImageSize];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"清除文件缓存（%@）" ,self.m_sTmpFileSize];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"清空会话列表";
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"清空所有消息";
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.textLabel.text = @"清空所有服务消息";

    }else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"修改登录密码";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma label -
#pragma label UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0f;
    }else{
        return 0.0f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == [self numberOfSectionsInTableView:tableView] - 1){
        return 20.0f;
    }else{
        return 0.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {             //清除图片缓存
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企信" message:@"确定要清除图片缓存码？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.section == 0 && indexPath.row == 1) {       //清除文件缓存
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企信" message:@"确定要清除文件缓存码？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.section == 1 && indexPath.row == 0) {       //清空会话列表
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企信" message:@"“取消”会保留会话列表，“确认”则清空会话列表！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.section == 1 && indexPath.row == 1) {       //清空所有消息
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企信" message:@"本操作将清空您所有的会话和消息记录，点击“确定”将完成本操作，点击“取消”放弃本操作！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.section == 1 && indexPath.row == 2) {       //清空所有服务消息
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企信" message:@"本操作将清空您所有服务消息记录，点击“确定”将完成本操作，点击“取消”放弃本操作！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];

    }else if (indexPath.section == 2 && indexPath.row == 0) {       //修改登录密码
        UIViewCtrl_Password_Modify *tmp_uiview = [[[UIViewCtrl_Password_Modify alloc] initWithNibName:@"UIViewCtrl_Password_Modify" bundle:nil] autorelease];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_uiview animated:YES];
    }else{
        
    }
    
}

#pragma label -
#pragma label UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && [[alertView message] compare:@"确定要清除图片缓存码？"] == NSOrderedSame) {
        NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
        [self clearFileForDir:sImagePath];
        self.m_sTmpImageSize = @"0.0 B";
        [self.tableview_01 reloadData];
        
    }else if (buttonIndex == 1 && [[alertView message] compare:@"确定要清除文件缓存码？"] == NSOrderedSame) {
        NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *sFilePath = [sPath stringByAppendingPathComponent:@"temp_file"];
        [self clearFileForDir:sFilePath];
        self.m_sTmpFileSize = @"0.0 B";
        [self.tableview_01 reloadData];
    }
    else if (buttonIndex == 1 && [[alertView message] compare:@"“取消”会保留会话列表，“确认”则清空会话列表！"] == NSOrderedSame) {
        [[ChatDataHelper sharedService] deleteAllConversations];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllConversation object:nil];
    }
    else if (buttonIndex == 1 && [[alertView message] compare:@"本操作将清空您所有的会话和消息记录，点击“确定”将完成本操作，点击“取消”放弃本操作！"] == NSOrderedSame) {
        //qing
        [[ChatDataHelper sharedService] deleteAllMessages];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllMessages object:nil];
    }
    else if (buttonIndex == 1 && [[alertView message] compare:@"本操作将清空您所有服务消息记录，点击“确定”将完成本操作，点击“取消”放弃本操作！"] == NSOrderedSame) {
        [[documentDataHelp sharedService ]deleteAllNews];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newsShow" object:nil];
        //qing
//        [[ChatDataHelper sharedService] deleteAllMessages];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllMessages object:nil];
    }



}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

-(long)fileSizeForDir:(NSString*)path
{
    long lSize = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            lSize += fileAttributeDic.fileSize;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    [fileManager release];
    return lSize;
    
}

- (void) clearFileForDir:(NSString*)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        [fileManager removeItemAtPath:fullPath error:nil];
    }
    [fileManager release];
}

@end
