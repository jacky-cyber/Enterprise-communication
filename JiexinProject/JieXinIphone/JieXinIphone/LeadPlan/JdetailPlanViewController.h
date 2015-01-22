//
//  JdetailPlanViewController.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "JReceiceLeadPlan.h"
@interface JdetailPlanViewController : BaseViewController<UIAlertViewDelegate>

@property(nonatomic,retain)JReceiceLeadPlan *receiceLead;
@property(nonatomic,retain)NSString*userId,*day;
-(id)initWithId:(NSString*)userId day:(NSString*)day;

@end
