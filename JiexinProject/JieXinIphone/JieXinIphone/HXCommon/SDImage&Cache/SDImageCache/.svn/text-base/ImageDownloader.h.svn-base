//
//  UIImage+WebCache.h
//  SunboxSoft
//
//  Created by 雷 克 on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"
#import "SDImageCache.h"

@protocol ImageDownloaderDelegate;
@interface ImageDownloader:NSObject <SDWebImageManagerDelegate>
{
//    int index;
//    id <ImageDownloaderDelegate> delegate;
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger idNum;//代表某条消息
@property (nonatomic, retain) NSString *msgid;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, retain) NSString *imageKey;
@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

- (void)setImageWithURL:(NSURL *)url;
- (void)cancelCurrentImageLoad;

@end

@protocol ImageDownloaderDelegate <NSObject>

- (void)getImageBack:(UIImage *)image withImageDownloader:(ImageDownloader *)imageDownloader;

- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error;
@end
