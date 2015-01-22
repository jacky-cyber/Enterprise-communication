//
//  UIViewCtrl_Pic_Business_Card.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-2-26.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "UIViewCtrl_Pic_Business_Card.h"
#import "AppDelegate.h"
#import"QRCodeGenerator.h"
#import "SynUserInfo.h"
#import "FMDatabase.h"
#import "SynUserIcon.h"

@interface UIViewCtrl_Pic_Business_Card ()

@end

@implementation UIViewCtrl_Pic_Business_Card

@synthesize imageview_01 = _imageview_01;
@synthesize imageview_02 = _imageview_02;
@synthesize imageview_03 = _imageview_03,imageView04;
@synthesize view_01 = _view_01;
@synthesize label_01 = _label_01,label_02;

@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;

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
    [self.view_01 setHidden:YES];
    UIImage *image_01 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
    UIImage *image_02 = [image_01 resizableImageWithCapInsets:UIEdgeInsetsMake(image_01.size.height /2, image_01.size.width / 2, image_01.size.height / 2 , image_01.size.width / 2)];
    
    [self.button_01 setBackgroundImage:image_02 forState:UIControlStateHighlighted];
    [self.button_01 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.button_02 setBackgroundImage:image_02 forState:UIControlStateHighlighted];
    [self.button_02 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[self label_01] setText:[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];
    
    NSString *smallmimage = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserSmallIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    self.imageView04=[[UIImageView alloc]initWithFrame:CGRectMake(140, 241, 40, 40)];
    if ([filemanager fileExistsAtPath:smallmimage] == YES) {
        UIImage *image_01 = [UIImage imageWithContentsOfFile:smallmimage];
        [[self imageview_01] setImage:image_01];
        [self.imageView04 setImage:image_01];
    }else{
        if ([((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserSex]) compare:@"女"] == NSOrderedSame ) {
            UIImage *image_01 = [UIImage imageNamed:@"user_picture_girl.png"];
            [[self imageview_01] setImage:image_01];
            [self.imageView04 setImage:image_01];
        }else{
            UIImage *image_01 = [UIImage imageNamed:@"user_picture.png"];
            [[self imageview_01] setImage:image_01];
            [self.imageView04 setImage:image_01];
        }
    }
    
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    NSString *sNickName = nil;
    NSString *sCompanyName = nil;
    NSString *sDepartName = nil;
    NSString *sTelephone = nil;
    NSString *sMobile = nil;
    NSString *sEMail = nil;
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr isEqualToString:@"111.11.28.29"] || [headStr isEqualToString:@"111.11.28.30"]){
        sCompanyName=@"中移全通系统集成有限公司";
    }
    else if([headStr isEqualToString:@"111.11.28.41"]){
        sCompanyName=@"中国移动政企分公司";
    }
    self.label_02.text=sCompanyName;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kDepartId] integerValue] == 0) {
        sDepartName = @"";
    }else{
        NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
        FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
        if(![distanceDataBase open]){//打开数据库
        }
        NSString *sqlStr = [NSString stringWithFormat:@"select departmentname from im_department where departmentid=?;"];
        FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kDepartId]];
        if ([rs next])
        {
            sDepartName = [rs stringForColumn:@"departmentname"];
        }
        [rs close];
        [distanceDataBase close];
    }
    
    distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select userid, nickname, sex, usersig, telephone, mobile, email, field_char1 from im_users where userid=?;"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    if ([rs next])
    {
        sNickName = [rs stringForColumn:@"nickname"];
        sDepartName = [rs stringForColumn:@"usersig"];
        sTelephone = [rs stringForColumn:@"telephone"];
        sMobile = [rs stringForColumn:@"mobile"];
        sEMail = [rs stringForColumn:@"email"];
    }
    [rs close];
    [distanceDataBase close];
    
    
    NSString *sContent = @"MECARD:N:";
    sContent = [sContent stringByAppendingString:sNickName];
    sContent = [sContent stringByAppendingString:@";ORG:"];
    sContent = [sContent stringByAppendingString:sCompanyName];
    sContent = [sContent stringByAppendingString:@";TITLE:"];
    sContent = [sContent stringByAppendingString:sDepartName];
    sContent = [sContent stringByAppendingString:@";TEL:"];
    sContent = [sContent stringByAppendingString:sTelephone];
    sContent = [sContent stringByAppendingString:@";TEL:"];
    sContent = [sContent stringByAppendingString:sMobile];
    sContent = [sContent stringByAppendingString:@";EMAIL:"];
    sContent = [sContent stringByAppendingString:sEMail];
    sContent = [sContent stringByAppendingString:@";"];
    
    UIImage *image_03 = [QRCodeGenerator qrImageForString:sContent imageSize:self.imageview_02.bounds.size.width subImage:self.imageView04];
    
    [self.imageview_02 setImage:image_03];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnOpenMenu_Click:(id)sender
{
    [self.view_01 setHidden:!self.view_01.hidden];
}

- (IBAction)onBtnSaveCard_Click:(id)sender
{
    [self.view_01 setHidden:YES];
    UIImage *savedImage = self.bigImgv.image;
    
    [self saveImageToPhotos:savedImage];
}

- (IBAction)onBtnSendCard_Click:(id)sender
{
    [self.view_01 setHidden:YES];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您需要先保存名片，然后点击界面左下角的“相机”图标发送" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
    [alert show];
    NSArray *array = [NSArray arrayWithObjects: nil];
    [self sendSMS:@"您好，" recipientList:array];
    
}

- (IBAction)onBtnCloseMenu_Click:(id)sender
{
    [self.view_01 setHidden:YES];
}
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    NSString *msg = nil ;
    
    if (result == MessageComposeResultCancelled){
        msg = @"取消发送";
    }else if (result == MessageComposeResultSent){
        msg = @"发送成功";
    }else{
        msg = @"发送失败";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送结果提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}



@end
