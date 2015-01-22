//
//  Department.m
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "Department.h"

@implementation Department

@synthesize departmentid = _departmentid,departmentname = _departmentname,parentid = _parentid,sort = _sort,seat = _seat,isExpand  = _isExpand,departmentsArray = _departmentsArray,usersArray = _usersArray,allSubUserCount,subUserCount,onLineCount,isSelect = _isSelect;

-(id)init
{
    self=[super init];
    if(!self){
        return nil;
    }
    NSArray *tempArray = [[NSArray alloc] init];
    self.departmentsArray = tempArray;
    [tempArray release];
    
    NSArray *temp1Array = [[NSArray alloc] init];
    self.usersArray = temp1Array;
    [temp1Array release];
    
    NSArray *temp2Array = [[NSArray alloc] init];
    self.allSubUsers = temp2Array;
    [temp2Array release];
    
    _isExpand = NO;
    return self;
}

-(id)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    }
    self.departmentid = [attributes valueForKeyPath:@"departmentid"];
    self.departmentname = [attributes valueForKeyPath:@"departmentname"];
    self.parentid = [attributes valueForKeyPath:@"parentid"];
    self.sort = [attributes valueForKeyPath:@"sort"];
    return self;
}

-(void)dealloc
{
    self.departmentname = nil;
    self.departmentid = nil;
    self.departmentsArray = nil;
    self.usersArray = nil;
    self.allSubUsers = nil;
    self.parentid = nil;
    self.sort = nil;
    [super dealloc];
}

@end
