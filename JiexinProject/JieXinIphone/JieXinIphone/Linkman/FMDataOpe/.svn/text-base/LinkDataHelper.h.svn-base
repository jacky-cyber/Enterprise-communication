//
//  LinkDataHelper.h
//  JieXinIphone
//
//  Created by tony on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Department.h"
#import "User.h"
#import "DepartMem.h"

@interface LinkDataHelper : NSObject{
    FMDatabase *distanceDataBase;
    FMDatabase *localDataBase;
}
+(LinkDataHelper *)sharedService;
-(id)init;

-(void)readDistanceDataBase;
-(void)readLocalDataBase;

-(NSArray *)getAllDepartments;
-(NSArray *)getRootDepartment;
-(NSArray *)getSubDepartmentsWithDepartmentId:(NSString *)id;//获取某个部门下的子部门

-(NSArray *)getSubUsersWithDepartmentId:(NSString *)id;//获取某个部门下的人员
-(User *)getUserWithUserId:(NSString *)id;

- (BOOL)updateSelfStatus;
-(NSArray *)getUsersWithFuzzyUserName:(NSString *)str;//模糊查询

-(NSArray *)getAllSubUsersArrayWithDepartmentId:(NSString *)id;//获取某个部门下全部人员包括其下面部门的人员

-(NSArray *)getAllSubDepartmentsArrayWithDepartmentId:(NSString *)id;//获取所有的部门，包括子部门下的子部门

-(NSMutableString *)getAllSubUsersStrWithDepartmentId:(NSString *)id;//获取所有用户id的拼的字符串（包括子集的）

-(NSInteger)getAllSubUsersCountWithDepartmentId:(NSString *)id;
-(NSMutableDictionary *)getUserInfoByUserID:(NSString *)id;

- (NSMutableArray *)getAllUserNameSelectedByID:(NSMutableArray *)idArr;

//获得某人的部门id
- (NSArray *)getDepIdFromUserId:(NSString *)userID;

-(void)closeDistanceDatabase;
-(void)closeLocalDataBase;

@end
