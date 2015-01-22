//
//  ISTChatImageDowmLoad.h
//  JieXinIphone
//
//  Created by liqiang on 14-6-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISTChatImageDowmLoad;
@protocol ChatImageDownloaderDelegate <NSObject>


- (void)imageDownloaderFailWithError:(NSError *)error withDownLoader:(ISTChatImageDowmLoad *)downLoader;
- (void)setProgress:(CGFloat)progress;
- (void)imageDownloaderFinishWithImageData:(NSData *)imageDate withDownLoader:(ISTChatImageDowmLoad *)downLoader;

@end


@interface ISTChatImageDowmLoad : NSObject

@property (nonatomic, assign)id <ChatImageDownloaderDelegate> delegate;

@property (nonatomic, retain) NSString *msgid;
@property (nonatomic, retain) NSString *smallImageKey;

- (void)startDownLoadImageData:(NSString *)urlStr;
- (void)cancelDownLoad;


@end
