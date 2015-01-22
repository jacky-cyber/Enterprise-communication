//
//  UIView_User_Information.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//
#import "AppDelegate.h"
#import "NGLABAL_DEFINE.h"
#import "UIViewCtrl_User_Information.h"
#import "UIViewCtrl_My_Signature.h"
#import "SynUserInfo.h"
#import "FMDatabase.h"
#import "SynUserIcon.h"
#import "UIViewCtrl_Head_Image.h"
#import "ASIFormDataRequest.h"
#import "PullSelfPicVC.h"
#import "JSON.h"
#import "UIImage-Extensions.h"

@interface UIViewCtrl_User_Information ()<UIAlertViewDelegate>
@property (nonatomic,strong) UIImage *sImage;
@property (nonatomic,strong) UIImage *bImage;
@property (nonatomic) BOOL changeFlag;
@end

@implementation UIViewCtrl_User_Information

@synthesize m_sSignatureText = _m_sSignatureText;
@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize view_03 = _view_03;
@synthesize view_04 = _view_04;
@synthesize view_05 = _view_05;
@synthesize scrollview_01 = _scrollview_01;
@synthesize label_01 = _label_01;
@synthesize viewfield_01 = _viewfield_01;
@synthesize viewfield_02 = _viewfield_02;
@synthesize viewfield_03 = _viewfield_03;
@synthesize viewfield_04 = _viewfield_04;
@synthesize viewfield_05 = _viewfield_05;
@synthesize viewfield_06 = _viewfield_06;
@synthesize viewfield_07 = _viewfield_07;
@synthesize segmentctrl_01 = _segmentctrl_01;
@synthesize imageview_01 = _imageview_01;

@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize button_03 = _button_03;
@synthesize button_04 = _button_04;
@synthesize button_05 = _button_05;

@synthesize sImage;
@synthesize bImage;
@synthesize changeFlag;
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
    bImage=[[UIImage alloc] init];
    sImage=[[UIImage alloc] init];
    changeFlag=NO;

    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    arr_quert = [[NSMutableArray alloc] init];
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];
    
    [self.view_05.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_05.layer setBorderWidth:1.0f];
    [self.view_05.layer setCornerRadius:5.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextField_ValueChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self.button_05 setEnabled:YES];
    self.segmentctrl_01.enabled=NO;
    
    UIImage *image_03 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
    UIImage *image_04 = [image_03 resizableImageWithCapInsets:UIEdgeInsetsMake(image_03.size.height /2, image_03.size.width / 2, image_03.size.height / 2 , image_03.size.width / 2)];
    [self.button_04 setBackgroundImage:image_04 forState:UIControlStateNormal];
    [self.button_04 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *image_05 = [UIImage imageNamed:@"uiview_button_02_pressed.png"];
    UIImage *image_06 = [image_05 resizableImageWithCapInsets:UIEdgeInsetsMake(image_05.size.height /2, image_05.size.width / 2, image_05.size.height / 2 , image_05.size.width / 2)];
    [self.button_02 setBackgroundImage:image_06 forState:UIControlStateNormal];
    [self.button_02 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.button_03 setBackgroundImage:image_06 forState:UIControlStateNormal];
    [self.button_03 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:PARAMTER_KEY_NOTIFY_SIGNATURE_TXTCHG object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:@"getAllSysMsg" object:nil];
    
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *queryDepartIdSqlStr = [NSString stringWithFormat:@"select departmentid from im_department_member where userid=?;"];
    FMResultSet *departIdRs = [distanceDataBase executeQuery:queryDepartIdSqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    NSString *departId = nil;
    if ([departIdRs next])
    {
        departId = [departIdRs stringForColumn:@"departmentid"];
    }
    [departIdRs close];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *queryDepartNameSqlStr = [NSString stringWithFormat:@"select departmentname from im_department where departmentid=?"];
    FMResultSet *departNameRs = [distanceDataBase executeQuery:queryDepartNameSqlStr,departId];
    if ([departNameRs next])
    {
        [self.viewfield_02 setText:[departNameRs stringForColumn:@"departmentname"]];
    }
    
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select userid, nickname, sex, usersig, telephone, mobile, email, field_char1,field_char2 from im_users where userid=?;"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    if ([rs next])
    {
        if ([[rs stringForColumn:@"sex"] intValue] == 0) { //女
            self.segmentctrl_01.selectedSegmentIndex = 1;
        }else{
            self.segmentctrl_01.selectedSegmentIndex = 0;
        }
        [self.viewfield_01 setText:[rs stringForColumn:@"nickname"]];
        [self.viewfield_03 setText:[rs stringForColumn:@"usersig"]];
        [self.viewfield_04 setText:[rs stringForColumn:@"telephone"]];
        [self.viewfield_05 setText:[rs stringForColumn:@"mobile"]];
        [self.viewfield_06 setText:[rs stringForColumn:@"email"]];
        [self.viewfield_07 setText:[rs stringForColumn:@"field_char2"]];
        [self.label_01 setText:[rs stringForColumn:@"field_char1"]];
        if ([[self.label_01 text] length] < 1) {
            [self.label_01 setText:@"这个人很懒，什么也没留下！"];
        }
        [[NSUserDefaults standardUserDefaults] setValue:[rs stringForColumn:@"field_char1"] forKey:kUserSignature];
    }
    [rs close];
    [distanceDataBase close];
    
    
    NSString *smallmimage = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserSmallIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:smallmimage] == YES) {
        UIImage *image_01 = [UIImage imageWithContentsOfFile:smallmimage];
        [[self imageview_01] setImage:image_01];
    }else{
        if ([((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserSex]) compare:@"女"] == NSOrderedSame ) {
            UIImage *image_01 = [UIImage imageNamed:@"user_picture_girl.png"];
            [[self imageview_01] setImage:image_01];
        }else{
            UIImage *image_01 = [UIImage imageNamed:@"user_picture.png"];
            [[self imageview_01] setImage:image_01];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillHideNotification object:nil];
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onBtnModifyHead_LongClick:)];
    [longpress setMinimumPressDuration:0.5f];
    [self.button_01 addGestureRecognizer:longpress];
       [self.view_03 setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataNotification:) name:@"SetUserInfo" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.m_sSignatureText = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma label -
#pragma label UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
   
    bImage = [UIImage image:image fitInSize:CGSizeMake(200, 200 )];
    
     sImage = [UIImage image:image fitInSize:CGSizeMake(45, 45 )];

   UIImage *middle_image = [UIImage image:image fitInSize:CGSizeMake(400, 400 )];

    [arr_quert removeAllObjects];
    
    [[STHUDManager sharedManager] showHUDInView:self.view];

    [self UPloadFiles:@"middle" withImage:middle_image];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    for (int i = 0; i < [arr_quert count]; i++) {
        ASIFormDataRequest *form = [arr_quert objectAtIndex:i];
        [form setDelegate:nil];
    }
    [[AppDelegate shareDelegate].rootNavigation popToRootViewControllerAnimated:YES];
}

- (IBAction)Close_KeyBroad:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onTextField_BeginEdit:(id)sender
{
    changeFlag=YES;
    UITextField *tmp_text = sender;
    [tmp_text setBorderStyle:UITextBorderStyleRoundedRect];
}

- (IBAction)onTextField_EndEdit:(id)sender
{
    changeFlag=YES;
    UITextField *tmp_text = sender;
    [tmp_text setBorderStyle:UITextBorderStyleNone];
}

- (IBAction)onTextField_ValueChange
{
    if (self.button_05.enabled == NO) {
         changeFlag=YES;
        [self.button_05 setEnabled:YES];
    }
    
}

- (IBAction)onBtnOpen_MySign:(id)sender
{
    UIViewCtrl_My_Signature *tmp_view = [[UIViewCtrl_My_Signature alloc] initWithNibName:@"UIViewCtrl_My_Signature" bundle:nil] ;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    
    NSMutableDictionary *lParam = [[NSMutableDictionary alloc] init];
    [lParam setValue:[NSNumber numberWithInteger:COMMAND_INITIALIZE_USER_INFORMATIOIN] forKey:PARAMTER_KEY_COMMAND_ID];
    [lParam setValue:self.m_sSignatureText forKey:PARAMTER_KEY_SIGNATURE_TEXT];
    
    [tmp_view performSelectorOnMainThread:@selector(ON_COMMAND:) withObject:lParam waitUntilDone:YES];
}

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:PARAMTER_KEY_NOTIFY_SIGNATURE_TXTCHG] == NSOrderedSame) {
        self.m_sSignatureText = [[wParam object] valueForKey:PARAMTER_KEY_SIGNATURE_TEXT];
        if (self.m_sSignatureText != nil) {
            [self.label_01 setText:self.m_sSignatureText];
        }
    }else if ([[wParam name] compare:UIKeyboardWillShowNotification] == NSOrderedSame) {
        NSDictionary *info = [wParam userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        [self.view_04 setFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20 - kbSize.height)];
        if ([self.viewfield_01 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 224.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 224.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }else if ([self.viewfield_02 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 314.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 314.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }else if ([self.viewfield_03 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 359.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 359.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }else if ([self.viewfield_04 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 404.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 404.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }else if ([self.viewfield_05 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 449.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 449.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }else if ([self.viewfield_06 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 493.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 493.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }
        else if ([self.viewfield_07 isFirstResponder]) {
            if (self.scrollview_01.frame.size.height < 537.0f + 52.0) {
                [self.scrollview_01 setContentOffset:CGPointMake(0.0f, 537.0f + 52.0 - self.scrollview_01.frame.size.height)];
            }
        }

    }else if ([[wParam name] compare:UIKeyboardWillHideNotification] == NSOrderedSame) {
        [self.view_04 setFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20)];
    }
}

- (IBAction)onBtnSave_Click:(id)sender
{
    if(!changeFlag){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有做任何修改" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    NSString *nickname = [self.viewfield_01 text];
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:User_Name];
    NSString *sex = @"0";
    if (self.segmentctrl_01.selectedSegmentIndex != 1) {
        sex = @"1";
    }
    NSString *telephone = [self.viewfield_04 text];
    NSString *mobile = [self.viewfield_05 text];
    NSString *email = [self.viewfield_06 text];
    NSString *fax = [self.viewfield_07 text];
//    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    
    [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:User_NickName];
    
    if ([((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserSex]) compare:@"女"] == NSOrderedSame ) {
        UIImage *image_01 = [UIImage imageNamed:@"user_picture_girl.png"];
        [[self imageview_01] setImage:image_01];
    }else{
        UIImage *image_01 = [UIImage imageNamed:@"user_picture.png"];
        [[self imageview_01] setImage:image_01];
    }
    
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msg_packet = @[@{@"type":@"req"},@{@"sessionID":sessionId}, @{@"cmd": @"SetUserInfo"}, @{@"nickName": nickname}, @{@"username":username}, @{@"sex": sex}, @{@"mobile": mobile}, @{@"telephone": telephone}, @{@"email": email}, @{@"fax": fax}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
    
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)receiveDataNotification:(NSNotification *)wParam
{
    if([wParam.name isEqualToString:@"SetUserInfo" ]){
     int result =  [wParam.userInfo[@"result"] intValue];
        if(result==0){
            changeFlag=NO;
            NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
            FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
            if(![distanceDataBase open]){//打开数据库
            }
            
            NSString *nickname = [self.viewfield_01 text];
            NSString *telephone = [self.viewfield_04 text];
            NSString *mobile = [self.viewfield_05 text];
            NSString *email = [self.viewfield_06 text];
            NSString *fax = [self.viewfield_07 text];
            NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
            NSString *sex = @"0";
            [[NSUserDefaults standardUserDefaults] setObject:@"女" forKey:kUserSex];
            if (self.segmentctrl_01.selectedSegmentIndex != 1) {
                sex = @"1";
                [[NSUserDefaults standardUserDefaults] setObject:@"男" forKey:kUserSex];
            }
            NSString *sqlStr = @"update im_users set nickname=?, sex=?, telephone=?, mobile=?, email=?,field_char2=? where userid=?";
            [distanceDataBase executeUpdate:sqlStr, nickname, sex, telephone, mobile, email,fax, userid];
            [distanceDataBase close];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"信息修改成功！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            alert.delegate=self;
            alert.tag=1001;
            [alert show];

        }
        else
        {
            [ShowAlertView showAlertViewStr:@"信息修改失败！"];
        }
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==1001){
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
    }
}

- (IBAction)onBtnShowHead_Click:(id)sender
{
    [self.view endEditing:YES];
    NSString *bigmimage = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:bigmimage] == YES) {
        UIViewCtrl_Head_Image *tmp_view = [[UIViewCtrl_Head_Image alloc] initWithNibName:@"UIViewCtrl_Head_Image" bundle:nil];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您未设置头像！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)onBtnModifyHead_LongClick:(id)sender
{
    [self.view endEditing:YES];
    [self.view_03 setHidden:NO];
}

- (IBAction)onBtnCloseMenu_Click:(id)sender
{
    [self.view_03 setHidden:YES];
}

- (IBAction)onBtnCamera_Click:(id)sender
{
    [self.view_03 setHidden:YES];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)onBtnPhotoLibrary_Click:(id)sender
{
    [self.view_03 setHidden:YES];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) UPloadFiles:(NSString *) wPara withImage:(UIImage *)image
{
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *url=[NSString stringWithFormat:@"http://%@/webimadmin/api/image/avatar",headStr];

    
    NSMutableData *mt_data = [NSMutableData data];
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"domainid\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", [GetContantValue getDomaiId]] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"size\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", wPara] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@".jpg" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    [mt_data appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //////////////////////////////////////////
    if ([wPara compare:@"big"] == NSOrderedSame) {
        [mt_data appendData:UIImageJPEGRepresentation(image, 1.0f)];
    }else if ([wPara compare:@"small"] == NSOrderedSame) {
        [mt_data appendData:UIImageJPEGRepresentation(image, 1.0f)];
    }else if ([wPara compare:@"middle"] == NSOrderedSame) {
        url=[NSString stringWithFormat:@"http://%@/webimadmin/api/image/avatarSuper",headStr];
        [mt_data appendData:UIImageJPEGRepresentation(image, 1.0f)];
    }

    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2821190dec--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *form = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] ;
    [arr_quert addObject:form];
    [form setTimeOutSeconds:60.0];
    form.delegate = self;
    form.shouldAttemptPersistentConnection=NO;
    [form addRequestHeader:@"Accept" value:@"text/html"];
    [form addRequestHeader:@"Content-Type" value:@"multipart/form-data; boundary=---------------------------7de2821190dec"];
    [form addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:mt_data.length]]];
    [form setRequestMethod:@"POST"];
    [form setPostBody:mt_data];
    [form setDidFinishSelector:@selector(requestFinished:)];
    [form setDidFailSelector:@selector(requestFailed:)];
    [form startAsynchronous];

}

- (IBAction)onBtnMyPhotos_Click:(id)sender
{
    PullSelfPicVC *pullSelf = [[PullSelfPicVC alloc]init];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:pullSelf animated:YES];
//    [pullSelf release];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSDictionary *infoDic = [[request responseString]JSONValue];
    if ([[infoDic objectForKey:@"status"] intValue] != 1) {
        [ShowAlertView showAlertViewStr:@"头像上传失败"];
        return;
    }
    [[self imageview_01] setImage:sImage];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSString * bigmimage_path =[[SynUserIcon sharedManager] getCurrentUserBigIconPath];
    if ([filemanager fileExistsAtPath:bigmimage_path] == NO) {
        [filemanager createDirectoryAtPath:bigmimage_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    bigmimage_path = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",bigmimage_path,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    
    NSString * smallimage_path =[[SynUserIcon sharedManager] getCurrentUserSmallIconPath];
    if ([filemanager fileExistsAtPath:smallimage_path] == NO) {
        [filemanager createDirectoryAtPath:smallimage_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    smallimage_path = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",smallimage_path,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    
    NSData *bigData=UIImageJPEGRepresentation(bImage, 1.0);
    [bigData writeToFile:bigmimage_path atomically:YES];
    
    NSData *smallData=UIImageJPEGRepresentation(sImage, 1.0);
    [smallData writeToFile:smallimage_path atomically:YES];
    
    [ShowAlertView showAlertViewStr:@"头像上传成功"];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Request failed");
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"头像上传失败"];
}



@end
