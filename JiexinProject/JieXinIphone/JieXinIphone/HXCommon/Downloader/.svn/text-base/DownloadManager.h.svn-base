

#import <Foundation/Foundation.h>

@protocol DownloadManagerDelegate;
@interface DownloadManager : NSObject
{
@private
	id <DownloadManagerDelegate> _delegate;
	
	NSString	*_title;
	NSURL		*_fileURL;
	NSString	*_fileName;
	

	NSUInteger _currentSize;
	
	NSNumber *_totalFileSize;
	UIProgressView *_progressView;
	UIAlertView *_progressAlertView;
	
	NSURLConnection *_URLConnection;
	NSMutableData *_activeDownload;
	
}

@property (nonatomic, assign) id <DownloadManagerDelegate> delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *fileURL;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) NSUInteger currentSize;
@property (nonatomic, copy) NSNumber *totalFileSize;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UIAlertView *progressAlertView;
@property (nonatomic, retain) NSURLConnection *URLConnection;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, copy) NSString *failedMessage;

- (void)start;
- (void)createProgressionAlertWithMessage:(NSString *)message;
- (void)writeToFile:(NSData *)data;

@end

@protocol DownloadManagerDelegate <NSObject>
- (void)downloadManagerDataDownloadFinished: (DownloadManager *)downloader;
- (void)downloadManagerDataDownloadFailed: (DownloadManager *)downloader;
@end





