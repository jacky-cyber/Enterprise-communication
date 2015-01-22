//
//  documentSortViewController.h
//  JieXinIphone
//
//  Created by miaolizhuang on 14-4-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define statusBar      (CGFloat)(iOSVersion<7.0? 0:20)
#define navBar         (CGFloat)(iOSVersion<7.0? 0:44)

//@protocol fileInfoDataDelegate <NSObject>
//
//-(void)fileInfoData:(NSMutableArray*)array;
//
//@end
@interface documentSortViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic)int bntTag;
@property (nonatomic,strong)UITableView * sortTableView;
@property(nonatomic,strong)NSMutableArray * programaArray;
@property (nonatomic,strong)NSMutableArray * tableViewArray;
@property(nonatomic,strong)NSString * proid;
@property(nonatomic)int cnt;
@property(nonatomic,strong)NSMutableDictionary*proIdDic;
@property (nonatomic,strong)NSMutableArray * baseArr;
@property (nonatomic, assign) id sortDelegate;
@end
