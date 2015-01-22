//
//  GroupSendMsgViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "GroupSendMsgViewController.h"
#import "CustomTextView.h"
#import "User.h"
#import "MsgCategoryVC.h"
#import "LinkDateCenter.h"

@interface GroupSendMsgViewController ()<UITextViewDelegate,MsgCategoryDelegate>

@property (nonatomic, retain) UIView *mainBgView;
@property (nonatomic, retain) CustomTextView  *namesTextView;
@property (nonatomic, retain) CustomTextView  *contentTextView;
@property (nonatomic, retain)UILabel *titleLabel;


@end

@implementation GroupSendMsgViewController
{
    BOOL _isMySendSms;
}
- (void)dealloc
{
    self.selectArr = nil;
    self.mainBgView = nil;
    self.namesTextView = nil;
    self.contentTextView = nil;
    self.phoneStr = nil;
    self.titleLabel = nil;
    self.groupid = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectArr = [NSMutableArray array];
        _isMySendSms = NO;
        //增加监听，获取发送成功数据的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveSmsDataNotification:)
                                                     name:kSendSMS
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
	// Do any additional setup after loading the view.
}

- (void)initSubViews
{
    CGFloat changeFloat = 0;
    if (IOSVersion >= 7.0) {
        changeFloat = 20;
    }
    
    self.mainBgView = [[[UIView alloc] initWithFrame:CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight)] autorelease];
    _mainBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainBgView];

    if (IOSVersion >= 7.0) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, changeFloat, kScreen_Width, kNavHeight)];
    header.image = UIImageWithName(@"top_bar_bg.png");
    header.userInteractionEnabled = YES;
    [self.view addSubview:header];
    [header release];
    
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, changeFloat, 100, kNavHeight)] autorelease];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"群发短信";
    [self.view addSubview:_titleLabel];

    
//    UIButton *historyBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    historyBt.frame = CGRectMake(kScreen_Width-70, 0, 70, kNavHeight);
//    [historyBt setImage:[UIImage imageNamed:@"chatHistory.png"] forState:UIControlStateNormal];
//    [historyBt setImageEdgeInsets:UIEdgeInsetsMake(10, 34, 10, 11)];
//    [historyBt addTarget:self action:@selector(readChatHistory) forControlEvents:UIControlEventTouchUpInside];
//    [header addSubview:historyBt];

    
    UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kScreen_Width - 20, 115)];
    upImageView.userInteractionEnabled = YES;
//    upImageView.image = [[UIImage imageNamed:@"shuru_bg4.png"] stretchableImageWithLeftCapWidth:100 topCapHeight:40];
    [upImageView.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [upImageView.layer setBorderWidth:1.0f];
    [upImageView.layer setCornerRadius:5.0f];

    [_mainBgView addSubview:upImageView];
    [upImageView release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(upImageView.frame)-20, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"自短信窗口发送短信至";
    [upImageView addSubview:titleLabel];
    [titleLabel release];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, kScreen_Width-20, 1)];
    line.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    [upImageView addSubview:line];
    [line release];
    
    self.namesTextView = [[[CustomTextView alloc] initWithFrame:CGRectMake(3, 42, CGRectGetWidth(upImageView.frame)-6, 115-40-5) withPlaceholder:@"请选择人员"] autorelease];
    _namesTextView.font = [UIFont systemFontOfSize:16.0f];
    _namesTextView.editable = NO;
    //算人员的名字
    NSString *name = @"";
    for(User *elem in self.selectArr)
    {
//        if(elem.mobile && ![elem.mobile isEqualToString:@""])
        if ([name length])
        {
            name = [NSString stringWithFormat:@"%@;%@",name,elem.nickname];
        }
        else
        {
            name = elem.nickname;
        }
    }
    _namesTextView.text = name;
    [upImageView addSubview:_namesTextView];
    
    UILabel *contentLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(upImageView.frame)+3, kScreen_Width-20, 30)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    contentLabel.text = @"正文";
    [_mainBgView addSubview:contentLabel];
    [contentLabel release];
    
    UIButton *msgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBt.frame= CGRectMake(kScreen_Width-40, CGRectGetMaxY(upImageView.frame)+2, 30, 30);
    [msgBt setImage:[UIImage imageNamed:@"duanxinjilu.png"] forState:UIControlStateNormal];
    [msgBt addTarget:self action:@selector(selectMsgFromDb) forControlEvents:UIControlEventTouchUpInside];
    [_mainBgView addSubview:msgBt];
    
    UIImageView *downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(contentLabel.frame), kScreen_Width - 20, 115)];
    downImageView.userInteractionEnabled = YES;
//    downImageView.image = [[UIImage imageNamed:@"shuru_bg4.png"] stretchableImageWithLeftCapWidth:100 topCapHeight:40];
    [downImageView.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [downImageView.layer setBorderWidth:1.0f];
    [downImageView.layer setCornerRadius:5.0f];

    [_mainBgView addSubview:downImageView];
    [downImageView release];
    
    self.contentTextView = [[[CustomTextView alloc] initWithFrame:CGRectMake(5, 2, CGRectGetWidth(downImageView.frame)-10, 110) withPlaceholder:@"请输入正文"] autorelease];
    _contentTextView.font = [UIFont systemFontOfSize:16.0f];
    self.contentTextView.returnKeyType = UIReturnKeyDone;
    self.contentTextView.delegate = self;
    [downImageView addSubview:_contentTextView];
    
    UIButton *sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBt.frame = CGRectMake(10, CGRectGetMaxY(downImageView.frame)+10, kScreen_Width-20, 40);
    [sendBt addTarget:self action:@selector(sendData) forControlEvents:UIControlEventTouchUpInside];
    [sendBt setImage:[UIImage imageNamed:@"duanxin_Btn.png"] forState:UIControlStateNormal];
    [_mainBgView addSubview:sendBt];
}

- (void)sendData
{
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
    _isMySendSms =YES;
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    User *userSelf = [[LinkDateCenter sharedCenter] getUserWithUserId:sessionId];
    NSString *toPhoneNum = @"";
    for(User *elem in self.selectArr)
    {
        if ([sessionId isEqualToString:elem.userid]) {
            continue;
        }
        //        if(elem.mobile && ![elem.mobile isEqualToString:@""])
        if ([toPhoneNum length])
        {
            toPhoneNum = [NSString stringWithFormat:@"%@%@;",toPhoneNum,elem.mobile];
        }
        else
        {
            toPhoneNum = [NSString stringWithFormat:@"%@;",elem.mobile];
        }
    }
    //加上自己
    if ([toPhoneNum length])
    {
        toPhoneNum = [NSString stringWithFormat:@"%@%@;",toPhoneNum,userSelf.mobile];
    }
   

    
    NSString *msg = [NSString stringWithFormat:@"[短信]%@",_contentTextView.text];
    NSString *SerialID = [NSString createUUID];
    NSArray *offLineArr = nil;
    offLineArr = @[@{@"type": @"rsp"},@{@"cmd":@"SendSMS"},@{@"sessionID": sessionId},@{@"fromphonenum":_phoneStr},@{@"tophonenum":toPhoneNum},@{@"msmmsg":msg},@{@"SerialID":SerialID}];
    NSMutableArray *xmlArr = [NSMutableArray arrayWithArray:offLineArr];
    if (_groupid && [_groupid length]) {
        [xmlArr addObject:@{@"groupid": _groupid}];
    }
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:xmlArr];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    
}

- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)readChatHistory
{
    
}

- (void)selectMsgFromDb
{
    MsgCategoryVC *msg = [[MsgCategoryVC alloc] initWithNibName:nil bundle:nil];
    msg.delegate = self;
    [self.navigationController pushViewController:msg animated:YES];
    [msg release];
}

- (void)selectMsgDetail:(NSDictionary *)infoDic
{
    _contentTextView.text = [NSString stringWithFormat:@"%@%@",_contentTextView.text,[infoDic objectForKey:@"msgContent"]];
}

- (void)receiveSmsDataNotification:(NSNotification *)notification
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (_isMySendSms)
    {
        _isMySendSms = NO;
    }
    else
    {
        return;
    }
    NSDictionary *dic = [notification userInfo];
    if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
        [ShowAlertView showAlertViewStr:@"发送失败"];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"发送成功"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4
                     animations:^{
                         _mainBgView.frame = CGRectMake(0, -50, kScreen_Width, kScreen_Height-20-kNavHeight);
                     }];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGFloat changeFloat = 0;
    if (IOSVersion >= 7.0) {
        changeFloat = 20;
    }

    [UIView animateWithDuration:0.4
                     animations:^{
                         _mainBgView.frame = CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight);
                     }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
