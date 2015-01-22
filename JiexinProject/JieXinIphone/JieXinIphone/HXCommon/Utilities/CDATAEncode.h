//
//  CDATAEncode.h
//  JieXinIphone
//
//  Created by liqiang on 14-4-22.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDATAEncode : NSObject

+ (NSString *)encodeCDATAStr:(NSString *)str;
+ (NSString *)decodeCDATAStr:(NSString *)str;


@end
