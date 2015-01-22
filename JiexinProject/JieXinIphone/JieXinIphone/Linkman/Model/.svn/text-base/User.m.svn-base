//
//  User.m
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userid = _userid,nickname = _nickname,sex = _sex,telephone = _telephone,xuhao = _xuhao,usersig = _usersig,username = _username,domainid = _domainid,sort = _sort,email = _email,mobile = _mobile,seat = _seat,field_char1 = _field_char1,field_char2 = _field_char2,field_int1 = _field_int1,field_int2 = _field_int2,deparment = _deparment,userStatus = _userStatus;

-(id)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    }
    self.userid = [attributes valueForKeyPath:@"userid"];
    self.nickname = [attributes valueForKeyPath:@"nickname"];
    self.sex = [attributes valueForKeyPath:@"sex"];
    self.telephone = [attributes valueForKeyPath:@"telephone"];
    self.xuhao = [attributes valueForKeyPath:@"xuhao"];
    self.usersig = [attributes valueForKeyPath:@"usersig"];
    self.username = [attributes valueForKeyPath:@"username"];
    self.domainid = [attributes valueForKeyPath:@"domainid"];
    self.sort = [attributes valueForKeyPath:@"sort"];
    self.email = [attributes valueForKeyPath:@"email"];
    self.mobile = [attributes valueForKeyPath:@"mobile"];
    return self;
}

-(void)dealloc
{
    self.deparment = nil;
    self.field_int2 = nil;
    self.field_int1 = nil;
    self.field_char1 = nil;
    self.field_char2 = nil;
    self.userid = nil;
    self.nickname = nil;
    self.sex = nil;
    self.telephone = nil;
    self.xuhao = nil;
    self.usersig = nil;
    self.username = nil;
    self.domainid = nil;
    self.sort = nil;
    self.email = nil;
    self.mobile = nil;
    self.chineseStr = nil;
    [super dealloc];
}

-(NSComparisonResult)compareSort:(id)element{
    return [self.sort compare:[element sort]];
}

-(NSComparisonResult)compareUserStatus:(id)element
{
    return [[NSNumber numberWithInt:[element userStatus]] compare:[NSNumber numberWithInt:self.userStatus]];
}

@end
