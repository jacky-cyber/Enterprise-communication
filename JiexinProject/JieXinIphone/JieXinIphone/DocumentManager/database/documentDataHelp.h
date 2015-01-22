//
//  documentDataHelp.h
//  JieXinIphone
//
//  Created by lxrent02 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FMDatabase.h"



@interface documentDataHelp : NSObject
{
     FMDatabase *mDatabase;
}

+(documentDataHelp *)sharedService;
//关闭数据库 因为频繁的打开和关闭数据库会导致内存暴增
- (void)closeDocModelDb;
//插入一个数据模型
-(void)insertDocModelItem:(id)item;
//读出一个数据模型
-(NSMutableArray*)readDocModelItem:(NSString *)tableName;
//删除一个模型的表信息
-(void)deleteDocModelItem:(NSString *)tableName;
- (BOOL) deleteTestList:(NSString *)deletList withCategoryid:(NSString*)categoryid;
- (BOOL) deleteTestList:(NSString *)deletList ;
- (BOOL)deleteAllNews;
@end
