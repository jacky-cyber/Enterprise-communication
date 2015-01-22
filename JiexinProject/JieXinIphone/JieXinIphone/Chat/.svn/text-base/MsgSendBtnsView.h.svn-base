//
//  MsgSendBtnsView.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-4.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgSendBtnsDelegate <NSObject>

- (void)msgBtnTap;
- (void)duanxinBtnTap;
- (void)clearUnReadCountImageView;

@end


@interface MsgSendBtnsView : UIView

@property (nonatomic, retain) UIButton *msgBtn;
@property (nonatomic, retain) UIButton *duanxinBtn;
@property (nonatomic, assign) id <MsgSendBtnsDelegate> delegate;

- (void)setUnReadCountView:(NSInteger)count;

@end
