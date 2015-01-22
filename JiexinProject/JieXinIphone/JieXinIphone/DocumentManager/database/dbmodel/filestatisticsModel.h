//
//  filestatisticsModel.h
//  JieXinIphone
//
//  Created by lxrent02 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface filestatisticsModel : NSObject

//文档统计表
/*
 字段含义
 fileid             文件ID
 downloadcount      下载数
 readcount          阅览数
 updatetime         更新时间
 
 */
@property(nonatomic,strong)NSString*fileid;
@property(nonatomic,strong)NSString*downloadcount;
@property(nonatomic,strong)NSString*readcount;
@property(nonatomic,strong)NSString*updatetime;

@end
