//
//  CarOrderVC.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-4.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CarOrderVC.h"
#import "carOrderModel.h"
#import "Car_helper.h"
#import "LeaderApprovalVC.h"
#import "AdminDispatch.h"

@interface CarOrderVC ()

@property(nonatomic,strong) UIScrollView *scrollow;

@end

@implementation CarOrderVC
{
    carOrderModel  *_carDetailModel;
    CarCommitType _commitType;
    CarConlumType _conlumType;
    NSString *cartype;
}
@synthesize baseView;
@synthesize actionBtn;
@synthesize formId;

- (void)dealloc
{
    self.baseView = nil;
    self.titleLabel = nil;
    self.back_Btn = nil;
//    RELEASE_SAFELY(_carDetailModel);
    self.formId = nil;
    [[Car_helper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

- (id)initWithFormId:(NSString *)formid andType:(CarCommitType)type andConlum:(CarConlumType)conlum
{
    self = [super init];
    if (self) {
        self.formId = formid;
        _commitType = type;
        _conlumType = conlum;
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    self.baseView = [[[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, kScreen_Width, kScreen_Height - 44-self.iosChangeFloat)] autorelease];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    //返回按钮
    self.back_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _back_Btn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [_back_Btn addTarget:self action:@selector(backBtn_Click) forControlEvents:UIControlEventTouchUpInside ];
    [_back_Btn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:_back_Btn];
    
    //添加头部标题
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40, self.iosChangeFloat, 100, _back_Btn.height)] autorelease];
    _titleLabel.text = @"车辆申请表单";
    _titleLabel.textColor = kDarkerGray;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    //    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_titleLabel];
    
    //滚动视图
    _scrollow = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kDeviceHeight)];
    _scrollow.contentSize = CGSizeMake(320, kDeviceHeight*3);
    [self.view addSubview:_scrollow];

    self.actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionBtn setFrame:CGRectMake(250, self.iosChangeFloat+10, 50, 22.5)];
    [actionBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    if (_commitType == Car_commitByLeader)
    {
        [actionBtn setTitle:@"审批" forState:UIControlStateNormal];
        actionBtn.hidden = NO;
    }
    else if (_commitType == Car_commitByAdmin)
    {
        [actionBtn setTitle:@"分派" forState:UIControlStateNormal];
        actionBtn.hidden = NO;
    }
    else
    {
        actionBtn.hidden = YES;
    }
    [actionBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionBtn];
    
    [[STHUDManager sharedManager] showHUDInView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self requestFormInfomation];
}

- (void)initSubViews
{
    NSMutableArray *laberArr = [[NSMutableArray alloc] init];
    NSMutableArray *labelInfo = [[NSMutableArray alloc] init];
    if ([_carDetailModel.carType isEqualToString:@"0"])
    {
        _carDetailModel.carType = @"帕萨特-4人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"别克商务-6人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"丰田商务-16人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"考斯特-22人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"金龙客车-50人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"奥迪A6-4人";
    }
    else if([_carDetailModel.carType isEqualToString:@"1"])
    {
        _carDetailModel.carType = @"奔驰-4人";
    }
    
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
    if ([power isEqualToString:@"2"] && (_conlumType == Car_yishen || _conlumType == Car_yiwan))
    {
        NSArray *laberArrTMP = [NSArray arrayWithObjects:@"用车部门",@"申请人",@"用车人",@"联系方式",@"用车人数",@"用车类型",@"用车时间",@"出发地",@"还车时间",@"目的地",@"用车事由",@"对车辆有无特殊要求",@"司机",@"司机电话",@"车牌号",nil];
        
        NSArray *labelInfoTMP = [NSArray arrayWithObjects:[NSString stringWithFormat:@"  %@", _carDetailModel.department],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.userName],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.carUser],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.userTel ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.peopleNum ],
                                 //                          [NSString stringWithFormat:@"  %@",_carDetailModel.carType ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.carType],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.useTime ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.drivePlace ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.returnTime ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.returnPlace ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.reason ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.require ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.driver ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.driveTell ],
                                 [NSString stringWithFormat:@"  %@",_carDetailModel.carNumer],nil];
        laberArr = [laberArrTMP copy];
        labelInfo = [labelInfoTMP copy];

    }
    else if (_conlumType == Car_daishen || _conlumType == Car_yiche) //|| [jurisdiction isEqualToString:@"0"] || [jurisdiction isEqualToString:@"2"])
    {
        
        NSArray *laberArrTMP = [NSArray arrayWithObjects:@"用车部门",@"申请人",@"用车人",@"联系方式",@"用车人数",@"用车类型",@"用车时间",@"出发地",@"还车时间",@"目的地",@"用车事由",@"对车辆有无特殊要求", @"审批领导",@"司机",@"司机电话",@"车牌号",nil];
        
        NSArray *labelInfoTMP = [NSArray arrayWithObjects:[NSString stringWithFormat:@"  %@", _carDetailModel.department],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.userName],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carUser],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.userTel ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.peopleNum ],
                              //                          [NSString stringWithFormat:@"  %@",_carDetailModel.carType ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carType],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.useTime ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.drivePlace ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.returnTime ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.returnPlace ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.reason ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.require ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.leader ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.driver ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.driveTell ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carNumer],nil];
        laberArr = [laberArrTMP copy];
        labelInfo = [labelInfoTMP copy];
    }
    else
    {
        NSArray *laberArrTMP = [NSArray arrayWithObjects:@"用车部门",@"申请人",@"用车人",@"联系方式",@"用车人数",@"用车类型",@"用车时间",@"出发地",@"还车时间",@"目的地",@"用车事由",@"对车辆有无特殊要求", @"审批领导",@"领导审批意见",@"司机",@"司机电话",@"车牌号",nil];
        
        NSArray *labelInfoTMP = [NSArray arrayWithObjects:[NSString stringWithFormat:@"  %@", _carDetailModel.department],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.userName],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carUser],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.userTel ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.peopleNum ],
                              //                          [NSString stringWithFormat:@"  %@",_carDetailModel.carType ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carType ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.useTime ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.drivePlace ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.returnTime ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.returnPlace ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.reason ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.require ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.leader ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.leaderOpinion],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.driver ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.driveTell ],
                              [NSString stringWithFormat:@"  %@",_carDetailModel.carNumer],nil];
        laberArr = [laberArrTMP copy];
        labelInfo = [labelInfoTMP copy];
    }
    

    
//    NSString *handState=nil;
//    if([_result.text isEqualToString:@"同意"]){
//        handState=@"3";
//    }else{
//        handState=@"2";
//    }
    
    int cnt;
    if ([_carDetailModel.state isEqualToString:@"4"]) {
        cnt =[laberArr count];
    }
    else if ([_carDetailModel.state isEqualToString:@"0"]){
       cnt= [laberArr count]-4;
    }
    else{
        cnt = [laberArr count]-3;
    }

    int _y = 10;
    for(int index = 0; index <cnt; index++ ) {
        
        //申请信息
//        UIImageView *imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(20, _y, 300, 40)];
//        [imageBg setImage:[UIImage imageNamed:@"t_d.png"]];
//        [_scrollow addSubview:imageBg];
        
        
//        [temptextField.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];//设置边框
//        temptextField.layer.cornerRadius = 5.0f;
//        [temptextField.layer setBorderWidth:1.0f];
//        temptextField.delegate=self;
//        temptextField.borderStyle = UITextBorderStyleLine;
//        temptextField.font = [UIFont systemFontOfSize:15.0f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 300, 40)];
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.textColor = kDarkerGray;
        label.textAlignment= NSTextAlignmentLeft;
        label.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1.0f];
        label.text = [laberArr objectAtIndex:index];
        [_scrollow addSubview:label];
        [label release];
        

        CGSize labelsize = CGSizeMake(300, 40);
        if (index == 10 || index == 11)
        {
            labelsize = [[labelInfo objectAtIndex:index] sizeWithFont:[UIFont boldSystemFontOfSize: 15.0f]
                                                    constrainedToSize:CGSizeMake(300, 200)
                                                        lineBreakMode:NSLineBreakByWordWrapping];
            
            
            if (labelsize.height < 40) {
                labelsize.height = 40;
            }
        }
        

        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom, 300, labelsize.height)];
        label1.lineBreakMode = NSLineBreakByWordWrapping;
        label1.numberOfLines = 0;
        //[label1 setNumberOfLines:0];
        label1.font = [UIFont systemFontOfSize:15.0f];
        
        label1.text = [labelInfo objectAtIndex:index];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentLeft;
        [label1 setLineBreakMode:NSLineBreakByWordWrapping];
        label1.textColor = kDarkGray;
        [label1 setBackgroundColor:[UIColor colorWithRed:235.0f/255.0 green:235.0f/255.0 blue:235.0f/255.0 alpha:1]];
        [label1.layer setBorderColor:[[UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f] CGColor]];
        label1.layer.cornerRadius = 5.0f;
        [label1.layer setBorderWidth:1.0f];
        label1.text = [labelInfo objectAtIndex:index];
        label1.textColor = kDarkGray;

        [_scrollow addSubview:label1];
        [label1 release];
        
        _y = _y + 40 + labelsize.height;
    }
    
    [_scrollow setContentSize:CGSizeMake(320, _y+80)];
}

- (void)commitAction:(UIButton *)sender
{
    if (_commitType == Car_commitByAdmin)
    {
        AdminDispatch *advc = [[AdminDispatch alloc] initWithInfo:_carDetailModel andFormId:self.formId];
        [self.navigationController pushViewController:advc animated:YES];
        [advc release];
    }
    else if(_commitType == Car_commitByLeader)
    {
        LeaderApprovalVC *lavc = [[LeaderApprovalVC alloc] initWithInfo:_carDetailModel andFormId:self.formId];
        [self.navigationController pushViewController:lavc animated:YES];
        [lavc release];
    }
    else
    {
        return;
    }
}

//返回上上一个控制器
- (void)backBtn_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestFormInfomation
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    [[Car_helper sharedService] requestForType:kQuerycourseCarDetail info:@{@"id":self.formId,@"useId":userid} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}

//返回成功进行解析数据
- (void)requestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    _carDetailModel = [[carOrderModel alloc] init];
    _carDetailModel.returnTime  = [NSString stringWithFormat:@"%@",[datas objectForKey:@"returnTime"]];
    _carDetailModel.carUser = [NSString stringWithFormat:@"  %@",[datas objectForKey:@"carusername"]],
    _carDetailModel.returnPlace = [NSString stringWithFormat:@"%@",[datas objectForKey:@"returnPlace"]];
    _carDetailModel.reason = [NSString stringWithFormat:@"%@",[datas objectForKey:@"reason"]];
    _carDetailModel.carType = [NSString stringWithFormat:@"%@",[datas objectForKey:@"carType"]];
    _carDetailModel.department = [NSString stringWithFormat:@"%@",[datas objectForKey:@"department"]];
    _carDetailModel.state = [NSString stringWithFormat:@"%@",[datas objectForKey:@"state"]];
    _carDetailModel.resultcode = [NSString stringWithFormat:@"%@",[datas objectForKey:@"resultcode"]];
    _carDetailModel.peopleNum = [NSString stringWithFormat:@"%@",[datas objectForKey:@"peopleNum"]];
    _carDetailModel.drivePlace = [NSString stringWithFormat:@"%@",[datas objectForKey:@"drivePlace"]];
    _carDetailModel.userTel = [NSString stringWithFormat:@"%@",[datas objectForKey:@"userTel"]];
    _carDetailModel.userId = [NSString stringWithFormat:@"%@",[datas objectForKey:@"userId"]];
    _carDetailModel.leader = [NSString stringWithFormat:@"%@",[datas objectForKey:@"leader"]];
    _carDetailModel.userName = [NSString stringWithFormat:@"%@",[datas objectForKey:@"userName"]];
    _carDetailModel.require = [NSString stringWithFormat:@"%@",[datas objectForKey:@"require"]];
    _carDetailModel.leaderId = [NSString stringWithFormat:@"%@",[datas objectForKey:@"leaderId"]];
    _carDetailModel.useTime = [NSString stringWithFormat:@"%@",[datas objectForKey:@"useTime"]];
    if ([datas objectForKey:@"leaderOpinion"]) {
        
        _carDetailModel.leaderOpinion = [NSString stringWithFormat:@"%@",[datas objectForKey:@"leaderOpinion"]];
    }
    else
    {
        _carDetailModel.leaderOpinion = @"无";
    }
    _carDetailModel.driver = [NSString stringWithFormat:@"%@",[datas objectForKey:@"driver"]];
    _carDetailModel.driveTell = [NSString stringWithFormat:@"%@",[datas objectForKey:@"driverTel"]];
    _carDetailModel.carNumer = [NSString stringWithFormat:@"%@",[datas objectForKey:@"carNum"]];
    [self initSubViews];
}

//返回失败执行此方法
- (void)requestFailed:(NSMutableDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    NSLog(@"requestCarDetailFailed 数据返回失败");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
