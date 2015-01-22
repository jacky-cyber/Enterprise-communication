//
//  ImageLibrary.h
//  CMBC_iPad_Project
//
//  Created by Raik on 13-11-2.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TakeCameraViewController.h"

@protocol PhotoLibraryDelegate
- (void)selectImage:(UIImage *)image withInfo:(id)info;
@end


@interface PhotoLibrary : NSObject<UIActionSheetDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TakeDelegate>
{
    id<PhotoLibraryDelegate> _delegate;
}
@property (nonatomic, assign)id<PhotoLibraryDelegate> delegate;
@property (nonatomic, retain)UIPopoverController *photoLibraryPopover;
@property (nonatomic, assign)CGRect popFrame;
@property (nonatomic, retain)TakeCameraViewController *takeCamera;

+ (id)allocWithZone:(NSZone *)zone;
- (void)settingDelegate:(id)theDelegate popAt:(CGRect)frame;
- (void)choosePhoto;

- (void)takePhotoWithCamera;

- (void)choosePhotoFromLibrary;
- (void)takePhotoWithCamera;

@end
