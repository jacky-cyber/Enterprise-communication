//
//  SynUserIcon.h
//  JieXinIphone
//
//  Created by tony on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "CXAlertView.h"

#define kIconDownloadURL    @"UserIconDownloadUrl"
#define kIconEnterpriseID   @"EnterpriseIDForUserIcon"

#define kIconUpdateVersion  @"IconUpdateVersion"
#define kIconLocalVersion   @"IconLocalVersion"
#define kIconUpdateUrl      @"IconUpdateUrl"

@protocol HttpIconDownloadManagerDelegate;
@interface SynUserIcon : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
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
@property (nonatomic, assign) id<HttpIconDownloadManagerDelegate>delegate;
@property (nonatomic, retain) NSDictionary *dbInfo;
@property (nonatomic, retain) NSString *newVersion;

- (NSString *)getCurrentUserBigIconPath;
-(NSString *)getCurrentUserSmallIconPath;
-(NSString *)getCurrentUserMiddleIconPath;

+ (SynUserIcon *)sharedManager;
- (void)downloadFileWithInfo:(NSDictionary *)infoDic withDelegate:(id)delegate;
- (void)downloadFileUrl:(NSString *)downloadUrl withEnterpriseId:(NSString *)entId;

@end

@protocol HttpIconDownloadManagerDelegate <NSObject>
@optional
- (void)downloadManagerDataDownloadFinished: (SynUserIcon *)downloader;
- (void)downloadManagerDataDownloadFailed: (SynUserIcon *)downloader;
@end
