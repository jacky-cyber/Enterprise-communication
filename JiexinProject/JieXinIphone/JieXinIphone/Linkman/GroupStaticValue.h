//
//  GroupStaticValue.h
//  SunboxApp_Standard_IPad
//
//  Created by liqiang on 13-7-4.
//  Copyright (c) 2013年 Raik. All rights reserved.
//

#define group_owner 4000001
#define group_member 4000002

typedef enum{
    Group_ListType = 0,          //获取群组列表
    Group_membersType,       //获取成员列表
    Group_deleteType,        //退出群组
    Group_dismissType,       //解散群组
    Group_createType         //创建群组
}GroupRequestType;

typedef enum{
    GroupStyle = 0,          //群列表单元格
    MemberStyle,         //成员列表单元格
}CellStyle;

typedef enum
{
    FormalGroup = 1,  //正式群组
    TempGroup = 2       //临时群组
}GroupType;

typedef enum{
    Dep_state = 0,    //选择部门
    Group_state,      //选择群组
    Contact_state     //选择联系人
}SelectedState;

typedef enum{
    GroupChat = 0,    //多人会话
    SendMess          //群发短信
}WhatTodo;