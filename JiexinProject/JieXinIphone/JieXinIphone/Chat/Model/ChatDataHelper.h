//
//  ChatDataHelper.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ChatConversationListFeed.h"
#import "ChatMessagesFeed.h"


typedef enum
{
    TextMsg = 0,//文本
    PicMsg,    //图片
    HeKaMsg,       //贺卡
}MessageType;

@interface ChatDataHelper : NSObject

+(ChatDataHelper *)sharedService;
//关闭数据库 因为频繁的打开和关闭数据库会导致内存暴增
- (void)closeDb;

//分页读取会话列表
- (NSMutableArray *)readConversationsListWithFromIndex:(NSInteger)fromIndex withPageSize:(NSInteger)pageSize;

//根据谈话的id 去删除某一个对话
- (BOOL)deleteConversation:(NSInteger)relativeId;
//请求所有对话id
- (NSMutableArray *)readAllConversationIDWithIsGroup:(BOOL)isGroup;

//查询对话的信息
- (NSDictionary *)queryRowWith:(NSInteger)releativeId;
//插入一个新的对话
- (BOOL)insertConversation:(ChatConversationListFeed *)feed;
//获得姓名
-(NSString *)getUserName:(NSInteger)relativeId;
//更新对话的群组的名称
- (BOOL)updateGroupName:(NSInteger)relativeId withGroupName:(NSString *)name;

//获取一个人的信息
- (NSMutableDictionary *)getUserInfoDic:(NSInteger)relativeId;

//修改某个对话列表的未阅数
- (BOOL)upDateUnReadCount:(NSInteger)relativeId;

//根据联系人查询聊天记录
- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId  withPage:(int)page;
- (int)queryCountMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId;

//查询多少条到多少条的记录
- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withFromIndex:(int)fromIndex withPageSize:(int)pageSize;
//查询某个时间点前的n条数据
- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withSeriod:(NSString *)seriod withPageSize:(int)pageSize;


- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withSendDate:(NSString *)sendDate withSeriod:(NSString *)seriod withPageSize:(int)pageSize;

//查询某天的消息记录
- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withDate:(NSString *)date withConFeed:(ChatConversationListFeed *)feed;

//删除聊天记录
- (BOOL)deleteMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId;
//查询消息记录中的最大的时间
- (NSString *)queryLastTimeWithRelativeId:(NSInteger)fromUserId withToUserId:(NSInteger)toUserId;

//插入一条聊天记录
- (BOOL)insertAMessage:(ChatMessagesFeed *)feed;
//删除一条聊天记录
- (BOOL)deleteAMessage:(NSString *)msgid;
//获得当前聊天的最大Id
- (int)getMaxIdFromNowChatMessage:(NSInteger)relativeId;
//更新某条消息的发送状态
- (BOOL)updateMessageSendStatusWithDate:(NSString *)date withSendStatus:(SendStatus)sendStatus;
//跟新某条消息的内容
- (BOOL)updateMessageContentWithDate:(NSString *)date withMessage:(NSString *)msg;
//删除所有对话列表
- (BOOL)deleteAllConversations;
//删除所有消息
- (BOOL)deleteAllMessages;
//插入一条同步的消息
- (BOOL)insertSynMessage:(ChatMessagesFeed *)feed;

//判断消息是否已经存在
- (BOOL)inertOnlineMsg:(ChatMessagesFeed *)feed;



@end
