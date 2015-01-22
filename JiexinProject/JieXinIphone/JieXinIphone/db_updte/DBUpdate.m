//
//  DBUpdate.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "DBUpdate.h"

@implementation DBUpdate

- (void)dealloc
{
    [super dealloc];
}

- (NSInteger)Exec:(NSArray *) aSqls AtDB:(NSString *)sDbName{
    
    char *pErr;
    
    if (sqlite3_open([sDbName cStringUsingEncoding:NSUTF8StringEncoding] , &m_db) != SQLITE_OK) {
        sqlite3_close(m_db);
        NSLog(@"DataBase Open Error");
        return -1;
    }
    
    for (int i = 0; i < aSqls.count; i++) {
        
        NSString *tmpSql = [aSqls objectAtIndex:i];
        if (sqlite3_exec(m_db, [tmpSql cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &pErr) != SQLITE_OK) {
            NSLog(@"Error - %@ , sql = %@", [NSString stringWithUTF8String:pErr], tmpSql);
        }
    }
    
    sqlite3_close(m_db);
    return 0;
    
}

@end
