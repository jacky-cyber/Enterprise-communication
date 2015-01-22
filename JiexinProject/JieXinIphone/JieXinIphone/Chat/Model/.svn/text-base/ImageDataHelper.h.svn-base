//
//  ImageDataHelper.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLImage.h"

@interface ImageDataHelper : NSObject
+(ImageDataHelper *)sharedService;
- (void)storeWithImage:(UIImage *)image imageName:(NSString *)imageName;
//存储gif图的nsdata
- (void)storeWithGIFImageData:(NSData *)imageData imageName:(NSString *)imageName;

- (UIImage *)getImageWithName:(NSString *)imageName;
- (UIImage *)getChatDetailImageWithName:(NSString *)imageName;
- (OLImage *)getYLGifImage:(NSString *)imageName;

@end
