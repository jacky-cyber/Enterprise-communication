//
//  AlbumOrTakePhotoLibrary.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageSelectDelegate
- (void)selectImage:(UIImage *)image withInfo:(id)info;
@end

@interface AlbumOrTakePhotoLibrary : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign)id<ImageSelectDelegate> delegate;

+ (id)allocWithZone:(NSZone *)zone;
- (void)choosePhotoFromAlbum;
- (void)choosePhotoFromTakePhotos;
@end
