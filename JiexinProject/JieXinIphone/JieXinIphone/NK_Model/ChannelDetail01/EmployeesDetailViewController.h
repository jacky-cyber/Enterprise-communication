//
//  EmployeesDetailViewController.h
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface EmployeesDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSDictionary *dataDic;

@end
