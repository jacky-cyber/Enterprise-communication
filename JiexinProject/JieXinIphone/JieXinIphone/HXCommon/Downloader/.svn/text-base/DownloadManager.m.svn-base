
#import <UIKit/UIKit.h>
#import "DownloadManager.h"
//Raik temp 
#import "SDDataCache.h"

#define DELEGATE_CALLBACK(X, Y) if (self.delegate && [self.delegate respondsToSelector:@selector(X)]) [self.delegate performSelector:@selector(X) withObject:Y];
#define kIMGCancel @"cancel.png"
@implementation DownloadManager

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)start
{
	if (_fileURL == nil) {
		return;
	}
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_fileURL];
    //TO DO: == Raik 临时的
	NSData *oldData = [[SDDataCache sharedDataCache] dataFromKey:@"Cookie"];
	NSMutableArray *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];	
	NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookie];
	[request setAllHTTPHeaderFields:headers];
	[request setHTTPShouldHandleCookies:YES];
	//==

	self.URLConnection = [NSURLConnection connectionWithRequest:request delegate:self];
	if (_URLConnection) {
		[self createProgressionAlertWithMessage:_title];
	} else {
	}
}

#pragma mark Alert View Delegate Methods
-(void)cancelLoadAction:(UIButton *)sender{
	
	NSError *error;
	NSString *filePath=[NSString stringWithFormat:@"%@",_fileName];
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
	}
	[_progressAlertView dismissWithClickedButtonIndex:0 animated:YES];
	[_URLConnection cancel];
}

- (void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	if (buttonIndex == 0) {
		[self cancelLoadAction:nil];
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createProgressionAlertWithMessage:(NSString *)message 
{	
	self.progressAlertView = [[UIAlertView alloc] initWithTitle:message
														message:NSLocalizedString(@"Please wait...\n\n\n\n",nil) 
													   delegate:self 
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:nil];
    
	// Create the progress bar and add it to the alert
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f+10.0f, 225.0f, 90.0f)];
	self.progressView.userInteractionEnabled = NO;
    [_progressView setProgressViewStyle:UIProgressViewStyleBar];
	[_progressAlertView addSubview:_progressView];
	
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 90.0f+10.0f, 225.0f, 40.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.text = @"";
    label.tag = 101;
    [_progressAlertView addSubview:label];
	[label release];
	
//	UIButton *btnCancelLoad = [[UIButton alloc] initWithFrame:CGRectMake(235, 4, 38, 37)];
//	[btnCancelLoad setBackgroundColor:[UIColor clearColor]];
//	[btnCancelLoad setImage:[UIImage imageNamed:kIMGCancel] forState:UIControlStateNormal];
//	[btnCancelLoad setTitle:@"Cancle" forState:UIControlStateNormal];
//	[btnCancelLoad addTarget:self action:@selector(cancelLoadAction:) forControlEvents:UIControlEventTouchUpInside];
//	[_progressAlertView addSubview:btnCancelLoad];
//	[btnCancelLoad release];
	
    [_progressAlertView show];
	NSLog(@"frame %@",NSStringFromCGRect(self.progressView.frame));
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	self.currentSize = 0;
	self.activeDownload = [NSMutableData data];
    self.totalFileSize = [NSNumber numberWithLongLong:[response expectedContentLength]];
	
	// Check for bad connection
	if ([response expectedContentLength] < 0)
	{
		NSString *reason = [NSString stringWithFormat:@"Invalid URL [%@]", [_fileURL absoluteString]]; 
        self.failedMessage = reason;
		[connection cancel];
        DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:,self);
		return;
	}
	
	if ([response suggestedFilename])
		DELEGATE_CALLBACK(downloadManagerDidReceiveData:, [response suggestedFilename]);
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [self.activeDownload appendData:data];
	self.currentSize = self.currentSize + [data length];
	NSNumber *resourceLength = [NSNumber numberWithUnsignedInteger:self.currentSize];
	
    NSNumber *progress = [NSNumber numberWithFloat:([resourceLength floatValue] / [_totalFileSize floatValue])];
    self.progressView.progress = [progress floatValue];
	
    const unsigned int bytes = 1024 ;
    UILabel *label = (UILabel *)[_progressAlertView viewWithTag:101];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPositiveFormat:@"##0.00"];
    NSNumber *partial = [NSNumber numberWithFloat:([resourceLength floatValue] / bytes)];
    NSNumber *total = [NSNumber numberWithFloat:([_totalFileSize floatValue] / bytes)];
    label.text = [NSString stringWithFormat:@"%@ KB / %@ KB", [formatter stringFromNumber:partial], [formatter stringFromNumber:total]];
    [formatter release];
	
//	[self writeToFile:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    self.failedMessage = [error localizedFailureReason];
	[_progressAlertView dismissWithClickedButtonIndex:0 animated:YES];
    DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:, self);
}

-(void)writeToFile:(NSData *)data{
	NSString *filePath = [NSString stringWithFormat:@"%@",_fileName];
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO){
		[[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
	}
	FILE *file = fopen([_fileName UTF8String], [@"ab+" UTF8String]);
	if(file != NULL){
		fseek(file, 0, SEEK_END);
	}
	int readSize = [data length];
	fwrite((const void *)[data bytes], readSize, 1, file);
	fclose(file);
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self writeToFile:self.activeDownload];
    [_progressAlertView dismissWithClickedButtonIndex:0 animated:YES];
	DELEGATE_CALLBACK(downloadManagerDataDownloadFinished:, self);
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
}
///////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize fileURL = _fileURL;
@synthesize fileName = _fileName;
@synthesize currentSize = _currentSize;
@synthesize totalFileSize = _totalFileSize;
@synthesize progressView = _progressView;
@synthesize progressAlertView = _progressAlertView;
@synthesize URLConnection = _URLConnection;
@synthesize activeDownload = _activeDownload;
@synthesize failedMessage;
//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    NSLog(@"Downloader dealloc");
    _delegate = nil;
    [_title release];
    [_fileURL release];
    [_fileName release];
    [_totalFileSize release];
    [_progressView release];
    if(_progressAlertView)
    {
        [_progressAlertView dismissWithClickedButtonIndex:0 animated:NO];
        [_progressAlertView release];
    }
    if(_URLConnection)
    {
        [_URLConnection cancel];
        [_URLConnection release];
    }
	[_activeDownload release];
	
    [super dealloc];
}


@end








