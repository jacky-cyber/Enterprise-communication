//
//  AllDataReplyCenter.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllDataReplyCenter : NSObject

+ (void)dealDataWithXmlString:(NSString *)xmlString;
+ (void)dealDataWithXmlData:(NSData *)xmlData;


@end
