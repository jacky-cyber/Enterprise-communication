//
//  CDATAEncode.m
//  JieXinIphone
//
//  Created by liqiang on 14-4-22.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CDATAEncode.h"

@implementation CDATAEncode

+ (NSString *)encodeCDATAStr:(NSString *)str
{
    NSString *encodeStr = [str stringByReplacingOccurrencesOfString:@"<JoyIM>" withString:@"&lt;JoyIM&gt;"];
    encodeStr = [encodeStr stringByReplacingOccurrencesOfString:@"</JoyIM>" withString:@"&lt;/JoyIM&gt;"];
    encodeStr = [encodeStr stringByReplacingOccurrencesOfString:@"]]>" withString:@"]]&gt;"];
    return encodeStr;
}
+ (NSString *)decodeCDATAStr:(NSString *)str
{
    NSString *decodeStr = [str stringByReplacingOccurrencesOfString:@"&lt;JoyIM&gt;" withString:@"<JoyIM>"];
    decodeStr = [decodeStr stringByReplacingOccurrencesOfString:@"&lt;/JoyIM&gt;" withString:@"</JoyIM>"];
    decodeStr = [decodeStr stringByReplacingOccurrencesOfString:@"]]&gt;" withString:@"]]>"];
    return decodeStr;
}


@end
