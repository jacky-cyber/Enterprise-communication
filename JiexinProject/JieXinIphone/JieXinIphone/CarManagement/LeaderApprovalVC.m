//
//  LeaderApprovalVC.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-4-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LeaderApprovalVC.h"
#import "Car_helper.h"
#import "ShowAlertView.h"
#import "CarManagementVC.h"


@interface LeaderApprovalVC ()

@end

@implementation LeaderApprovalVC
{
    UIView *_baseView;
    carOrderModel *_carOrderModel;
    NSString *_formId;
    UILabel *_result;
    NSString *_leaderOpition;
    UITextField *commentView;
}

- (void)dealloc
{
    RELEASE_SAFELY(_baseView);
    RELEASE_SAFELY(_carOrderModel);
    [[Car_helper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

- (id)initWithInfo:(carOrderModel *)carOrder andFormId:(NSString *)idString
{
    self = [super init];
    if (self) {
        // Custom initialization
//        _carOrderModel = [[carOrderModel alloc] init];
        _carOrderModel = [carOrder retain];
        _formId = idString;
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, kScreen_Width, kScreen_Height)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    [_baseView release];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [backBtn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.right,self.iosChangeFloat, 100, 40)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    titleLabel.text = @"领导审批";
    titleLabel.textColor = kDarkerGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
//    //提交按钮
//    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [actionBtn setFrame:CGRectMake(270, self.iosChangeFloat+10, 50, 22.5)];
//    [actionBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
//    actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [actionBtn setTitle:@"提交" forState:UIControlStateNormal];
//    [actionBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:actionBtn];
}

- (void)loadSubviews
{
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
//    title.text = @"审核结果";
//    title.textColor = kDarkerGray;
//    title.font = [UIFont boldSystemFontOfSize:18];
//    [_baseView addSubview:title];
//    [title release];
//    
//    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(180, 10, 20, 10)];
//    [switchButton setOn:YES];
//    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    [_baseView addSubview:switchButton];
//    [switchButton release];
//    
    _result = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 30)];
    _result.text = @"同意";
    _result.textColor = [UIColor whiteColor];
    _result.textAlignment = NSTextAlignmentCenter;
    _result.font = [UIFont systemFontOfSize:16];
    [_baseView addSubview:_result];
    [_result release];
    
    
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 35)];
    comment.text = @"领导审核意见";
    comment.textColor = kDarkerGray;
    comment.font = [UIFont boldSystemFontOfSize:16.0];
    [_baseView addSubview:comment];
    [comment release];
    
    commentView = [[UITextField alloc] initWithFrame:CGRectMake(10, comment.bottom, 300, 35)];
    [commentView.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    commentView.text = @"同意";
    commentView.layer.cornerRadius = 5.0f;
    [commentView.layer setBorderWidth:1.0f];
    commentView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [comment setNumberOfLines:2];
    [_baseView addSubview:commentView];
    
    


    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *imageName = [NSString stringWithFormat:@"agree.png"];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tag = 100;
    [button setFrame:CGRectMake(10+0*150, commentView.bottom+20, 140, 50)];
    [button addTarget:self action:@selector(subCommitAction:) forControlEvents:UIControlEventTouchUpInside ];
    [_baseView addSubview:button];
    
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noBtn setBackgroundImage:[UIImage imageNamed:@"agree1.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tag = 101;
    [noBtn setFrame:CGRectMake(20+1*150, commentView.bottom+20, 140, 50)];
    [noBtn addTarget:self action:@selector(nosubCommitAction:) forControlEvents:UIControlEventTouchUpInside ];
    [_baseView addSubview:noBtn];

}

-(void)subCommitAction:(UIButton *)sender
{
    if (commentView.text.length!=0) {
        _result.text = @"同意";
        [self commitAction:nil];
    }else {
        [ShowAlertView showAlertViewStr:@"审核意见不能为空！"];
        NSLog(@"请输入审核意见");
    }



}

-(void)nosubCommitAction:(UIButton *)sender
{
    if (commentView.text.length!=0) {
        _result.text = @"不同意";
        [self commitAction:nil];
    }else {
        [ShowAlertView showAlertViewStr:@"请输入不同意原因！"];
    }
    
}

- (void)commitAction:(UIButton *)sender
{
    [self requestData];
}


//返回上上一个控制器
- (void)backBtn_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 获取数据
/*
 领导提交表单
 submitappleader
 String userId = request.getParameter("userId");
 String userName = request.getParameter("userName");
 String appid = request.getParameter("id");
 String status = request.getParameter("handState");
 */
- (void) requestData
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSString *handState=nil;
    if([_result.text isEqualToString:@"同意"]){
        handState=@"3";
    }else{
        handState=@"2";
    }
    [[Car_helper sharedService] requestForType:kCarCommitByLeader info:@{@"id":_formId,@"handState":handState,@"leaderOpinion": commentView.text} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    
    
    
}

- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if([[datas objectForKey:@"resultcode"] isEqualToString:@"0"]){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    }else if ([[datas objectForKey:@"resultcode"] isEqualToString:@"93"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前数据已过期！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

}

- (void)requestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"提交失败"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KRefreshData object:nil];
    UIViewController *carVC = (UIViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:carVC animated:YES];
}

@end
