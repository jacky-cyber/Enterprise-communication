//
//  ChatDataHelper.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatDataHelper.h"
#import "SynUserInfo.h"

//对话记录表
#define kConversationsTable @"kConversationsTable"
#define kChartMessagesTable   @"chartmessage"

#define ChartmessageTableVersion         [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"ChartmessageVersion"]



@interface ChatDataHelper()
@property (nonatomic, retain)FMDatabase *dbBase;
@property (nonatomic, retain)NSString *bundleVer;

@end
@implementation ChatDataHelper

+ (id) sharedService
{
	static ChatDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[ChatDataHelper alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    [self closeDb];
    self.bundleVer = nil;
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        self.bundleVer = [[NSUserDefaults standardUserDefaults] objectForKey:ChartmessageTableVersion];
	}
	return self;
}

#pragma mark - 判断数据库中某张表是否存在
- (BOOL) isTableExist:(NSString *)tableName
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
    
    if (![db open]) {
        return NO;
    }

    FMResultSet *rs = [db executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 == count)
        {
            return NO;//不存在此表
        }
        else
        {
            return YES;//存在此表
        }
    }
    return NO;
}

#pragma mark - DBOperations

-(FMDatabase *)readDataBase
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
    if (![db open]) {
        return nil;
    }
    /*
     字段含义:
     relativeId 谈话对象的id
     relativeName 谈话对象的名称
     last_message 最后一条信息
     msgDate 最后消息的日期
     unread_count 未读的数目
     loginId 登录的id
     isGroup  是否是组别 int 0不是 1是
     fromUserId  谈话来自人
     fromUserName  谈话人的名字
     */
    

    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS kConversationsTable (Id integer PRIMARY KEY AUTOINCREMENT,relativeId integer ,relativeName text,last_message text,msgDate text,unread_count integer,loginId text,isGroup integer,fromUserId integer,fromUserName text)"];
    
    
    /*
     字段含义:
     messageType 消息类型 文本0 1 是图片  2是贺卡其它暂定
     relativeId 联系人Id
     type  是否是群组类型   单人是0  群组是1
     fromUserId  消息来源人的id
     fromUserName 消息来源人的name
     message  文本内容
     isMySendMessage 是否是我发的信息 1是我发的 0 不是
     date   消息id
     toUserId 发送到的id
     loginid  登录的id
     isOffLineMessage 是否是离线消息  0不是 1是
     sendDate  发送的日期
     sendStatus  发送的状态  0是失败 1是成功 2是正在发送
    */
//    select * from people
//    where peopleId in (select peopleId from people group by peopleId having count(peopleId) > 1)
//    先删除主键
//    alter table table_test drop primary key;
//    然后再添加主键
//    alter table table_test add primary key(id);

    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    if (!self.bundleVer || ![self.bundleVer isEqualToString:versionString]) {
        NSString *dropChatMessageSqlStr = [NSString stringWithFormat:@"DROP TABLE IF EXISTS '%@'",kChartMessagesTable];
        BOOL result=[db executeUpdate:dropChatMessageSqlStr];
        if (result) {
            self.bundleVer = versionString;
            [[NSUserDefaults standardUserDefaults] setValue:versionString forKey:ChartmessageTableVersion];
        }
    }
    NSString *chatMessageSqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(Id integer,messageType INTEGER,relativeId INTEGER,type INTEGER, fromUserId INTEGER,fromUserName text,message text,isMySendMessage int, date text, toUserId INTEGER,loginid text, isOffLineMessage int,sendDate text,sendStatus int,PRIMARY KEY(date,relativeId))",kChartMessagesTable];
    [db executeUpdate:chatMessageSqlStr];
    
    return db;
}
- (void)closeDb
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    [db close];
    [distanceDataBase close];
}

- (NSMutableArray *)readConversationsListWithFromIndex:(NSInteger)fromIndex withPageSize:(NSInteger)pageSize
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@ order by msgDate Desc limit %d,%d",kConversationsTable,fromIndex,pageSize];
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:sqlQuery];
    while ([rs next])
    {
        ChatConversationListFeed *feed = [[ChatConversationListFeed alloc] init];
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        if (relativeId)
        {
            feed.relativeId = relativeId;
        }
        
        NSString *relativeName = [rs stringForColumn:@"relativeName"];
        if (relativeName)
        {
            feed.relativeName = relativeName;
        }
        
        NSString *last_message = [rs stringForColumn:@"last_message"];
        if (last_message)
        {
            feed.last_message = last_message;
        }
        
        NSString *msgDate = [rs stringForColumn:@"msgDate"];
        if (msgDate)
        {
            feed.msgDate = msgDate;
        }
        
        NSInteger unread_count = [[rs stringForColumn:@"unread_count"] integerValue];
        if (unread_count)
        {
            feed.unread_count = unread_count;
        }
        
        NSString *loginId = [rs stringForColumn:@"loginId"];
        if (loginId)
        {
            feed.loginId = loginId;
        }
        
        NSInteger isGroup = [[rs stringForColumn:@"isGroup"] integerValue];
        feed.isGroup = isGroup;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        feed.fromUserName = fromUserName;
        
        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
    return resultArray;
}


- (NSDictionary *)queryRowWith:(NSInteger)releativeId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"SElECT * From %@ WHERE relativeId=?",kConversationsTable];
    FMResultSet *rs = [db executeQuery:sqlStr,[NSNumber numberWithInteger:releativeId]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    while ([rs next])
    {
        NSString *relativeId = [rs stringForColumn:@"relativeId"];
        [dic setValue:relativeId forKey:@"relativeId"];
        
        NSString *unread_count = [rs stringForColumn:@"unread_count"];
        [dic setValue:unread_count forKey:@"unread_count"];
        
        NSString *last_message = [rs stringForColumn:@"last_message"];
        [dic setValue:last_message forKey:@"last_message"];
        
        NSString *msgDate = [rs stringForColumn:@"msgDate"];
        [dic setValue:msgDate forKey:@"msgDate"];


    }
    [rs close];
//    [db close];
    if ([[dic allKeys] count]) {
        return dic;
    }
    return nil;
}

- (BOOL)insertConversation:(ChatConversationListFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (relativeId, relativeName, last_message, msgDate, unread_count, loginId,isGroup,fromUserId,fromUserName) VALUES(?,?,?,?,?,?,?,?,?)",kConversationsTable];

    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInteger:feed.relativeId],feed.relativeName,feed.last_message,feed.msgDate,[NSNumber numberWithInteger:feed.unread_count],feed.loginId,[NSNumber numberWithInteger:feed.isGroup],[NSNumber numberWithInteger:feed.fromUserId],feed.fromUserName];
//    [db close];
    return result;
}

- (BOOL)deleteConversation:(NSInteger)relativeId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From %@ WHERE relativeId=?",kConversationsTable];
    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInteger:relativeId]];
//    [db close];
    return result;
}

//请求所有对话id
- (NSMutableArray *)readAllConversationIDWithIsGroup:(BOOL)isGroup
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
   
    
    NSString *sqlStr = nil;
    if (isGroup) {
        sqlStr = [NSString stringWithFormat:@"SElECT * From %@ where isGroup =1",kConversationsTable];
    }
    else
    {
        sqlStr = [NSString stringWithFormat:@"SElECT * From %@ where isGroup =0",kConversationsTable];
    }
    FMResultSet *rs = [db executeQuery:sqlStr];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];

        NSString *relativeId = [rs stringForColumn:@"relativeId"];
        [dic setValue:relativeId forKey:@"relativeId"];
        
        NSString *unread_count = [rs stringForColumn:@"unread_count"];
        [dic setValue:unread_count forKey:@"unread_count"];
        [arr addObject:dic];
    }
    [rs close];
    return arr;
}

- (BOOL)upDateUnReadCount:(NSInteger)relativeId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ set unread_count=0 WHERE relativeId=?",kConversationsTable];
    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInteger:relativeId]];
//    [db close];
    return result;
}


//读取服务器下载的数据库
-(NSString *)getUserName:(NSInteger)relativeId
{
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select nickname From im_users WHERE userid=?"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[NSNumber numberWithInteger:relativeId]];
    while ([rs next])
    {
        NSString *nickName = [rs stringForColumn:@"nickname"];
        return nickName;
    }
    [rs close];
//    [distanceDataBase close];
    return @"无姓名";
}



- (NSMutableDictionary *)getUserInfoDic:(NSInteger)relativeId
{
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    NSString *sqlStr = [NSString stringWithFormat:@"select * From im_users WHERE userid=?"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[NSNumber numberWithInteger:relativeId]];
    while ([rs next])
    {
        NSString *nickName = [rs stringForColumn:@"nickname"];
        [infoDic setValue:nickName forKey:@"nickName"];
        
        NSString *mobile = [rs stringForColumn:@"mobile"];
        [infoDic setValue:mobile forKey:@"mobile"];
        
        NSString *email = [rs stringForColumn:@"email"];
        [infoDic setValue:email forKey:@"email"];
        
        NSString *userid = [rs stringForColumn:@"userid"];
        [infoDic setValue:userid forKey:@"userid"];

    }
    [rs close];
//    [distanceDataBase close];
    return infoDic;

}

- (BOOL)deleteMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
    
//    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?)) and (Id>=%d and Id<=%d)",kChartMessagesTable,fromId,toId];
    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))",kChartMessagesTable];
    BOOL result = [db executeUpdate:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
//    [db close];
    return result;
}



- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withFromIndex:(int)fromIndex withPageSize:(int)pageSize
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))order by sendDate Asc  limit %d,%d",kChartMessagesTable,fromIndex,pageSize];
//    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where relativeId=? order by sendDate Asc  limit %d,%d",kChartMessagesTable,fromIndex,pageSize];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId]];

    while ([rs next])
    {
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        
        NSInteger Id = [[rs stringForColumn:@"Id"] integerValue];
        feed.Id = Id;
        
        NSInteger messageType = [[rs stringForColumn:@"messageType"] integerValue];
        feed.messageType = messageType;
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        feed.relativeId = relativeId;
        
        NSInteger type = [[rs stringForColumn:@"type"] integerValue];
        feed.type = type;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        if ([fromUserName isKindOfClass:[NSNull class]])
        {
            fromUserName = @"";
        }
        feed.fromUserName = fromUserName;
        
        NSString *message = [rs stringForColumn:@"message"];
        if ([message isKindOfClass:[NSNull class]])
        {
            message = @"";
        }
        feed.message = message;
        
        NSInteger isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] integerValue];
        feed.isMySendMessage = isMySendMessage;
        
        NSString *date = [rs stringForColumn:@"date"];
        if ([date isKindOfClass:[NSNull class]])
        {
            date = @"";
        }
        feed.date = date;
        
        NSInteger toUserId = [[rs stringForColumn:@"toUserId"] integerValue];
        feed.toUserId = toUserId;
        
        NSString *loginid = [rs stringForColumn:@"loginid"];
        if ([loginid isKindOfClass:[NSNull class]])
        {
            loginid = @"";
        }
        feed.loginid = loginid;
        
        int isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] intValue];
        feed.isOffLineMessage = isOffLineMessage;
        
        NSString *sendDate = [rs stringForColumn:@"sendDate"];
        if ([sendDate isKindOfClass:[NSNull class]])
        {
            sendDate = @"";
        }
        feed.sendDate = sendDate;
        
        int sendStatus = [[rs stringForColumn:@"sendStatus"] intValue];
        feed.sendStatus = sendStatus;
        
        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
//    [db close];
    return resultArray;
}


- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withDate:(NSString *)date withConFeed:(ChatConversationListFeed *)feed;
{
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Date,Week,Time,Income,Expend,Type,Mark FROM DetailBill WHERE Date LIKE '%@%@'",date,@"%"];
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?)) and sendDate LIKE '%@%@%@' order by date Desc",kChartMessagesTable,@"%",date,@"%"];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?)) and sendDate LIKE '%@%@%@' order by sendDate Asc",kChartMessagesTable,@"%",date,@"%"];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    while ([rs next])
    {
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        
        NSInteger Id = [[rs stringForColumn:@"Id"] integerValue];
        feed.Id = Id;
        
        NSInteger messageType = [[rs stringForColumn:@"messageType"] integerValue];
        feed.messageType = messageType;
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        feed.relativeId = relativeId;
        
        NSInteger type = [[rs stringForColumn:@"type"] integerValue];
        feed.type = type;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        if ([fromUserName isKindOfClass:[NSNull class]])
        {
            fromUserName = @"";
        }
        feed.fromUserName = fromUserName;
        
        NSString *message = [rs stringForColumn:@"message"];
        if ([message isKindOfClass:[NSNull class]])
        {
            message = @"";
        }
        feed.message = message;
        
        int isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] intValue];
        feed.isMySendMessage = isMySendMessage;
        
        NSString *date = [rs stringForColumn:@"date"];
        if ([date isKindOfClass:[NSNull class]])
        {
            date = @"";
        }
        feed.date = date;
        
        NSInteger toUserId = [[rs stringForColumn:@"toUserId"] integerValue];
        feed.toUserId = toUserId;
        
        NSString *loginid = [rs stringForColumn:@"loginid"];
        if ([loginid isKindOfClass:[NSNull class]])
        {
            loginid = @"";
        }
        feed.loginid = loginid;
        
        int isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] intValue];
        feed.isOffLineMessage = isOffLineMessage;
        
        NSString *sendDate = [rs stringForColumn:@"sendDate"];
        if ([sendDate isKindOfClass:[NSNull class]])
        {
            sendDate = @"";
        }
        feed.sendDate = sendDate;
        
        SendStatus sendStatus = (SendStatus)[[rs stringForColumn:@"sendStatus"] intValue];
        if (sendStatus == SendFailed) {
            feed.sendStatus = SendFailed;
        }
        else
        {
            feed.sendStatus = SendSuccess;
        }
        
        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
//    [db close];
    return resultArray;
}
- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withSendDate:(NSString *)sendDate withSeriod:(NSString *)seriod withPageSize:(int)pageSize
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))and (sendDate <= '%@')and(date != '%@') order by sendDate Desc   limit %d",kChartMessagesTable,sendDate,seriod, pageSize];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where relativeId=? and (sendDate <= '%@')and(date != '%@') order by sendDate Desc   limit %d",kChartMessagesTable,sendDate,seriod, pageSize];
//    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId]];

    while ([rs next])
    {
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        
        NSInteger Id = [[rs stringForColumn:@"Id"] integerValue];
        feed.Id = Id;
        
        NSInteger messageType = [[rs stringForColumn:@"messageType"] integerValue];
        feed.messageType = messageType;
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        feed.relativeId = relativeId;
        
        NSInteger type = [[rs stringForColumn:@"type"] integerValue];
        feed.type = type;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        if ([fromUserName isKindOfClass:[NSNull class]])
        {
            fromUserName = @"";
        }
        feed.fromUserName = fromUserName;
        
        NSString *message = [rs stringForColumn:@"message"];
        if ([message isKindOfClass:[NSNull class]])
        {
            message = @"";
        }
        feed.message = message;
        
        NSInteger isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] integerValue];
        feed.isMySendMessage = isMySendMessage;
        
        NSString *date = [rs stringForColumn:@"date"];
        if ([date isKindOfClass:[NSNull class]])
        {
            date = @"";
        }
        feed.date = date;
        
        NSInteger toUserId = [[rs stringForColumn:@"toUserId"] integerValue];
        feed.toUserId = toUserId;
        
        NSString *loginid = [rs stringForColumn:@"loginid"];
        if ([loginid isKindOfClass:[NSNull class]])
        {
            loginid = @"";
        }
        feed.loginid = loginid;
        
        NSInteger isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] integerValue];
        feed.isOffLineMessage = isOffLineMessage;
        
        NSString *sendDate = [rs stringForColumn:@"sendDate"];
        if ([sendDate isKindOfClass:[NSNull class]])
        {
            sendDate = @"";
        }
        feed.sendDate = sendDate;
        
        SendStatus sendStatus = (SendStatus)[[rs stringForColumn:@"sendStatus"] intValue];
        if (sendStatus == SendFailed || sendStatus == OnSending) {
            feed.sendStatus = SendFailed;
        }
        else
        {
            feed.sendStatus = SendSuccess;
        }
        feed.showDate = [TimeChangeWithTimeStamp getMMTimeFromFFFTime:feed.sendDate];

        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
    
    
//    NSString *showDate = nil;
//    for(int i = [resultArray count]-1;i>0;i--)
//    {
//        ChatMessagesFeed *feed = [resultArray objectAtIndex:i];
//        if (i == [resultArray count]-1) {
//            feed.isTimeLabelShow = YES;
//            showDate = feed.showDate;
//        }
//        else
//        {
//            feed.isTimeLabelShow =  [TimeChangeWithTimeStamp isBeyondMMWithTime:showDate withOtherTime:feed.showDate];
//            if (feed.isTimeLabelShow) {
//                showDate = feed.showDate;
//            }
//
//        }
//    }
    //    [db close];
    return resultArray;
}

- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId withSeriod:(NSString *)seriod withPageSize:(int)pageSize
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))and (sendDate < '%@') order by sendDate Desc   limit %d",kChartMessagesTable,seriod,pageSize];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    while ([rs next])
    {
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        
        NSInteger Id = [[rs stringForColumn:@"Id"] integerValue];
        feed.Id = Id;
        
        NSInteger messageType = [[rs stringForColumn:@"messageType"] integerValue];
        feed.messageType = messageType;
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        feed.relativeId = relativeId;
        
        NSInteger type = [[rs stringForColumn:@"type"] integerValue];
        feed.type = type;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        if ([fromUserName isKindOfClass:[NSNull class]])
        {
            fromUserName = @"";
        }
        feed.fromUserName = fromUserName;
        
        NSString *message = [rs stringForColumn:@"message"];
        if ([message isKindOfClass:[NSNull class]])
        {
            message = @"";
        }
        feed.message = message;
        
        NSInteger isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] integerValue];
        feed.isMySendMessage = isMySendMessage;
        
        NSString *date = [rs stringForColumn:@"date"];
        if ([date isKindOfClass:[NSNull class]])
        {
            date = @"";
        }
        feed.date = date;
        
        NSInteger toUserId = [[rs stringForColumn:@"toUserId"] integerValue];
        feed.toUserId = toUserId;
        
        NSString *loginid = [rs stringForColumn:@"loginid"];
        if ([loginid isKindOfClass:[NSNull class]])
        {
            loginid = @"";
        }
        feed.loginid = loginid;
        
        NSInteger isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] integerValue];
        feed.isOffLineMessage = isOffLineMessage;
        
        NSString *sendDate = [rs stringForColumn:@"sendDate"];
        if ([sendDate isKindOfClass:[NSNull class]])
        {
            sendDate = @"";
        }
        feed.sendDate = sendDate;
        
        SendStatus sendStatus = (SendStatus)[[rs stringForColumn:@"sendStatus"] intValue];
        if (sendStatus == SendFailed || sendStatus == OnSending) {
            feed.sendStatus = SendFailed;
        }
        else
        {
            feed.sendStatus = SendSuccess;
        }
        
        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
    //    [db close];
    return resultArray;

}

//- (NSString *)queryLastMessagesDateWithRelativeId:(int)relativeId  withToUserId:(int)toUserId
//{
//    FMDatabase *db = [self readDataBase];
//    if (!db) {
//        NSLog(@"Could not open db.");
//        return nil;
//    }
//    
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT MAX(Id) FROM %@ where (relativeId=? and toUserId=?)",kChartMessagesTable];
//    
//    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInt:relativeId],[NSNumber numberWithInt:toUserId]];
//    //
//    int maxId = 0;
//    while ([rs next])
//    {
//       maxId = [[rs stringForColumnIndex:0] intValue];
//    }
//    
//    
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))order by Id Asc  ",kChartMessagesTable,fromIndex,pageSize];
//    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInt:fromUserId],[NSNumber numberWithInt:toUserId],[NSNumber numberWithInt:toUserId],[NSNumber numberWithInt:fromUserId]];
//    while ([rs next])
//    {
//        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
//        
//        int Id = [[rs stringForColumn:@"Id"] intValue];
//        feed.Id = Id;
//        
//        int messageType = [[rs stringForColumn:@"messageType"] intValue];
//        feed.messageType = messageType;
//        
//        int relativeId = [[rs stringForColumn:@"relativeId"] intValue];
//        feed.relativeId = relativeId;
//        
//        int type = [[rs stringForColumn:@"type"] intValue];
//        feed.type = type;
//        
//        int fromUserId = [[rs stringForColumn:@"fromUserId"] intValue];
//        feed.fromUserId = fromUserId;
//        
//        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
//        if ([fromUserName isKindOfClass:[NSNull class]])
//        {
//            fromUserName = @"";
//        }
//        feed.fromUserName = fromUserName;
//        
//        NSString *message = [rs stringForColumn:@"message"];
//        if ([message isKindOfClass:[NSNull class]])
//        {
//            message = @"";
//        }
//        feed.message = message;
//        
//        int isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] intValue];
//        feed.isMySendMessage = isMySendMessage;
//        
//        NSString *date = [rs stringForColumn:@"date"];
//        if ([date isKindOfClass:[NSNull class]])
//        {
//            date = @"";
//        }
//        feed.date = date;
//        
//        int toUserId = [[rs stringForColumn:@"toUserId"] intValue];
//        feed.toUserId = toUserId;
//        
//        NSString *loginid = [rs stringForColumn:@"loginid"];
//        if ([loginid isKindOfClass:[NSNull class]])
//        {
//            loginid = @"";
//        }
//        feed.loginid = loginid;
//        
//        int isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] intValue];
//        feed.isOffLineMessage = isOffLineMessage;
//        
//        NSString *sendDate = [rs stringForColumn:@"sendDate"];
//        if ([sendDate isKindOfClass:[NSNull class]])
//        {
//            sendDate = @"";
//        }
//        feed.sendDate = sendDate;
//        
//        int sendStatus = [[rs stringForColumn:@"sendStatus"] intValue];
//        feed.sendStatus = sendStatus;
//        
//        [resultArray addObject:feed];
//    }
//    return resultArray;
//
//    
//}
- (int)queryCountMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return 0;
    }
    
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT count(*) FROM %@ where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))",kChartMessagesTable];
//    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT count(*) FROM %@ where  relativeId=?",kChartMessagesTable];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId]];
    
    while ([rs next])
    {
        return  [rs intForColumnIndex:0];
    }
    [rs close];
    return 0;
}

- (NSMutableArray *)queryMessagesWithRelativeId:(NSInteger)fromUserId  withToUserId:(NSInteger)toUserId  withPage:(int)page;
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    int allCount = 0;
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *countSqlQuery = [NSString stringWithFormat:@"SELECT count(*) FROM %@ where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))",kChartMessagesTable];
    FMResultSet *countRs = [db executeQuery:countSqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    
    while ([countRs next])
    {
        allCount = [countRs intForColumnIndex:0];
    }

    if (!allCount)
    {
        return resultArray;
    }
    
    //
    int requestAcount = 15*page;
    if (allCount <requestAcount) {
        requestAcount = allCount;
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@  where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))order by Id Desc  limit %d,%d",kChartMessagesTable,15*(page-1),requestAcount];
    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    while ([rs next])
    {
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        
        NSInteger Id = [[rs stringForColumn:@"Id"] integerValue];
        feed.Id = Id;
        
        NSInteger messageType = [[rs stringForColumn:@"messageType"] integerValue];
        feed.messageType = messageType;
        
        NSInteger relativeId = [[rs stringForColumn:@"relativeId"] integerValue];
        feed.relativeId = relativeId;
        
        NSInteger type = [[rs stringForColumn:@"type"] integerValue];
        feed.type = type;
        
        NSInteger fromUserId = [[rs stringForColumn:@"fromUserId"] integerValue];
        feed.fromUserId = fromUserId;
        
        NSString *fromUserName = [rs stringForColumn:@"fromUserName"];
        if ([fromUserName isKindOfClass:[NSNull class]])
        {
            fromUserName = @"";
        }
        feed.fromUserName = fromUserName;
        
        NSString *message = [rs stringForColumn:@"message"];
        if ([message isKindOfClass:[NSNull class]])
        {
            message = @"";
        }
        feed.message = message;
        
        NSInteger isMySendMessage = [[rs stringForColumn:@"isMySendMessage"] integerValue];
        feed.isMySendMessage = isMySendMessage;
        
        NSString *date = [rs stringForColumn:@"date"];
        if ([date isKindOfClass:[NSNull class]])
        {
            date = @"";
        }
        feed.date = date;
        
        NSInteger toUserId = [[rs stringForColumn:@"toUserId"] integerValue];
        feed.toUserId = toUserId;
        
        NSString *loginid = [rs stringForColumn:@"loginid"];
        if ([loginid isKindOfClass:[NSNull class]])
        {
            loginid = @"";
        }
        feed.loginid = loginid;
        
        int isOffLineMessage = [[rs stringForColumn:@"isOffLineMessage"] intValue];
        feed.isOffLineMessage = isOffLineMessage;
        
        NSString *sendDate = [rs stringForColumn:@"sendDate"];
        if ([sendDate isKindOfClass:[NSNull class]])
        {
            sendDate = @"";
        }
        feed.sendDate = sendDate;
        
        int sendStatus = [[rs stringForColumn:@"sendStatus"] intValue];
        feed.sendStatus = sendStatus;
        
        [resultArray addObject:feed];
        [feed release];
    }
    [rs close];
    return resultArray;
}


- (NSString *)queryLastTimeWithRelativeId:(NSInteger)fromUserId withToUserId:(NSInteger)toUserId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
//    NSString *countSqlQuery = [NSString stringWithFormat:@"SELECT  Min(date) FROM %@ where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))",kChartMessagesTable];
    NSString *countSqlQuery = [NSString stringWithFormat:@"SELECT  Min(sendDate) FROM %@ where ((relativeId=? and toUserId=?) or (fromUserId=? and relativeId=?))",kChartMessagesTable];
    FMResultSet *countRs = [db executeQuery:countSqlQuery,[NSNumber numberWithInteger:fromUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:toUserId],[NSNumber numberWithInteger:fromUserId]];
    
    //
    NSString *minDate = nil;
    while ([countRs next])
    {
        minDate = [countRs stringForColumnIndex:0];
    }
//    [db close];
    return minDate;
//    NSString *maxDate;
//    while ([countRs next])
//    {
//         maxDate = [countRs stringForColumnIndex:0];
//    }
//
//    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT sendDate FROM %@  where date=?",kChartMessagesTable];
//    FMResultSet *rs = [db executeQuery:sqlQuery,maxDate];
//    NSString *time = @"";
//    while ([rs next])
//    {
//        time = [rs stringForColumn:@"sendDate"];
//        
//    }
//    [db close];
//    return time;

}

- (BOOL)insertAMessage:(ChatMessagesFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (messageType, relativeId, type, fromUserId, fromUserName, message,isMySendMessage,date,toUserId,loginid,isOffLineMessage,sendDate,sendStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",kChartMessagesTable];
    
    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInteger:feed.messageType],[NSNumber numberWithInteger:feed.relativeId],[NSNumber numberWithInteger:feed.type],[NSNumber numberWithInteger:feed.fromUserId],feed.fromUserName,feed.message,[NSNumber numberWithInteger:feed.isMySendMessage],feed.date,[NSNumber numberWithInteger:feed.toUserId],feed.loginid,[NSNumber numberWithInteger:feed.isOffLineMessage],feed.sendDate,[NSNumber numberWithInt:feed.sendStatus]];
//    [db close];
    return result;
}

- (BOOL)inertOnlineMsg:(ChatMessagesFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *existSql = [NSString stringWithFormat:@"SELECT * FROM %@  where  date=?",kChartMessagesTable];
    FMResultSet *rs = [db executeQuery:existSql,feed.date];
    while ([rs next])
    {
        [rs close];
        return NO;
    }
    [rs close];
    return [self insertAMessage:feed];
}

- (BOOL)insertSynMessage:(ChatMessagesFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
//    NSString *existSql = [NSString stringWithFormat:@"SELECT * FROM %@  where date=?",kChartMessagesTable];
//    FMResultSet *rs = [db executeQuery:existSql,feed.date];
    NSString *existSql = [NSString stringWithFormat:@"SELECT * FROM %@  where relativeId=? and message=? and date=?",kChartMessagesTable];
    FMResultSet *rs = [db executeQuery:existSql,[NSNumber numberWithInteger:feed.relativeId],feed.message,feed.date];
    while ([rs next])
    {
//        NSString *date = [rs stringForColumn:@"date"];
        //更新它的时间
//        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ set sendDate=? WHERE date=?",kChartMessagesTable];
//        [db executeUpdate:updateSql,feed.sendDate,date];

//        [db close];
        [rs close];
        return YES;
    }
    [rs close];
    return [self insertAMessage:feed];
}

- (BOOL)deleteAMessage:(NSString *)msgid
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From %@ WHERE date=?",kChartMessagesTable];
    BOOL result = [db executeUpdate:sqlStr,msgid];
//    [db close];
    return result;
}


//获得当前聊天的最大Id
- (int)getMaxIdFromNowChatMessage:(NSInteger)relativeId
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT MAX(Id) FROM %@ where relativeId=?",kChartMessagesTable];

    FMResultSet *rs = [db executeQuery:sqlQuery,[NSNumber numberWithInteger:relativeId]];
//
    int maxId = 0;
    while ([rs next])
    {
        maxId = [[rs stringForColumnIndex:0] intValue];
    }
    [rs close];
//    [db close];
    return maxId;
}

//删除所有对话列表
- (BOOL)deleteAllConversations
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From %@",kConversationsTable];
    BOOL result = [db executeUpdate:sqlStr];
//    [db close];
    return result;
}
//删除所有消息
- (BOOL)deleteAllMessages
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From %@",kChartMessagesTable];
    BOOL result = [db executeUpdate:sqlStr];
//    [db close];
    return result;
}

- (BOOL)updateMessageSendStatusWithDate:(NSString *)date withSendStatus:(SendStatus)sendStatus;
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ set sendStatus=? WHERE date=?",kChartMessagesTable];
    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInt:sendStatus],date];
//    [db close];
    return result;
}

//更改群组名字
- (BOOL)updateGroupName:(NSInteger)relativeId withGroupName:(NSString *)name
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ set relativeName=? WHERE relativeId=?",kConversationsTable];
    BOOL result = [db executeUpdate:sqlStr,name,[NSNumber numberWithInteger:relativeId]];
//    [db close];
    return result;
}


- (BOOL)updateMessageContentWithDate:(NSString *)date withMessage:(NSString *)msg;
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ set message=? WHERE date=?",kChartMessagesTable];
    BOOL result = [db executeUpdate:sqlStr,date,msg];
//    [db close];
    return result;
}





@end
