//
//  ToolUtil.h
//  JieXinIphone
//
//  Created by tony on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolUtil : NSObject

+ (UIImage *) convertToGrayStyle:(UIImage *)img;
+ (BOOL)validateMobile:(NSString *)mobileNum;

@end
