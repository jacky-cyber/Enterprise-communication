//
//  ChatHistoryViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "ChatConversationListFeed.h"
#import "PullTableView.h"
#import "ChatDataHelper.h"
#import "ChatMessagesFeed.h"


@interface ChatHistoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) ChatConversationListFeed *conFeed;
@property (retain, nonatomic) NSMutableArray *messageDetailList;


@end
