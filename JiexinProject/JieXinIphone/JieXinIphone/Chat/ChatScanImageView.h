//
//  ChatScanImageView.h
//  JieXinIphone
//
//  Created by liqiang on 14-6-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatScanImageViewDelegate <NSObject>

- (void)sendOtherImage:(NSString *)imageStr;
- (void)getSmallImageBack:(UIImage *)smallImage witMsgId:(NSString *)msgId;

@end
@interface ChatScanImageView : UIView

@property (nonatomic, assign) id <ChatScanImageViewDelegate> delegate;
- (void)setcontentImagesArr:(NSMutableArray *)imageArr  withNowIndex:(NSInteger)index;
@end
