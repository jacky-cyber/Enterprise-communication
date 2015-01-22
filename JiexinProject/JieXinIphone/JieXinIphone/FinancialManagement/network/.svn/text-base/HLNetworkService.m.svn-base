//
//  HLNetworkService.m
//  JieXinIphone
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "HLNetworkService.h"

@implementation HLNetworkService

+ (id)parsetData:(NSString *)name
{
    //获取到包文件的跟目录
    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
    
    //根据传入的名字拼接
    NSString *path = [sourcePath stringByAppendingPathComponent:name];
    
    //将路径下的数据读出来
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //判断版本解析数据
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    id result = nil;
    if ([version floatValue] >=5.0) {
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    }// 5.0之后解析方法
    else{
        result = [data objectFromJSONData];
    }// 5.0之前解析方法
    return result;
}// JSON数据解析
+ (id)testData
{
    
    return [self parsetData:@"test.json"];
}


@end
