//
//  JReceiceLeadPlan+JGetUrlForLeadPlan.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JReceiceLeadPlan.h"
#import "ASIHTTPRequest.h"

@interface JReceiceLeadPlan (JGetUrlForLeadPlan)<ASIHTTPRequestDelegate>

+(NSDictionary*)checkLeadPlanRequestUrlType:(enum requestTypes)requestTyep info:(NSDictionary*)dic;

@end
