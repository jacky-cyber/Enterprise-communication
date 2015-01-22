//
//  HttpDownload.h
//  JieXinIphone
//
//  Created by gabriella on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

/****************************************************************************************************
 * 代码调用示例
 * NSString *objStr = @"http://111.11.28.30/app/0_93.db";
 *
 * NSString *SavePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
 * HttpDownload *httpdwon = [[HttpDownload alloc] init];
 
 * [httpdwon DownLoadFileFrom:objStr SaveTo:SavePath];
 * [httpdwon release];
 * httpdwon.sFileName 不包含路径的文件名称
 * httpdwon.nFileSize 需要下载的文件大小
****************************************************************************************************/

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "CXAlertView.h"

#define kDownloadURL    @"UserDBDownloadUrl"
#define kEnterpriseID   @"EnterpriseIDForDB"

#define kUpdateVersion  @"UpdateVersion"
#define kDbUrlDbVersion  @"dburlDbVersion"
#define kUpdateUrl      @"UpdateUrl"

@protocol HttpDownloadManagerDelegate;
@interface SynUserInfo : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    long long fileSize;
    NSString *m_sServerUrl;
    NSString *m_sSavePath;
    NSMutableData *m_dataNote;
    CXAlertView *_downloadAlertView;
    NSString *diskCachePath;
    NSDictionary *dbInfo;
}

@property (readonly, nonatomic) NSString *sFileName;
@property (readonly) long long nFileSize;

@property (strong, nonatomic) NSURLConnection *myConnection;//连接网络
@property (strong, nonatomic) NSMutableData *allData;//存储网络下载的数据

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) CXAlertView *downloadAlertView;
@property (nonatomic, assign) id<HttpDownloadManagerDelegate>delegate;
@property (nonatomic, retain) NSDictionary *dbInfo;

- (NSString *)getCurrentUserDBPath;
+ (SynUserInfo *)sharedManager;
- (void)downloadFileWithInfo:(NSDictionary *)infoDic withDelegate:(id)delegate;
- (void)downloadFileUrl:(NSString *)downloadUrl withEnterpriseId:(NSString *)entId;
- (BOOL)isStoredLocalDB:(NSString *)entId;


@end

@protocol HttpDownloadManagerDelegate <NSObject>
@optional
- (void)downloadManagerDataDownloadFinished: (SynUserInfo *)downloader;
- (void)downloadManagerDataDownloadFailed: (SynUserInfo *)downloader;
@end
