//
//  JEditLeadPlanVC.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-30.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JEditLeadPlanVC.h"

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
    SUREBUTTON_TAG=1832,
    RETURNBUTTON_TAG,
    SECTIONVIEW_TAG=232
    
};
#import "JReceiceLeadPlan.h"
@interface JEditLeadPlanVC (){
    NSString *EditTitle;
    NSString *EditType;
    NSArray *EditPerson;
    NSArray *EditTime;
    NSString *EditAddress;
    NSString *EditRemark;
    NSString *EditId;
    NSString *currentStartTime;//当前选择的会议开始时间
    NSString *currentEndTime;//当前选择的会议结束时间
   
}
@property(nonatomic,copy) NSString *EditTitle,*EditType,*EditAddress,*EditRemark,*EditId;
@property(nonatomic,retain)NSArray *EditPerson ,*EditTime;

@end

@implementation JEditLeadPlanVC

@synthesize EditTitle,EditTime,EditRemark,EditAddress,EditId,EditPerson,EditType;

//编辑初始化的方法
-(id)editLeadPlan:(NSString*)title type:(NSString*)type person:(NSArray*)person time:(NSArray*)time address:(NSString*)address remark:(NSString*)remark id:(NSString *)canlendarId{
    self=[self init];
    EditTitle=title;
    EditType=type;
    self.EditPerson=person;
    self.EditTime=time;
    EditAddress=address;
    EditRemark=remark;
    EditId=canlendarId;
    selectPonson[0]=0;
    isEditLeadPlan=YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadEditDatasForView];

    
}
-(void)reloadEditDatasForView{
    JTitleLabel *titleView=(JTitleLabel*)[self.view viewWithTag:TITLE_TAG];
    titleView.text=@"编辑工作日程";
    //提交
    JButton* sumitBt=(JButton*)[self.view viewWithTag:BUTTON_SUMBIT];
    [sumitBt addTarget:self action:@selector(sumitEditLeadPlan) forControlEvents:UIControlEventTouchUpInside];
    //加载主题
    UITextView *mainContent=(UITextView*)[self.mainBgView viewWithTag:CONTENT_TAG];
    JTitleLabel *countTitle=(JTitleLabel*)[self.mainBgView viewWithTag:COUNTTITLE_TAG];
    mainContent.text=EditTitle;
    countTitle.text=[NSString stringWithFormat:@"%d/200",[mainContent.text length]];
    CGSize size= [EditTitle sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainContent.frame.size.width, 200) lineBreakMode:NSLineBreakByCharWrapping];
    if(mainContent.frame.size.height<size.height){
        mainContent.frame=CGRectMake(mainContent.frame.origin.x, mainContent.frame.origin.y, size.width, size.height);
        countTitle.frame=CGRectMake(mainContent.right-40,  mainContent.bottom-20, 40,20);
        UIView *sectionView=(UIView *)[self.mainBgView viewWithTag:SECTIONVIEW_TAG];
        sectionView.frame=CGRectMake(sectionView.left, mainContent.bottom+10, kScreen_Width, sectionView.height);
        self.mainBgView.contentSize=CGSizeMake(kScreen_Width, sectionView.bottom+10);
    }

    //加载会议类型
    if([EditType intValue]==2){
        selectPlanType=[EditType intValue];
    }else if([EditType intValue]<2) {
        selectPlanType=1-[EditType intValue];
    }
    JButton *typeBt=(JButton*)[self.mainBgView viewWithTag:TYPE_TAG+selectPlanType];
    typeBt.selected=YES;
    
    //加载人员
    int sumPerson=0;
    NSMutableArray *nameArr=[NSMutableArray array];
    [nameArr addObject:@"待定"];
    for(int i=1;i<[self.checkUser.leader count];i++){
        [nameArr addObject:[self.checkUser.leader[i] objectForKey:@"name"]];
    }
    for(int i=0;i<[EditPerson count];i++){
        int tag=PERSON_TAG+[nameArr indexOfObject:EditPerson[i]]+1;
        JButton *personBt=(JButton*)[self.mainBgView viewWithTag:tag];
        if(personBt){
            personBt.selected=YES;
            sumPerson++;
            selectPonson[tag-PERSON_TAG]=1;
        }
        if(sumPerson==[self.checkUser.leader count]-1){
            JButton *personBt=(JButton*)[self.mainBgView viewWithTag:PERSON_TAG];
            personBt.selected=YES;
            selectPonson[0]=1;
        }
    }
    
    //加载会议时间
    UITextField *fromTimeTF=(UITextField*)[self.mainBgView viewWithTag:TIME_TAG];
    UITextField *toTimeTF=(UITextField*)[self.mainBgView viewWithTag:TIME_TAG+1];
    if([EditTime count]==2){
        fromTimeTF.text=EditTime[0];
        self.currentStartTime=EditTime[0];
        toTimeTF.text=EditTime[1];
        self.currentEndTime=EditTime[1];
        sureTime=1;
    }else{
        NSString *date=[NSString stringWithFormat:@"%@ 00:00:00",EditTime[0]];
        fromTimeTF.text=EditTime[0];
        toTimeTF.text=EditTime[0];
        self.currentStartTime=date;
        self.currentEndTime=date;
        sureTime=0;
    }
    ////、、、、
    JButton *timeBt2=(JButton*)[self.mainBgView viewWithTag:TIMEBUTTON_TAG+[EditTime count]-1];
    timeBt2.selected=YES;
    
    //加载备注
    UITextView *remarkTF=(UITextView*)[self.mainBgView viewWithTag:REAMRK_TAG];
    remarkTF.text=EditRemark;
    
    //加载地址
    UITextView *addressTF=(UITextView*)[self.mainBgView viewWithTag:ADDRESS_TAG];
    addressTF.text=EditAddress;
    
}
#pragma mark 触发方法
//编辑行程的方法
-(void)sumitEditLeadPlan{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否确定编辑!" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    alter.tag=SUREBUTTON_TAG;
    [alter show];
    [alter release];
}
-(void)sureEditLeadPlan{
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
            if((selectPonson[i+1]==1||selectPonson[0]==1)&&i>0){
                personSelectStr=@"1";
                [personSelectId appendString:[self.checkUser.leader[i] objectForKey:@"userId"]];
                [personSelectId appendString:@","];
                [personSelectName appendString:[self.checkUser.leader[i] objectForKey:@"name"]];
                [personSelectName appendString:@","];
            }
        }
    }
    
    if(personSelectId.length<=0 ||personSelectName.length<=0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"参与人员不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    NSString * personSelectIds=[personSelectId substringToIndex:personSelectId.length-1];
    NSString * personSelectNames=[personSelectName substringToIndex:personSelectName.length-1];
    [personSelectId release];
    
    [self.leadPlan modifyLeadPlan:@[self.checkUser.userId,[[NSUserDefaults standardUserDefaults]objectForKey:User_Name]] canlendarId:EditId  time:@[selectTimeStr,startTime.text,endTime.text] theme:title.text person:@[personSelectStr,personSelectIds,personSelectNames] canlendarType:[NSString stringWithFormat:@"%d",selectPlanType ] location:address.text remarks:remark.text];
    NSString *message=nil;
    if([self.leadPlan.resultcode isEqualToString:@"0"]){
        message=@"编辑成功";
        self.UpdateMessage=@"YES";
        
    }else{
        message =@"编辑失败";
    }
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"信息提示" message:message delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.tag=RETURNBUTTON_TAG;
    [alter show];
    [alter release];
}
#pragma mark uialertViewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0&&alertView.tag==SUREBUTTON_TAG){
        [self sureEditLeadPlan];
    }else if(buttonIndex==0 && alertView.tag==RETURNBUTTON_TAG){
        [self onBtnReturn_Click];
    }
//    if(buttonIndex==0){
////        for(UIView *tmpView in [self.mainBgView subviews]){
////            if([tmpView isKindOfClass:[UIView class]]){
////                [tmpView removeFromSuperview];
////            }
////        }
//        [self reloadEditDatasForView];
//    }else{
//        
//        [self  onBtnReturn_Click];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

