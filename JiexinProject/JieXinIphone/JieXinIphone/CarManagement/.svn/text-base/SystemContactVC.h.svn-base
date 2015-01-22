//
//  SystemContactVC.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14/6/10.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BaseViewController.h"

@protocol CarSelectDelegate <NSObject>

- (void)selectFinish:(NSInteger)index andType:(CarSelectType)type;

@end

@interface SystemContactVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    CarSelectType _type;
}

@property (nonatomic, retain) UITableView *listView;
@property (strong, nonatomic) NSMutableArray *source;
@property (nonatomic, assign) id<CarSelectDelegate>selectDelegate;

- (id)initWithData:(NSMutableArray *)array andType:(CarSelectType)type;

@end
