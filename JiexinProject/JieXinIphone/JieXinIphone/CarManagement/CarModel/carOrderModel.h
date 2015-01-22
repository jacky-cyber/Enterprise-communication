//
//  carOrderModel.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-10.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carOrderModel : NSObject




//{"returnTime":"2014-04-03 15:21:02.0","returnPlace":"123","reason":"123","department":"产品事业部","state":"1","resultcode":"0","peopleNum":123,"drivePlace":"123","userTel":12312312312,"userId":"7","leader":"0","userName":"123name","require":"123","leaderId":"2","useTime":"2014-04-03 15:21:00.0"}


@property(nonatomic,retain) NSString *returnTime; //时间
@property(nonatomic,retain) NSString *returnPlace;//地点
@property(nonatomic,retain) NSString *reason;     //用车事由
@property(nonatomic,retain) NSString *department;  //部门
@property(nonatomic,retain) NSString *state;       //状态
@property(nonatomic,retain) NSString *resultcode;  //
@property(nonatomic,retain) NSString *peopleNum;   //用车人数
@property(nonatomic,retain) NSString *drivePlace;  //提车地点
@property(nonatomic,retain) NSString *userTel;     //申请人联系方式
@property(nonatomic,retain) NSString *userId;     //用户ID
@property(nonatomic,retain) NSString *leader;     //领导
@property(nonatomic,retain) NSString *leaderId;   //领导Id
@property(nonatomic,retain) NSString *userName;  //申请人
@property(nonatomic,retain) NSString *carUser;  //申请人
@property(nonatomic,retain) NSString *require;   //对车辆有无特殊要求
@property(nonatomic,retain) NSString *useTime; //用车时间
@property(nonatomic,retain) NSString *carType; //车类型
@property(nonatomic,retain) NSString *driver;   //司机
@property(nonatomic,retain) NSString *driveTell;//司机电话
@property(nonatomic,retain) NSString *carNumer; //车牌号
@property(nonatomic,retain) NSString *carcomany;//车辆公司
@property(nonatomic,retain) NSString *leaderOpinion;//领导意见


@end
