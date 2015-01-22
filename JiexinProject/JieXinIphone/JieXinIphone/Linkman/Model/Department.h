//
//  Department.h
//  JieXinIphone
//
//  Created by tony on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Department : NSObject

@property(nonatomic,retain)NSString *departmentid;
@property(nonatomic,retain)NSString *departmentname;
@property(nonatomic,retain)NSString *parentid;
@property(nonatomic,retain)NSString *sort;
@property(nonatomic,assign)CGFloat seat;

@property(nonatomic,retain)NSArray *allSubUsers;//所有的子用户（包括儿子、孙子等的子用户）
@property(nonatomic,assign)BOOL isSelect;//是否选中
@property(nonatomic,assign)BOOL isExpand;//是否展开
@property(nonatomic,retain)NSArray *usersArray;//该部门该级别的人员
@property(nonatomic,retain)NSArray *departmentsArray;//该级别的部门
@property(nonatomic,assign)NSInteger allSubUserCount;//属于该部门的人员数
@property(nonatomic,assign)NSInteger subUserCount;//该部门下一级的人数
@property(nonatomic,assign)NSInteger onLineCount;//在线人数
-(id)initWithAttributes:(NSDictionary *)attributes;

@end
