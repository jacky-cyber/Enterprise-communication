//
//  documentDataHelp.m
//  JieXinIphone
//
//  Created by lxrent02 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//


#import "documentDataHelp.h"
#import "SynUserInfo.h"
#import "filestatisticsModel.h"
#import "fileinfoModel.h"
#import "downloadrecordModel.h"
#import "permissionModel.h"
#import "programaModel.h"
#import "UIViewCtrl_NewsModel.h"
@interface documentDataHelp()
@property (nonatomic, retain)FMDatabase *dbBase;

@end
@implementation documentDataHelp

+ (id) sharedService
{
	static documentDataHelp *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[documentDataHelp alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    [self closeDocModelDb];
    // [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        mDatabase = [FMDatabase databaseWithPath:kdocumentDBPath];
        if (![mDatabase open]) {
            return nil;
        }
        
        //栏目表
        /*
         字段含义
         name           栏目名称
         upid           父栏目
         hassub         是否有子栏目
         plevel         栏目等级
         createtime     创建时间
         creater        创建人
         updatetime     更新时间
         deleted        删除标记0/1
         groupid
         */
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS programa (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT DEFAULT NULL,upid TEXT,hassub TEXT,plevel TEXT,createtime TEXT DEFAULT NULL,creater TEXT DEFAULT NULL,updatetime TEXT DEFAULT NULL,deleted TEXT DEFAULT NULL,groupid TEXT DEFAULT NULL)"];
        
        //用户权限表
        /*
         字段含义
         canread            阅读权限0/1
         candownload        下载权限0/1
         userid             用户ID
         fileid             文件ID
         
         */
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS permission (serial integer  PRIMARY KEY AUTOINCREMENT,canread TEXT DEFAULT NULL,candownload TEXT,userid TEXT,fileid TEXT DEFAULT NULL)"];
        //文档下载记录表
        /*
         字段含义
         userid             用户ID
         fileid             文件ID
         downloadtime       下载时间
         watermarkcontent   水印内容
         
         */
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS downloadrecord (serial integer  PRIMARY KEY AUTOINCREMENT,userid TEXT DEFAULT NULL,fileid TEXT,downloadtime TEXT, watermarkcontent TEXT DEFAULT NULL)"];
        //文档信息表
        /*
         字段含义
         name               文件名称
         programaid         所属栏目
         title              文件标题
         filedesc           文件描述
         filesize           文件大小
         path               文件保存路径
         ext                文件类型
         pdfpath            PDF保存位置
         uploadtime         上传时间
         updatetime         更新时间
         uploaderid         上传用户ID
         groupid
         */
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS fileinfo (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT DEFAULT NULL,programaid TEXT,title TEXT,filedesc TEXT,filesize TEXT DEFAULT NULL,path TEXT DEFAULT NULL,ext TEXT DEFAULT NULL,pdfpath TEXT DEFAULT NULL,uploadtime TEXT DEFAULT NULL,updatetime TEXT DEFAULT NULL,uploaderid TEXT DEFAULT NULL,jpgStr TEXT DEFAULT NULL,jpgCount TEXT DEFAULT NULL,groupid TEXT DEFAULT NULL)"];
        
        //文档统计表
        /*
         字段含义
         fileid             文件ID
         downloadcount      下载数
         readcount          阅览数
         updatetime         更新时间
         
         */
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS filestatistics (serial integer  PRIMARY KEY AUTOINCREMENT,fileid TEXT DEFAULT NULL,downloadcount TEXT,readcount TEXT, updatetime TEXT DEFAULT NULL)"];
        //菜单表
        
        [mDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS NewsTable (serial integer  PRIMARY KEY AUTOINCREMENT,sysid TEXT DEFAULT NULL,categoryid TEXT DEFAULT NULL)"];
        
	}
	return self;
}
-(FMDatabase*)creatDb{
    FMDatabase*db = [FMDatabase databaseWithPath:kdocumentDBPath];
    if (![db open]) {
        return nil;
    }
    
    //栏目表
    /*
     字段含义
     name           栏目名称
     upid           父栏目
     hassub         是否有子栏目
     plevel         栏目等级
     createtime     创建时间
     creater        创建人
     updatetime     更新时间
     deleted        删除标记0/1
     groupid
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS programa (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT DEFAULT NULL,upid TEXT,hassub TEXT,plevel TEXT,createtime TEXT DEFAULT NULL,creater TEXT DEFAULT NULL,updatetime TEXT DEFAULT NULL,deleted TEXT DEFAULT NULL,groupid TEXT DEFAULT NULL)"];
    
    //用户权限表
    /*
     字段含义
     canread            阅读权限0/1
     candownload        下载权限0/1
     userid             用户ID
     fileid             文件ID
     
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS permission (serial integer  PRIMARY KEY AUTOINCREMENT,canread TEXT DEFAULT NULL,candownload TEXT,userid TEXT,fileid TEXT DEFAULT NULL)"];
    //文档下载记录表
    /*
     字段含义
     userid             用户ID
     fileid             文件ID
     downloadtime       下载时间
     watermarkcontent   水印内容
     
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS downloadrecord (serial integer  PRIMARY KEY AUTOINCREMENT,userid TEXT DEFAULT NULL,fileid TEXT,downloadtime TEXT, watermarkcontent TEXT DEFAULT NULL)"];
    //文档信息表
    /*
     字段含义
     name               文件名称
     programaid         所属栏目
     title              文件标题
     filedesc           文件描述
     filesize           文件大小
     path               文件保存路径
     ext                文件类型
     pdfpath            PDF保存位置
     uploadtime         上传时间
     updatetime         更新时间
     uploaderid         上传用户ID
     groupid
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS fileinfo (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT DEFAULT NULL,programaid TEXT,title TEXT,filedesc TEXT,filesize TEXT DEFAULT NULL,path TEXT DEFAULT NULL,ext TEXT DEFAULT NULL,pdfpath TEXT DEFAULT NULL,uploadtime TEXT DEFAULT NULL,updatetime TEXT DEFAULT NULL,uploaderid TEXT DEFAULT NULL,jpgStr TEXT DEFAULT NULL,jpgCount TEXT DEFAULT NULL,groupid TEXT DEFAULT NULL)"];
    
    //文档统计表
    /*
     字段含义
     fileid             文件ID
     downloadcount      下载数
     readcount          阅览数
     updatetime         更新时间
     
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS filestatistics (serial integer  PRIMARY KEY AUTOINCREMENT,fileid TEXT DEFAULT NULL,downloadcount TEXT,readcount TEXT, updatetime TEXT DEFAULT NULL)"];
    //菜单表
    
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS NewsTable (serial integer  PRIMARY KEY AUTOINCREMENT,sysid TEXT DEFAULT NULL,categoryid TEXT DEFAULT NULL)"];
    
    return db;
}
- (void)closeDocModelDb
{
    mDatabase = [FMDatabase databaseWithPath:kdocumentDBPath];
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    [mDatabase close];
    [distanceDataBase close];
}

-(void)insertDocModelItem:(id)item
{
    FMDatabase*dataBase = [self creatDb];
    if([item isKindOfClass:[programaModel class]])
    {   //插入栏目信息
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO programa (name,upid,hassub,plevel,createtime,creater,updatetime,deleted,groupid) VALUES (?,?,?,?,?,?,?,?,?)"];
        
        programaModel * newItem = (programaModel*)item;
        BOOL success=[dataBase executeUpdate:sql,newItem.name,newItem.upid,newItem.hassub,newItem.plevel,newItem.createtime,newItem.creater,newItem.updatetime,newItem.deleted,newItem.groupid];
        if (!success) {
            NSLog(@"插入失败");
        }
    }
    else if([item isKindOfClass:[fileinfoModel class]])
    {      //插入文件信息
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO fileinfo (name,programaid,title,filedesc,filesize,path,ext,pdfpath,uploadtime,updatetime,uploaderid,jpgStr,jpgCount,groupid) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
        
        fileinfoModel * newItem = (fileinfoModel*)item;
        BOOL success=[dataBase executeUpdate:sql,newItem.name,newItem.programaid,newItem.title,newItem.filedesc,newItem.filesize,newItem.path,newItem.ext,newItem.pdfpath,newItem.uploadtime,newItem.updatetime,newItem.uploaderid,newItem.jpgStr,newItem.jpgCount,newItem.groupid];
        if (!success) {
            NSLog(@"插入失败");
        }
    }
    else if([item isKindOfClass:[permissionModel class]])
    {   //插入权限信息
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO permission (canread,candownload,userid,fileid) VALUES (?,?,?,?)"];
        
        permissionModel * newItem = (permissionModel*)item;
        BOOL success=[dataBase executeUpdate:sql,newItem.canread,newItem.candownload,newItem.userid,newItem.fileid];
        if (!success) {
            NSLog(@"插入失败");
        }
    }
    else if([item isKindOfClass:[downloadrecordModel class]])
    {   //插入下载记录信息
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO downloadrecord (userid,fileid,downloadtime,watermarkcontent) VALUES (?,?,?,?)"];
        
        downloadrecordModel * newItem = (downloadrecordModel*)item;
        BOOL success=[dataBase executeUpdate:sql,newItem.userid,newItem.fileid,newItem.downloadtime,newItem.watermarkcontent];
        if (!success) {
            NSLog(@"插入失败");
        }
    }
    else if([item isKindOfClass:[filestatisticsModel class]])
    {   //插入文档统计信息
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO filestatistics (fileid,downloadcount,readcount,updatetime) VALUES (?,?,?,?)"];
        
        filestatisticsModel * newItem = (filestatisticsModel*)item;
        BOOL success=[dataBase executeUpdate:sql,newItem.fileid,newItem.downloadcount,newItem.readcount,newItem.updatetime];
        if (!success) {
            NSLog(@"插入失败");
        }
    }else if ([item isKindOfClass:[ UIViewCtrl_NewsModel class]]){
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO NewsTable (sysid,categoryid) VALUES (?,?)"];
        
        UIViewCtrl_NewsModel * newItem = (UIViewCtrl_NewsModel*)item;
        NSLog(@"sysid====%@",newItem.Sysid);
        BOOL success=[dataBase executeUpdate:sql,newItem.Sysid,newItem.Category];
        if (!success) {
            NSLog(@"插入失败");

    }
    
    }
    
    [self closeDocModelDb];
}
-(NSMutableArray*)readDocModelItem:(NSString *)tableName
{
    FMDatabase* db = [self creatDb];
    NSMutableArray * modelArr = [[NSMutableArray alloc]init];
      NSString *sql=nil;
      if ([tableName isEqualToString:@"programa"]) {
        sql=[NSString stringWithFormat:@"SELECT name,upid,hassub,plevel,createtime,creater,updatetime,deleted,groupid FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            while ([rs next]) {
                programaModel *item=[[programaModel alloc] init];
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                item.name = [rs stringForColumn:@"name"];
                if(item.name!=nil)
                    [dic setObject:item.name forKey:@"name"];
                item.upid = [rs stringForColumn:@"upid"];
                if(item.upid!=nil)
                    [dic setObject:item.upid forKey:@"upid"];
                item.hassub = [rs stringForColumn:@"hassub"];
                if(item.hassub!=nil)
                    [dic setObject:item.hassub forKey:@"hassub"];
                item.plevel = [rs stringForColumn:@"plevel"];
                if(item.plevel!=nil)
                    [dic setObject:item.plevel forKey:@"plevel"];
                item.createtime = [rs stringForColumn:@"createtime"];
                if(item.createtime!=nil)
                    [dic setObject:item.createtime forKey:@"createtime"];
                item.creater = [rs stringForColumn:@"creater"];
                if(item.creater!=nil)
                    [dic setObject:item.creater forKey:@"creater"];
                item.updatetime = [rs stringForColumn:@"updatetime"];
                if(item.updatetime!=nil)
                    [dic setObject:item.updatetime forKey:@"updatetime"];
                item.deleted = [rs stringForColumn:@"deleted"];
                if(item.deleted!=nil)
                    [dic setObject:item.deleted forKey:@"deleted"];
                item.groupid = [rs stringForColumn:@"groupid"];
                if(item.groupid!=nil)
                    [dic setObject:item.groupid forKey:@"groupid"];
                [modelArr addObject:dic];
            }
            return modelArr;
            
        }
        
    }
    else if ([tableName isEqualToString:@"fileinfo"]) {
        sql=[NSString stringWithFormat:@"SELECT name,programaid,title,filedesc,filesize,path,ext,pdfpath,uploadtime,updatetime,uploaderid,jpgStr,jpgCount,groupid FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            while ([rs next]) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                
                fileinfoModel *item=[[fileinfoModel alloc] init];
                item.name = [rs stringForColumn:@"name"];
                if(item.name!=nil)
                    [dic setObject:item.name forKey:@"name"];
                item.programaid = [rs stringForColumn:@"programaid"];
                if(item.programaid!=nil)
                    [dic setObject:item.programaid forKey:@"programaid"];
                item.title = [rs stringForColumn:@"title"];
                if(item.title!=nil)
                    [dic setObject:item.title forKey:@"title"];
                item.filedesc = [rs stringForColumn:@"filedesc"];
                if(item.filedesc!=nil)
                    [dic setObject:item.filedesc forKey:@"filedesc"];
                item.filesize = [rs stringForColumn:@"filesize"];
                if(item.filesize!=nil)
                    [dic setObject:item.filesize forKey:@"filesize"];
                item.path = [rs stringForColumn:@"path"];
                if(item.path!=nil)
                    [dic setObject:item.path forKey:@"path"];
                item.ext = [rs stringForColumn:@"ext"];
                if(item.ext!=nil)
                    [dic setObject:item.ext forKey:@"ext"];
                item.pdfpath = [rs stringForColumn:@"pdfpath"];
                if(item.pdfpath!=nil)
                    [dic setObject:item.pdfpath forKey:@"pdfpath"];
                item.uploadtime = [rs stringForColumn:@"uploadtime"];
                if(item.uploadtime!=nil)
                    [dic setObject:item.uploadtime forKey:@"uploadtime"];
                item.updatetime = [rs stringForColumn:@"updatetime"];
                if(item.updatetime!=nil)
                    [dic setObject:item.updatetime forKey:@"updatetime"];
                item.uploaderid = [rs stringForColumn:@"uploaderid"];
                if(item.uploaderid!=nil)
                    [dic setObject:item.uploaderid forKey:@"uploaderid"];
                item.jpgStr = [rs stringForColumn:@"jpgStr"];
                if(item.jpgStr!=nil)
                    [dic setObject:item.jpgStr forKey:@"jpgStr"];
                item.jpgCount = [rs stringForColumn:@"jpgCount"];
                if(item.jpgCount!=nil)
                    [dic setObject:item.jpgCount forKey:@"jpgCount"];
                item.groupid = [rs stringForColumn:@"groupid"];
                if(item.groupid!=nil)
                    [dic setObject:item.groupid forKey:@"groupid"];
                [modelArr addObject:dic];
            }
            return modelArr;
        }
        
    }
    else if ([tableName isEqualToString:@"permission"]) {
        sql=[NSString stringWithFormat:@"SELECT canread,candownload,userid,fileid FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            while ([rs next]) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                
                permissionModel *item=[[permissionModel alloc] init];
                item.canread = [rs stringForColumn:@"canread"];
                if(item.canread!=nil)
                    [dic setObject:item.canread forKey:@"canread"];
                item.candownload = [rs stringForColumn:@"candownload"];
                if(item.candownload!=nil)
                    [dic setObject:item.candownload forKey:@"candownload"];
                item.userid = [rs stringForColumn:@"userid"];
                if(item.userid!=nil)
                    [dic setObject:item.userid forKey:@"userid"];
                item.fileid = [rs stringForColumn:@"fileid"];
                if(item.fileid!=nil)
                    [dic setObject:item.fileid forKey:@"fileid"];
                [modelArr addObject:dic];
            }
            return modelArr;
            
        }
        
    }
    else if ([tableName isEqualToString:@"downloadrecord"]) {
        sql=[NSString stringWithFormat:@"SELECT userid,fileid,downloadtime,watermarkcontent FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            while ([rs next]) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                downloadrecordModel *item=[[downloadrecordModel alloc] init];
                item.userid = [rs stringForColumn:@"userid"];
                if(item.userid!=nil)
                    [dic setObject:item.userid forKey:@"userid"];
                item.fileid = [rs stringForColumn:@"fileid"];
                if(item.fileid!=nil)
                    [dic setObject:item.fileid forKey:@"fileid"];
                item.downloadtime = [rs stringForColumn:@"downloadtime"];
                if(item.downloadtime!=nil)
                    [dic setObject:item.downloadtime forKey:@"downloadtime"];
                item.watermarkcontent = [rs stringForColumn:@"watermarkcontent"];
                if(item.watermarkcontent!=nil)
                    [dic setObject:item.watermarkcontent forKey:@"watermarkcontent"];
                [modelArr addObject:dic];
                
            }
            return modelArr;
        }
        
    }
    else if ([tableName isEqualToString:@"filestatistics"]) {
        sql=[NSString stringWithFormat:@"SELECT fileid,downloadcount,readcount,updatetime FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            
            while ([rs next]) {
                filestatisticsModel *item=[[filestatisticsModel alloc] init];
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                item.fileid = [rs stringForColumn:@"fileid"];
                if(item.fileid!=nil)
                    [dic setObject:item.fileid forKey:@"fileid"];
                item.downloadcount = [rs stringForColumn:@"downloadcount"];
                if(item.downloadcount!=nil)
                    [dic setObject:item.downloadcount forKey:@"downloadcount"];
                item.readcount = [rs stringForColumn:@"readcount"];
                if(item.readcount!=nil)
                    [dic setObject:item.readcount forKey:@"readcount"];
                item.updatetime = [rs stringForColumn:@"updatetime"];
                if(item.updatetime!=nil)
                    [dic setObject:item.updatetime forKey:@"updatetime"];
                [modelArr addObject:dic];
                
            }
            return modelArr;
        }
    }else if ([tableName isEqualToString:@"NewsTable"]) {
        sql=[NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        if (sql) {
            FMResultSet *rs=[db executeQuery:sql];
            
            while ([rs next]) {
                UIViewCtrl_NewsModel *item=[[UIViewCtrl_NewsModel alloc] init];
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                item.Sysid = [rs stringForColumn:@"sysid"];
                if(item.Sysid!=nil)
                    [dic setObject:item.Sysid forKey:@"sysid"];
                
                item.Category = [rs stringForColumn:@"categoryid"];
                if(item.Category!=nil)
                [dic setObject:item.Category forKey:@"categoryid"];
                [modelArr addObject:dic];
                

                
            }
            return modelArr;
        }
    }

    return modelArr;
     [self closeDocModelDb];
}
-(void)deleteDocModelItem:(NSString *)tableName
{
   
    FMDatabase *db = [self creatDb];
    NSString * sql = [NSString stringWithFormat:@"delete from %@",tableName];
  [db executeUpdate:sql];
     [self closeDocModelDb];
    
}
- (BOOL) deleteTestList:(NSString *)deletList withCategoryid:(NSString*)categoryid{
    FMDatabase *db = [self creatDb];
         NSString *sql =[NSString stringWithFormat:@"delete from NewsTable  where sysid = ? and categoryid = ?"];
            BOOL success=[db executeUpdate:sql,deletList,categoryid];
            if (!success) {
                NSLog(@"dlete失败");
                
            }

            return YES;
     [self closeDocModelDb];
}

- (BOOL) deleteTestList:(NSString *)deletList {
    FMDatabase *db = [self creatDb];
        NSString *sql =[NSString stringWithFormat:@"delete from NewsTable  where sysid = ? "];
        BOOL success=[db executeUpdate:sql,deletList];
        if (!success) {
            NSLog(@"dlete失败");
            
        }
        
        return YES;
     [self closeDocModelDb];
}
//删除所有消息
- (BOOL)deleteAllNews
{
   FMDatabase *db = [self creatDb];
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE From NewsTable"];
    BOOL result = [db executeUpdate:sqlStr];
    //    [db close];
    return result;
}



@end