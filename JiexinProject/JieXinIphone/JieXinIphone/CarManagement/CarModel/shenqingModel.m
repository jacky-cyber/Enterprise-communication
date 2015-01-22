//
//  shenqingModel.m
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "shenqingModel.h"

@implementation shenqingModel

- (void)dealloc
{
    
    self.comname = nil;
    self.department = nil;
    self.leader1  = nil;
    self.userId = nil;
    self.userName1 = nil;
    self.resultcode = nil;
    self.departmentId = nil;
    
    self.department1 = nil;//部门
    self.userName1 = nil;//申请人
    self.userTel = nil;//电话
    self.peopleNum = nil;//人数
    self.carType = nil;//用车类型
    self.useTime = nil;//用车时间
    self.drivePlace = nil;//提车时间
    self.returnTime = nil;//还车时间
    self.returnPlace = nil;//还车地点
    self.reason = nil;// 事由
    self.require = nil;// 用车要求
    self.leader1 = nil;//领导
    
    [super dealloc];
}
@end
