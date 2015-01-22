//
//  humanResourceManageCell.h
//  JieXinIphone
//
//  Created by miaolizhuang on 14-5-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myTitleLabel.h"
@protocol JFinancialListsDelegate<NSObject>
-(void)tapTheViewToSuper:(int)tag;
@end
@interface humanResourceLists : UIView
@property(nonatomic,retain)myTitleLabel*titleLabe;
@property(nonatomic,assign)id<JFinancialListsDelegate>delegate;
@property (nonatomic,strong) UILabel *redLabel;
-(void)setTitleLabel:(NSString*)title;
-(void)showOrHiddenRedLabel:(BOOL)flag;
@end
