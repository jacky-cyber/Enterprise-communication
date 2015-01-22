//
//  NSDictionary+HttpXMLParser.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HttpXMLParser)

+ (NSDictionary *)httpDictionaryFromXML:(NSString *)xmlString withType:(HttpRequestType)type;

@end
