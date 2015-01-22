//
//  UIViewCtrl_System_Notify.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-4.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface UIViewCtrl_System_Notify : FrameBaseViewController <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate,UIScrollViewDelegate>

@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (strong, nonatomic) UIView *loadview_01;
@property (strong, nonatomic) UILabel *loadlabel_01;
@property (strong, nonatomic) UIActivityIndicatorView *loadindicator;
@property (strong, nonatomic) NSMutableArray *arrayData;

- (IBAction)onBtnReturn_Click:(id)sender;
- (void) receiveDataNotification:(NSNotification *) wParam;



@end
