//
//  GroupDataHelper.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "GroupDataHelper.h"

#define kGroupInfoTable             @"groupInfoTable"

@implementation GroupDataHelper

+ (id) sharedService
{
	static GroupDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[GroupDataHelper alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        
        //获取群组的具体内容
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupDetailInfo:)
                                                     name:kFetchGroupInfo
                                                   object:nil];

	}
	return self;
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
     id
     grouptype 正式群为1，临时群为2
     groupId   群组ID
     groupName 群组名称
     creatorID 群主ID
     time      创建时间
     num       群总人数
     */
    
    NSString *groupInfoSqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(Id integer PRIMARY KEY AUTOINCREMENT, groupType integer,groupId text,groupName text,creatorID text,time text,num integer, receive_state text)",kGroupInfoTable];
    [db executeUpdate:groupInfoSqlStr];
    

    return db;
}

- (void)operateGroupDB:(NSString *)sqlstr
{
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return;
    }
    
    [db executeUpdate:sqlstr];
    [db close];
}

- (BOOL)insertAGroupToDb:(NSDictionary *)infoDic
{
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return NO;
    }
//    NSString *groupInfoSqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(groupType integer,groupId text,groupName text,creatorID text,time text,num integer)",kGroupInfoTable];
//    [db executeUpdate:sqlstr];
//    [db close];
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (groupType, groupId, groupName, creatorID) VALUES(?,?,?,?)",kGroupInfoTable];
    
    [db executeUpdate:sqlStr,[infoDic objectForKey:@"gtype"],[infoDic objectForKey:@"groupid"],[infoDic objectForKey:@"name"],[infoDic objectForKey:@"sessionId"]];
    [db close];

    return YES;
}


- (NSMutableArray *)getAllGroupid
{
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSMutableArray *groupidArr = [[NSMutableArray alloc] init];
    FMResultSet *rs=[db executeQuery:@"select * from groupInfoTable"];
    while ([rs next])
    {
        if ([rs stringForColumn:@"groupId"]) {
            [groupidArr addObject:[rs stringForColumn:@"groupId"]];
        }
    }

    [db close];
    return [groupidArr autorelease];
}


//获得所有groupid和groupname
- (BOOL)isNameChanged:(NSDictionary *)groupDic
{
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }

    NSString *groupName = @"";
    FMResultSet *rs=[db executeQuery:@"select * from groupInfoTable where groupId=?",[groupDic objectForKey:@"id"]];
    while ([rs next])
    {
       groupName = [rs stringForColumn:@"groupName"];
    }
    [db close];
    
    return ![[groupDic objectForKey:@"name"] isEqualToString:groupName];
}


- (NSString *)getGroupNameByid:(NSString *)groupid
{
    NSString *groupName = @"";
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupId = '%@'",groupid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while ([rs next])
    {
       groupName  = [rs stringForColumn:@"groupName"];
    }
    if (![groupName length]) {
        [self getGroupDetailInfo:groupid];
        groupName = @"未知群组";
    }
    return  groupName;
}

- (NSString *)getGroupCreatorByid:(NSString *)groupid
{
    NSString *creatorID = @"";
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupId = '%@'",groupid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while ([rs next])
    {
        creatorID  = [rs stringForColumn:@"creatorID"];
    }
    
    return  creatorID;
}

- (NSString *)getGroupTimeByid:(NSString *)groupid
{
    NSString *time = @"";
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupId = '%@'",groupid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while ([rs next])
    {
        time  = [rs stringForColumn:@"time"];
    }
    
    return  time;
}

- (NSInteger)getGroupNumByid:(NSString *)groupid
{
    NSInteger groupNum = 0;
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return 0;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupId = '%@'",groupid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while ([rs next])
    {
        groupNum  = [[rs stringForColumn:@"groupName"] integerValue];
    }
    
    return  groupNum;
}

- (NSInteger)getGroupTypeByid:(NSString *)groupid
{
    NSInteger groupType = -1;
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return -2;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupId = '%@'",groupid];
    FMResultSet *rs=[db executeQuery:sqlStr];
    while ([rs next])
    {
        groupType  = [[rs stringForColumn:@"groupType"] integerValue];
    }
    
    return  groupType;
}

- (NSMutableArray *)getAllGroupInfoWithType:(NSInteger)type
{
    NSMutableArray *groupArray = nil;
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from groupInfoTable where groupType = %d",type];
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next])
    {
        NSString *groupid = [rs stringForColumn:@"groupId"];
        NSString *groupName = [rs stringForColumn:@"groupName"];
        NSString *creatorID = [rs stringForColumn:@"creatorID"];
        NSInteger type = [[rs stringForColumn:@"grouptype"] integerValue];
        NSString *grouptype = [NSString stringWithFormat:@"%d",type];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:groupid,@"id",creatorID,@"creatorID",groupName,@"name",grouptype,@"type",nil];
        [groupArray addObject:dic];
    }
    
    return groupArray;
}

- (NSMutableArray *)getGroupReceiveStateByIds:(NSArray *) groupids
{
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return nil;
    }
    NSString *tmp = @"select Id,groupId,groupName,receive_state from groupInfoTable where groupId in ('";
    tmp = [tmp stringByAppendingString:[groupids objectAtIndex:0]];
    tmp = [tmp stringByAppendingString:@"'"];
    for (int i = 1; i < [groupids count]; i++) {
        tmp = [tmp stringByAppendingString:@",'"];
        tmp = [tmp stringByAppendingString:[groupids objectAtIndex:i]];
        tmp = [tmp stringByAppendingString:@"'"];
    }
    tmp = [tmp stringByAppendingString:@");"];
    NSLog(@"%@", tmp);

    NSMutableArray *groupidArr = [NSMutableArray array];
    FMResultSet *rs=[db executeQuery:tmp];
    while ([rs next])
    {
        NSLog(@"%@", [rs stringForColumn:@"groupName"]);
        NSMutableDictionary * dict_row = [[[NSMutableDictionary alloc] init] autorelease];
        [dict_row setValue:[rs stringForColumn:@"Id"] forKey:@"id"];
        [dict_row setValue:[rs stringForColumn:@"groupId"] forKey:@"groupId"];
        [dict_row setValue:[rs stringForColumn:@"groupName"] forKey:@"groupName"];
        [dict_row setValue:[rs stringForColumn:@"receive_state"] forKey:@"receive_state"];
        [groupidArr addObject:dict_row];
    }
    
    [db close];
    return groupidArr;
}

- (void)updateGroupReceiveStatus:(NSString *)Status ById:(NSString *)groupid{
    
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return;
    }
    
   NSString *sqlStr = [NSString stringWithFormat:@"update groupInfoTable set receive_state='%@' where groupId = '%@'",Status, groupid];
   [db executeUpdate:sqlStr];
}

#pragma mark -获取组的具体内容
- (void)getGroupDetailInfo:(NSString *)groupIdStr
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    
    NSArray *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"fetchgroupinfo"},@{@"groupid":groupIdStr}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    
}

- (void)receiveGroupDetailInfo:(NSNotification *)notification
{
    NSLog(@"%@",notification.userInfo);
    NSDictionary *infoDic = notification.userInfo;
    
    FMDatabase *db = [self readDataBase];
    if (!db)
    {
        NSLog(@"Could not open db.");
        return;
    }
//
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (groupType, groupId, groupName, creatorID, time, num) VALUES(?,?,?,?,?,?)",kGroupInfoTable];

    [db executeUpdate:sqlStr,[infoDic objectForKey:@"grouptype"],[infoDic objectForKey:@"id"],[infoDic objectForKey:@"name"],[infoDic objectForKey:@"creatorID"],[infoDic objectForKey:@"time"],[infoDic objectForKey:@"num"]];
    [db close];
}


- (void)renameGroupNameWithName:(NSString *)name andGroupId:(NSString *)groupID
{
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE groupInfoTable SET groupName='%@' WHERE  groupId='%@'",name,groupID];
    [self operateGroupDB:sqlStr];
}

@end
