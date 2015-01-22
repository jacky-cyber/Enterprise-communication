//
//  SendOtherViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-5-13.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"


@interface SendOtherViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

@property (nonatomic, retain) NSString *sendOtherMessage;

@end
