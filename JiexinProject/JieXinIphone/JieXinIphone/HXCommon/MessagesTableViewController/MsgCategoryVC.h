//
//  MsgCategoryVC.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgCategoryDelegate <NSObject>

- (void)selectMsgDetail:(NSDictionary *)infoDic;

@end

@interface MsgCategoryVC : FrameBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) id <MsgCategoryDelegate> delegate;

@end
