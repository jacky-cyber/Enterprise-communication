//
//  programaModel.h
//  JieXinIphone
//
//  Created by lxrent02 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface programaModel : NSObject
//栏目表
/*
 字段含义
 name           栏目名称
 upid           父栏目
 hassub         是否有子栏目
 plevel         栏目等级
 createtime     创建时间
 creater        创建人
 updatetime     更新时间
 deleted        删除标记0/1
 groupid
 */
@property(nonatomic,strong)NSString*fileid;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * upid;
@property(nonatomic,strong) NSString * hassub;
@property(nonatomic,strong) NSString * plevel;
@property(nonatomic,strong) NSString * createtime;
@property(nonatomic,strong) NSString * creater;
@property(nonatomic,strong) NSString * updatetime;
@property(nonatomic,strong) NSString * deleted;
@property(nonatomic,strong) NSString * groupid;
@end
