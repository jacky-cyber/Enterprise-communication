//
//  RotatePhotoViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-6-10.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol PhotoLibraryDelegate
- (void)selectImage:(UIImage *)image withInfo:(id)info;
@end


@interface RotatePhotoViewController : BaseViewController

@property (nonatomic, retain) UIImage *rotateImage;
@property (nonatomic, assign)id<PhotoLibraryDelegate> delegate;

- (void)fillRotateImageView:(UIImage *)rotateImage;

@end
