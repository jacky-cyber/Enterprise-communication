//
//  CardApplyViewController.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CardApplyViewController.h"
#import "KxMenu.h"
#import "Card_helper.h"
#import "LinkDateCenter.h"
#import "ChineseString.h"
#import "pinyin.h"

#import "ApplyPickerView.h"

#define ConstantValue 12673
#define SelectNameTag  5555
#define SelectDepTag   6666
#define SelectJobTag   7777
#define SelectLeaderTag  8888

@interface CardApplyViewController ()
{
    UIView *_baseView;
    ApplyPopoverView *_popView;
    ApplyPickerView *_pickerView;
    NSMutableArray *_userArray;
    
    NSString *_applicantid;  //申请人id
    NSString *_applicant;  //申请人姓名
    
    NSString *_jurisdiction;
    
    //以下动作请勿模仿！如有雷同，纯属巧合！！！
    UIButton *_selectName;
    UIButton *_selectDep;
    UIButton *_selectJob;
    UITextField *_pcode;
    UITextField *_mobile;
    UITextField *_telephone;
    UITextField *_fax;
    UITextField *_email;
    UITextField *_count;
    UIButton *_selectLeader;
    UITextField *_yName;
    
    NSArray *_departmentArray;
    //是否是领导
    BOOL _isLeaderApply;
    //是否显示部门
    BOOL _isShowDepartment;
}

//所有人的信息
@property (nonatomic, retain) NSDictionary *allUserInoDic;

@end

@implementation CardApplyViewController
@synthesize iosChangeFloat;
@synthesize dataArray;
@synthesize contentView;
@synthesize allUserInoDic;


- (void)dealloc
{
    self.dataArray = nil;
    self.contentView = nil;
    self.userid = nil;
    self.allUserInoDic = nil;
    RELEASE_SAFELY(_userArray);
    RELEASE_SAFELY(_yName);
    RELEASE_SAFELY(_jurisdiction);
    RELEASE_SAFELY(_applicantid);
    RELEASE_SAFELY(_applicant);
    [[Card_helper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

- (id)initWithJurisdiction:(NSString *)jurisdiction  withUserId:(NSString *)userid
{
    self = [super init];
    if (self) {
        // Custom initialization
        if (iOSVersion < 7.0) {
            self.iosChangeFloat = 0;
        }else{
            self.iosChangeFloat = 20.f;
        }
        _isLeaderApply = NO;
        _isShowDepartment = YES;
        _userArray = [[NSMutableArray alloc] init];
        self.userid = userid;
        language = Language_chinese;
        _jurisdiction = [jurisdiction retain];
        _applicantid = [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] retain];
        _applicant = [[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName] retain];
    
        [self loadSubviews];
    }
    return self;
}


- (void)loadSubviews
{
    //背景
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0,self.iosChangeFloat+44, kScreen_Width, kScreen_Height-self.iosChangeFloat-44)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    [_baseView release];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside ];
    [backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.iosChangeFloat, 100, 40)];
    titleLabel.text = @"名片申请";
    titleLabel.textColor = kDarkerGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //确认按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(270, self.iosChangeFloat+12, 30, 20);
    [doneBtn setImage:[UIImage imageNamed:@"done_1.png"] forState:UIControlStateNormal];
    [doneBtn setImage:[UIImage imageNamed:@"done_2.png"] forState:UIControlStateHighlighted];
    [doneBtn addTarget:self action:@selector(confirmApply:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:doneBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super createCustomNavBarWithoutLogo];
    [self loadCustomNavigationBar];
    
    self.contentView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, kScreen_Width, CGRectGetHeight(_baseView.frame) - 35)] autorelease];
    [contentView setContentSize:CGSizeMake(kScreen_Width, 2*kScreen_Height)];
    [_baseView addSubview:self.contentView];
 
    [self getUserInfomation:self.userid];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


- (void)getUsersFromSameDep:(NSString *)depId
{
    [_userArray addObjectsFromArray:[[LinkDateCenter sharedCenter] getSubUsersWithDepartmentId:depId]];
}

- (void)loadCustomNavigationBar
{
    NSArray *arr = [NSArray arrayWithObjects:@"中文",@"英文",nil];
   
    float _x = 0.0f;
    for (int index = 0; index<[arr count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0+_x, 0, 317.0/[arr count], 34);
        button.tag = ConstantValue + index;
        [button setTitleColor:kDarkerGray forState:UIControlStateNormal];
        [button setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFont];
        NSString *str = [arr objectAtIndex:index];
        [button setTitle:str forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (index == 0)
        {
            button.selected = YES;
        }
        [_baseView addSubview:button];
        _x+=320.0/[arr count];
    }
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0,34, kScreen_Width,1)];
    line.image = [UIImage imageNamed:@"line.png"];
    [_baseView addSubview:line];
    [line release];
}

- (void)loadApplyItems
{
    //清空原布局
    for (id elem in self.contentView.subviews) {
        [elem removeFromSuperview];
    }
    
    if (!dataArray) {
        return;
    }
    
    //重新布局
    if (language == Language_chinese)
    {
        float _y = 5.0f;
        float _x = 90.0f;
        
        UILabel *label = nil;
        
        //名字
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"名    字:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_down.png"]];
        imageView1.frame = CGRectMake(_x + 85, _y + 16.5, 18, 12);
        [self.contentView addSubview:imageView1];
        [imageView1 release];
        
        _selectName = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectName.tag = UserType + ConstantValue;
        _selectName.frame = CGRectMake(_x, _y, 80, 45);
        [_selectName setTitleColor:kDarkGray forState:UIControlStateNormal];
        [_selectName setTitle:[[dataArray objectAtIndex:0] objectForKey:@"Title"] forState:UIControlStateNormal];
        _selectName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _selectName.titleLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [_selectName addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectName];
        
        [self drawLine:_selectName.frame];
        
        _y += 46.0f;
        
        if (_isShowDepartment) {
            //部门
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
            label.text = @"部    门:";
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            
            UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_down.png"]];
            imageView2.frame = CGRectMake(_x + 85, _y + 16.5, 18, 12);
            [self.contentView addSubview:imageView2];
            [imageView2 release];
            
            _selectDep = [UIButton buttonWithType:UIButtonTypeCustom];
            _selectDep.frame = CGRectMake(_x, _y, 80, 45);
            _selectDep.tag = DepType + ConstantValue;
            [_selectDep setTitleColor:kDarkGray forState:UIControlStateNormal];
            [_selectDep setTitle:[[dataArray objectAtIndex:1] objectForKey:@"Title"] forState:UIControlStateNormal];
            _selectDep.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _selectDep.titleLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
            [_selectDep addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_selectDep];
            
            [self drawLine:_selectDep.frame];
            
            _y += 46.0f;
        }
        
        //职位
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"职    位:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_down.png"]];
        imageView3.frame = CGRectMake(kScreen_Width - 40, _y + 16.5, 18, 12);
        [self.contentView addSubview:imageView3];
        [imageView3 release];
        
        _selectJob = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectJob.tag = JobType + ConstantValue;
        _selectJob.frame = CGRectMake(_x, _y, 200, 45);
        [_selectJob setTitleColor:kDarkGray forState:UIControlStateNormal];
        [_selectJob setTitle:[[dataArray objectAtIndex:2] objectForKey:@"Title"] forState:UIControlStateNormal];
        _selectJob.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _selectJob.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        _selectJob.titleLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [_selectJob addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectJob];
        
        [self drawLine:_selectJob.frame];
        
        _y += 46.0f;
        
        //公司名称  3
        CGSize  comNameSize = [[dataArray objectAtIndex:3] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 10] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (comNameSize.height < 45.0f) {
            comNameSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"公司名称 :";
        label.font = [UIFont systemFontOfSize:kCommonFont + 1];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y,220, comNameSize.height)];
        nameLabel.text = [dataArray objectAtIndex:3];
        nameLabel.textColor = kDarkGray;
        nameLabel.numberOfLines = 0;
        nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        nameLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        [self drawLine:nameLabel.frame];
        
        _y += (comNameSize.height + 1.0f);
        
        //公司地址  4
        CGSize  comAddSize = [[dataArray objectAtIndex:4] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 10] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (comAddSize.height < 45.0f) {
            comAddSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"公司地址 :";
        label.font = [UIFont systemFontOfSize:kCommonFont + 1];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y,220, comAddSize.height)];
        addressLabel.text = [dataArray objectAtIndex:4];
        addressLabel.textColor = kDarkGray;
        addressLabel.numberOfLines = 0;
        addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        addressLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:addressLabel];
        [addressLabel release];
        
        [self drawLine:addressLabel.frame];
        
        _y += (comAddSize.height + 1.0f);
        
        //邮编  5
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"邮    编:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _pcode = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        _pcode.tag = ConstantValue + 5;
        _pcode.textColor = kDarkGray;
        _pcode.text = [dataArray objectAtIndex:5];
        _pcode.keyboardType = UIKeyboardTypeNumberPad;
        _pcode.delegate = self;
        [self.contentView addSubview:_pcode];
        [_pcode release];
        
        [self drawLine:_pcode.frame];
        
        _y += 46.0f;
        
        //手机 6
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"手    机:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _mobile = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        _mobile.text = [dataArray objectAtIndex:6];
        _mobile.textColor = kDarkGray;
        _mobile.tag = ConstantValue + 6;
        _mobile.keyboardType = UIKeyboardTypeNumberPad;
        _mobile.delegate = self;
        [self.contentView addSubview:_mobile];
        [_mobile release];
        
        [self drawLine:_mobile.frame];
        
        _y += 46.0f;
        
        //电话  7
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"电    话:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _telephone = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        _telephone.text = [dataArray objectAtIndex:7];
        _telephone.textColor = kDarkGray;
        _telephone.tag = ConstantValue + 7;
        _telephone.keyboardType = UIKeyboardTypeNumberPad;
        _telephone.delegate = self;
        [self.contentView addSubview:_telephone];
        [_telephone release];
        
        
        [self drawLine:_telephone.frame];
        
        _y += 46.0f;
        
        //传真  8
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"传    真:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 35, 45)];
        label.text = @"010 ";
        label.textColor = kDarkGray;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        [label release];
        
        _fax = [[UITextField alloc] initWithFrame:CGRectMake(_x+35, _y, 220-35, 45)];
        _fax.text = [dataArray objectAtIndex:8];
        _fax.textColor = kDarkGray;
        _fax.tag = ConstantValue + 8;
        _fax.keyboardType = UIKeyboardTypeNumberPad;
        _fax.delegate = self;
        [self.contentView addSubview:_fax];
        [_fax release];
        
        [self drawLine:_fax.frame];
        
        _y += 46.0f;
        
        //电子邮箱  9
        CGSize  emailSize = [[dataArray objectAtIndex:9] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 1] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (emailSize.height < 45.0f) {
            emailSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"电子信箱:";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _email = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 220, emailSize.height)];
        _email.text = [dataArray objectAtIndex:9];
        _email.textColor = kDarkGray;
        _email.adjustsFontSizeToFitWidth = YES;
        _email.tag = ConstantValue + 9;
        _email.delegate = self;
        [self.contentView addSubview:_email];
        [_email release];
        
        [self drawLine:_email.frame];
        
//        _y += (emailSize.height + 1.0f);
        
        if ([_jurisdiction isEqualToString:@"2"]) {
        }
        else
        {
            _y += (emailSize.height + 1.0f);
        }
        
        
        if (!_isLeaderApply) {
            //审批人  11
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
            label.text = @"审 批 人:";
            label.textColor = kMAIN_THEME_COLOR;
            if ([_jurisdiction isEqualToString:@"2"]) {
                label.textColor = [UIColor grayColor];
                label.hidden = YES;
            }
            label.font = [UIFont boldSystemFontOfSize:kCommonFont+1];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            
            UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_down.png"]];
            imageView4.frame = CGRectMake(_x + 125, _y + 16.5, 18, 12);
            [self.contentView addSubview:imageView4];
            [imageView4 release];
            
            _selectLeader = [UIButton buttonWithType:UIButtonTypeCustom];
            _selectLeader.tag = LeaderType + ConstantValue;
            _selectLeader.frame = CGRectMake(_x, _y, 120, 45);
            if ([_jurisdiction isEqualToString:@"2"]) {
                _selectLeader.hidden = YES;
            }
            [_selectLeader setTitleColor:kDarkGray forState:UIControlStateNormal];
            [_selectLeader setTitle:[[dataArray objectAtIndex:11] objectForKey:@"Title"] forState:UIControlStateNormal];
            _selectLeader.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            _selectLeader.titleLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
            [_selectLeader addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_selectLeader];
            
            [self drawLine:_selectLeader.frame];
            
            _y += 46.0f;
            
        }

        
        //申请数量  10
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"申请数量:";
        label.textColor = kMAIN_THEME_COLOR;
        label.font = [UIFont boldSystemFontOfSize:kCommonFont+1];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _count = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 80, 45)];
        _count.text = [dataArray objectAtIndex:10];
        _count.textColor = kDarkGray;
        _count.tag = ConstantValue + 10;
        _count.textAlignment = NSTextAlignmentCenter;
        _count.keyboardType = UIKeyboardTypeNumberPad;
        _count.delegate = self;
        [self.contentView addSubview:_count];
        [_count release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(_x+ 80, _y, 80, 45)];
        label.text = @"盒";
        label.textColor = kDarkGray;
        label.font = [UIFont boldSystemFontOfSize:kCommonFont+1];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        [label release];
        
        [self drawLine:_count.frame];
        
//        if ([_jurisdiction isEqualToString:@"2"]) {
//        }
//        else
//        {
//             _y += 46.0f;
//        }
//       
        [self.contentView setContentSize:CGSizeMake(kScreen_Width, CGRectGetMaxY(_count.frame)+20)];
//        if (!_isLeaderApply) {
//            //审批人  11
//            label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
//            label.text = @"审 批 人:";
//            label.textColor = kMAIN_THEME_COLOR;
//            if ([_jurisdiction isEqualToString:@"2"]) {
//                label.textColor = [UIColor grayColor];
//                label.hidden = YES;
//            }
//            label.font = [UIFont boldSystemFontOfSize:kCommonFont+1];
//            label.textAlignment = NSTextAlignmentCenter;
//            [self.contentView addSubview:label];
//            [label release];
//            
//            UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_down.png"]];
//            imageView4.frame = CGRectMake(_x + 125, _y + 16.5, 18, 12);
//            [self.contentView addSubview:imageView4];
//            [imageView4 release];
//            
//            _selectLeader = [UIButton buttonWithType:UIButtonTypeCustom];
//            _selectLeader.tag = LeaderType + ConstantValue;
//            _selectLeader.frame = CGRectMake(_x, _y, 120, 45);
//            if ([_jurisdiction isEqualToString:@"2"]) {
//                _selectLeader.hidden = YES;
//            }
//            [_selectLeader setTitleColor:kDarkGray forState:UIControlStateNormal];
//            [_selectLeader setTitle:[[dataArray objectAtIndex:11] objectForKey:@"Title"] forState:UIControlStateNormal];
//            _selectLeader.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            _selectLeader.titleLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
//            [_selectLeader addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
//            [self.contentView addSubview:_selectLeader];
//            
//            [self drawLine:_selectLeader.frame];
//            
//            //调整scrollView的高度
//            [self.contentView setContentSize:CGSizeMake(kScreen_Width, CGRectGetMaxY(_selectLeader.frame)+20)];
//        }
//        else
//        {
//            //调整scrollView的高度
//            [self.contentView setContentSize:CGSizeMake(kScreen_Width, CGRectGetMaxY(_count.frame)+20)];
//        }
       
    }
    else
    {
        float _y = 5.0f;
        float _x = 90.0f;
        
        UILabel *label = nil;
        
        //名字  0
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Name:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        _yName = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        _yName.text = [dataArray objectAtIndex:12];
        _yName.textColor = kDarkGray;
        _yName.tag = ConstantValue + 0;
        _yName.delegate = self;
        [self.contentView addSubview:_yName];
        
        [self drawLine:_yName.frame];
        
        _y += 46.0f;
        
        //部门  1
        
        NSString *depId = [[dataArray objectAtIndex:1] objectForKey:@"id"];
        NSString *ydepName = nil;
        for (int i = 0; i < [[self.allUserInoDic objectForKey:@"dep"] count]; ++i)
        {
            if ([[[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:i] objectForKey:@"departmentId"] isEqualToString:depId]) {
                ydepName = [[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:i] objectForKey:@"ydepartmen"];
                break;
            }
        }
        
        CGSize  depSize = [ydepName sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 8.6] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (depSize.height < 45.0f) {
            depSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Dep:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textColor = kDarkGray;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *depLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, depSize.height)];
        depLabel.text = ydepName;
        depLabel.numberOfLines = 0;
        depLabel.textColor = kDarkGray;
        depLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:depLabel];
        [depLabel release];
        
        [self drawLine:depLabel.frame];
        
        _y += (depSize.height + 1.0f);
        
        //职位  2
        NSString *jobId = [[dataArray objectAtIndex:2] objectForKey:@"id"];
        NSString *yjobName = nil;
        for (int i = 0; i < [[self.allUserInoDic objectForKey:@"job"] count]; ++i)
        {
            if ([[[[self.allUserInoDic objectForKey:@"job"] objectAtIndex:i] objectForKey:@"jobid"] isEqualToString:jobId]) {
                yjobName = [[[self.allUserInoDic objectForKey:@"job"] objectAtIndex:i] objectForKey:@"yjobName"];
                break;
            }
        }
        
        CGSize  jobSize = [yjobName sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 8.6] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (jobSize.height < 45.0f) {
            jobSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Job:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kDarkGray;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, jobSize.height)];
        jobLabel.text = yjobName;
        jobLabel.numberOfLines = 0;
        jobLabel.textColor = kDarkGray;
        jobLabel.lineBreakMode = NSLineBreakByWordWrapping;
        jobLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:jobLabel];
        [jobLabel release];
        
        [self drawLine:jobLabel.frame];
        
        _y += (jobSize.height + 1.0f);
        
        //公司名称  3
        CGSize  comNameSize = [[[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"ycomname"] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 8.6] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (comNameSize.height < 45.0f) {
            comNameSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Company:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textColor = kDarkGray;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, comNameSize.height)];
        comLabel.text = [[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"ycomname"];
        comLabel.numberOfLines = 0;
        comLabel.textColor = kDarkGray;
        comLabel.lineBreakMode = NSLineBreakByWordWrapping;
        comLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:comLabel];
        [comLabel release];
        
        [self drawLine:comLabel.frame];
        
        _y += (comNameSize.height + 1.0f);
        
        //公司地址  4
        CGSize  comAddSize = [[[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"ycaddress"] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 8.6] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (comAddSize.height < 45.0f) {
            comAddSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Address:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textColor = kDarkGray;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y,220, comAddSize.height)];
        addressLabel.text = [[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"ycaddress"];
        addressLabel.numberOfLines = 0;
        addressLabel.textColor = kDarkGray;
        addressLabel.lineBreakMode = UILineBreakModeWordWrap;
        addressLabel.font = [UIFont systemFontOfSize:kCommonFont+1];
        [self.contentView addSubview:addressLabel];
        [addressLabel release];
        
        [self drawLine:addressLabel.frame];
        
        _y += (comAddSize.height + 1.0f);
        
        //邮编  5
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Postcode:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kDarkGray;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *pcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        pcodeLabel.text = [dataArray objectAtIndex:5];
        pcodeLabel.textColor = kDarkGray;
        [self.contentView addSubview:pcodeLabel];
        [pcodeLabel release];
        
        [self drawLine:pcodeLabel.frame];
        
        _y += 46.0f;
        
        //手机  6
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Mobile:";
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textColor = kDarkGray;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        mobileLabel.text = [@"+86 " stringByAppendingString:[dataArray objectAtIndex:6]];;

        NSString *mobile = [dataArray objectAtIndex:6];
        if (mobile.length == 0) {
            mobileLabel.text = @"";
        }
        else
        {
            mobileLabel.text = [@"+86 " stringByAppendingString:[dataArray objectAtIndex:6]];
        }

        mobileLabel.textColor = kDarkGray;
        [self.contentView addSubview:mobileLabel];
        [mobileLabel release];
        
        [self drawLine:mobileLabel.frame];
        
        _y += 46.0f;
        
        //电话  7
        CGSize  telSize = [[dataArray objectAtIndex:7] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 1] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (telSize.height < 45.0f) {
            telSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Tel:";
        label.textColor = kDarkGray;
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *teleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, telSize.height)];
        teleLabel.numberOfLines = 0;
        teleLabel.text = [@"+86 10 " stringByAppendingString:[dataArray objectAtIndex:7]];
        teleLabel.textColor = kDarkGray;
        [self.contentView addSubview:teleLabel];
        [teleLabel release];
        
        [self drawLine:teleLabel.frame];
        
        _y += (telSize.height + 1.0f);
        
        //传真
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"Fax:";
        label.textColor = kDarkGray;
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *faxLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
        faxLabel.text = [@"+86 10 " stringByAppendingString:[dataArray objectAtIndex:8]];
        faxLabel.textColor = kDarkGray;
        [self.contentView addSubview:faxLabel];
        [faxLabel release];
        
        [self drawLine:faxLabel.frame];
        
        _y += 46.0f;
        
        //电子邮箱
        CGSize  emailSize = [[dataArray objectAtIndex:9] sizeWithFont:[UIFont systemFontOfSize:kCommonFont + 8.6] constrainedToSize:CGSizeMake(kScreen_Width, 500) lineBreakMode:NSLineBreakByWordWrapping];
        if (emailSize.height < 45.0f) {
            emailSize.height = 45.0f;
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
        label.text = @"E-mail:";
        label.textColor = kDarkGray;
        label.font = [UIFont italicSystemFontOfSize:kCommonFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, emailSize.height)];
        emailLabel.text = [dataArray objectAtIndex:9];
        emailLabel.textColor = kDarkGray;
        emailLabel.numberOfLines = 0;
        emailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:emailLabel];
        [emailLabel release];
        
        [self drawLine:emailLabel.frame];
        
//        _y += 46.0f;
//        
//        //申请数量
//        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
//        label.text = @"申请数量:";
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:label];
//        [label release];
//        
//        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
//        countLabel.text = [dataArray objectAtIndex:10];
//        [self.contentView addSubview:countLabel];
//        [countLabel release];
//        
//        _y += 46.0f;
//        
//        //审批人
//        NSString *leaderId = [[dataArray objectAtIndex:11] objectForKey:@"id"];
//        NSString *yleaderName = nil;
//        for (int i = 0; i < [[[self.allUserInoDicArray objectAtIndex:11] objectForKey:@"Content"] count]; ++i)
//        {
//            if ([[[[[self.allUserInoDicArray objectAtIndex:11] objectForKey:@"Content"] objectAtIndex:i] objectForKey:@"leaderId"] isEqualToString:leaderId]) {
//                yleaderName = [[[[self.allUserInoDicArray objectAtIndex:11] objectForKey:@"Content"] objectAtIndex:i] objectForKey:@"yleaderName"];
//                break;
//            }
//        }
//        
//        label = [[UILabel alloc] initWithFrame:CGRectMake(10, _y, 80, 45)];
//        label.text = @"审批人:";
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:label];
//        [label release];
//        
//        UILabel *leaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, 220, 45)];
//        leaderLabel.text = yleaderName;
//        [self.contentView addSubview:leaderLabel];
//        [leaderLabel release];
        
        //调整UIScrollView高度
        [self.contentView setContentSize:CGSizeMake(kScreen_Width, CGRectGetMaxY(emailLabel.frame)+20)];
    }
    
    //所有文本框处置居中(针对 iOS 6)
    for (id elem in self.contentView.subviews) {
        if ([elem isKindOfClass:[UITextField class]]) {
            UITextField *tx = (UITextField *)elem;
            tx.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }
}

- (void)drawLine:(CGRect)rect
{
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(rect), kScreen_Width,1)];
    line.image = [UIImage imageNamed:@"line.png"];
    [self.contentView addSubview:line];
    [line release];
}

#pragma mark -
#pragma mark SaveInformation

- (void)savaInformation
{
    [self.contentView endEditing:YES];
    
    if (language == Language_chinese) {
        [dataArray replaceObjectAtIndex:5 withObject:_pcode.text];
        [dataArray replaceObjectAtIndex:6 withObject:_mobile.text];
        [dataArray replaceObjectAtIndex:7 withObject:_telephone.text];
        [dataArray replaceObjectAtIndex:8 withObject:_fax.text];
        [dataArray replaceObjectAtIndex:9 withObject:_email.text];
        [dataArray replaceObjectAtIndex:10 withObject:_count.text];
    }
    else
    {
        [dataArray replaceObjectAtIndex:12 withObject:_yName.text];
    }
}

#pragma mark -
#pragma mark ButtonPressed Methods

- (void)confirmApply:(UIButton *)sender
{
    self.contentView.userInteractionEnabled = NO;
    if (!_popView) {
        if (_pickerView) {
            [_pickerView removeFromSuperview];
            [_pickerView release];
            _pickerView = nil;
        }
        _popView = [[ApplyPopoverView alloc] initWithFrame:CGRectMake(kScreen_Width - 20 - 105, 0, 105, 80)];
        _popView.popoverDelegate = self;
        [_baseView addSubview:_popView];
    }
}

- (void)goBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonPressed:(UIButton *)sender
{
    [self savaInformation];
    language = (Language )sender.tag - ConstantValue;
    [self resetBtnState];
    sender.selected = YES;
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
    
    //切换中英文
    [self loadApplyItems];
}

- (void)resetBtnState
{
    for (id elem in _baseView.subviews)
    {
        if ([elem isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)elem;
            btn.selected = NO;
        }
    }
}

#pragma mark -
#pragma mark PickerView delegate Methods

- (void)itemSelected:(NSDictionary *)item andView:(UIView *)view
{
    if (view.tag == SelectNameTag)
    {
        [dataArray replaceObjectAtIndex:0 withObject:item];
        
        [_applicantid release];
        _applicantid = [[item objectForKey:@"id"] retain];
        
        [_applicant release];
        _applicant = [[item objectForKey:@"Title"] retain];
        
        //是否是领导
        _isLeaderApply = [self isLeader];
        
        for (id elem in self.contentView.subviews) {
            if ([elem isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)elem;
                [btn setTitle:@"" forState:UIControlStateNormal];
            }
        }
        
        [_selectName setTitle:_applicant forState:UIControlStateNormal];
        
        NSDictionary *blankDic = @{@"Title": @"",@"id":@""};
        [self.dataArray replaceObjectAtIndex:1 withObject:blankDic];
        [self.dataArray replaceObjectAtIndex:2 withObject:blankDic];
        [self.dataArray replaceObjectAtIndex:11 withObject:blankDic];
        
        
        User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:_applicantid];

        _mobile.text = user.mobile;
        _telephone.text = user.telephone;
        _email.text = user.email;
        _fax.text = @"";
        _yName.text = @"";
        
        [self.dataArray replaceObjectAtIndex:5 withObject:@"100053"];
        [self.dataArray replaceObjectAtIndex:6 withObject:user.mobile];
        [self.dataArray replaceObjectAtIndex:7 withObject:[@"010-15801696688-" stringByAppendingString:user.telephone]];
        [self.dataArray replaceObjectAtIndex:8 withObject:user.field_char2];
        [self.dataArray replaceObjectAtIndex:9 withObject:user.email];
        [self.dataArray replaceObjectAtIndex:12 withObject:@""];
        
        _isShowDepartment = ![self is301Department];
      
        [self loadApplyItems];
        
    }
    else if (view.tag == SelectDepTag)
    {
        //选择部门直接更换部门就可以了
        [dataArray replaceObjectAtIndex:1 withObject:item];
        [_selectDep setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
//        
//        [self loadApplyItems];
    }
    else if (view.tag == SelectJobTag)
    {
        [dataArray replaceObjectAtIndex:2 withObject:item];
        [_selectJob setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
    }
    else if (view.tag == SelectLeaderTag)
    {
        [dataArray replaceObjectAtIndex:11 withObject:item];
        [_selectLeader setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }];
}

- (void)itemCanceled
{
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
}

#pragma mark -
#pragma mark 选择菜单回调

- (void)selectFinished:(NSInteger)index andType:(SelectType)type
{
    switch (type) {
        case DepType:
        {
            NSDictionary *item = @{@"Title":[[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:index] objectForKey:@"department"],@"id":[[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:index] objectForKey:@"departmentId"]};
            [dataArray replaceObjectAtIndex:1 withObject:item];
            [_selectDep setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
        }break;
        case JobType:
        {
            NSDictionary *item = @{@"Title":[[[self.allUserInoDic objectForKey:@"job"] objectAtIndex:index] objectForKey:@"jobName"],@"id":[[[self.allUserInoDic objectForKey:@"job"] objectAtIndex:index] objectForKey:@"jobid"]};
            [dataArray replaceObjectAtIndex:2 withObject:item];
            [_selectJob setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
        }break;
        case LeaderType:
        {
            NSDictionary *item = @{@"Title":[[[self.allUserInoDic objectForKey:@"leader"] objectAtIndex:index] objectForKey:@"leaderName"],@"id":[[[self.allUserInoDic objectForKey:@"leader"] objectAtIndex:index] objectForKey:@"leaderId"]};
            [dataArray replaceObjectAtIndex:11 withObject:item];
            [_selectLeader setTitle:[item objectForKey:@"Title"] forState:UIControlStateNormal];
        }break;
        case UserType:
        {
            User *user = [_userArray objectAtIndex:index];
            
            [_applicantid release];
            _applicantid = [user.userid retain];
            
            [_applicant release];
            _applicant = [user.nickname retain];
            
            NSDictionary *item = @{@"Title":_applicant,@"id":_applicantid};
            [dataArray replaceObjectAtIndex:0 withObject:item];
            
            //是否是领导
            _isLeaderApply = [self isLeader];
            
            for (id elem in self.contentView.subviews) {
                if ([elem isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)elem;
                    [btn setTitle:@"" forState:UIControlStateNormal];
                }
            }
            
            [_selectName setTitle:_applicant forState:UIControlStateNormal];
            
            NSDictionary *blankDic = @{@"Title": @"",@"id":@""};
            [self.dataArray replaceObjectAtIndex:1 withObject:blankDic];
            [self.dataArray replaceObjectAtIndex:2 withObject:blankDic];
            [self.dataArray replaceObjectAtIndex:11 withObject:blankDic];
            
            _mobile.text = user.mobile;
            _telephone.text = user.telephone;
            _email.text = user.email;
            _fax.text = @"";
            _yName.text = @"";
            
            [self.dataArray replaceObjectAtIndex:5 withObject:@"100053"];
            [self.dataArray replaceObjectAtIndex:6 withObject:user.mobile];
            [self.dataArray replaceObjectAtIndex:7 withObject:[@"010-15801696688-" stringByAppendingString:user.telephone]];
            [self.dataArray replaceObjectAtIndex:8 withObject:user.field_char2];
            [self.dataArray replaceObjectAtIndex:9 withObject:user.email];
            [self.dataArray replaceObjectAtIndex:12 withObject:@""];
            
            _isShowDepartment = ![self is301Department];
            
            [self loadApplyItems];
        }break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark 下拉菜单

- (void)selectMenu:(UIButton *)sender
{
    SelectType type = sender.tag - ConstantValue;
    
    NSMutableArray *array = [NSMutableArray array];
    
    switch (type) {
        case DepType:
        {
            array = [self.allUserInoDic objectForKey:@"dep"];
        }break;
        case JobType:
        {
            array = [self.allUserInoDic objectForKey:@"job"];
        }break;
        case LeaderType:
        {
            array = [self.allUserInoDic objectForKey:@"leader"];
        }break;
        case UserType:
        {
            array = _userArray;
        }break;
            
            
        default:
            break;
    }
    
    SelectVC *svc = [[SelectVC alloc] initWithData:array andType:type];
    svc.selectDelegate =self;
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];
}

-(void)selectName:(UIButton *)sender
{
    if (_popView) {
        return;
    }
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
    [self.contentView endEditing:YES];
    
    NSMutableArray *userArray = [NSMutableArray array];
    for (User *user in _userArray)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:user.nickname forKey:@"Title"];
        [dic setObject:user.userid forKey:@"id"];
        
        [userArray addObject:dic];
    }
    
    _pickerView = [[ApplyPickerView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 236, kScreen_Width, 236) andSourceData:userArray];
    _pickerView.tag = SelectNameTag;
    _pickerView.pickerdelegate = self;
    [self.view addSubview:_pickerView];
}

-(void)selectDep:(UIButton *)sender
{
    if (_popView) {
        return;
    }
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
    
    [self.contentView endEditing:YES];

    NSMutableArray *depArray = [NSMutableArray array];
    for (NSDictionary *dep in [self.allUserInoDic objectForKey:@"dep"])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[dep objectForKey:@"department"] forKey:@"Title"];
        [dic setObject:[dep objectForKey:@"departmentId"] forKey:@"id"];
        
        [depArray addObject:dic];
    }
    
    _pickerView = [[ApplyPickerView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 236, kScreen_Width, 236) andSourceData:depArray];
    _pickerView.tag = SelectDepTag;
    _pickerView.pickerdelegate = self;
    [self.view addSubview:_pickerView];
}

-(void)selectJob:(UIButton *)sender
{
    if (_popView) {
        return;
    }
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
    
    [self.contentView endEditing:YES];
    
    NSMutableArray *jobArray = [NSMutableArray array];
    for (NSDictionary *job in [self.allUserInoDic objectForKey:@"job"])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[job objectForKey:@"jobName"] forKey:@"Title"];
        [dic setObject:[job objectForKey:@"jobid"] forKey:@"id"];
        
        [jobArray addObject:dic];
    }

    _pickerView = [[ApplyPickerView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 236, kScreen_Width, 236) andSourceData:jobArray];
    _pickerView.tag = SelectJobTag;
    _pickerView.pickerdelegate = self;
    [self.view addSubview:_pickerView];
}

-(void)selectLeader:(UIButton *)sender
{
    if (_popView) {
        return;
    }
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_pickerView release];
        _pickerView = nil;
    }
    
    [self.contentView endEditing:YES];
    
    NSMutableArray *leaderArray = [NSMutableArray array];
    for (NSDictionary *leader in [self.allUserInoDic objectForKey:@"leader"])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[leader objectForKey:@"leaderName"] forKey:@"Title"];
        [dic setObject:[leader objectForKey:@"leaderId"] forKey:@"id"];
        
        [leaderArray addObject:dic];
    }
    
    if ([leaderArray count] == 0) {
        [ShowAlertView showAlertViewStr:@"没有领导可选"];
        return;
    }
    _pickerView = [[ApplyPickerView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 236, kScreen_Width, 236) andSourceData:leaderArray];
    _pickerView.tag = SelectLeaderTag;
    _pickerView.pickerdelegate = self;
    [self.view addSubview:_pickerView];
}

#pragma mark -
#pragma mark PopoverDelegate Methods

- (void)commitApply
{
    self.contentView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3f animations:^{
        [_popView removeFromSuperview];
        [_popView release];
        _popView = nil;
    }];
    
    [self commitCardApply];
}

- (void)modifyApply
{
    self.contentView.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.3f animations:^{
        [_popView removeFromSuperview];
        [_popView release];
        _popView = nil;
    }];
}

#pragma mark -
#pragma mark Request and requestDelegate Methods

- (void)getUserInfomation:(NSString *)userid
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    //传入userid,获取申请人相关信息
    if (userid) {
        
        [[Card_helper sharedService] requestForType:Card_UserInfoRequest info:@{@"userId":userid} target:self successSel:@"getInfoRequestFinished:" failedSel:@"getInfoRequestFailed:"];
    }
}

- (void)getInfoRequestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    if ([datas count] == 0 || [[datas objectForKey:@"resultcode"] isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"人员信息获取失败，请联系管理员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    self.allUserInoDic = datas;
    
    //获取所有同部门的用户
    [self getAllUsers:datas];
    
    //初始化数组
    [self initializeArrays];
    
    //中英文布局
    [self loadApplyItems];
}

- (void)getInfoRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

- (void)commitCardApply
{
    [self savaInformation];
    NSString *englishName = [self.dataArray objectAtIndex:12];
    
    if (englishName.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入英文名字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return;
    }

    for (id elem in self.dataArray) {
        if ([elem isKindOfClass:[NSString class]])
        {
            NSString *str = (NSString *)elem;
            if (str.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息不全，请填写完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
                return;
            }
        }
    }
    
    NSString *handState = @"0";
    if (_isLeaderApply || [_jurisdiction isEqualToString:@"2"]) //或者使用用户为领导
    {
        handState = @"1";
    }
    
    //领导id  如果是领导自己申请leaderId就是自己 否则就是选择的
    NSString *leaderId = [[self.dataArray objectAtIndex:11] objectForKey:@"id"];
    if (_isLeaderApply) {
        leaderId = _applicantid;
    }
    //部门id  如果是301 则隐藏
    NSString *departmentId = [[self.dataArray objectAtIndex:1] objectForKey:@"id"];
    if (!_isShowDepartment) {
        departmentId = @"301";
    }
    //如果实际使用人是领导 或者 申请人是领导 handState就传1 否则就传0
    NSDictionary *dic = @{@"departmentId": departmentId,@"jobid": [[self.dataArray objectAtIndex:2] objectForKey:@"id"],@"userid": self.userid,@"appName": [[self.dataArray objectAtIndex:0] objectForKey:@"Title"],@"userName": [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName],@"mobile": [self.dataArray objectAtIndex:6],@"amount": [self.dataArray objectAtIndex:10],@"leader": [[self.dataArray objectAtIndex:11] objectForKey:@"Title"],@"leaderId": leaderId,@"handState": handState,@"email": [self.dataArray objectAtIndex:9],@"fax": [self.dataArray objectAtIndex:8],@"phone": [self.dataArray objectAtIndex:7],@"yuserName": [self.dataArray objectAtIndex:12],@"pcode": [self.dataArray objectAtIndex:5]};
    [[STHUDManager sharedManager] showHUDInView:self.view];
    //提交数据
    [[Card_helper sharedService] requestForType:Card_CommitRequest info:dic target:self successSel:@"commitRequestFinished:" failedSel:@"commitRequestFailed:"];
}

- (void)commitRequestFinished:(NSDictionary *)datas
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    //提示用户是否提交成功，提交成功后返回主界面
    if ([[datas objectForKey:@"resultcode"] isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"申请提交成功，点击按钮返回" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"申请失败"];
    }
}

- (void)commitRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"申请失败"];
}

#pragma mark -
#pragma mark 获取同部门用户

- (void)getAllUsers:(NSDictionary *)datas
{
    //换取同部门所有成员并且如果是综合部的需要加入领导（领导名单在返回数据的bleader字段中，并且只有综合部成员该字段才有内容），用户按邮箱顺序排序
//    for (NSDictionary *dic in [datas objectForKey:@"dep"]) {
//        [self getUsersFromSameDep:[dic objectForKey:@"departmentId"]];
//    }
    //现在要去取本地的部门
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray  *depIdArr = [[LinkDateCenter sharedCenter] getDepIdFromUserId:sessionID];
    for(NSString *depID in depIdArr)
    {
        [self getUsersFromSameDep:depID];
    }
    [self sortArrByRules:_userArray];
    
    //领单名单 领导放在前面
    NSArray *bleader = [NSArray arrayWithArray:[datas objectForKey:@"bleader"]];
    NSMutableArray *bleaderUsrArr = [NSMutableArray array];
    if ([bleader count] != 0) {
        for (NSDictionary *dic in bleader) {
            User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:[dic objectForKey:@"blId"]];
            if (user) {
                
                [bleaderUsrArr addObject:user];
            }
        }
        [self sortArrByRules:bleaderUsrArr];
    }

    
    if ([bleader count] != 0) {
        for(int i = [bleaderUsrArr count]-1;i>=0;i--)
        {
            User *user = [bleaderUsrArr objectAtIndex:i];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userid == %@",user.userid];
            NSArray *filterArr = [_userArray filteredArrayUsingPredicate:predicate];
            if ([filterArr count]) {
                [_userArray removeObject:user];
                [_userArray insertObject:user atIndex:0];
            }
            else
            {
                [_userArray insertObject:user atIndex:0];
            }
        }
    }

    
//    //排序，按级别排序
//    if ([_userArray count]) {
//        
//        NSSortDescriptor *descriptorSort = [NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES];
////        NSSortDescriptor *descriptorName = [NSSortDescriptor sortDescriptorWithKey:@"nickname" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
//        NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptorSort, nil];
//        [_userArray sortUsingDescriptors:sortDescriptors];
//    }
//
//    //领单名单 领导放在前面
//    NSArray *bleader = [NSArray arrayWithArray:[datas objectForKey:@"bleader"]];
//    
//    if ([bleader count] != 0) {
//        for (NSDictionary *dic in bleader) {
//            User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:[dic objectForKey:@"blId"]];
//            if (user) {
//                if (![_userArray containsObject:user])
////                    [_userArray addObject:user];
//                [_userArray insertObject:user atIndex:0];
//
//                }
//            else
//            {
//                [_userArray removeObject:user];
//                [_userArray insertObject:user atIndex:0];
//            }
//        }
//    }
    
}

- (void)sortArrByRules:(NSArray *)arr
{
    
    for (User *user in arr) {
        user.sortIntNum = [user.sort integerValue];
        NSString *pinYinResult=@"";
        for(int j=0;j<user.nickname.length;j++)
        {
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([user.nickname characterAtIndex:j])]uppercaseString];
            pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        user.chineseStr =  pinYinResult;
    }
    //排序，按级别排序
    if ([arr count]) {
        NSSortDescriptor *descriptorSort = [NSSortDescriptor sortDescriptorWithKey:@"sortIntNum" ascending:YES];
        NSSortDescriptor *descriptorName = [NSSortDescriptor sortDescriptorWithKey:@"chineseStr" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptorSort,descriptorName, nil];
        [arr sortUsingDescriptors:sortDescriptors];
    }

}

#pragma mark -
#pragma mark UIAlertview Delegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:newCardApply object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 判断申请人是否是领导

- (BOOL)isLeader
{
    BOOL flag = NO;
    
//    for (NSDictionary *dic in [[self.allUserInoDicArray objectAtIndex:11] objectForKey:@"Content"])
//    {
//        if ([_applicantid isEqualToString:[dic objectForKey:@"leaderId"]])
//        {
//            flag = YES;
//            break;
//        }
//    }
    
    NSArray *bleader = [NSArray arrayWithArray:[self.allUserInoDic objectForKey:@"bleader"]];
    if ([bleader count] != 0) {
        for (NSDictionary *dic in bleader) {
            if ([[dic objectForKey:@"blId"] isEqualToString:_applicantid]) {
                flag = YES;
                break;
            }
        }
    }
    
    NSArray *leaderArr = [NSArray arrayWithArray:[self.allUserInoDic objectForKey:@"leader"]];
    if ([leaderArr count] != 0) {
        for (NSDictionary *dic in leaderArr)
        {
            if ([[dic objectForKey:@"leaderId"] isEqualToString:_applicantid]) {
                flag = YES;
                break;
            }
        }
    }
    return flag;
}

- (BOOL)is301Department
{
    BOOL flag = NO;

    NSArray *bleader = [NSArray arrayWithArray:[self.allUserInoDic objectForKey:@"bleader"]];
    if ([bleader count] != 0) {
        for (NSDictionary *dic in bleader) {
            if ([[dic objectForKey:@"blId"] isEqualToString:_applicantid]&&[[dic objectForKey:@"depid"] isEqualToString:@"301"]) {
                flag = YES;
                break;
            }
        }
    }
    
    NSArray *leaderArr = [NSArray arrayWithArray:[self.allUserInoDic objectForKey:@"leader"]];
    if ([bleader count] != 0) {
        for (NSDictionary *dic in leaderArr)
        {
            if ([[dic objectForKey:@"leaderId"] isEqualToString:_applicantid]&&[[dic objectForKey:@"de"] isEqualToString:@"301"]) {
                flag = YES;
                break;
            }
        }
    }
    return flag;

}

#pragma mark -
#pragma mark 源数组初始化

- (void)initializeArrays
{
    //获取申请人信息
    User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:_applicantid];
    if (!user) {
        return;
    }
    
    NSString *comname = [[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"comname"];
    NSString *comAddress = [[[self.allUserInoDic objectForKey:@"dep"] objectAtIndex:0] objectForKey:@"caddress"];
    
    NSString *tel = @"010-15801696688-";
    if (user.telephone) {
        tel = [@"010-15801696688-" stringByAppendingString:user.telephone];
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:
                      @[
                        @{@"Title":_applicant,@"id":_applicantid},
                        @{@"Title":@"",@"id":@""},
                        @{@"Title":@"",@"id":@""},
                        comname?comname:@"",
                        comAddress?comAddress:@"",
                        @"100053",
                        user.mobile?user.mobile:@"",
                        tel,
                        user.field_char2?user.field_char2:@"",
                        user.email?user.email:@"",
                        @"5",
                        @{@"Title":@"",@"id":@""},
                        @""]
                      ];
    
}

#pragma mark -
#pragma mark UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag - ConstantValue != 0) {
        self.contentView.contentSize = CGSizeMake(self.contentView.contentSize.width, self.contentView.contentSize.height + 216);
        [self.contentView setContentOffset:CGPointMake(self.contentView.contentOffset.x, self.contentView.contentOffset.y + 216)];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.contentView endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.contentView endEditing:YES];
    
    if (textField.tag - ConstantValue != 0) {
        self.contentView.contentSize = CGSizeMake(self.contentView.contentSize.width, self.contentView.contentSize.height - 216);
        if (self.contentView.contentOffset.y <= 216) {
            [self.contentView setContentOffset:CGPointMake(self.contentView.contentOffset.x, 0)];
        }
        else
        {
            [self.contentView setContentOffset:CGPointMake(self.contentView.contentOffset.x, self.contentView.contentOffset.y - 216)];
        }
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.contentView endEditing:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any reallUserInoDics that can be recreated.
}


@end
