//
//  LinkSearchResultViw.h
//  JieXinIphone
//
//  Created by tony on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomAlertView.h"
#import "IPhone_CustomListCell.h"
@protocol LinkSearchResultViwDelegate;

@interface LinkSearchResultViw : UIView<UITableViewDataSource,UITableViewDelegate,CustomeAlertViewDelegate,IPhone_CustomListCellIconDelegate,UITextFieldDelegate>
{
    CustomAlertView *_customAllertView;
}

@property(nonatomic,retain)UITableView *tableListView;
@property (nonatomic, retain) NSMutableArray *datasArray;
@property(nonatomic,retain)NSMutableArray *tableDatasArray;
@property(nonatomic,assign)id<LinkSearchResultViwDelegate> delegate;
@property (nonatomic, retain) CustomAlertView *_customAllertView;
@property(nonatomic,retain)NSString *adriodStr;
@property(nonatomic,retain)NSString *iphoneStr;
@property(nonatomic,retain)NSString *webStr;
@property(nonatomic,retain)NSString *busyStr;
@property(nonatomic,retain)NSString *leaveStr;
@property(nonatomic,retain)NSString *onlineStr;

-(void)reloadResultView;
@end

@protocol LinkSearchResultViwDelegate <NSObject>
-(void)contactSearchResultAlertViewWith:(id)object withStyel:(ContactBtnStyle)style;
-(void)groupChat:(Department *)deparment;
-(void)sendGroupMess:(Department *)department;
@end