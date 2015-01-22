//
//  JAdminLeadPlanVC.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JAdminLeadPlanVC.h"
enum{
    BUTTON_BACK=11,  //返回按钮
    CONTENT_TAG,
    COUNTTITLE_TAG,
    ADDRESS_TAG,
    ADDRESS_TITLE_TAG,
    REAMRK_TAG,
    REAMRK_TITLE_TAG,
    BUTTON_SUMBIT,
    TITLE_TAG,
    DETAIL_PICKER_TAG,
    MORE_PICKER_TAG,
    TYPE_TAG=1110,
    PERSON_TAG=1120,
    TIME_TAG=1030,
    TIMEBUTTON_TAG=1130,
    TimeBUtton_tag=10030,
    SECTIONVIEW_TAG=232
    
};
@interface JAdminLeadPlanVC (){
    
    
}

@end

@implementation JAdminLeadPlanVC
@synthesize mainBgView,checkUser,leadPlan,UpdateMessage,currentEndTime,currentStartTime;

#pragma  mark init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        checkUser=[JCheckUser shareCheckUser];
        leadPlan=[[JReceiceLeadPlan alloc]shareJReciceLeadPlan];
        for(int i=0;i<20;i++) selectPonson[i]=0;
        isEditLeadPlan=NO;
        selectPlanType=0;//默认为会议
        selectPonson[0]=1;//默认为全部
        sureTime=1;//为确定时间
        self.UpdateMessage=nil;//默认是没有修改，
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    [self loadBackView];
	[self loadAddLeadPlan];

}
#pragma mark 界面处理部分
-(void)loadBackView{
    mainBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height- 20-46)] ;
    [self.mainBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_caledar_bg.png"]]];
    self.mainBgView.delegate=self;
   
    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:BUTTON_BACK];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:@"增加工作日程" rect:CGRectMake(15, self.iosChangeFloat, 150,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    [self.view addSubview:titleView];
    titleView.tag=TITLE_TAG;
    [titleView release];
    
    //提交按钮
    JButton *sumbitBt=[[JButton alloc]initButton:@"确定" image:nil type:BUTTONTYPE_BACK fontSize:17 point:CGPointMake(kScreen_Width-60, self.iosChangeFloat+2) tag:BUTTON_SUMBIT];
    [sumbitBt setTitleColor:RGBCOLOR(25, 160, 229) forState:UIControlStateNormal];
    if(!isEditLeadPlan)
       [sumbitBt addTarget:self action:@selector(sumitAddLeadPlan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sumbitBt];
    [sumbitBt release];
  
}
-(void)loadAddLeadPlan{
 
    UITextView *mainContent=[self createView:@"UITextView" rect:CGRectMake(10, 10, kScreen_Width-20, 80) tag:CONTENT_TAG];
    mainContent.text=@"请输入主题";
    [self.mainBgView addSubview:mainContent];
   

    JTitleLabel *countTitle=[[JTitleLabel alloc]initJTitleLabel:@"0/200" rect:CGRectMake(mainContent.right-40,  mainContent.bottom-20, 40,20) fontSize:10 fontColor:RGBCOLOR(100, 100,100)];
    countTitle.tag=COUNTTITLE_TAG;
    [self.mainBgView addSubview:countTitle];
    [countTitle release];
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectZero];
    sectionView.tag=SECTIONVIEW_TAG;
    [self.mainBgView addSubview:sectionView];
    
    //会议类型
    JTitleLabel *typeName=[[JTitleLabel alloc]initJTitleLabel:@"类型" rect:CGRectMake(10,0,70,30 ) fontSize:17 fontColor:nil];
    typeName.textAlignment=NSTextAlignmentLeft;
    [sectionView addSubview:typeName];
    [typeName release];
    NSArray *arrayType=@[@"会议",@"活动",@"其他"];
    UIView *typeView=[self createView:@"UIView" rect:CGRectMake(10, typeName.bottom, 300, 41*arrayType.count) tag:0];
    [sectionView addSubview:typeView];
    [typeView release];
    
    for(int i=0;i<[arrayType count];i++){
        JButton *typeBt=[self createButton:[arrayType objectAtIndex:i] point:CGPointMake(1,i*41) tag:TYPE_TAG+i];
        if(i==0&&!isEditLeadPlan) typeBt.selected=YES;
        [typeBt addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        [typeView addSubview:typeBt];
        [typeBt release];
    }
  
    
    //参与人员
    JTitleLabel *person=[[JTitleLabel alloc]initJTitleLabel:@"参与人员" rect:CGRectMake(10,typeView.bottom+10,200,30 ) fontSize:17 fontColor:nil];
    person.textAlignment=NSTextAlignmentLeft;
    [sectionView addSubview:person];
    ///
    UIView *personView=[self createView:@"UIView" rect:CGRectMake(10, person.bottom, 300, 41*([self.checkUser.leader count]+1)) tag:PERSON_TAG-1];
    [sectionView addSubview:personView];
    [personView release];
    ////
    for(int i=0;i<[self.checkUser.leader count]+1;i++){
        NSString *name=i==0?[self.checkUser.leader[0] objectForKey:@"name"]:(i>1?[self.checkUser.leader[i-1] objectForKey:@"name"]:@"待定");
        JButton *personBt=[self createButton:name point:CGPointMake(0,41*i) tag:PERSON_TAG+i];
        [personBt addTarget:self action:@selector(selectPerson:) forControlEvents:UIControlEventTouchUpInside];
        if(i!=1&&!isEditLeadPlan){
            personBt.selected=YES;
            selectPonson[i]=1;
        }
        [personView addSubview:personBt];
        [personBt release];
    }
    //会议时间
    JTitleLabel *timeName=[[JTitleLabel alloc]initJTitleLabel:@"起止时间" rect:CGRectMake(10,personView.bottom+10,200,30 ) fontSize:14 fontColor:nil];
    timeName.tag=111110;
    timeName.textAlignment=NSTextAlignmentLeft;
    [sectionView addSubview:timeName];
    ///
    UIView *timeView1=[self createView:@"UIView" rect:CGRectMake(10, timeName.bottom, 300, 41*2) tag:3232];
    [sectionView addSubview:timeView1];
    [timeView1 release];
    /////
    NSArray *timeArr1=@[@"开始时间",@"结束时间"];
    for(int i=0;i<[timeArr1 count];i++){
        UIView *timeV=[[UIView alloc]initWithFrame:CGRectMake(0, i*41, 300, 40)];
        timeV.backgroundColor=[UIColor whiteColor];
        [timeView1 addSubview:timeV];
        
        JTitleLabel *timeTitle=[[JTitleLabel alloc]initJTitleLabel:timeArr1[i] rect:CGRectMake(0, 10, 80, 20) fontSize:14 fontColor:RGBCOLOR(68, 68, 68)];
        [timeV addSubview:timeTitle];
        UITextField *fromeTF=[[UITextField alloc]initWithFrame:CGRectMake(90, 5, 200,30)];
        
        //时间初始化
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        fromeTF.text =  [dateFormatter stringFromDate:[NSDate date]];
        self.currentStartTime=fromeTF.text;
        self.currentEndTime=fromeTF.text;
        
        fromeTF.delegate=self;
        fromeTF.tag=TIME_TAG+i;
        [timeV addSubview:fromeTF];

        JButton *fromBt=[[JButton alloc]initButton:nil image:@"content_user_bg.png" type:BUTTON_TYPE_DOWN fontSize:0 point:CGPointMake(270, 10) tag:TimeBUtton_tag+i];
        [fromBt addTarget:self action:@selector(selectSureTime:) forControlEvents:UIControlEventTouchUpInside];
        [timeV addSubview:fromBt];
        [fromBt release];
        [fromeTF release];
        [timeV release];

    }
    //时间为确定还是待定
    UIView *timeView2=[self createView:@"UIView" rect:CGRectMake(10, timeView1.bottom+10, 300, 41*2) tag:0];
    [sectionView addSubview:timeView2];
    [timeView2 release];
    
    NSArray *timeArr2=@[@"待定",@"确定"];
    for(int i=0;i<[timeArr1 count];i++){
        JButton *timeBt2=[self createButton:timeArr2[i] point:CGPointMake(0,41*i) tag:TIMEBUTTON_TAG+i];
        [timeBt2 addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        if(i==1&&!isEditLeadPlan) timeBt2.selected=YES;
        [timeView2 addSubview:timeBt2];
        [timeBt2 release];
    }
    
    //地址
    JTitleLabel *addressName=[[JTitleLabel alloc]initJTitleLabel:@"地点" rect:CGRectMake(10,timeView2.bottom+10,120,20 ) fontSize:17 fontColor:nil];
    addressName.textAlignment=NSTextAlignmentLeft;
    [sectionView addSubview:addressName];
    [addressName release];
    UITextView *addressTF=[self createView:@"UITextView" rect:CGRectMake(10, addressName.bottom, kScreen_Width-20, 50) tag:ADDRESS_TAG];
        [sectionView addSubview:addressTF];
    [addressTF release];
    
    JTitleLabel *countAddress=[[JTitleLabel alloc]initJTitleLabel:@"0/30" rect:CGRectMake(addressTF.right-30,  addressTF.bottom-20, 30,20) fontSize:10 fontColor:RGBCOLOR(100, 100,100)];
    countAddress.tag=ADDRESS_TITLE_TAG;
    [sectionView addSubview:countAddress];
    
    //备注
    JTitleLabel *remarkName=[[JTitleLabel alloc]initJTitleLabel:@"备注" rect:CGRectMake(10,addressTF.bottom+10,120,20 ) fontSize:17 fontColor:nil];
    remarkName.textAlignment=NSTextAlignmentLeft;
    [sectionView addSubview:remarkName];
    
    UITextView *remarkTF=[self createView:@"UITextView" rect:CGRectMake(10, remarkName.bottom, kScreen_Width-20, 50) tag:REAMRK_TAG];
    [sectionView addSubview:remarkTF];
    [remarkTF release];
    [remarkName release];
    JTitleLabel *countRemark=[[JTitleLabel alloc]initJTitleLabel:@"0/30" rect:CGRectMake(remarkTF.right-30,  remarkTF.bottom-20, 30,20) fontSize:10 fontColor:RGBCOLOR(100, 100,100)];
    countRemark.tag=REAMRK_TITLE_TAG;
    [sectionView addSubview:countRemark];
    [countRemark release];

    
    sectionView.frame=CGRectMake(0,mainContent.bottom+10,kScreen_Width,remarkTF.bottom);
    self.mainBgView.contentSize=CGSizeMake(kScreen_Width, sectionView.bottom+10);
    [mainContent release];
}
-(id)createView:(NSString*)view rect:(CGRect)rect tag:(int)tag{
    
    if([view isEqualToString:@"UIView"]){
        UIView *maintView=[[UIView alloc]initWithFrame:rect];
        maintView.layer.borderColor=[RGBCOLOR(213, 213, 213) CGColor];
        maintView.layer.borderWidth=1.0;
        maintView.layer.cornerRadius=5.0;
        maintView.tag=tag;
        return maintView;

    }
    if([view isEqualToString:@"UITextView"]){
      UITextView*  maintView=[[UITextView alloc]initWithFrame:rect];
        maintView.delegate=self;
        maintView.layer.borderColor=[RGBCOLOR(213, 213, 213) CGColor];
        maintView.layer.borderWidth=1.0;
        maintView.layer.cornerRadius=5.0;
        maintView.tag=tag;
        maintView.textColor=RGBCOLOR(100, 100, 100);
        return maintView;
    }
    
    return nil;
}
//创建button
-(JButton*)createButton:(NSString*)title point:(CGPoint)point tag:(int)tag{
    JButton *maintView=[[JButton alloc]initButton:title image:nil type:BUTTONTYPE_USERSELECT fontSize:14 point:point tag:tag];
    [maintView setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
    [maintView setBackgroundImage:[UIImage imageNamed:@"button_select_my.png"] forState:UIControlStateSelected];
    maintView.backgroundColor=[UIColor whiteColor];
    maintView.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    maintView.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    return maintView;
}

#pragma mark 触发方法
//返回按钮方法
- (void)onBtnReturn_Click
{
    if([self.UpdateMessage isEqualToString:@"YES"]){
        self.UpdateMessage=nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateMessage" object:nil];
    }

    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}
//选择人员的方法
-(void)selectPerson:(JButton*)sender{

    UIView *topPerson=(UIView*)[self.mainBgView viewWithTag:PERSON_TAG-1];
    UIView *sectionView=(UIView*)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
    [self.mainBgView setContentOffset:CGPointMake(0, topPerson.top+sectionView.top-30) animated:YES];
    if(sender.tag==PERSON_TAG+0){//为全部
        sender.selected=!sender.selected;
        JButton *button=(JButton*)[self.view viewWithTag:PERSON_TAG+1];//设置待定为反
        button.selected=NO;
        selectPonson[1]=0;
        selectPonson[0]=sender.selected;
        for(int i=2;i<[self.checkUser.leader count]+1;i++){
            JButton *button=(JButton*)[self.mainBgView viewWithTag:PERSON_TAG+i];
            selectPonson[i]=sender.selected;
            button.selected=sender.selected;
        }
//        
//        //人员选择全部后时间也随着改变
//        JButton *sureBt=(JButton*)[self.mainBgView viewWithTag:TIMEBUTTON_TAG+1];;
//        [self selectTime:sureBt];
    }else if(sender.tag==PERSON_TAG+1){//为待定
        sender.selected=!sender.selected;
        JButton *button=(JButton*)[self.view viewWithTag:PERSON_TAG+0];
        button.selected=NO;//设置确定为反
        selectPonson[0]=0;
        selectPonson[1]=sender.selected;
        for(int i=2;i<[self.checkUser.leader count]+1;i++){
            JButton *button=(JButton*)[self.mainBgView viewWithTag:PERSON_TAG+i];
            selectPonson[i]=NO;
            button.selected=NO;
        }
//        //人员选择待定后时间也随着改变
//        JButton *unSureBt=(JButton*)[self.mainBgView viewWithTag:TIMEBUTTON_TAG];;
//        [self selectTime:unSureBt];
        
    }else if(sender.tag>1){
        sender.selected=!sender.selected;
        selectPonson[sender.tag-PERSON_TAG]=sender.selected;
        selectPonson[1]=0;
        selectPonson[0]=0;
        JButton *button=(JButton*)[self.view viewWithTag:PERSON_TAG+1];//设置待定为反
        button.selected=NO;
        JButton *buttons=(JButton*)[self.view viewWithTag:PERSON_TAG+0];//设置确定为反
        buttons.selected=NO;
        int sumPerson=0;//当前选择的总人数是多少，确定是否为选择全部
        for(int i=2;i<[self.checkUser.leader count]+1;i++){
            sumPerson+=selectPonson[i];
            if(sumPerson==[self.checkUser.leader count]-1){
                buttons.selected=YES;
                selectPonson[0]=1;
            }
        }
        
//        //人员选择确定后时间也随着改变
//        JButton *sureBt=(JButton*)[self.mainBgView viewWithTag:TIMEBUTTON_TAG+1];;
//        [self selectTime:sureBt];
    }
  
}
//选择会议类型方法
-(void)selectType:(JButton*)sender{
    for(int i=0;i<3;i++){
        JButton *button=(JButton*)[self.mainBgView viewWithTag:TYPE_TAG+i];
        button.selected=NO;
    }
    //设定为当前选择的类型
    selectPlanType=sender.tag-TYPE_TAG;
    sender.selected=!sender.selected;
}
//选择会议时间方法
-(void)selectTime:(JButton*)sender{
    
    UIView *timeView=(UIView*)[self.mainBgView viewWithTag:3232];
    UIView *sectionView=(UIView*)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
    [self.mainBgView setContentOffset:CGPointMake(0, timeView.top+sectionView.top-30) animated:YES];
    
    for(int i=0;i<2;i++){
        JButton *button=(JButton*)[self.view viewWithTag:TIMEBUTTON_TAG+i];
        button.selected=NO;
    }
    sender.selected=!sender.selected;
    sureTime=sender.tag-TIMEBUTTON_TAG;

    UITextField *textField1=(UITextField*)[self.view viewWithTag:TIME_TAG];
    if(sender.tag==TIMEBUTTON_TAG){//待定
            textField1.text=[[NSString stringWithFormat:@"%@",self.currentStartTime] substringToIndex:10];
    }else{//确定
            textField1.text=self.currentStartTime;
    }
    UITextField *textField2=(UITextField*)[self.view viewWithTag:TIME_TAG+1];
    if(sender.tag==TIMEBUTTON_TAG){
        textField2.text=[[NSString stringWithFormat:@"%@",self.currentEndTime] substringToIndex:10];
    }else{
        textField2.text=self.currentEndTime;
    }

}
-(void)selectSureTime:(JButton*)sender{
    
    UIView *timeView=(UIView*)[self.mainBgView viewWithTag:3232];
    UIView *sectionView=(UIView*)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
    [self.mainBgView setContentOffset:CGPointMake(0, timeView.top+sectionView.top-30) animated:YES];
    
    //选择时间后就一定为确定
    JButton *sureBt=(JButton*)[self.view viewWithTag:TIMEBUTTON_TAG];
    sureBt.selected=NO;
    JButton *sureBt1=(JButton*)[self.view viewWithTag:TIMEBUTTON_TAG+1];
    sureBt1.selected=YES;
    sureTime=1;
    currentTimeSelect=[sender tag];
    JDatePickerView *datePicker=[[JDatePickerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    datePicker.delegate=self;
    [self.view addSubview:datePicker];
    if(sureTime){
        datePicker.tag=DETAIL_PICKER_TAG;
    }
    
}


-(void)datePicker:(JDatePickerView *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *dateAndTime=nil;
    
    if(currentTimeSelect==TimeBUtton_tag){
       self. currentStartTime=[picker getDate];
        
        //细节而已 如果结束时间没有时分秒，则自动附0
        UITextField *text=(UITextField*)[self.view viewWithTag:TIME_TAG+1];
        if([text.text compare:self.currentStartTime options:NSLiteralSearch]<=0){
            text.text=self.currentStartTime;
            self.currentEndTime=text.text;
        }
        dateAndTime=self.currentStartTime;
    }else{
        //细节而已 如果结束时间没有时分秒，则自动附0
        self.currentEndTime=[picker getDate];
        UITextField *text=(UITextField*)[self.view viewWithTag:TIME_TAG];
        if([text.text length]<19){
            text.text=self.currentStartTime;
        }
        if([self.currentStartTime compare:self.currentEndTime options:NSLiteralSearch]>0){
            self.currentEndTime=self.currentStartTime;
            
        }
        dateAndTime=self.currentEndTime;
    }
    UITextField *text=(UITextField*)[self.view viewWithTag:currentTimeSelect-TimeBUtton_tag+TIME_TAG];
    text.text=dateAndTime;
}



//创建行程的方法
//提交方法
-(void)sumitAddLeadPlan{
    NSString *selectTimeStr=[NSString stringWithFormat:@"%d",sureTime];
    UITextField *startTime=(UITextField*)[self.view viewWithTag:TIME_TAG];
    UITextField *endTime=(UITextField*)[self.view viewWithTag:TIME_TAG+1];
    if([startTime.text length]==0||[endTime.text length]==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入正确选择时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UITextView *title=(UITextView*)[self.view viewWithTag:CONTENT_TAG];
    UITextView *address=(UITextView*)[self.view viewWithTag:ADDRESS_TAG];
    UITextView *remark=(UITextView*)[self.view viewWithTag:REAMRK_TAG];
    NSString *message1=nil;
    if(remark.text.length>30){
        message1=@"备注不能超过30字";
    }
    if(address.text.length>30){
        message1=@"地址不能超过30字";
    }
    if(title.text.length>200){
        message1=@"主题不能超过200字";
    }else if([title.text isEqualToString:@"请输入主题"]){
        message1=@"主题不能为空";
    }
    if(message1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:message1 delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSString *personSelectStr;
    NSMutableString *personSelectId=[[NSMutableString alloc]init];
    NSMutableString *personSelectName=[[NSMutableString alloc]init];
    for(int i=1;i<[self.checkUser.leader count];i++){
        if(selectPonson[1]==1){
            personSelectStr=@"0";
            [personSelectId appendString:@"0,"];
            [personSelectName appendString:@"待定,"];
            break;
        }else{
            if(selectPonson[i+1]==1||selectPonson[0]==1){
                personSelectStr=@"1";
                [personSelectId appendString:[self.checkUser.leader[i] objectForKey:@"userId"]];
                [personSelectId appendString:@","];
                [personSelectName appendString:[self.checkUser.leader[i] objectForKey:@"name"]];
                [personSelectName appendString:@","];
            }
        }
    }
    
    
    NSString * personSelectIds=[personSelectId substringToIndex:personSelectId.length-1];
    NSString * personSelectNames=[personSelectName substringToIndex:personSelectName.length-1];
  
    
    [self.leadPlan addLeadPlan:self.checkUser.userId time:@[selectTimeStr,startTime.text,endTime.text] theme:title.text person:@[personSelectStr,personSelectIds,personSelectNames] canlendarType:[NSString stringWithFormat:@"%d",selectPlanType ] location:address.text remarks:remark.text];
    NSString *message=nil;
    if([self.leadPlan.resultcode isEqualToString:@"0"]){
        message=@"创建成功";
        self.UpdateMessage=@"YES";
    }else{
        message =@"创建失败";
    }
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:message message:@"是否继续!" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alter show];
}
#pragma mark uitextviewdelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if(textView.tag==CONTENT_TAG&&[textView.text isEqualToString:@"请输入主题"])textView.text=@"";
    if(textView.tag==ADDRESS_TAG){
        UIView *sectionView=(UIView*)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
        [self.mainBgView setContentOffset:CGPointMake(0, textView.top+sectionView.top-30) animated:YES];
        
    }else if(textView.tag==REAMRK_TAG){
        UIView *sectionView=(UIView*)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
        [self.mainBgView setContentOffset:CGPointMake(0, textView.top+sectionView.top-100) animated:YES];
    }
  
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if(textView.tag==CONTENT_TAG&&[textView.text isEqualToString:@""])
        textView.text=@"请输入主题";

    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    int countTitleContent;

    if(textView.tag==CONTENT_TAG){//是主题
        JTitleLabel *countText=(JTitleLabel*)[self.mainBgView viewWithTag:COUNTTITLE_TAG];
        countTitleContent=[textView.text length];
        countText.text=[NSString stringWithFormat:@"%d/200",countTitleContent];
    }
    if(textView.tag==ADDRESS_TAG){//地址
        JTitleLabel *countText=(JTitleLabel*)[self.mainBgView viewWithTag:ADDRESS_TITLE_TAG];
        countTitleContent=[textView.text length];
        countText.text=[NSString stringWithFormat:@"%d/30",countTitleContent];
    }
    if(textView.tag==REAMRK_TAG){//备注
        JTitleLabel *countText=(JTitleLabel*)[self.mainBgView viewWithTag:REAMRK_TITLE_TAG];
        countTitleContent=[textView.text length];
        countText.text=[NSString stringWithFormat:@"%d/30",countTitleContent];
    }
}

#pragma mark uitextfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark uialertViewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        for(UIView *tmpView in [self.mainBgView subviews]){
            if([tmpView isKindOfClass:[UIView class]]){
                [tmpView removeFromSuperview];
            }
        }
        [self loadAddLeadPlan];
    }else{
        
        [self  onBtnReturn_Click];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.mainBgView=nil;
    [super dealloc];
}

@end
