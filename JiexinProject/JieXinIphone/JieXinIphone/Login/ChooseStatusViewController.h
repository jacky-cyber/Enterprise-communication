//
//  ChooseStatusViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStatusTitle @"kStatusTitle"
#define kStatusValue @"kStatusValue"


@protocol ChooseStatusDelegate <NSObject>

- (void) chooseStatusFinish:(NSDictionary *)dic;

@end

@interface ChooseStatusViewController : UITableViewController
@property (assign) id<ChooseStatusDelegate> delegate;


@end
