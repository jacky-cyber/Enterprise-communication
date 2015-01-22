//
//  GroupDataHelper.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface GroupDataHelper : NSObject

+(GroupDataHelper *)sharedService;

- (void)operateGroupDB:(NSString *)sqlstr;
//获得所有groupid
- (NSMutableArray *)getAllGroupid;
//获得所有groupid和groupname
- (BOOL)isNameChanged:(NSDictionary *)groupDic;

- (NSString *)getGroupNameByid:(NSString *)groupid;
- (NSString *)getGroupCreatorByid:(NSString *)groupid;
- (NSString *)getGroupTimeByid:(NSString *)groupid;
- (NSInteger)getGroupNumByid:(NSString *)groupid;
- (NSInteger)getGroupTypeByid:(NSString *)groupid;
- (NSMutableArray *)getAllGroupInfoWithType:(NSInteger)type;

- (NSMutableArray *)getGroupReceiveStateByIds:(NSArray *) groupids;
- (void)updateGroupReceiveStatus:(NSString *)Status ById:(NSString *)groupid;
//插入一个群组到数据库
- (BOOL)insertAGroupToDb:(NSDictionary *)infoDic;

//重命名群组的名字后  修改数据库
- (void)renameGroupNameWithName:(NSString *)name andGroupId:(NSString *)groupID;



@end
