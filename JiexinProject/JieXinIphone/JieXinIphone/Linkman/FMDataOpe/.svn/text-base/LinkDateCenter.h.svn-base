//
//  LinkDatCenter.h
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"
#import "User.h"
#import "DepartMem.h"
@interface LinkDateCenter : NSObject

+ (id)sharedCenter;

-(NSArray *)getAllDepartments;
-(NSArray *)getRootDepartment;
-(NSArray *)getSubDepartmentsWithDepartmentId:(NSString *)id;
-(NSArray *)getSubUsersWithDepartmentId:(NSString *)id;//获取某个部门下的人员
-(NSInteger)getAllSubUsersCountWithDepartmentId:(NSString *)id;
-(NSMutableDictionary *)getUserNameByUserID:(NSString *)id; //通过用户id获取用户名字和职位
-(NSMutableArray *)getAllUserNameSelectedByID:(NSMutableArray *)idArr; //通过id获取一系列用户的名字
-(User *)getUserWithUserId:(NSString *)id;

-(NSArray *)getUsersWithFuzzyUserName:(NSString *)str;//模糊查询

-(NSArray *)getAllSubUsersArrayWithDepartmentId:(NSString *)id;//获取某个部门下全部人员包括其下面部门的人员
-(NSMutableString *)getAllSubUsersStrWithDepartmentId:(NSString *)id;//获取所有用户id的拼的字符串（包括子集的）
-(NSArray *)getAllSubDepartmentsArrayWithDepartmentId:(NSString *)id;//获取所有的部门，包括子部门下的子部门

//根据某人获得部门id
- (NSArray *)getDepIdFromUserId:(NSString *)userID;


@end
