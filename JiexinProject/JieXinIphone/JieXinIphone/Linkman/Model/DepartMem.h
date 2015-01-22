//
//  DepartMem.h
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

/*
   部门和用户的关系表
 */
#import <Foundation/Foundation.h>

@interface DepartMem : NSObject

@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *departmentid;

-(id)initWithAttributes:(NSDictionary *)attributes;

@end
