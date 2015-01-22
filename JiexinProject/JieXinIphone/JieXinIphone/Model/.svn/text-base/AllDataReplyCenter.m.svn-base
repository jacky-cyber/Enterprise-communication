//
//  AllDataReplyCenter.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AllDataReplyCenter.h"
#import "GDataXMLNode.h"
#import "RegexKitLite.h"


@implementation AllDataReplyCenter

+ (void)dealDataWithXmlString:(NSString *)xmlString
{
    NSData *data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    SHXMLParser	*parser	= [[SHXMLParser alloc] init];
    NSDictionary *datas = [[parser parseData:data] objectForKey:@"JoyIM"];
        NSString *cmd = [datas objectForKey:@"cmd"];
    //发送数据
    [[NSNotificationCenter defaultCenter] postNotificationName:cmd
                                                        object:nil
                                                      userInfo:datas];
}
+ (void)dealDataWithXmlData:(NSData *)xmlData
{
    SHXMLParser	*parser	= [[SHXMLParser alloc] init];
    NSDictionary *datas = [[parser parseData:xmlData] objectForKey:@"JoyIM"];
    NSString *cmd = [datas objectForKey:@"cmd"];
    //发送数据
    [[NSNotificationCenter defaultCenter] postNotificationName:cmd
                                                        object:nil
                                                      userInfo:datas];
    [parser release];
}


//@interface NSDictionary(ApprovalPrivateXMLParser)
//
//+ (NSDictionary *)dictionaryWithApprovalListXMLElement:(GDataXMLElement *)rootElement;
//+ (NSDictionary *)dictionaryWithApprovalDetailXMLElement:(GDataXMLElement *)rootElement;
//+(NSDictionary *)dictionaryFromCommonLanguage:(GDataXMLElement *)rootElement;
//@end
//

@end
