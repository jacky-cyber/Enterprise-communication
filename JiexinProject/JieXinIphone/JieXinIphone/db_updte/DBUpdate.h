//
//  DBUpdate.h
//  JieXinIphone
//
//  Created by gabriella on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

/****************************************************************************************************
 * 代码调用示例
 * NSString *DBPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
 * NSString *DBName = [DBPath stringByAppendingPathComponent:@"0_93.db"];
 * DBUpdate * db_update = [[DBUpdate alloc] init];
 * NSMutableArray *arrSqls = [[NSMutableArray alloc] init];
 * [arrSqls addObject:@"create table t_my_test(col_01 varchar(64), col_02 varchar(64), col_03 integer);"];
 * [arrSqls addObject:@"insert into t_my_test(col_01, col_02, col_03) values ('row_01', 'row_01', 1);"];
 * [arrSqls addObject:@"insert into t_my_test(col_01, col_02, col_03) values ('row_02', 'row_02', 2);"];
 * [arrSqls addObject:@"insert into t_my_test(col_01, col_02, col_03) values ('row_03', 'row_03', 3);"];
 * [arrSqls addObject:@"insert into t_my_test(col_01, col_02, col_03) values ('row_04', 'row_04', 4);"];
 * [arrSqls addObject:@"insert into t_my_test(col_01, col_02, col_03) values ('row_05', 'row_05', 5);"];
 * [db_update Exec:arrSqls AtDB:DBName];
 * [arrSqls release];
 * [db_update release];
 ****************************************************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBUpdate : NSObject
{
    sqlite3 *m_db;
}

- (NSInteger)Exec:(NSArray *) sSql AtDB:(NSString *)sDbName;


@end
