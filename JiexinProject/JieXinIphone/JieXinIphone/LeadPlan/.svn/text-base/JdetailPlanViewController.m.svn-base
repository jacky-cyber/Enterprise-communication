//
//  JdetailPlanViewController.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JdetailPlanViewController.h"

#import "JReceiceLeadPlan.h"
#import "JTitleLabel.h"
#import "JAdminLeadPlanVC.h"
#import "JEditLeadPlanVC.h"
#import "JCheckUser.h"
#import "JButton.h"
@interface JdetailPlanViewController ()
@property(nonatomic,retain)UIScrollView *mainBgView;
@property(nonatomic,retain)JCheckUser*checkUser;
@property(nonatomic,copy)NSString*otherForDay;
@end
enum{
    BUTTON_SUMBIT=12,
    BUTTON_ADD=120,
    BUTTON_EMDIT=1120,
    BUTTON_DELETE=1220
};
@implementation JdetailPlanViewController
@synthesize receiceLead,userId,day,checkUser,otherForDay,mainBgView;
-(id)initWithId:(NSString*)Id day:(NSString*)d{
    if(self=[super init]){
        self.userId=Id;
        self.day=d;
        self.checkUser=[JCheckUser  shareCheckUser];

        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateMessages:) name:@"UpdateMessage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateMessages:) name:@"UpdateMessage" object:nil];
}
-(void)UpdateMessages:(NSNotification*)notification{

    
    for(UIView *tmpView in [self.mainBgView subviews]){
        if([tmpView isKindOfClass:[UIView class]]){
            [tmpView removeFromSuperview];
        }
    }
    [receiceLead reciceLeadPlan:userId day:day];
    receiceLead.personData=[receiceLead.personData[0] objectForKey:@"calendarIntroducte" ];
    self.mainBgView.contentSize=CGSizeMake(kScreen_Width, (220*[receiceLead.personData  count]+10));
    [self fillScheduleForm];
    
    
    
    
}

-(void)dealloc{
    self.receiceLead=nil;
    self.userId=nil;
    
    [super dealloc];
}
#pragma mark 加载视图
//加载返回按钮
-(int)loadBackView{
    mainBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height-46-self.iosChangeFloat)];
    self.mainBgView.contentSize=CGSizeMake(kScreen_Width, kScreen_Height);
    
    
    
    [self.mainBgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:110];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    receiceLead=[[JReceiceLeadPlan alloc]shareJReciceLeadPlan];
//    [receiceLead reciceLeadPlan:userId day:day];
    NSString *year=[day substringToIndex:4];
    NSString *mon=[[day substringFromIndex:4] substringToIndex:2];
    NSString *dates=[[day substringFromIndex:6]substringToIndex:2];
    self.otherForDay=[NSString stringWithFormat:@"%@-%@-%@",year,mon,dates];
    for(NSDictionary *dic in receiceLead.data){
        if([self.otherForDay isEqualToString:[dic objectForKey:@"day"]]){
            receiceLead.personData=[dic objectForKey:@"calendarIntroducte"];
        }
    }
    if(![receiceLead.personData count]){
        return -1;
    }
    NSString *date=[NSString stringWithFormat:@"工作日程"];

    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:date rect:CGRectMake(25, self.iosChangeFloat, 100,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    [self.view addSubview:titleView];
    [titleView release];
    
    //增加按钮
    if([self.checkUser.userType isEqualToString:@"1"]){
        JButton *sumbitBt=[[JButton alloc]initButton:nil image:@"tjlxr.png" type:BUTTON_TYPE_DOWN fontSize:17 point:CGPointMake(kScreen_Width-40, self.iosChangeFloat+10) tag:BUTTON_ADD];
        [sumbitBt setTitleColor:RGBCOLOR(25, 160, 229) forState:UIControlStateNormal];
        [sumbitBt addTarget:self action:@selector(sumitAddLeadPlan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sumbitBt];
        [sumbitBt release];
    }
    return 0;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    if([self loadBackView]==-1){
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"请求超时" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag=110;
         [alert show];
        return;
    }
        

    self.mainBgView.contentSize=CGSizeMake(kScreen_Width, (220*[receiceLead.personData  count]+10));

    [self fillScheduleForm];
}
-(void)fillScheduleForm
{

    for(int i=0;i<[receiceLead.personData count];i++){
        NSDictionary *caleIntro=(NSDictionary*)[receiceLead.personData objectAtIndex:i];
        //
        NSString *maintitle = nil;
        if([[caleIntro objectForKey:@"type"] isEqualToString:@"0"]){
            maintitle=[NSString stringWithFormat:@"%@[活动]",[caleIntro objectForKey:@"title" ]];
        }else if([[caleIntro objectForKey:@"type"] isEqualToString:@"1"]){
            maintitle=[NSString stringWithFormat:@"%@[会议]",[caleIntro objectForKey:@"title" ]];
        }else{
            maintitle=[NSString stringWithFormat:@"%@[其他]",[caleIntro objectForKey:@"title" ]];
        }
        //NSString
        NSArray *array_object = [NSArray arrayWithObjects:[caleIntro objectForKey:@"time"],@"主题",maintitle,@"人员",[caleIntro objectForKey:@"person"], @"地点",[caleIntro objectForKey:@"location"],nil];

        
        UIView *view_schedule = [self createScheduleView:array_object Postion:CGPointMake(10, i*203 + 10 * (i + 1) )];
        [self.mainBgView addSubview:view_schedule];
        
        if([self.checkUser.userType isEqualToString:@"1"]){
            JButton *emditBt=[[JButton alloc]initButton:nil image:@"编辑.png" type:BUTTON_TYPE_DOWN fontSize:0 point:CGPointMake(view_schedule.frame.size.width-70, 10) tag:BUTTON_EMDIT+i];
            [emditBt addTarget:self action:@selector(pressEditButton:) forControlEvents:UIControlEventTouchUpInside];
            [view_schedule addSubview:emditBt];
            [emditBt release];
            
            JButton *deleteBt=[[JButton alloc]initButton:nil image:@"shanchu2.png" type:BUTTON_TYPE_DOWN fontSize:0 point:CGPointMake(view_schedule.frame.size.width-40, 10) tag:BUTTON_DELETE +i];
            [deleteBt addTarget:self action:@selector(pressDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
            [view_schedule addSubview:deleteBt];
            [deleteBt release];
        }
    }

}
-(UIView*)createScheduleView:(NSArray*)array Postion:(CGPoint)pos{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(pos.x, pos.y, 300.0f, 200.0f)];
    UIColor *bordercolor = RGBCOLOR(221, 221, 221);
    UIColor *titlebgcolor =RGBCOLOR(228, 228, 228);
    UIColor *titletextcolor =RGBCOLOR(233, 91, 14);
    bgView.layer.borderColor=[bordercolor CGColor];
    bgView.clipsToBounds=YES;
    bgView.layer.borderWidth=0.7f;
    bgView.layer.cornerRadius=10.0f;
    for(int i=0;i<7;i++){
        UIView *subView=[[UIView alloc]initWithFrame:CGRectZero];
        subView.backgroundColor=[UIColor whiteColor];
        subView.layer.borderColor=[bordercolor CGColor];
        subView.layer.borderWidth=0.3f;
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectZero];
        title.textAlignment=NSTextAlignmentLeft;
        
        title.text=array[i];
        title.numberOfLines=2;
        if(i==0){
            subView.frame=CGRectMake(0.0f, 0.0f, 300.0f, 60.0f);
            subView.backgroundColor=titlebgcolor;
            title.frame=CGRectMake(10.0f, 14.0f, 100.0f, 21.0f);
            title.textColor=titletextcolor;
        }
        if(i>0&&i%2!=0){
            subView.frame=CGRectMake(0.0f, (i/2+1)*50.0f, 80.0f, 50.0f);
            title.frame=CGRectMake(2.0f, 2.0f, 76.0f, 46.0f);
            title.textAlignment=NSTextAlignmentCenter;
        }
        if(i>0&&i%2==0){
            subView.frame=CGRectMake(80.0f, (i/2)*50.0f, 220.0f, 50.0f);
            title.frame=CGRectMake(2.0f, 2.0f, 216.0f, 46.0f);
        }
        [bgView addSubview:subView];
        [subView addSubview:title];
    }
    
    return bgView;
}

#pragma mark uialterdelegete
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==110)
      [self onBtnReturn_Click];
    if(buttonIndex==0&&alertView.tag>=1120){//调用删除
        [self sureDeleteCanledar:alertView.tag];
    }else if(alertView.tag==111){//最后确定删除，并重新加载数据
        for(UIView *tmpView in [self.mainBgView subviews]){
            if([tmpView isKindOfClass:[UIView class]])
                [tmpView removeFromSuperview];
        }
        [receiceLead reciceLeadPlan:userId day:day];
        receiceLead.personData=[receiceLead.personData[0] objectForKey:@"calendarIntroducte" ];
        [self fillScheduleForm];
    }
}
#pragma mark 触发方法
- (void)onBtnReturn_Click
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}
-(void)sumitAddLeadPlan{
    JAdminLeadPlanVC *adminLeadPlan=[[JAdminLeadPlanVC alloc]init];
    [self.navigationController pushViewController:adminLeadPlan animated:YES ];

}
-(void)pressEditButton:(JButton*)sender{
    
    NSArray *personArr=[[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"person"] componentsSeparatedByString:@","];
    
    if([personArr count]==1){
        NSArray *personARR=[[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"person"] componentsSeparatedByString:@"  "];
        if([personARR count]>1)
            personArr=personARR;
    }
    NSArray *timeArr=nil;
    if([[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"time"] isEqualToString:@"待定"]){
        timeArr=@[self.otherForDay];
       
    }else{
        timeArr=@[[NSString stringWithFormat:@"%@ %@:00",self.otherForDay,[[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"time"] substringToIndex:5]],[NSString stringWithFormat:@"%@ %@:00",self.otherForDay,[[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"time"] substringFromIndex:6]]];
    }

    
    JEditLeadPlanVC *editLeadPlan=[[JEditLeadPlanVC alloc]editLeadPlan:[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"title"] type:[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"type"] person:personArr time:timeArr address:[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"location"] remark:[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"remarks"]id:[receiceLead.personData[sender.tag-BUTTON_EMDIT] objectForKey:@"id"]];
    
    [self.navigationController pushViewController:editLeadPlan animated:YES ];

}
-(void)pressDeleteButton:(JButton*)sender{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"警告" message:@"是否继续删除" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    alter.tag=sender.tag;
    [alter show];
}
-(void)sureDeleteCanledar:(int)tag{
    [receiceLead deleteLeadPlan:self.checkUser.userId canlendarId:[receiceLead.personData[tag-BUTTON_DELETE] objectForKey:@"id"]];
    NSString *message=nil;
    if([receiceLead.resultcode isEqualToString:@"0"]){
        message=@"删除成功";
        
    }else{
        message=@"删除失败";
    }
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
    alter.tag=111;
    [alter show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
