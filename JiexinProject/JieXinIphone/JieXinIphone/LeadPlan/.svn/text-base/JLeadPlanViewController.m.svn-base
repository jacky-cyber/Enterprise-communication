//
//  JLeadPlanViewController.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JLeadPlanViewController.h"
#import "JDateTime.h"
#import "JTitleLabel.h"
#import "JAdminLeadPlanVC.h"
#import "KxMenu.h"
#import "JButton.h"
#import "JReceiceLeadPlan.h"
#import "JdetailPlanViewController.h"
#import "documentDataHelp.h"
enum{
    BUTTON_LEFT=1000,
    BUTTON_RIGHT,
    BUTTON_TODAYS,
    BUTTON_BACK,
    BUTTON_USER,
    LABEL_TAG,
    IMAGEVIEW_TAG,
    LEADNAME_TAG,
    ISMESSAGE_TAG,
    MON_TAG
};
int currentIndex=0;
@interface JLeadPlanViewController (){
    CGRect screenRect;
    int fontSelectButton;
    int currentFontMonthFirstTag;
    int currentFontMonthEndTag;
}
@property(nonatomic,assign)CGRect screenRect;
@property (nonatomic, retain) UIView *mainBgView;
@property(nonatomic,retain)NSDictionary *userDic;

@end

@implementation JLeadPlanViewController
@synthesize screenRect,mainBgView,userInfo,leadPlan,userDic;

- (void)dealloc
{
    //self.leadPlan=nil;
   // self.userInfo=nil;
    self.mainBgView = nil;
    
    [super dealloc];
}
#pragma mark init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fontSelectButton=200;//设置默认为第一个
        currentYear=[[JDateTime GetYear]intValue];
        currentMonth=[[JDateTime GetMonth]intValue];
        self.userInfo=[JCheckUser  shareCheckUser];

       dayArray=[JDateTime GetDayArrayByYear:currentYear andMonth:currentMonth];
        leadPlan=[[JReceiceLeadPlan alloc]shareJReciceLeadPlan];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNotifactionOpeation) name:@"NEWNOTIFACTIONOPEATION" object:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   if([self checkUserIsLook]){
      [super createCustomNavBarWithoutLogo];
      [self loadBackView];
      [self LoadTitleView];
      [self LoadWeekView];
      [self AddDaybuttenToCalendarView ];

   }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadLeadData];
}
#pragma mark 界面处理部分
//加载返回按钮
-(void)loadBackView{
    self.mainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height- 20-46)] ;
    [self.mainBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_caledar_bg.png"]]];
    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:BUTTON_BACK];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:@"工作日程" rect:CGRectMake(15, self.iosChangeFloat, 100,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    
    [self.view addSubview:titleView];
    
    JButton *leadName=[[JButton alloc]initButton:nil image:nil type:BUTTONTYPE_USER fontSize:10 point:CGPointMake(kScreen_Width-80, self.iosChangeFloat+ 10) tag:LEADNAME_TAG];
    [leadName addTarget:self action:@selector(addAdminPress) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:leadName];
    
    
    JButton *changeUserbt=[[JButton alloc]initButton:nil  image:@"content_user_bg2.png" type:BUTTONTYPE_ADD fontSize:15 point:CGPointMake(kScreen_Width-51, self.iosChangeFloat+12) tag:BUTTON_USER];
    [changeUserbt setBackgroundImage:nil forState:UIControlStateHighlighted];
    [changeUserbt setTitleColor:RGBCOLOR(43, 159,224) forState:UIControlStateNormal];
    changeUserbt.titleLabel.textAlignment=NSTextAlignmentLeft;
    [changeUserbt addTarget:self action:@selector(checkUserCaledar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeUserbt];
    [changeUserbt release];
    
    JTitleLabel *isHasMessage=[[JTitleLabel alloc]initJTitleLabel:@"暂无日程安排" rect:CGRectMake(10,self.iosChangeFloat+380,100,20) fontSize:12 fontColor:RGBCOLOR(101, 99,100)];
    isHasMessage.tag=ISMESSAGE_TAG;
    isHasMessage.hidden=YES;
    [self.view addSubview:isHasMessage];
    [isHasMessage release];


    
}
-(void)LoadTitleView{//增加题头
    JButton *leftButton=[[JButton alloc]initButton:nil image:@"content_caledar_left.png" type:BUTTONTYPE_LEAD_TITLE fontSize:14 point:CGPointMake(30, 5) tag:BUTTON_LEFT];
    [leftButton addTarget:self action:@selector(pressCheckMonth:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:[NSString stringWithFormat:@"%d月",currentMonth-1] forState:UIControlStateNormal];
    [self.mainBgView addSubview:leftButton];
    [leftButton release];
    
    JTitleLabel *date=[[JTitleLabel alloc]initJTitleLabel:[JDateTime GetDateTime] rect:CGRectMake(95, 5, 70, 25) fontSize:17 fontColor:nil];
    JTitleLabel *mon=[[JTitleLabel alloc]initJTitleLabel:[JDateTime GetDateTimedate] rect:CGRectMake(165, 5, 40, 25) fontSize:17 fontColor:RGBCOLOR(233, 102, 30)];
    mon.textAlignment=NSTextAlignmentLeft;
    mon.tag=MON_TAG;
    [self.mainBgView addSubview:mon];
    [mon release];
    date.tag=LABEL_TAG;
    [self.mainBgView addSubview:date];
    date.backgroundColor=[UIColor clearColor];
    [date release];

    JButton *rightButton=[[JButton alloc]initButton:@"" image:@"content_caledar_left.png" type:BUTTONTYPE_LEAD_TITLE fontSize:14 point:CGPointMake(250, 5) tag:BUTTON_RIGHT];
    [rightButton addTarget:self action:@selector(pressCheckMonth:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:[NSString stringWithFormat:@"%d月",currentMonth+1] forState:UIControlStateNormal];
    [self.mainBgView addSubview:rightButton];
    [rightButton release];
    
}
-(void)LoadWeekView{//增加每个月的星期列表
    UIImageView *titleImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(3, 33, kScreen_Width-6, 24)] autorelease];
    titleImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_caledar_bg_title.png"]];
    [self.mainBgView addSubview:titleImageView];
    NSMutableArray* array = [[NSMutableArray alloc]initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:array[i]];
        lable.textColor = [UIColor blackColor];
      
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(5+i*43+i*2, 0, 30, 25);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        [titleImageView addSubview:lable];
        [lable release];
        if(i==5||i==6){
            lable.textColor=RGBCOLOR(109, 170, 10);
        }

    }
    
}
-(void)AddDaybuttenToCalendarView{//向日历中添加指定月份的日历
    currentFontMonthFirstTag=200+[JDateTime  GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]-1;
    currentFontMonthEndTag=200+[JDateTime GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]+[JDateTime GetNumberOfDayByYear:currentYear andByMonth:currentMonth]-2;
    for(int i=0;i<42;i++){
        
        JButton *date=[[JButton alloc]initButton:[dayArray objectAtIndex:i] image: @"content_image_bg.png" type:BUTTONTYPE_CALENDAR fontSize:15 point:CGPointMake(3+(i%7)*45, 60+(i/7)*45) tag:i+200];
        [date setBackgroundImage:[UIImage imageNamed:@"content_image_bg.png"] forState:UIControlStateSelected];
        [date setBackgroundColor:RGBCOLOR(215, 215, 215)];
        date.titleLabel.textColor=[UIColor blackColor];
        //判断当天是否为节假日
        if([leadPlan gettotalHoliday:i]!=0){
            [date setBackgroundImage:[UIImage imageNamed:@"webDay.png"] forState:UIControlStateNormal];
            [date setTitleColor:RGBCOLOR(31, 72, 27) forState:UIControlStateNormal];
        }

        //设定前月和后月的格式。
        if(i<[JDateTime  GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]-1 ||i>[JDateTime GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]+[JDateTime GetNumberOfDayByYear:currentYear andByMonth:currentMonth]-2){
            [date setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
        }
        //设定今天的格式
        if(([[JDateTime GetDay]intValue]==[dayArray[i] intValue])
           && (currentMonth==[[JDateTime GetMonth]intValue])
           && (currentYear==[[JDateTime GetYear]intValue]) &&(date.tag>=currentFontMonthFirstTag && date.tag<=currentFontMonthEndTag)){
        
            [date setBackgroundImage:[UIImage imageNamed:@"content_image_bg_today.png"] forState:UIControlStateNormal];
            [date setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];            
        }

       //判断当天是否有日程安排   ///
        if([leadPlan getTotalMonth:i]!=0){
            JTitleLabel *numTitle=[[JTitleLabel alloc]initJTitleLabel:[NSString stringWithFormat:@"%d",[leadPlan getTotalMonth:i]] rect:CGRectMake(date.frame.size.width-15, date.frame.size.height-15, 15,15) fontSize:12 fontColor:[UIColor whiteColor]];
            UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(date.frame.size.width-25, date.frame.size.height-25, 25,25)];
            imagView.image=[UIImage imageNamed:@"haveday.png"];
            [date addSubview:imagView];
            [date addSubview:numTitle];
        }

        //设置是否有信息更新
      UILabel  *redLabel=[[UILabel alloc] initWithFrame:CGRectMake(38, 1, 6, 6)];
        redLabel.tag=i+300;
        redLabel.hidden=YES;
        redLabel.layer.cornerRadius=3;
        redLabel.layer.masksToBounds = YES;
        redLabel.backgroundColor=[UIColor redColor];
        [date addSubview:redLabel];
        [redLabel release];

        [date addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainBgView addSubview:date];
        [date release];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NEWNOTIFACTIONOPEATION" object:nil];//加载完成，post通知
}

#pragma mark 逻辑处理部分
///用户是否有权限查看
-(BOOL)checkUserIsLook{
    if([self.userInfo.resultcode isEqualToString:@"1"]){
        NSLog(@"error");
        return false;
    }
    return true;
}
-(void)loadNotifactionOpeation{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NEWNOTIFACTIONOPEATION" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNotifactionOpeation) name:@"NEWNOTIFACTIONOPEATION" object:nil];
    for(int i=0;i<43;i++){
        if([leadPlan gettotalNewMessage:i]!=0){
            UILabel *label=(UILabel *)[self.mainBgView viewWithTag:i+300];
            label.hidden=NO;
        }
    }
    
}

//加载领导日程
-(void)loadLeadData{
  
    self.userDic=@{@"userId":self.userInfo.userId};
    
    if([self.userInfo.userType isEqualToString:@"1"]){
        self.userDic=@{@"userId":@""};//如果是管理员就设置为空
        JButton *button=(JButton*)[self.view viewWithTag:LEADNAME_TAG];
        if([button.titleLabel.text isEqualToString:@""]||button.titleLabel.text==nil)
            [button setBackgroundImage:[UIImage imageNamed:@"tjlxrtt.png"] forState:UIControlStateNormal];
        button.enabled=YES;
    }else{
        for(NSDictionary *dic in self.userInfo.leader){
            if([[dic objectForKey:@"userId"]isEqualToString:self.userInfo.userId]){
                JButton *button=(JButton*)[self.view viewWithTag:BUTTON_USER];
                [button setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }
        }
       
    }
    [self pressCheckMonth:nil];

}
#pragma mark 点击事件部分
-(void)pressCheckMonth:(id)sender{//根据按钮返回相应的日期/月份
    if(![sender isKindOfClass:[KxMenuItem class]]){
        switch ([sender tag]) {
            case BUTTON_LEFT:{
                if(--currentMonth==0){
                    currentYear--;
                    currentMonth=12;
                }
                break;
            }
            case BUTTON_TODAYS:{
                currentYear=[[JDateTime GetYear]intValue];
                currentMonth=[[JDateTime GetMonth]intValue];
                break;
            }
            case BUTTON_RIGHT:{
                if(++currentMonth==13){
                    currentYear++;
                    currentMonth=1;
                }
                break;
            }
            default:
                break;
        }

    }
    JButton *leftButton=(JButton *)[self.view viewWithTag:BUTTON_LEFT];
    [leftButton setTitle:[NSString stringWithFormat:@"%d月",currentMonth-1>0?currentMonth-1:12] forState:UIControlStateNormal];
    JButton *rightButton=(JButton *)[self.view viewWithTag:BUTTON_RIGHT];
    [rightButton setTitle:[NSString stringWithFormat:@"%d月",currentMonth+1<13?currentMonth+1:1] forState:UIControlStateNormal];
    dayArray=nil;
    dayArray=[JDateTime GetDayArrayByYear:currentYear andMonth:currentMonth];
    //移除原来的
    for(int i=0;i<42;i++){
        [[ self.view viewWithTag:200+i] removeFromSuperview];
    }
    //移除原本的
    JTitleLabel *date=(JTitleLabel*)[self.view viewWithTag:LABEL_TAG];
    date.text=[NSString stringWithFormat:@"%d年",currentYear];
    JTitleLabel *mon=(JTitleLabel*)[self.view viewWithTag:MON_TAG];
    mon.text=[NSString stringWithFormat:@"%d月",currentMonth];
    
    //userDic=(NSDictionary*)[self.userInfo.leader objectAtIndex:currentIndex];
    JTitleLabel *isHasMessage=(JTitleLabel*)[self.view viewWithTag:ISMESSAGE_TAG];
    isHasMessage.hidden=YES;
 
    if(![sender isKindOfClass:[KxMenuItem class]]){
       [self.leadPlan reciceLeadPlan:[self.userDic objectForKey:@"userId"] startDay:[NSString stringWithFormat:@"%@%@",[[JDateTime getFontYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getFontYearAndMonth] objectForKey:@"MONTH"]] endDay:[NSString stringWithFormat:@"%@%@",[[JDateTime getEndYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getEndYearAndMonth] objectForKey:@"MONTH"]]currentYear:currentYear currentMonth:currentMonth array:dayArray];
    }
    //重新加载
    [self AddDaybuttenToCalendarView];
}
//管理员点击方法
-(void)addAdminPress{
    JAdminLeadPlanVC *adminLeadPlan=[[JAdminLeadPlanVC alloc]init];
    [self.navigationController pushViewController:adminLeadPlan animated:YES ];
    [adminLeadPlan release];
}
//用户选择下拉列表
-(void)checkUserCaledar:(UIButton *)sender
{
    
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:3];
    for(int i=0;i<[self.userInfo.leader count];i++){
        NSDictionary *userNameDic=(NSDictionary*)[self.userInfo.leader objectAtIndex:i];
        KxMenuItem *item=  [KxMenuItem menuItem:[userNameDic objectForKey:@"name"] image:nil target:self action:@selector(pushcheckUserBt:) index:i+10];
        [arr addObject:item];
        
    }
    
    if([arr count]){
        [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+15, sender.frame.size.width, sender.frame.size.height) menuItems:arr];
    }
    
}
//根据用户查看行程
-(void)pushcheckUserBt:(id)sender{
 
    JButton *name=(JButton *)[self.view viewWithTag:BUTTON_USER];

    if([sender isKindOfClass:[KxMenuItem class]])
    {
        KxMenuItem *item = (KxMenuItem *)sender;
        
   
        if([item.title isEqualToString:@"全部"]){
            [name setBackgroundImage:[UIImage imageNamed:@"content_user_bg2.png"] forState:UIControlStateNormal];
            [name setTitle:@"" forState:UIControlStateNormal];
        }else{
            [name setTitle:[sender title] forState:UIControlStateNormal];
            [name setBackgroundImage:nil forState:UIControlStateNormal];
        }
        currentIndex = item.index-10;
       userDic=[(NSDictionary*)[self.userInfo.leader objectAtIndex:currentIndex] retain];
        
        dayArray=[JDateTime GetDayArrayByYear:currentYear andMonth:currentMonth];
           [self.leadPlan reciceLeadPlan:[self.userDic objectForKey:@"userId"] startDay:[NSString stringWithFormat:@"%@%@",[[JDateTime getFontYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getFontYearAndMonth] objectForKey:@"MONTH"]] endDay:[NSString stringWithFormat:@"%@%@",[[JDateTime getEndYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getEndYearAndMonth] objectForKey:@"MONTH"]]currentYear:currentYear currentMonth:currentMonth array:dayArray];
        [self pressCheckMonth:sender];//重新加载日历
    }
}

//点击某天时标题显示为此内容
-(void)pressButton:(id)sender{
    //修改标题显示的日期
    UIButton *button=(UIButton*)[self.view viewWithTag:[sender tag]];
    //获取之前被点中的按钮，并修改
    UIButton *fontButton=(UIButton *)[self.view viewWithTag:fontSelectButton];
    [fontButton setBackgroundImage:[UIImage imageNamed:@"content_image_bg.png"] forState:UIControlStateNormal];
    if([leadPlan gettotalHoliday:fontSelectButton-200]){
        [fontButton setBackgroundImage:[UIImage imageNamed:@"webDay.png"] forState:UIControlStateNormal];
    }
    fontSelectButton=button.tag;//修改当前的tag为下次的之前

    if(button.tag>=currentFontMonthFirstTag && button.tag<=currentFontMonthEndTag){
        [[documentDataHelp sharedService] deleteTestList:@"06" withCategoryid:[NSString stringWithFormat:@"%d-%02d-%02d",currentYear,currentMonth,button.titleLabel.text.intValue]];
    }else if(button.tag<currentFontMonthFirstTag){
        [[documentDataHelp sharedService] deleteTestList:@"06" withCategoryid:[NSString stringWithFormat:@"%@-%@-%02d",[[JDateTime getFontYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getFontYearAndMonth] objectForKey:@"MONTH"],button.titleLabel.text.intValue]];
    }else if(button.tag>currentFontMonthEndTag){
        [[documentDataHelp sharedService] deleteTestList:@"06" withCategoryid:[NSString stringWithFormat:@"%@-%@-%02d",[[JDateTime getEndYearAndMonth] objectForKey:@"YEAR"],[[JDateTime getEndYearAndMonth] objectForKey:@"MONTH"],button.titleLabel.text.intValue]];
    }
    //设置当前显示
    [button setBackgroundImage:[UIImage imageNamed:@"content_image_bg_today.png"] forState:UIControlStateNormal];
    JTitleLabel *date=(JTitleLabel*)[self.view viewWithTag:LABEL_TAG];
    date.text=[NSString stringWithFormat:@"%d年",currentYear];
    JTitleLabel *monsss=(JTitleLabel*)[self.view viewWithTag:MON_TAG];
    monsss.text=[NSString stringWithFormat:@"%d月",currentMonth];
   
    NSString *year=nil;
    NSString *mon=nil;
    NSString *day=nil;
    if(([sender tag]-200)<[JDateTime GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]){
        mon=[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"];
        year=[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"];
        
    }else if(([sender tag]-200)<[JDateTime GetTheWeekOfDayByYear:currentYear andByMonth:currentMonth]+[JDateTime GetNumberOfDayByYear:currentYear andByMonth:currentMonth]){
        mon=(currentMonth<10)?[NSString stringWithFormat:@"0%d",currentMonth]:[NSString stringWithFormat:@"%d",currentMonth];
        year=[NSString stringWithFormat:@"%d",currentYear];
    }else{
        mon=[[JDateTime getEndYearAndMonth]objectForKey:@"MONTH"];
        year=[[JDateTime getEndYearAndMonth]objectForKey:@"YEAR"];
    }
    day=([button.titleLabel.text intValue]<10)?[NSString stringWithFormat:@"0%d",[button.titleLabel.text intValue]]:[NSString stringWithFormat:@"%d",[button.titleLabel.text intValue]];
    JTitleLabel *isHasMessage=(JTitleLabel*)[self.view viewWithTag:ISMESSAGE_TAG];
    isHasMessage.hidden=NO;
   if([leadPlan getTotalMonth:([sender tag]-200)])
    {
        isHasMessage.hidden=YES;
        JdetailPlanViewController *detailPlan=[[JdetailPlanViewController alloc]initWithId:[self.userDic objectForKey:@"userId"] day:[NSString stringWithFormat:@"%@%@%@",year,mon,day]];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detailPlan animated:YES];
    }
    
}
- (void)onBtnReturn_Click
{

    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}


#pragma mark 代理类部分
////uialterdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
