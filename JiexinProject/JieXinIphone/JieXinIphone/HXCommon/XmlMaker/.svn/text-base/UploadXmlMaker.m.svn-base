//
//  UploadXmlMaker.m
//  SunboxApp_Standard_IPad
//
//  Created by liqiang on 13-11-22.
//  Copyright (c) 2013年 Raik. All rights reserved.
//

#import "UploadXmlMaker.h"


@implementation UploadXmlMaker
+ (NSString *)getXmlStrFromArr:(NSMutableArray *)paramArr
{
    NSString *xmlString = [self getXmlString:paramArr];
    xmlString = [NSString stringWithFormat:@"<JoyIM>\n%@\n</JoyIM>",xmlString];
    return xmlString;
}

+ (NSString *)getXmlString:(NSMutableArray *)arr
{
    NSString *xmlString = nil;
    
    for(NSDictionary *multiDic in arr)
    {
        NSString *key = [[multiDic allKeys] objectAtIndex:0];
        NSString *value = [multiDic objectForKey:key];
        
        if (!xmlString)
        {
            xmlString = [NSString stringWithFormat:@"<%@>%@</%@>",key,value,key];
        }
        else
        {
            xmlString = [NSString stringWithFormat:@"%@\n<%@>%@</%@>",xmlString,key,value,key];
        }
        
    }
    return xmlString;
}


@end
