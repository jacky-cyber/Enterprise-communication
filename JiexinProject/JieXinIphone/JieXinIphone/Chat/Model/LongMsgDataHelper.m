//
//  LongMsgDataHelper.m
//  JieXinIphone
//
//  Created by liqiang on 14-4-1.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LongMsgDataHelper.h"
#import "SynUserInfo.h"

#define kLongMsgTable @"kLongMsgTable"
#define LongMsgTableVersion         [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"kLongMsgTableVersion"]


@interface LongMsgDataHelper()
@property (nonatomic, retain)NSString *bundleVer;

@end


@implementation LongMsgDataHelper
+ (id) sharedService
{
	static LongMsgDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[LongMsgDataHelper alloc] init];
    });
    return _sharedInst;
}
- (id) init
{
	if (self = [super init])
	{
        self.bundleVer = [[NSUserDefaults standardUserDefaults] objectForKey:LongMsgTableVersion];
	}
	return self;
}
- (void)dealloc
{
    [self closeDb];
    self.bundleVer = nil;

    [super dealloc];
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
     serialID 发送的时间戳
     infoID 这个群消息群组每条消息的时间戳
     msgType 200个人 201群组
     sumCount 长消息分的总数
     sendOrder 长消息的顺序
     time      发送的时间
     from   发送的人的id
     to      发送到某人的id
     relateId  相关联的id
     msg        群组的消息
     */
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    if (!self.bundleVer || ![self.bundleVer isEqualToString:versionString])
    {
        NSString *dropChatMessageSqlStr = [NSString stringWithFormat:@"DROP TABLE IF EXISTS '%@'",kLongMsgTable];
        BOOL result=[db executeUpdate:dropChatMessageSqlStr];
        if (result) {
            self.bundleVer = versionString;
            [[NSUserDefaults standardUserDefaults] setValue:versionString forKey:LongMsgTableVersion];
        }
    }

    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS kLongMsgTable (Id integer,serialID text,infoID text,msgType integer,sumCount integer,sendOrder integer,time text,sendStatus integer, fromId text,toId text,relateId text,msg text,PRIMARY KEY(infoID,serialID))"];
    return db;
}
- (void)closeDb
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
//    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
//    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    [db close];
//    [distanceDataBase close];
}

- (BOOL)insertALongMsgToDB:(LongMsgFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if(!db)
    {
        NSLog(@"Could not open db.");
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(serialID,infoID, msgType, sumCount, sendOrder, time,sendStatus,fromId,toId,relateId,msg) VALUES(?,?,?,?,?,?,?,?,?,?,?)",kLongMsgTable];

    BOOL result = [db executeUpdate:sqlStr,feed.serialID,feed.infoID,[NSNumber numberWithInteger:feed.msgType],[NSNumber numberWithInteger:feed.sumCount],[NSNumber numberWithInteger:feed.sendOrder],feed.time,[NSNumber numberWithInt:feed.sendStatus],feed.from,feed.to,feed.relateId,feed.msg];
    return result;
}

- (NSString *)getInfoIDFromSerialID:(NSString *)serialID
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *countSql = [NSString stringWithFormat:@"SELECT infoID FROM %@ WHERE serialID='%@'",kLongMsgTable,serialID];
    FMResultSet *rs = [db executeQuery:countSql];
    
    NSString *infoID=@"";
    while ([rs next])
    {
        infoID = [rs stringForColumn:@"infoID"];
    }
    return infoID;
}
- (BOOL)deleteLongMsgsWithInfoId:(NSString *)infoID
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From %@ where infoID='%@'",kLongMsgTable,infoID];
    BOOL result = [db executeUpdate:sqlStr];
    [db close];
    return result;
}


- (BOOL)updateMessageSendStatusWithSerialID:(NSString *)serialID withSendorder:(NSString *)sendorder withSendStatus:(SendStatus)sendStatus withRelateID:(NSString *)relateID;
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ set sendStatus=? WHERE serialID=? and sendOrder=? and relateId=? ",kLongMsgTable];
    BOOL result = [db executeUpdate:sqlStr,[NSNumber numberWithInt:sendStatus],serialID,sendorder,relateID];
    return result;
}

- (BOOL)querySendResultWithInfoID:(NSString *)infoID withRelativeId:(NSInteger)relativeID
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
 
    NSString *countSql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@ WHERE infoID ='%@' and relateId =%d and sendStatus =%d",kLongMsgTable,infoID,relativeID,SendSuccess];
    FMResultSet *rs = [db executeQuery:countSql];

    int count=0;
    while ([rs next])
    {
        count = [rs intForColumn:@"count"];
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT sumCount from %@ where infoID ='%@' and relateId = %d",kLongMsgTable,infoID,relativeID];
   rs = [db executeQuery:sqlStr];
    NSInteger sumCount = 1;
    while ([rs next]) {
        sumCount = [rs intForColumn:@"sumCount"];
        break;
    }
    [rs close];
    if (count != sumCount||count ==0 ||sumCount ==0) {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSMutableArray *)combineLongMsgsWithInfoId:(NSString *)InfoId WithRelateID:(NSString *)relateID
{
    NSMutableArray *arr = [NSMutableArray array];

    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT sumCount from %@ where infoID ='%@' and relateId ='%@'",kLongMsgTable,InfoId,relateID];
    FMResultSet *rs = [db executeQuery:sqlStr];
    NSInteger sumCount = 0;
    while ([rs next]) {
        sumCount = [rs intForColumn:@"sumCount"];
        break;
    }
    [rs close];
    
    if (sumCount == 0) {
        return arr;
    }
    NSString *msgSqlStr = [NSString stringWithFormat:@"SELECT * from %@ where infoID ='%@' and relateId = %@ and sendOrder<=%d order by sendOrder Asc",kLongMsgTable,InfoId,relateID,sumCount];
    FMResultSet *tmpRs = [db executeQuery:msgSqlStr];
    while ([tmpRs next]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[tmpRs stringForColumn:@"msg"] forKey:@"msg"];
        
        [dic setValue:[NSNumber numberWithInt:[tmpRs intForColumn:@"sendOrder"]] forKey:@"sendOrder"];
        
        [dic setValue:[tmpRs stringForColumn:@"serialID"] forKey:@"serialID"];
        [arr addObject:dic];
    }
    [tmpRs close];
    return  arr;
}

- (NSString *)queryMinSerialIdWithInfoId:(NSString *)InfoId WithRelateID:(NSString *)relateID
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
    }
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT serialID from %@ where infoID ='%@' and relateId ='%@' and sendOrder=%d",kLongMsgTable,InfoId,relateID,1];
    FMResultSet *tmpRs = [db executeQuery:sqlStr];
    NSString *tmpStr = @"";
    while ([tmpRs next]) {
        tmpStr = [tmpRs stringForColumn:@"serialID"];
        return tmpStr;
        break;
    }
    [tmpRs close];
    return nil;
}

@end
