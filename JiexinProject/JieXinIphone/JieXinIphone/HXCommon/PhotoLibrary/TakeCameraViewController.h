//
//  TakeCameraViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TakeDelegate
- (void)selectImage:(UIImage *)image withInfo:(id)info;
@end

@interface TakeCameraViewController : UIViewController
@property (nonatomic, assign)id<TakeDelegate> delegate;


@end
