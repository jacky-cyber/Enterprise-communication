//
//  NotificationDataHelper.m
//  JieXinIphone
//
//  Created by gabriella on 14-3-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "NotificationDataHelper.h"

@implementation NotificationDataHelper

+ (id) sharedService
{
	static NotificationDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ _sharedInst=[[NotificationDataHelper alloc] init]; });
    return _sharedInst;
}

#pragma mark - DBOperations

-(FMDatabase *)readDataBase
{
    FMDatabase *db = [FMDatabase databaseWithPath:kLocalDBPath];
    if (![db open]) {
        return nil;
    }
    
    NSString *sql_str = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(msgid text, msgtime text, msgtitle text, msgintro text, msg text, msgurl text);",kNotificationInfoTable];
    [db executeUpdate:sql_str];
    return db;
}

- (BOOL) appendNotification: (NSMutableDictionary *)wParam
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (msgid, msgtime, msgtitle, msgintro, msg, msgurl) VALUES(?,?,?,?,?,?);",kNotificationInfoTable];
    
    
    BOOL result = [db executeUpdate:sqlStr,[wParam valueForKey:kMsgid], [wParam valueForKey:kMsgtime], [wParam valueForKey:kMsgtitle], [wParam valueForKey:kMsgintro], [wParam valueForKey:kMsg], [wParam valueForKey:kMsgurl]];
    
    [db close];
    return result;
}

- (BOOL) notificationExist:(NSString *) msgid
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return NO;
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select msgid from %@ where msgid = '%@';", kNotificationInfoTable, msgid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    if ([rs next]) {
        [db close];
        return YES;
    }
    [db close];
    return NO;
}

- (NSMutableArray *)getAllNotification
{
    FMDatabase *db = [self readDataBase];
    if (!db) {
        NSLog(@"Could not open db.");
        return nil;
    }
    NSMutableArray *arrRes = [NSMutableArray array];
    NSString *sqlStr = [NSString stringWithFormat:@"select msgid, msgtime, msgtitle, msgintro, msg, msgurl from %@ order by msgtitle desc;", kNotificationInfoTable];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while  ([rs next]) {
        NSMutableDictionary *tmp_item = [NSMutableDictionary dictionary];
        
        [tmp_item setValue:[rs stringForColumn:kMsgid] forKey:kMsgid];
        [tmp_item setValue:[rs stringForColumn:kMsgtime] forKey:kMsgtime];
        [tmp_item setValue:[rs stringForColumn:kMsgtitle] forKey:kMsgtitle];
        [tmp_item setValue:[rs stringForColumn:kMsgintro] forKey:kMsgintro];
        [tmp_item setValue:[rs stringForColumn:kMsg] forKey:kMsg];
        [tmp_item setValue:[rs stringForColumn:kMsgurl] forKey:kMsgurl];
        [arrRes addObject:tmp_item];
    }
    [db close];
    
    return arrRes;
}



@end
