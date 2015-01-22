//
//  LinkViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "NavPushDelegate.h"
#import "LinkDepartmentView.h"
#import "MailHelp.h"
#import "LinkDateCenter.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "LinkContactsView.h"


@interface LinkViewController : BaseViewController<NavPushDelegate,LinkDepartmentViewDelegate,MFMessageComposeViewControllerDelegate,ContactsListViewDelegate>
{
    UIImageView *topView;
    UIView *bgView;
    
    UIImageView *createView;
    UIButton *createGroupBtn;
    SelectedState state;
    
    UIButton *depBtn,*groupBtn,*contactBtn;
    UIButton *deleteBatch;
    UIButton *doneBtn;
    
    BOOL isFolded;
    
    NSMutableArray *personSelectedArr;
}

@property (nonatomic, retain) NSMutableArray *personSelectedArr;

- (void)pushToGroupChatView:(NSDictionary *)dic;

@end
