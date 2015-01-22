//
//  ISTChatImageDowmLoad.m
//  JieXinIphone
//
//  Created by liqiang on 14-6-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ISTChatImageDowmLoad.h"

@interface ISTChatImageDowmLoad()
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) NSNumber *totalFileSize;

@end

@implementation ISTChatImageDowmLoad

- (void)dealloc
{
    self.connection = nil;
    self.imageData = nil;
    self.totalFileSize  = nil;
    self.delegate = nil;
    self.msgid = nil;
    self.smallImageKey = nil;
    [super dealloc];
}

- (void)startDownLoadImageData:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO] autorelease];
    [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_connection start];
    [request release];
    
    if (_connection)
    {
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(imageDownloaderFailWithError: withDownLoader:)])
        {
            [self.delegate performSelector:@selector(imageDownloaderFailWithError: withDownLoader:) withObject:self withObject:nil];
        }
    }
}

- (void)cancelDownLoad
{
    if (_connection)
    {
        [_connection cancel];
        self.connection = nil;
    }
}

#pragma mark NSURLConnection (delegate)

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.imageData = [NSMutableData data];
    self.totalFileSize = [NSNumber numberWithLongLong:[response expectedContentLength]];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
    NSNumber *resourceLength = [NSNumber numberWithUnsignedInteger:[_imageData length]];
    if ([self.delegate respondsToSelector:@selector(setProgress:)]) {
        NSNumber *progress = [NSNumber numberWithFloat: [resourceLength floatValue]/[_totalFileSize floatValue]];
        [self.delegate setProgress:[progress floatValue]];
    }

}

- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes
{
    if ([self.delegate respondsToSelector:@selector(setProgress:)]) {
        [self.delegate setProgress:totalBytesWritten/expectedTotalBytes];
    }
}

#pragma GCC diagnostic ignored "-Wundeclared-selector"
- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    self.connection = nil;
    if ([self.delegate respondsToSelector:@selector(imageDownloaderFinishWithImageData: withDownLoader:)])
    {
        [self.delegate imageDownloaderFinishWithImageData:_imageData withDownLoader:self];
        self.imageData = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(imageDownloaderFailWithError: withDownLoader:)])
    {
        [self.delegate imageDownloaderFailWithError:nil withDownLoader:self];
        self.connection = nil;
        self.imageData = nil;
    }
}



@end
