//
//  LinkContactsView.h
//  JieXinIphone
//
//  Created by tony on 14-2-28.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TKAddressBook.h"
#import "ContactsBt.h"
#import "PullTableView.h"
@protocol ContactsListViewDelegate;

@interface LinkContactsView : UIView<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate,PullTableViewDelegate>

@property(nonatomic,retain)PullTableView *tableListView;
@property (nonatomic, retain) NSMutableArray *datasArray;
@property(nonatomic,retain)NSMutableArray *addressBookArray;
@property(nonatomic,retain)NSMutableArray *searchResultArray;
@property(nonatomic,assign)id<ContactsListViewDelegate> delegate;
-(void)initSubView;
-(void)getAddressBookDataModel;
- (void)whetherCanVisitAddressBook;
- (void)searchWithKey:(NSString *)keyStr;
@end

@protocol ContactsListViewDelegate <NSObject>
- (void)linkContactsCallPhone:(ContactsBt *)sender;
- (void)linkContactsSendEmail:(ContactsBt *)sender;
- (void)linkContactsSendSMS:(ContactsBt *)sender;
@end
