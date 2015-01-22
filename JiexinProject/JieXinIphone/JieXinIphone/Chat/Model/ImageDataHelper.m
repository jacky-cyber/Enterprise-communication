//
//  ImageDataHelper.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ImageDataHelper.h"

@interface ImageDataHelper()

@property(nonatomic, retain)NSString *storeChatImagePath;

@end

@implementation ImageDataHelper

+ (id) sharedService
{
	static ImageDataHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[ImageDataHelper alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    self.storeChatImagePath = nil;
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.storeChatImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
        [self initCache];
	}
	return self;
}

-(void)initCache
{
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:sImagePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:sImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


#pragma mark - 设置存取的方法

- (void)storeWithImage:(UIImage *)image imageName:(NSString *)imageName
{
    NSData * imageData = UIImageJPEGRepresentation(image, 0.5f);
    imageName = [imageName md5];
    NSString* fullPathToFile = [self.storeChatImagePath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

- (void)storeWithGIFImageData:(NSData *)imageData imageName:(NSString *)imageName
{
    imageName = [imageName md5];
    NSString* fullPathToFile = [self.storeChatImagePath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}


- (UIImage *)getImageWithName:(NSString *)imageName
{
    imageName = [imageName md5];
    NSString* fullPathToFile = [self.storeChatImagePath stringByAppendingPathComponent:imageName];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    if (image_01) {
        return image_01;
    }
    return nil;
}

- (UIImage *)getChatDetailImageWithName:(NSString *)imageName
{
    imageName = [imageName md5];
    NSString* fullPathToFile = [self.storeChatImagePath stringByAppendingPathComponent:imageName];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    if (image_01) {
        return image_01;
    }
    else
    {
        return [UIImage imageNamed:@"messageloading.png"];
    }
    return nil;
}

- (OLImage *)getYLGifImage:(NSString *)imageName
{
    imageName = [imageName md5];
    NSString* fullPathToFile = [self.storeChatImagePath stringByAppendingPathComponent:imageName];
    OLImage *image_01 = [OLImage imageWithContentsOfFile:fullPathToFile];
    if (image_01) {
        return image_01;
    }
    return nil;
}



@end
