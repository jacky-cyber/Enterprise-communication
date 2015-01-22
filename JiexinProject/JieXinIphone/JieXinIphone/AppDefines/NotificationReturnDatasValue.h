//
//  NotificationReturnDatasValue.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

//记录了所有数据的通知  这里面的内容不要轻易改动

//获取登录成功后的通知
#define kLoginFinishData @"login"

//获取被动离线的数据通知
#define  kKickedOffline     @"kickedOffline"

//全量获取用户状态
#define kPullUserStatusList @"PullUserStatusList"

//变更用户状态
#define kPushUserStatus @"pushUserStatus"

//获取离线消息
#define kFetchOfflineMsg      @"CoversationSyncinfomation"
//获取某个对话的聊天内容
#define kChatSyncinfomation      @"ChatSyncinfomation"

//获取群组离线消息
#define kFetchGroupOfflineMsg   @"groupLeaveWord"

//获取某些成员的状态
#define kGetUserStatus @"getUserStatus"

//在线消息返回
#define kOnlineMsg              @"fetchMsg"

//在线消息返回
#define kFetchLongMsg              @"fetchLongMsg"


//在线群组消息返回
#define kGroupOnLineMsg         @"fetchGroupMsg"

// 获取群组的具体内容
#define kFetchGroupInfo         @"fetchgroupinfo"
//获取用户群组列表
#define kGroupListData @"group"

//获取群成员列表
#define kGroupMemberData @"groupMember"

//群主解散群组
#define kGroupDeleteMaster @"DelGroup"

//成员退出群组
#define kGroupDeleteMass @"ExitGroup"

//群主解散群组（批量）
#define kGroupDeleteBatchMaster @"DelGroupBatch"

//成员退出群组（批量）
#define kGroupDeleteBatchMass @"ExitGroupBatch"

//创建群组
#define kGroupCreateData @"CreateGroup"

//增加或者删除群成员
#define kGroupMemberChangesData @"GroupMem"

//获取所有用户的状态
#define kGetAllUserStatus    @"pullUserStatusList"

//创建讨论组成功后发出通知
#define kForumCreateSucceed  @"forumCreateSucceed"

//修改群组名称
#define kRenameGroupName  @"RENAME_GROUP"

//发送短信
#define  kSendSMS @"SendSMS"

//发送群组消息
#define kGroupMsg @"groupMsg"

//发送个人消息
#define kPersonalMsg @"sendMsg"

//网络连接中断
#define  kDisconnect @"Disconnect"

//网络重新连接
#define  kConnect @"Connect"

//长消息的发送
#define kSendLongMsg @"sendLongMsg"

//获取头像更新
#define kDownUserpicture @"DownUserpictureResult"

//刷新数据
#define KRefreshData @"DoRefresh"
