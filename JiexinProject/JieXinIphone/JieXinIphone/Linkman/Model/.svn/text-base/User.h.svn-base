//
//  User.h
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"
typedef enum
{
    User_online = 1,
    User_andriodOnLine,
    User_iphoneOnLine,
    User_webOnLine,
    User_busy,
    User_leave,
    User_hidden,
     User_offline
}UserStatusStyle;

@interface User : NSObject

@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *nickname;
@property(nonatomic,retain)NSString *sex;
@property(nonatomic,retain)NSString *telephone;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *mobile;
@property(nonatomic,retain)NSString *xuhao;
@property(nonatomic,retain)NSString *usersig;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSString *domainid;
@property(nonatomic,retain)NSString *sort;
@property(nonatomic,retain)NSString *field_char1;
@property(nonatomic,retain)NSString *field_char2;
@property(nonatomic,retain)NSString *field_int1;
@property(nonatomic,retain)NSString *field_int2;

@property(nonatomic,assign)UserStatusStyle userStatus;
@property(nonatomic,retain)Department *deparment;//用户所属的部门
@property(nonatomic,assign)CGFloat seat;//他的显示位置
@property(nonatomic,assign)BOOL isSelect;//是否选中

@property (nonatomic, retain)NSString *chineseStr;

@property (nonatomic, assign) NSInteger sortIntNum;

-(id)initWithAttributes:(NSDictionary *)attributes;
-(NSComparisonResult)compareSort:(id)element;//按sort排序
-(NSComparisonResult)compareUserStatus:(id)element;
@end
