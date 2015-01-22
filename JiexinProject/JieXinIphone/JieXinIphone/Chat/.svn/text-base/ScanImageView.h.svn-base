//
//  ScanImageView.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "ImageDownloader.h"


@protocol DownImageFinishedDelegate <NSObject>

- (void)getImageBack:(UIImage *)image withImageDownloader:(ImageDownloader *)imageDownloader;

@end


@interface ScanImageView : UIView
@property (nonatomic, assign) id<DownImageFinishedDelegate> delegate;
@property (nonatomic, assign) NSString *msgid;

- (void)setOriginalImageWithUrl:(NSString *)url withSmallImageUrl:(NSString *)smallImageUrl;

@end
