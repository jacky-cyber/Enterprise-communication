//
//  JEditLeadPlanVC.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-30.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JAdminLeadPlanVC.h"

@interface JEditLeadPlanVC : JAdminLeadPlanVC
-(id)editLeadPlan:(NSString*)title type:(NSString*)type person:(NSArray*)person time:(NSArray*)time address:(NSString*)address remark:(NSString*)remark id:(NSString*)canlendarId;
@end
