//
//  SynUserIcon.m
//  JieXinIphone
//
//  Created by tony on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SynUserIcon.h"
#import "STFormDataRequest.h"
#import "Integrated+Extensions.h"
#import "DBUpdate.h"
#import "ZipArchive.h"
#import "FMDatabase.h"

#define AlertLabelTag 101
#define AlertProgressViewTag 102
#define kRequestBaseTag 200

#define AlertDownloadFailedTag 301
#define AlertUpdateFailedTag 102

#define kIconFileNumber @"13213123daefe1"

#define DELEGATE_CALLBACK(X, Y) if (self.delegate && [self.delegate respondsToSelector:@selector(X)]) [self.delegate performSelector:@selector(X) withObject:Y];

static NSString* const kUserIconacheDirectory = @"UserIconCache";
@implementation SynUserIcon
{
    STFormDataRequest *_downloadRequest;
    NSString *_companyId;
}
@synthesize sFileName = _sFileName;
@synthesize nFileSize = _nFileSize;
@synthesize isLoading = _isLoading;
@synthesize downloadAlertView = _downloadAlertView;
@synthesize dbInfo = _dbInfo;
- (id)init
{
    if ((self = [super init]))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downUserPicture:)
                                                     name:kDownUserpicture
                                                   object:nil];

        // Init the disk cache
        [self updateDefualtInfo];
    }
    return self;
}

-(void)updateDefualtInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSMutableString *tempPath = [NSMutableString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain]];
    [tempPath appendString:kUserIconacheDirectory];
    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:tempPath] retain];
    
    //公司id
    _companyId = [GetContantValue getDomaiId];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

+ (SynUserIcon *)sharedManager
{
    static SynUserIcon *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

//返回用户图标存放的路径
- (NSString *)getCurrentUserBigIconPath
{
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:kIconFileNumber]];
    return [NSString stringWithFormat:@"%@/big",unzipto];
}

-(NSString *)getCurrentUserSmallIconPath
{
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:kIconFileNumber]];
    return [NSString stringWithFormat:@"%@/small",unzipto];
}

-(NSString *)getCurrentUserMiddleIconPath
{
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:kIconFileNumber]];
    return [NSString stringWithFormat:@"%@/middle",unzipto];
}

- (NSString *)cachePathForKey:(NSString *)key
{
    if(key == nil)
        key = @"nil";
    
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [diskCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",filename]];
}

#pragma mark - 文件夹是否存在
- (BOOL)isStoredLocalIcon:(NSString *)entId
{
    BOOL isStored = NO;
    NSString *userPath = [self cachePathForKey:entId];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:userPath] != NO) {
        
        isStored = YES;
    }
    return isStored;
}

- (void)downloadError
{
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"提示" message:@"下载用户包图标失败" cancelButtonTitle:nil];
    [alertView addButtonWithTitle:@"重新下载"
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.tag = 320;
                              [alertView dismiss];
                              
                              //重新下载
                              NSString *downloadUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kIconDownloadURL];
                              NSString *entID = [[NSUserDefaults standardUserDefaults] objectForKey:kIconEnterpriseID];
                              [self downloadFileUrl:downloadUrl withEnterpriseId:entID];
                          }];
    
    alertView.didDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
        if(alertView.tag == 320)
        {
            
        }
    };
    
    [alertView addButtonWithTitle:@"取消"
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              [alertView dismiss];
                          }];
    [alertView show];
}

- (void)updateError
{
//    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"提示" message:@"更新用户包图标失败" cancelButtonTitle:nil];
//    [alertView addButtonWithTitle:@"重新更新"
//                             type:CXAlertViewButtonTypeCancel
//                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
//                              alertView.tag = 420;
//                              [alertView dismiss];
//                              
//                              //重新更新
//                              NSString *updateUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kIconUpdateUrl];
//                              [self requestUpdateInfoWithUrl:updateUrl];
//                          }];
//    
//    alertView.didDismissHandler = ^(CXAlertView *alertView) {
//        NSLog(@"%@, didDismissHandler", alertView);
//        if(alertView.tag == 420)
//        {
//            
//        }
//    };
//    
//    [alertView addButtonWithTitle:@"取消"
//                             type:CXAlertViewButtonTypeCancel
//                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
//                              [alertView dismiss];
//                          }];
//    [alertView show];
}

- (void)errorAlert:(int)tag
{
    if ([_downloadAlertView isVisible]) {
        [self.downloadAlertView dismiss];
    }
    
    if(tag == AlertDownloadFailedTag)
    {
        [self performSelector:@selector(downloadError) withObject:nil afterDelay:0.3];
    }
    else if(tag == AlertUpdateFailedTag)
    {
        [self performSelector:@selector(updateError) withObject:nil afterDelay:0.3];
    }
}
#pragma mark - alert view
- (void)showAlertViewWithProgress:(NSString *)message
{
    if(self.downloadAlertView.isVisible)
    {
        [self.downloadAlertView dismiss];
    }
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 80)];
    contentView.backgroundColor = [UIColor clearColor];
    CXAlertView *progressAlertView = [[CXAlertView alloc] initWithTitle:message contentView:contentView cancelButtonTitle:nil];
    progressAlertView.containerWidth = 300;
    progressAlertView.bottomScrollViewHeight = 0;
    
	// Create the progress bar and add it to the alert
    UIProgressView *downloadProgressView = [[[UIProgressView alloc] initWithFrame:CGRectMake(5.0f, 20.0f, contentView.bounds.size.width-10, 90.0f)] autorelease];
	//self.progressView.userInteractionEnabled = NO;
    downloadProgressView.tag = AlertProgressViewTag;
    [downloadProgressView setProgressViewStyle:UIProgressViewStyleBar];
	[contentView addSubview:downloadProgressView];
    
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 30.0f, contentView.bounds.size.width - 30, 40.0f)];
    sizeLabel.backgroundColor = [UIColor clearColor];
    sizeLabel.textColor = [UIColor blackColor];
    sizeLabel.font = [UIFont systemFontOfSize:12.0f];
    //label.text = @"";
    sizeLabel.textAlignment = NSTextAlignmentRight;
    sizeLabel.tag = AlertLabelTag;
    [contentView addSubview:sizeLabel];
	[sizeLabel release];
    [contentView release];
    self.downloadAlertView = progressAlertView;
    [progressAlertView release];
    [self.downloadAlertView show];
}

#pragma mark - 下载输入口
- (void)downloadFileWithInfo:(NSDictionary *)infoDic withDelegate:(id)delegate
{
    self.dbInfo = infoDic;
    self.delegate = delegate;
    
    [self updateDefualtInfo];
    
    //当前的版本
    NSString *localVersion = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],kIconLocalVersion]];
    if (localVersion) {
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSArray *msgArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"DownUserpicture"},@{@"localpictureId": localVersion}];
        NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
        [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    }
    
    NSString *entId = [infoDic objectForKey:kIconEnterpriseID];
    NSString *updateUrl = [infoDic objectForKey:kIconUpdateUrl];
    NSString *updateVersion = [infoDic objectForKey:kIconUpdateVersion];
    NSString *downloadUrl = [infoDic objectForKey:kIconDownloadURL];
    
    
    
     NSString *fileName = [NSString stringWithFormat:@"%@_%@.zip",localVersion,updateVersion];
    
    //更新地址
    updateUrl = [NSString stringWithFormat:@"%@%@/%@",downloadUrl,_companyId,fileName];
    
    //下载地址
    downloadUrl = [NSString stringWithFormat:@"%@%@/%@",downloadUrl,_companyId,[NSString stringWithFormat:@"%@.zip",_companyId]];
    
    //没区分企业
    if(entId == nil)
    {
        entId = kIconFileNumber;
    }
    if([self isStoredLocalIcon:entId])
    {
        if([localVersion floatValue] < [updateVersion floatValue])
        {
//            [self requestUpdateInfoWithUrl:updateUrl];
        }
    }
    else
    {
       // [self requestUpdateInfoWithUrl:downloadUrl];
        [self downloadFileUrl:downloadUrl withEnterpriseId:entId];
    }
}
#pragma mark - 在线消息
- (void)downUserPicture:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    NSString *localVersion = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],kIconLocalVersion]];
    NSString *entId = [_dbInfo objectForKey:kIconEnterpriseID];
    NSString *updateUrl = [_dbInfo objectForKey:kIconUpdateUrl];
    NSString *downloadUrl = [_dbInfo objectForKey:kIconDownloadURL];
    NSString *updateVersion = [dic objectForKey:@"serverpictureId"];
    self.newVersion = updateVersion;
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.zip",localVersion,updateVersion];
    //更新地址
    updateUrl = [NSString stringWithFormat:@"%@%@/%@",downloadUrl,_companyId,fileName];
    
    //没区分企业
    if(entId == nil)
    {
        entId = kIconFileNumber;
    }
    if([self isStoredLocalIcon:entId])
    {
        if([localVersion floatValue] < [updateVersion floatValue])
        {
            [self requestUpdateInfoWithUrl:updateUrl];
        }
    }
}

- (void)downloadFileUrl:(NSString *)downloadUrl withEnterpriseId:(NSString *)entId
{
    //    //http://111.11.28.30/app/0_143.db
    if(!downloadUrl || !entId)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"下载路径或者用户信息有问题" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    //downloadUrl = @"http:111.11.28.30/app/0_143.db";
    //downloadUrl = @"http://111.11.28.30/app/0_143.db";
    //sUrl = @"https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Notifications/Notifications.pdf";
    
    if(![downloadUrl hasPrefix:@"http"])
    {
        downloadUrl = [NSString stringWithFormat:@"http://%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],downloadUrl];
    }
    
    //[self showAlertViewWithProgress:@"正在同步用户图标信息"];
    
    [[NSUserDefaults standardUserDefaults] setValue:downloadUrl forKey:kIconDownloadURL];
    [[NSUserDefaults standardUserDefaults] setValue:entId forKey:kIconEnterpriseID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if(_downloadRequest)
    {
        [_downloadRequest clearDelegatesAndCancel];
        _downloadRequest = nil;
    }
    
    //[self showAlertViewWithProgress:@"正在同步用户信息"];
    _downloadRequest = [STFormDataRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
	_downloadRequest.requestFlagMark = [NSString createUUID];
    [_downloadRequest setUseCookiePersistence:NO];
    [_downloadRequest setShouldContinueWhenAppEntersBackground:YES];
    [_downloadRequest setDownloadProgressDelegate:self];
    [_downloadRequest setShouldAttemptPersistentConnection:NO];;
    [_downloadRequest setTimeOutSeconds:60.0f];
    [_downloadRequest setDidFinishSelector:@selector(downloadFinished:)];
    [_downloadRequest setDidFailSelector:@selector(downloadFailed:)];
	[_downloadRequest setDelegate:self];
	//异步
	[_downloadRequest startAsynchronous];
    
}

- (void)requestUpdateInfoWithUrl:(NSString *)updateUrl
{
    if(_downloadRequest)
    {
        [_downloadRequest clearDelegatesAndCancel];
        _downloadRequest = nil;
    }
    
    //[self showAlertViewWithProgress:@"正在同步用户信息"];
    //updateUrl = @"http://111.11.28.30/app/0_0_143.zip";
    //sUrl = @"https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Notifications/Notifications.pdf";
    if(![updateUrl hasPrefix:@"http"])
    {
        updateUrl = [NSString stringWithFormat:@"http://%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],updateUrl];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:updateUrl forKey:kIconUpdateUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _downloadRequest = [STFormDataRequest requestWithURL:[NSURL URLWithString:updateUrl]];
	_downloadRequest.requestFlagMark = [NSString createUUID];
    [_downloadRequest setUseCookiePersistence:NO];
    [_downloadRequest setShouldContinueWhenAppEntersBackground:YES];
    [_downloadRequest setDownloadProgressDelegate:self];
    [_downloadRequest setShouldAttemptPersistentConnection:NO];;
    [_downloadRequest setTimeOutSeconds:60.0f];
    [_downloadRequest setDidFinishSelector:@selector(getUpdateInfoFinished:)];
    [_downloadRequest setDidFailSelector:@selector(getUpdateInfoFailed:)];
	[_downloadRequest setDelegate:self];
	//异步
	[_downloadRequest startAsynchronous];
}


- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    [m_dataNote appendData:data];
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"收到头部！");
    fileSize = request.contentLength;
    if (fileSize <= 0) {
        [_downloadRequest cancel];
        DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:,self);
        return;
    }
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    m_dataNote = [[NSMutableData alloc] init];
}

//Asi代理调用
- (void)setProgress:(float)newProgress
{
    UIProgressView *progressView = (UIProgressView *)[_downloadAlertView viewWithTag:AlertProgressViewTag];
    [progressView setProgress:newProgress animated:YES];
    
    static const unsigned int bytes = 1024;
    float totalSize = fileSize/bytes;
    UILabel *label = (UILabel *)[_downloadAlertView viewWithTag:AlertLabelTag];
    label.text = [NSString stringWithFormat:@"%3.2f KB / %3.2f KB",totalSize * newProgress,totalSize];
}

- (void)downloadFinished:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    NSString *zipPath = [self cachePathForKey:kIconFileNumber];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [zipPath stringByDeletingLastPathComponent];
    if ([fileManager fileExistsAtPath:documentPath] == NO) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //写入本地：
    BOOL isWritten = [m_dataNote writeToFile:zipPath atomically:YES];
    if(isWritten == NO)
    {
        [self errorAlert:AlertUpdateFailedTag];
    }
   
    DELEGATE_CALLBACK(downloadManagerDataDownloadFinished:,self);
    
    ZipArchive* zip = [[[ZipArchive alloc] init] autorelease];
    
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:kIconFileNumber]];
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
            [self errorAlert:AlertUpdateFailedTag];
        }
        else
        {
             //下载并解压成功，纪录当前的版本号
            [[NSUserDefaults standardUserDefaults] setValue:[self.dbInfo objectForKey:kIconUpdateVersion] forKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],kIconLocalVersion]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [zip UnzipCloseFile];
    }
    
    //TODO:modify
    if ([_downloadAlertView isVisible]) {
        [self.downloadAlertView dismiss];
    }
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadRequest = nil;
}

- (void)downloadFailed:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    //[self.downloadAlertView setTitle:@"下载失败!"];
    [self errorAlert:AlertDownloadFailedTag];
    DELEGATE_CALLBACK(downloadManagerDataDownloadFailed: ,self);
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadRequest = nil;
}


- (void)getUpdateInfoFinished:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    NSString *upadateId = [self.dbInfo objectForKey:kIconUpdateVersion];
    NSString *zipPath = [self cachePathForKey:upadateId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [zipPath stringByDeletingLastPathComponent];
    if ([fileManager fileExistsAtPath:documentPath] == NO) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //写入本地：
    BOOL isWritten = [m_dataNote writeToFile:zipPath atomically:YES];
    if(isWritten == NO)
    {
        [self errorAlert:AlertUpdateFailedTag];
    }
    
    ZipArchive* zip = [[[ZipArchive alloc] init] autorelease];
    
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:kIconFileNumber]];
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
            [self errorAlert:AlertUpdateFailedTag];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"N_ReloadData"
                                                                object:nil];
            //当前的版本
            [[NSUserDefaults standardUserDefaults] setValue:self.newVersion forKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],kIconLocalVersion]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [zip UnzipCloseFile];
    }
    
    //将更新下载的文件删除掉
    [fileManager removeItemAtPath:zipPath error:nil];
    DELEGATE_CALLBACK(downloadManagerDataDownloadFinished:,self);
    //TODO:modify
    if ([_downloadAlertView isVisible]) {
        [self.downloadAlertView dismiss];
    }
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadRequest = nil;
}

- (void)getUpdateInfoFailed:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    //[self.downloadAlertView setTitle:@"下载失败!"];
    [self errorAlert:AlertUpdateFailedTag];
    DELEGATE_CALLBACK(downloadManagerDataDownloadFailed: ,self);
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadRequest = nil;
}


//取路径下的所有文件名
- (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath
{
	NSMutableArray *allContentsPathArray = [[[NSFileManager defaultManager] subpathsAtPath:directoryPath] mutableCopy];
	BOOL isDir = NO;
	for (int i = [allContentsPathArray count] - 1;i >= 0; i--)
	{
		NSString *path = [allContentsPathArray objectAtIndex:i];
		if (![[NSFileManager defaultManager] fileExistsAtPath:[directoryPath stringByAppendingPathComponent:path] isDirectory:&isDir] || isDir)
		{
			[allContentsPathArray removeObject:path];
			//isDir = NO;
		}
	}
	return allContentsPathArray;
}

- (void)dealloc
{
    [m_sServerUrl release];
    [m_sSavePath release];
    [_sFileName release];
    m_sServerUrl = nil;
    m_sSavePath = nil;
    _sFileName = nil;
    _nFileSize = 0;
    self.newVersion = nil;
    if(_companyId)
        [_companyId release];
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadAlertView = nil;
    _downloadRequest = nil;
    [super dealloc];
}
@end
