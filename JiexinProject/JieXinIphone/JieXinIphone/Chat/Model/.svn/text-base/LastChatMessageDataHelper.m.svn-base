//
//  LastChatMessageDataHelper.m
//  JieXinIphone
//
//  Created by liqiang on 14-4-16.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LastChatMessageDataHelper.h"

#define kLastChatMsgTable @"kLastChatMsgTable"

@implementation LastChatMessageDataHelper

+ (id) sharedService
{
	static LastChatMessageDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[LastChatMessageDataHelper alloc] init];
    });
    return _sharedInst;
}
- (id) init
{
	if (self = [super init])
	{
        
	}
	return self;
}
- (void)dealloc
{
    [self closeDb];
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
     msg 发送的时间戳
     relativeId 谈话对象的id
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS kLastChatMsgTable (Id integer PRIMARY KEY AUTOINCREMENT,msg text,relativeId integer)"];
    return db;
}
- (void)closeDb
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
    [db close];
}

- (BOOL)insertAChatLastMsgToDB:(LastChatMessageFeed *)feed
{
    FMDatabase *db = [self readDataBase];
    if(!db)
    {
        NSLog(@"Could not open db.");
    }
    //先将原来的删除在加入新的
    NSString *deleteSqlStr = [NSString stringWithFormat:@"DELETE From %@ WHERE relativeId=?",kLastChatMsgTable];
    [db executeUpdate:deleteSqlStr,[NSNumber numberWithInteger:feed.relativeId]];

    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(msg,relativeId) VALUES(?,?)",kLastChatMsgTable];
    BOOL result = [db executeUpdate:sqlStr,feed.msg,[NSNumber numberWithInteger:feed.relativeId]];
    return result;
}
- (NSString *)queryChatLastMsgFromDB:(NSInteger)relativeId
{
    FMDatabase *db = [self readDataBase];
    if(!db)
    {
        NSLog(@"Could not open db.");
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select msg from %@ where relativeId='%@'",kLastChatMsgTable,[NSNumber numberWithInteger:relativeId]];
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next])
    {
        NSString *msg = [rs stringForColumn:@"msg"];
        return msg;
    }
    return @"";
}

@end
