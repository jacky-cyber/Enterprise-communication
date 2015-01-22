//
//  OLImageView.h
//  OLImageViewDemo
//
//  Created by Diego Torres on 9/5/12.
//  Copyright (c) 2012 Onda Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISTChatImageDowmLoad.h"

@protocol DownLoadImageFinishedDelegate <NSObject>

- (void)getSmallImageBack:(UIImage *)smallImage  witMsgId:(NSString *)msgId;
@end


@interface OLImageView : UIImageView



/**
 The animation runloop mode.
 
 The default mode (NSDefaultRunLoopMode), causes the animation to pauses while it is contained in an actively scrolling `UIScrollView`. Use NSRunLoopCommonModes if you don't want this behavior.
 */
@property (nonatomic, copy) NSString *runLoopMode;
@property (nonatomic, assign) id<DownLoadImageFinishedDelegate> delegate;

@property (nonatomic, copy) NSString *bigImageKey;
@property (nonatomic, copy) NSString *smallImageKey;
@property (nonatomic, assign) NSString *msgid;
@property (nonatomic, strong) ISTChatImageDowmLoad *theDownloader;


- (void)startDownLoad;
@end
