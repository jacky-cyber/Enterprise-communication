//
//  LinkDatCenter.m
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkDateCenter.h"
#import "LinkDataHelper.h"
#import "Department.h"


@implementation LinkDateCenter
static LinkDateCenter *sharedCenter = nil;
+ (id)sharedCenter
{
    if (sharedCenter == nil) {
        sharedCenter = [[LinkDateCenter alloc] init];
    }
    return sharedCenter;
}

-(NSArray *)getAllDepartments
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result =  [[LinkDataHelper sharedService] getAllDepartments];
    
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSArray *)getRootDepartment
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getRootDepartment];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSArray *)getSubDepartmentsWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getSubDepartmentsWithDepartmentId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSArray *)getSubUsersWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getSubUsersWithDepartmentId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSInteger)getAllSubUsersCountWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSInteger count = [[LinkDataHelper sharedService] getAllSubUsersCountWithDepartmentId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return count;
}

-(NSArray *)getAllSubDepartmentsArrayWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getAllSubDepartmentsArrayWithDepartmentId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSArray *)getAllSubUsersArrayWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getAllSubUsersArrayWithDepartmentId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSMutableDictionary *)getUserNameByUserID:(NSString *)str
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSMutableDictionary *userInfo = [[[NSMutableDictionary alloc] init] autorelease];
    userInfo = [[LinkDataHelper sharedService] getUserInfoByUserID:str];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return userInfo;
}

-(NSArray *)getUsersWithFuzzyUserName:(NSString *)str
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *result = [[LinkDataHelper sharedService] getUsersWithFuzzyUserName:str];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return result;
}

-(NSMutableString *)getAllSubUsersStrWithDepartmentId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSMutableString *str = [NSMutableString stringWithString:[[LinkDataHelper sharedService] getAllSubUsersStrWithDepartmentId:id]];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return str;
}

- (NSMutableArray *)getAllUserNameSelectedByID:(NSMutableArray *)idArr
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[LinkDataHelper sharedService] getAllUserNameSelectedByID:idArr]];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return arr;
}

-(User *)getUserWithUserId:(NSString *)id
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    User *user = [[LinkDataHelper sharedService] getUserWithUserId:id];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return user;
}

- (NSArray *)getDepIdFromUserId:(NSString *)userID
{
    [[LinkDataHelper sharedService] readDistanceDataBase];
    NSArray *depIDArr = [[LinkDataHelper sharedService] getDepIdFromUserId:userID];
    [[LinkDataHelper sharedService] closeDistanceDatabase];
    return depIDArr;
}


@end
