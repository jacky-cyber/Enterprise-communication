//
//  LinkDepartmentView.h
//  JieXinIphone
//
//  Created by tony on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LinkDepartmentView_normal = 1,//常规的
    LinkDepartmentView_select,//可选的
    LinkDepartmentView_search//带搜索框的
}LinkDepartmentViewStyle;

#import "CustomAlertView.h"
#import "IPhone_CustomListCell.h"
#import "LinkSearchResultViw.h"
#import "PullTableView.h"
@protocol LinkDepartmentViewDelegate;
@interface LinkDepartmentView : UIView<UITableViewDataSource,UITableViewDelegate,CustomeAlertViewDelegate,IPhone_CustomListCellDelegate,IPhone_CustomListCellIconDelegate,UITextFieldDelegate,PullTableViewDelegate,LinkSearchResultViwDelegate>
{
    NSMutableArray *choosedDepartments;
    CustomAlertView *_customAllertView;
}

@property(nonatomic,retain)LinkSearchResultViw *linkSearchResultView;
@property(nonatomic,retain)UITextField *searchTextField;
@property(nonatomic,retain)PullTableView *tableListView;
@property (nonatomic, retain) NSMutableArray *datasArray;
@property(nonatomic,retain)NSMutableArray *expandDepartArray;
@property(nonatomic,assign)id<LinkDepartmentViewDelegate> delegate;
@property(nonatomic,retain)NSMutableArray *choosedDepartments;
@property(nonatomic,retain)NSMutableArray *choosedUsers;
@property(nonatomic,assign)LinkDepartmentViewStyle linkViewStyle;
@property(nonatomic,retain)NSMutableArray *currentAdroidArray;
@property(nonatomic,retain)NSMutableArray *currentIPhoneArray;
@property(nonatomic,retain)NSMutableArray *currentBusyArray;
@property(nonatomic,retain)NSMutableArray *currentLeaveArray;
@property(nonatomic,retain)NSMutableArray *currentOnlineArray;
@property(nonatomic,retain)NSMutableArray *currentWebArray;
@property(nonatomic,retain) UIButton *headerButton;
@property(nonatomic,retain)NSString *adriodStr;
@property(nonatomic,retain)NSString *iphoneStr;
@property(nonatomic,retain)NSString *webStr;
@property(nonatomic,retain)NSString *busyStr;
@property(nonatomic,retain)NSString *leaveStr;
@property(nonatomic,retain)NSString *onlineStr;
@property(nonatomic,retain)Department *rootDepartment;//最顶上的Department
@property (nonatomic, retain) CustomAlertView *_customAllertView;;
@property(nonatomic,retain)NSMutableArray *currentAddArray;
//要转发的信息
@property (nonatomic, retain) NSString *sendOtherMessage;


- (id)initWithFrame:(CGRect)frame withLinkViewStyle:(LinkDepartmentViewStyle)linkStyle;
-(void)search:(UIButton *)sender;
-(void)showOrHideSearchViewWith:(BOOL)flag;
@end

@protocol LinkDepartmentViewDelegate <NSObject>
-(void)contactAlertViewWith:(id)object withStyel:(ContactBtnStyle)style;
-(void)groupChat:(Department *)deparment;
-(void)sendGroupMess:(Department *)department;
@end
