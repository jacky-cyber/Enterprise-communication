//
//  LinkMakeGroupViewController.h
//  JieXinIphone
//
//  Created by tony on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LinkDepartmentView.h"
#import <MessageUI/MFMessageComposeViewController.h>

typedef enum
{
    MultiDuanxin_type = 10,//群发短信
    MultiChat_type, //群聊天
    SendOther_type,  //转发图片
}SendMessageType;

@interface LinkMakeGroupViewController : BaseViewController<LinkDepartmentViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    NSMutableArray *personSelectedArr;
}

@property (nonatomic, retain) NSMutableArray *personSelectedArr;
@property (nonatomic, retain)  NSMutableArray *choosedUsers;
@property(nonatomic,assign)SendMessageType sendType;//进入当前页面是否是群发短信
@property (nonatomic, retain) NSString *sendOtherMessage;

@end
