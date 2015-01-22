//
//  FinancialManagementVC.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-3-31.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PullTableView.h"
@interface FinancialManagementVC : BaseViewController <UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

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
