//
//  DepartMem.m
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "DepartMem.h"


@implementation DepartMem
@synthesize userid = _userid,departmentid = _departmentid;
-(id)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    }
    self.departmentid = [attributes valueForKeyPath:@"departmentid"];
    self.userid = [attributes valueForKeyPath:@"userid"];
    return self;
}

-(void)dealloc
{
    self.departmentid = nil;
    self.userid = nil;
    [super dealloc];
}

@end
