//
//  DomumentShareController.h
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-3-31.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewController.h"
#import "BaseViewController.h"

@interface DomumentShareController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) IBOutlet UIButton *lastBtn;
@property (nonatomic,strong) IBOutlet UIButton *readmoreBtn;
@property (nonatomic,strong) IBOutlet UIButton *downmoreBtn;
@property (nonatomic,strong) IBOutlet UITextField *searchField;
@property (nonatomic,strong) IBOutlet UILabel *lineLabel;
@property (nonatomic,strong) IBOutlet UIImageView * searchImage;


@property (nonatomic,strong) id<tabbarStatuDelegate> delegate;
@property (nonatomic) NSInteger viewTag;

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong )NSMutableArray *variableArr;
@property (nonatomic,strong) NSMutableArray *baseArr;

@property (nonatomic) BOOL pageFlag;
@end
