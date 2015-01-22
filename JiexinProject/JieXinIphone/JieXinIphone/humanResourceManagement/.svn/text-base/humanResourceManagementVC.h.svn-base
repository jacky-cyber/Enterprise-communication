//
//  humanResourceVC1.h
//  JieXinIphone
//
//  Created by miaolizhuang on 14-6-3.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PullTableView.h"
#import "BaseViewController.h"
@interface humanResourceManagementVC : BaseViewController <UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

{
@private
    PullTableView *_listTable;
    UIImageView *_NavigaBG;
    NSArray     *_array;
    int totalPage;
}
@property(nonatomic,strong)NSMutableArray * fModeArr;
-(void)setRequestTag:(int)tag name:(NSString*)name;


@end
