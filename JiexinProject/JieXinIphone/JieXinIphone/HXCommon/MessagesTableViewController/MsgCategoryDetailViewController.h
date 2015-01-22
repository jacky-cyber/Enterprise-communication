//
//  MsgCategoryDetailViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgDelegate <NSObject>

- (void)selectMsgDetail:(NSDictionary *)infoDic;

@end

@interface MsgCategoryDetailViewController : FrameBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain)NSString *cateId;
@property (nonatomic, assign) id <MsgDelegate> delegate;
@property (nonatomic, retain) NSString *titleStr;

@end
