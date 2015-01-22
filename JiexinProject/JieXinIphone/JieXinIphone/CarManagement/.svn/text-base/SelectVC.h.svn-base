//
//  SelectVC.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14/6/11.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol SelectDelegate <NSObject>

- (void)selectFinished:(NSInteger)index andType:(SelectType)type;

@end

@interface SelectVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    SelectType _type;
}

@property (nonatomic, retain) UITableView *listView;
@property (strong, nonatomic) NSArray *source;
@property (nonatomic, assign) id<SelectDelegate>selectDelegate;

- (id)initWithData:(NSMutableArray *)array andType:(SelectType)type;

@end
