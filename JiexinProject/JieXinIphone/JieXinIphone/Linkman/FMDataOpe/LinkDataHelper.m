//
//  LinkDataHelper.m
//  JieXinIphone
//
//  Created by tony on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkDataHelper.h"
#import "SynUserInfo.h"
#import "ChineseString.h"
#import "pinyin.h"

@interface LinkDataHelper(private)
-(NSArray *)getAllUserIdsWithDepartmentId:(NSString *)id;//通过部门id获取属于该部门下所有用户的id
-(NSInteger)getUsersCountWithDepartmentId:(NSString *)id;//通过部门id获取该部门下一级的人数

-(NSArray *)getUsersArrayWithDepartmentId:(NSString *)id;//通过部门id获取部门下一级的人

-(NSInteger)getSubUsersTotalCountWithDepartmentId:(NSString *)id;
-(Department *)getDepartmentWithUserId:(NSString *)id;//通过用户id获取department

-(Department *)getDepartmentWithDepartmentId:(NSString *)id;//通过部门id获取部门
-(DepartMem *)getDepartMenWithUserId:(NSString *)id;//通过用户id获取DepartMem关系
@end

@implementation LinkDataHelper
{
    NSInteger _totalCount;
    NSMutableArray *_usersArray;
    NSMutableArray *_departmentArray;
    
    NSMutableString *_allUsersIdStr;
}

static LinkDataHelper *_sharedFMData=nil;
#pragma mark - Singleton method
+(LinkDataHelper *)sharedService{
    @synchronized(self){
        if(_sharedFMData==nil){
            //如果为空，则创建一个对象
            _sharedFMData=[[self alloc] init];
        }
    }
    return _sharedFMData;
}

#pragma mark - dealloc
-(void)dealloc{
    if(_usersArray)
        [_usersArray release];
    if(_departmentArray)
        [_departmentArray release];
    [localDataBase close];
    [distanceDataBase close];
    [super dealloc];
}

#pragma mark - init
-(id)init{
    self = [super init];
    if(!self){
        return nil;
        
    }
    return self;
}

#pragma mark - 打开数据库
-(void)readDistanceDataBase{
    NSString *distanceDbPath = [[SynUserInfo sharedManager] getCurrentUserDBPath];
    //[[NSBundle mainBundle] pathForResource:@"0_90" ofType:@"db"];
    //创建数据库实例 db  这里说明下:如果路径中不存在"0_90.db"的文件,sqlite会自动创建"0_90.db"
    distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
        NSLog(@"0_90.db Could not open db.");
    }

    
    /*
     现在建一张表
     UserColl:userName,key,collTime,year,infoDic
     */
//    if(![self isTableExist:@"UserColl"])
//        [dataBase executeUpdate:@"CREATE TABLE UserColl(userName TEXT,key TEXT,collTime NUMERIC,updateTime NUMERIC,year integer,infoDic NONE)"];
    
    /*
     再建一张表UserAttachment：存放用户所下载附件的存放路径
     */
//    if(![self isTableExist:@"UserAttachment"])
//        [dataBase executeUpdate:@"CREATE TABLE UserAttachment(userName TEXT,key TEXT,attPath TEXT)"];
}

-(void)readLocalDataBase{
    NSString *localDbPath = [[NSBundle mainBundle] pathForResource:@"qtim" ofType:@"db"];
    localDataBase = [FMDatabase databaseWithPath:localDbPath];
    if(![localDataBase open]){//打开数据库
        NSLog(@"qtim.db Could not open db.");
    }
}

-(NSArray *)getAllDepartments
{
    NSMutableArray *resultArray = [NSMutableArray array];
    //按sort排序，降序排序desc,asc升序
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department order by sort desc,departmentname asc"];
    Department *tempDepart = [[[Department alloc] init] autorelease];
    while ([rs next]) {
        Department *deparment = [[Department alloc] init];
        deparment.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        if([tempDepart.departmentid isEqualToString:deparment.departmentid])
        {
            continue;
        }
        deparment.departmentname = [rs stringForColumn:@"departmentname"];
        deparment.parentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"parentid"]];
        //deparment.allSubUsers = [self getAllSubUsersArrayWithDepartmentId:deparment.departmentid];
        deparment.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        [resultArray addObject:deparment];
        tempDepart = deparment;
        [deparment release];
    }
    return resultArray;
}

-(NSArray *)getRootDepartment
{
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department where parentid=? order by sort desc,departmentname asc",[NSNumber numberWithInteger:0]];
    while ([rs next]) {
        Department *department = [[Department alloc] init];
        department.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        department.departmentname = [rs stringForColumn:@"departmentname"];
        department.parentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"parentid"]];
        department.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        department.subUserCount = [self getUsersCountWithDepartmentId:department.departmentid];
        //department.allSubUsers = [self getAllSubUsersArrayWithDepartmentId:department.departmentid];
        department.allSubUserCount = [self getAllSubUsersCountWithDepartmentId:department.departmentid];
        [resultArray addObject:department];
        [department release];
    }
    return resultArray;
}

-(NSArray *)getSubDepartmentsWithDepartmentId:(NSString *)id
{
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department where parentid=? order by sort desc,departmentname asc",[NSNumber numberWithInteger:[id integerValue]]];
    Department *tempDepart = [[[Department alloc] init] autorelease];
    while ([rs next]) {
        Department *deparment = [[Department alloc] init];
        deparment.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        if([tempDepart.departmentid isEqualToString:deparment.departmentid])
        {
            continue;
        }
        deparment.departmentname = [rs stringForColumn:@"departmentname"];
        deparment.parentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"parentid"]];
        deparment.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
         deparment.subUserCount = [self getUsersCountWithDepartmentId:deparment.departmentid];
        deparment.allSubUserCount = [self getAllSubUsersCountWithDepartmentId:deparment.departmentid];
        //deparment.allSubUsers = [self getAllSubUsersArrayWithDepartmentId:deparment.departmentid];
        [resultArray addObject:deparment];
        tempDepart = deparment;
        [deparment release];
    }
    return resultArray;
}

//- (BOOL)updateSelfStatus
//{
//    NSMutableArray *resultArray = [NSMutableArray array];
//    FMResultSet *rs = [distanceDataBase executeUpdate:@"UPDATE im_department set unread_count=0 WHERE relativeId=? * from  where parentid=? order by sort desc",[NSNumber numberWithInteger:[id integerValue]]];
//}

-(NSArray *)getSubUsersWithDepartmentId:(NSString *)id
{
    NSMutableArray *resultArray = [NSMutableArray array];
    /*
        通过内连接来查询用户
     */
//    NSArray *departMemArray = [self getAllUserIdsWithDepartmentId:id];
//    for(DepartMem *departMem in departMemArray)
//    {
//        User *user = [self getUserWithUserId:departMem.userid];
//        [resultArray addObject:user];
//    }
    
    /*
        SELECT * FROM im_users u inner join im_department_member m on u.userid=m.userid  where m.departmentid = ? order by userid desc;
     */
    FMResultSet *rs = [distanceDataBase executeQuery:@"SELECT distinct * FROM im_users u inner join im_department_member m on u.userid=m.userid  where m.departmentid = ? order by sort asc,LOWER(email) asc",[NSNumber numberWithInteger:[id integerValue]]];//sort desc,username asc
    
    User *tempUser = [[[User alloc] init] autorelease];
    while([rs next])
    {
        User *user = [[[User alloc] init] autorelease];
        user.userid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]];
        if([tempUser.userid isEqualToString:user.userid])
        {
            continue;
        }
        user.nickname = [rs stringForColumn:@"nickname"];
        user.sex = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"sex"]];
        user.telephone = [rs stringForColumn:@"telephone"];
        user.email = [rs stringForColumn:@"email"];
        user.mobile = [rs stringForColumn:@"mobile"];
        user.xuhao = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"xuhao"]];
        user.usersig = [rs stringForColumn:@"usersig"];
        user.username = [rs stringForColumn:@"username"];
        user.domainid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"domainid"]];
        user.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        user.field_char1 = [rs stringForColumn:@"field_char1"];
        user.field_char2 = [rs stringForColumn:@"field_char2"];
        user.field_int1 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int1"]];
        user.field_int2 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int2"]];
        user.deparment = [self getDepartmentWithUserId:user.userid];
        [resultArray addObject:user];
        tempUser = user;
    }
    //[resultArray sortUsingSelector:@selector(compareSort:)];//排序
//    NSSortDescriptor *sectionTitleSort = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
//    [resultArray sortUsingDescriptors:[NSArray arrayWithObject:sectionTitleSort]];
    
    return resultArray;
}

-(NSMutableArray *)zhongWenPaiXu:(NSMutableArray *)newArray{
    //中文排序。
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[newArray count];i++){
        User *user = [newArray objectAtIndex:i];
        NSString *tmpStr=[NSString string];
        tmpStr=[NSString stringWithString:[[newArray objectAtIndex:i]nickname] ];
        if(tmpStr==nil){
            tmpStr=@"";
        }
        if(![tmpStr isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<tmpStr.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([tmpStr characterAtIndex:j])]uppercaseString];
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter]; }
            tmpStr=pinYinResult;
        }else{
            tmpStr=@"";
        }
        user.chineseStr = tmpStr;
        [chineseStringsArray addObject:user];
    }
        //Step3:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"chineseStr"ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}

-(NSMutableString *)getSubUsersStrWithDepartmentId:(NSString *)id
{
    NSMutableString *resultStr = [[[NSMutableString alloc] init] autorelease];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department_member where departmentid = ? order by userid desc",[NSNumber numberWithInteger:[id integerValue]]];
    while([rs next])
    {
        [resultStr appendString:[NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]]];
         
        [resultStr appendString:@","];
    }
    return resultStr;
}

-(User *)getUserWithUserId:(NSString *)id
{
    User *user = [[[User alloc] init] autorelease];
    //按sort排序，降序排序desc,asc升序
//    NSString *sqlStr = [NSString stringWithFormat:@"select * from im_users where userid = %@",[NSNumber numberWithInteger:[id integerValue]]];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_users where userid = ?",[NSNumber numberWithInteger:[id integerValue]]];
    while([rs next])
    {
        user.userid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]];
        user.nickname = [rs stringForColumn:@"nickname"];
        user.sex = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"sex"]];
        user.telephone = [rs stringForColumn:@"telephone"];
        user.email = [rs stringForColumn:@"email"];
        user.mobile = [rs stringForColumn:@"mobile"];
        user.xuhao = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"xuhao"]];
        user.usersig = [rs stringForColumn:@"usersig"];
        user.username = [rs stringForColumn:@"username"];
        user.domainid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"domainid"]];
        user.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        user.field_char1 = [rs stringForColumn:@"field_char1"];
        user.field_char2 = [rs stringForColumn:@"field_char2"];
        user.field_int1 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int1"]];
        user.field_int2 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int2"]];
        user.deparment = [self getDepartmentWithUserId:user.userid];
        [rs close];
        return user;
    }
    [rs close];
    return nil;
}




#pragma mark - 关闭数据库
-(void)closeDistanceDatabase{
    [distanceDataBase close];
}

-(void)closeLocalDataBase
{
    [localDataBase close];
}

-(NSArray *)getAllUserIdsWithDepartmentId:(NSString *)id
{
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department_member where departmentid = ? order by userid desc",[NSNumber numberWithInteger:[id integerValue]]];
    while([rs next])
    {
        DepartMem *departMem = [[DepartMem alloc] init];
        departMem.userid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]];
        departMem.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        [resultArray addObject:departMem];
        [departMem release];
    }
    return resultArray;
}


-(NSInteger)getAllSubUsersCountWithDepartmentId:(NSString *)id
{
    _totalCount = 0;
    _totalCount = [self getSubUsersTotalCountWithDepartmentId:id];
    return _totalCount;
}

-(NSInteger)getSubUsersTotalCountWithDepartmentId:(NSString *)id
{
    NSInteger count = [self getUsersCountWithDepartmentId:id];//人数
    NSArray *subDepartments = [self getSubDepartmentsWithDepartmentId:id];//部门数组
    if([subDepartments count] > 0){
        for(Department *depart in subDepartments)
        {
            _totalCount = count + [self getSubUsersTotalCountWithDepartmentId:depart.departmentid];
            count = _totalCount;
        }
    }else
    {
        return count;
    }
    return _totalCount;
}

-(NSInteger)getUsersCountWithDepartmentId:(NSString *)id
{
    NSInteger count = 0;
    FMResultSet *rs  = [distanceDataBase executeQuery:@"SELECT count(*) as 'count' FROM  im_department_member where departmentid = ?",[NSNumber numberWithInteger:[id integerValue]]];
    while([rs next])
    {
        count = [rs intForColumn:@"count"];
        return  count;
    }
    return count;
}

-(Department *)getDepartmentWithUserId:(NSString *)id
{
    DepartMem *deparMem = [self getDepartMenWithUserId:id];
    Department *department = [self getDepartmentWithDepartmentId:deparMem.departmentid];
    return department;
}

-(DepartMem *)getDepartMenWithUserId:(NSString *)id
{
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department_member where userid = ? ",[NSNumber numberWithInteger:[id integerValue]]];
    while([rs next])
    {
        DepartMem *departMem = [[DepartMem alloc] init];
        departMem.userid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]];
        departMem.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        //这里不应该释放
//        [departMem release];
        return [departMem autorelease];
    }
    return nil;
}

-(Department *)getDepartmentWithDepartmentId:(NSString *)id
{
    Department *department = [[[Department alloc] init] autorelease];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department where departmentid=?",[NSNumber numberWithInteger:[id integerValue]]];
    while ([rs next]) {
        department.departmentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
        department.departmentname = [rs stringForColumn:@"departmentname"];
        department.parentid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"parentid"]];
        department.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        return department;
    }
    return nil;
}

-(NSMutableDictionary *)getUserInfoByUserID:(NSString *)str
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_users where userid = ?",[NSNumber numberWithInteger:[str integerValue]]];
    while ([rs next]) {
        [result setValue:[rs stringForColumn:@"nickname"] forKey:@"nickname"];
        [result setValue:[rs stringForColumn:@"usersig"] forKey:@"usersig"];
        [result setObject:[rs stringForColumn:@"sex"] forKey:@"sex"];

        break;
    }
    return result;
}

#pragma mark - 获取所有用户的数据User（包括子集的）
-(NSArray *)getAllSubUsersArrayWithDepartmentId:(NSString *)id
{
    _usersArray = [NSMutableArray array];
    _usersArray = [NSMutableArray arrayWithArray:[self getAllSubUsersWithDepartmentId:id]];
    return _usersArray;
}

-(NSArray *)getAllSubUsersWithDepartmentId:(NSString *)id
{
    NSArray *tempUserArray = [NSArray array];
    tempUserArray = [self getSubUsersWithDepartmentId:id];//人员userArray
    NSArray *subDepartments = [self getSubDepartmentsWithDepartmentId:id];//部门数组
    [_usersArray insertObjects:tempUserArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_usersArray count], [tempUserArray count])]];
    if([subDepartments count] > 0){
        for(Department *depart in subDepartments)
        {
            [self getAllSubUsersWithDepartmentId:depart.departmentid];
        }
    }else
    {
        return _usersArray;
    }
    return _usersArray;
}

#pragma mark - 获取所有用户id的拼的字符串（包括子集的）
-(NSMutableString *)getAllSubUsersStrWithDepartmentId:(NSString *)id
{
    _allUsersIdStr = [[[NSMutableString alloc] init] autorelease];
    _allUsersIdStr = [self getAllSubUsersIdStrWithDepartmentId:id];
    return _allUsersIdStr;
}

-(NSMutableString *)getAllSubUsersIdStrWithDepartmentId:(NSString *)id
{
    NSMutableString *tempStr = [self getSubUsersStrWithDepartmentId:id];
    [_allUsersIdStr appendString:tempStr];
    NSArray *subDepartments = [self getSubDepartmentIDsWithDepartmentId:id];//部门id数组
    if([subDepartments count] > 0){
        for(NSString *departId in subDepartments)
        {
            [self getAllSubUsersIdStrWithDepartmentId:departId];
        }
    }else
    {
        return _allUsersIdStr;
    }
    return _allUsersIdStr;
}

-(NSArray *)getSubDepartmentIDsWithDepartmentId:(NSString *)id
{
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [distanceDataBase executeQuery:@"select * from im_department where parentid=? order by sort desc,departmentname asc",[NSNumber numberWithInteger:[id integerValue]]];
    NSString *memoryId = @"";
    while ([rs next]) {
        if([memoryId isEqualToString:[NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]]])
        {
            continue;
        }
        [resultArray addObject:[NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]]];
        memoryId = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"departmentid"]];
    }
    return resultArray;
}

-(NSArray *)getAllSubDepartmentsArrayWithDepartmentId:(NSString *)id
{
    _departmentArray = [NSMutableArray array];
    _departmentArray = [NSMutableArray arrayWithArray:[self getSubDepartmentsArrayWithDepartmentId:id]];
    return _departmentArray;
}

-(NSArray *)getSubDepartmentsArrayWithDepartmentId:(NSString *)id
{
    NSArray *tempDepartmentArray = [NSArray array];
    tempDepartmentArray = [self getSubDepartmentsWithDepartmentId:id];//部门数组
    [_departmentArray insertObjects:tempDepartmentArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_departmentArray count], [tempDepartmentArray count])]];
    if([tempDepartmentArray count] > 0){
        for(Department *department in tempDepartmentArray)
        {
            [self getSubDepartmentsArrayWithDepartmentId:department.departmentid];
        }
    }else
    {
        return _departmentArray;
    }
    return _departmentArray;
}

-(NSArray *)getUsersWithFuzzyUserName:(NSString *)str
{
    NSMutableArray *resultArray = [NSMutableArray array];
    //按sort排序，降序排序desc,asc升序
    NSString *searchSql  = [NSString stringWithFormat:@"select * from im_users where nickname like '%%%@%%' order by sort asc,username asc", str];
    FMResultSet *rs = [distanceDataBase executeQuery:searchSql];
    User *tempUser = [[[User alloc] init] autorelease];
    while([rs next])
    {
        User *user = [[[User alloc] init] autorelease];
        user.userid = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"userid"]];
        if([tempUser.userid isEqualToString:user.userid])
        {
            continue;
        }
        user.nickname = [rs stringForColumn:@"nickname"];
        user.sex = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"sex"]];
        user.telephone = [rs stringForColumn:@"telephone"];
        user.email = [rs stringForColumn:@"email"];
        user.mobile = [rs stringForColumn:@"mobile"];
        user.xuhao = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"xuhao"]];
        user.usersig = [rs stringForColumn:@"usersig"];
        user.username = [rs stringForColumn:@"username"];
        user.domainid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"domainid"]];
        user.sort = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sort"]];
        user.field_char1 = [rs stringForColumn:@"field_char1"];
        user.field_char2 = [rs stringForColumn:@"field_char2"];
        user.field_int1 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int1"]];
        user.field_int2 = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"feild_int2"]];
        user.deparment = [self getDepartmentWithUserId:user.userid];
        [resultArray addObject:user];
        tempUser = user;
    }
    return resultArray;
}

- (NSMutableArray *)getAllUserNameSelectedByID:(NSMutableArray *)idArr
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSString *userid in idArr)
    {
        NSString *sqlstr = [NSString stringWithFormat:@"select * from im_users where userid = %d",(int)[userid integerValue]];
        FMResultSet *rs = [distanceDataBase executeQuery:sqlstr];
        while ([rs next]) {
            [result addObject:[rs stringForColumn:@"nickname"]];
            break;
        }
    }
    return result;
}

- (NSArray *)getDepIdFromUserId:(NSString *)userID
{
    NSString *sqlstr = [NSString stringWithFormat:@"SELECT * FROM im_department_member WHERE userid = '%@'",userID];
    NSMutableArray *depIDArr = [NSMutableArray array];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlstr];
    while ([rs next]) {
        [depIDArr addObject:[rs stringForColumn:@"departmentid"]];
        break;
    }
    return depIDArr;
}


@end
