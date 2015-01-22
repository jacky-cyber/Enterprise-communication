//
//  HttpDownload.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SynUserInfo.h"
#import "STFormDataRequest.h"
#import "Integrated+Extensions.h"
#import "DBUpdate.h"
#import "ZipArchive.h"
#import "FMDatabase.h"
#import "documentDataHelp.h"
#define AlertLabelTag 101
#define AlertProgressViewTag 102
#define kRequestBaseTag 200

#define AlertDownloadFailedTag 301
#define AlertUpdateFailedTag 102

#define DELEGATE_CALLBACK(X, Y) if (self.delegate && [self.delegate respondsToSelector:@selector(X)]) [self.delegate performSelector:@selector(X) withObject:Y];

static NSString* const kUserDBCacheDirectory = @"UserDBCache";


@implementation SynUserInfo
{
    STFormDataRequest *_downloadRequest;
}
@synthesize sFileName = _sFileName;
@synthesize nFileSize = _nFileSize;
@synthesize isLoading = _isLoading;
@synthesize downloadAlertView = _downloadAlertView;
- (id)init
{
    if ((self = [super init]))
    {
        // Init the disk cache
        [self updateDefualtInfo];
    }
    return self;
}

-(void)updateDefualtInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSMutableString *tempPath = [NSMutableString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain]];
    [tempPath appendString:kUserDBCacheDirectory];
    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:tempPath] retain];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

+ (SynUserInfo *)sharedManager
{
    static SynUserInfo *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (FMDatabase *)readDataBase
{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getCurrentUserDBPath]];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    return db;
}

#pragma mark - 关闭数据库
-(void)closeDatabase{
    
}

//调用组织结构数据库：
- (NSString *)getCurrentUserDBPath
{
    NSString *entID = [[NSUserDefaults standardUserDefaults] objectForKey:kEnterpriseID];
    return [self cachePathForKey:entID];
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
    
    return [diskCachePath stringByAppendingPathComponent:filename];
}

- (BOOL)isStoredLocalDB:(NSString *)entId
{
    BOOL isStored = NO;
    NSString *userPath = [self cachePathForKey:entId];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfFile:userPath];
    if ([fileManager fileExistsAtPath:userPath] != NO && [data length]) {
        isStored = YES;
    }
    return isStored;
}

- (void)downloadError
{
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"提示" message:@"下载组织机构数据失败" cancelButtonTitle:nil];
    [alertView addButtonWithTitle:@"重新下载"
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.tag = 320;
                              [alertView dismiss];
                              
                              //重新下载
                              NSString *downloadUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kDownloadURL];
                              NSString *entID = [[NSUserDefaults standardUserDefaults] objectForKey:kEnterpriseID];
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
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"提示" message:@"更新组织机构数据失败" cancelButtonTitle:nil];
    [alertView addButtonWithTitle:@"重新更新"
                             type:CXAlertViewButtonTypeCancel
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              alertView.tag = 420;
                              [alertView dismiss];
                              
                              //重新更新
                              NSString *updateUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kUpdateUrl];
                              [self requestUpdateInfoWithUrl:updateUrl];
                          }];
    
    alertView.didDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
        if(alertView.tag == 420)
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

- (void)downloadFileWithInfo:(NSDictionary *)infoDic withDelegate:(id)delegate
{
    self.dbInfo = infoDic;
    self.delegate = delegate;
    
    [self updateDefualtInfo];
    
    NSString *downloadUrl = [infoDic objectForKey:kDownloadURL];
    NSString *entId = [infoDic objectForKey:kEnterpriseID];
    NSString *updateUrl = [infoDic objectForKey:kUpdateUrl];
    NSString *updateVersion = [infoDic objectForKey:kUpdateVersion];
    NSString *dburlDbVersion = [infoDic objectForKey:kDbUrlDbVersion];
    NSInteger isDownDb = [[infoDic objectForKey:@"isDownDB"] integerValue];
    NSInteger localIsDownDb = [[[NSUserDefaults standardUserDefaults] objectForKey:kLocalIsDownDb] integerValue];
    BOOL isShouldDownDb = isDownDb >localIsDownDb?YES:NO;

    //没区分企业
    if(entId == nil)
    {
        entId = @"DefaultEnterpriseID";
    }
    if([self isStoredLocalDB:entId] && !isShouldDownDb)
    {
        NSString *localVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalVersion];
        if([localVersion floatValue] < [updateVersion floatValue])
        {
            [self requestUpdateInfoWithUrl:updateUrl];
        }
    }
    else
    {
        [self downloadFileUrl:downloadUrl withEnterpriseId:entId];
    }
}
- (void)downloadFileUrl:(NSString *)downloadUrl withEnterpriseId:(NSString *)entId
{
    //    //http://111.11.28.30/app/0_143.db
    //
    //
    //    m_sServerUrl = sUrl;
    //    [m_sServerUrl retain];
    //
    //    m_sSavePath = sPath;
    //    [m_sSavePath retain];
    //
    //    NSRange range = [m_sServerUrl rangeOfString:@"/" options:NSBackwardsSearch];
    //    range.length = m_sServerUrl.length - range.location - 1;
    //    range.location = range.location + 1;
    //    _sFileName = [m_sServerUrl substringWithRange:range];
    //    [_sFileName retain];
    //
    //    NSURL *url = [NSURL URLWithString:sUrl];
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0] ;
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    //    [connection release];
    //    [request release];
    //self.isLoading = YES;
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
    
    [[NSUserDefaults standardUserDefaults] setValue:downloadUrl forKey:kDownloadURL];
    [[NSUserDefaults standardUserDefaults] setValue:entId forKey:kEnterpriseID];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    if(_downloadRequest)
    {
        [_downloadRequest clearDelegatesAndCancel];
        _downloadRequest = nil;
    }
    
    [self showAlertViewWithProgress:@"正在同步用户信息"];
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
    
    [[NSUserDefaults standardUserDefaults] setValue:updateUrl forKey:kUpdateUrl];
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
//        DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:,self);
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
    NSString *entId = [[NSUserDefaults standardUserDefaults] objectForKey:kEnterpriseID];
    NSString *userPath = [self cachePathForKey:entId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [userPath stringByDeletingLastPathComponent];
    if ([fileManager fileExistsAtPath:documentPath] == NO) {
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //写入本地：
    BOOL isWritten = [m_dataNote writeToFile:userPath atomically:YES];
    //如果写入失败 或 m_dataNote 长度为0时 则移除
    if(isWritten == NO || ![m_dataNote length])
    {
        [fileManager removeItemAtPath:documentPath error:nil];
        [self errorAlert:AlertDownloadFailedTag];
    }
    //下载成功，纪录当前的版本号
    else
    {
        DELEGATE_CALLBACK(downloadManagerDataDownloadFinished:,self);

        [[NSUserDefaults standardUserDefaults] setValue:[self.dbInfo objectForKey:kDbUrlDbVersion] forKey:kLocalVersion];
        [[NSUserDefaults standardUserDefaults] setValue:[self.dbInfo objectForKey:@"isDownDB"] forKey:kLocalIsDownDb];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadRequest = nil;
}


- (void)getUpdateInfoFinished:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    NSString *upadateId = [self.dbInfo objectForKey:kUpdateVersion];
    NSString *zipPath = [NSString stringWithFormat:@"%@.zip",[self cachePathForKey:upadateId]];
    
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
    
    NSString *unzipto = [NSString stringWithFormat:@"%@",[diskCachePath stringByAppendingPathComponent:upadateId]];
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
            [self errorAlert:AlertUpdateFailedTag];
        }
        else
        {
            __block typeof(self)tmpObject = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 // 处理耗时操作的代码块...
                //更新数据库：
                NSArray *filePaths = [self allFilesInPathAndItsSubpaths:unzipto];
                FMDatabase *dataBase = [tmpObject readDataBase];
                for(NSString *filePath in filePaths)
                {
                    NSString *updateString = [[[NSString alloc] initWithContentsOfFile:[unzipto stringByAppendingPathComponent:filePath] encoding:NSUTF8StringEncoding error:nil] autorelease];
                    //NSLog(@"%@",updateString);
                    
                    NSArray *componentArray = [updateString componentsSeparatedByString:@"\n"];//通过;来分割有问题！现在通过\n来改
                    
                    //NSLog(@"%@",componentArray);
                    
                    //NSMutableArray *updateArray = [NSMutableArray array];
                    int count = 0;
                    BOOL isUpateFailed = NO;
                    for(NSString *perUpdate in componentArray)
                    {
                        perUpdate = [perUpdate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        //perUpdate = [NSString stringWithFormat:@"%@;",perUpdate];
                        //[updateArray addObject:perUpdate];
                        
                        if([perUpdate length])
                        {
                            //executeUpdate执行数据库插入的操作
                            BOOL updateSuc = [dataBase executeUpdate:perUpdate];
                            if(updateSuc == NO)
                            {
                                NSLog(@"有更新失败的数据");
                                isUpateFailed = YES;
                            }
                            else
                            {
                                count++;
                            }
                        }
                    }
                    NSLog(@"更新了%d条数据",count);
                    if(!isUpateFailed)
                    {
                        //更新无误，纪录版本号；
                        [[NSUserDefaults standardUserDefaults] setValue:[self.dbInfo objectForKey:kUpdateVersion] forKey:kLocalVersion];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    //NSLog(@"%@",updateArray);
                    //DBUpdate * db_update = [[[DBUpdate alloc] init] autorelease];
                    //[db_update Exec:updateArray AtDB:[self getCurrentUserDBPath]];
                }
                
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    [dataBase close];
                });
            });

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

- (void)getUpdateInfoFailed:(ASIHTTPRequest *)request
{
    self.isLoading = NO;
    //[self.downloadAlertView setTitle:@"下载失败!"];
   [self errorAlert:AlertUpdateFailedTag];
    
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
    
    if (m_dataNote != nil) {
        [m_dataNote release];
        m_dataNote = nil;
    }
    _downloadAlertView = nil;
    _downloadRequest = nil;
    [super dealloc];
}


//#pragma label -
//#pragma label NSURLConnectionDataDelegate Method
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    m_dataNote = [[NSMutableData alloc] initWithLength:0];
//    NSHTTPURLResponse * res = (NSHTTPURLResponse *)response;
//    NSInteger statusCode = [res statusCode];
//    if(statusCode >= 400) {
//        NSLog(@"HTTP ERROR CODE %d",statusCode);
//    }
//    
//    if (res && [res respondsToSelector:@selector(allHeaderFields)]) {
//        NSDictionary *HeaderFields = [res allHeaderFields];
//        _nFileSize = [[HeaderFields objectForKey:@"Content-Length"] longLongValue];
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [m_dataNote appendData:data];
//}
//
//#pragma label -
//#pragma label NSURLConnectionDownloadDelegate Method
//
//- (void)connectionDidFinishLoading:(NSURLConnection*)connection{
//    NSString *filePath = [m_sSavePath stringByAppendingPathComponent:self.sFileName];
//    [m_dataNote writeToFile:filePath atomically:YES];
//    [m_dataNote release];
//    m_dataNote = nil;
//    
//    
//}
//
//
//#pragma label -
//#pragma label NSURLConnectionDelegate Method
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    [m_dataNote release];
//    m_dataNote = nil;
//    NSLog(@"DownLoad - didFailWithError");
//}

@end
