//
//  fileinfoModel.h
//  JieXinIphone
//
//  Created by lxrent02 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fileinfoModel : NSObject
//文档信息表
/*
 字段含义
 name               文件名称
 programaid         所属栏目
 title              文件标题
 filedesc           文件描述
 filesize           文件大小
 path               文件保存路径
 ext                文件类型
 pdfpath            PDF保存位置
 uploadtime         上传时间
 updatetime         更新时间
 uploaderid         上传用户ID
 groupid
 */
@property(nonatomic,strong)NSString*fileid;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*programaid;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*filedesc;
@property(nonatomic,strong)NSString*filesize;
@property(nonatomic,strong)NSString*path;
@property(nonatomic,strong)NSString*ext;
@property(nonatomic,strong)NSString*pdfpath;
@property(nonatomic,strong)NSString*uploadtime;
@property(nonatomic,strong)NSString*updatetime;
@property(nonatomic,strong)NSString*uploaderid;
@property(nonatomic,strong)NSString*groupid;
@property(nonatomic,strong)NSString*jpgStr;
@property(nonatomic,strong)NSString* jpgCount;

@end
