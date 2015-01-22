//
//  HeKaViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendCardDelegate <NSObject>

- (void)sendCardWith:(id)sender;

@end

@interface HeKaViewController : UIViewController

@property (nonatomic, assign) id<SendCardDelegate> delegate;

@end
