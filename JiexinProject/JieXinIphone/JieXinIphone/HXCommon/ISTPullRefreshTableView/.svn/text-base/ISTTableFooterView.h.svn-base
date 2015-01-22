//
//  ISTTableFooterView.h
//  ISTPetsV2
//
//  Created by 陈 爱彬 on 13-3-6.
//  Copyright (c) 2013年 陈 爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ISTPullRefreshStateNormal = 0,  //正常
    ISTPullRefreshStatePulling,     //拉动中
    ISTPullRefreshStateLoading,     //加载中
    ISTPullRefreshStateTheEnd,      //到底了
}ISTPullRefreshState;

@interface ISTTableFooterView : UIView

@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) UILabel *infoLabel;
@property (nonatomic,assign) ISTPullRefreshState state;
@property (nonatomic,assign) BOOL loading;

- (void)stopLoadAnimation;
- (void)setFlashMessage:(NSString *)_msg withShowActivityIndicator:(BOOL)_bool;
- (void)setState:(ISTPullRefreshState)state;

@end
