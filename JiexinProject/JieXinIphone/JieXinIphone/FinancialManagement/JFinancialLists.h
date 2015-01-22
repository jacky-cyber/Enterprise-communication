//
//  JFinancialLists.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTitleLabel.h"
@protocol JFinancialListsDelegate<NSObject>
-(void)tapTheViewToSuper:(int)tag;
@end
@interface JFinancialLists : UIView
@property(nonatomic,retain)JTitleLabel*titleLabe;
@property(nonatomic,assign)id<JFinancialListsDelegate>delegate;
@property (nonatomic,strong) UILabel *redLabel;
-(void)setTitleLabel:(NSString*)title;
-(void)showOrHiddenRedLabel:(BOOL)flag;
@end
