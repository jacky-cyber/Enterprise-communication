//
//  CustomMethod.h
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "OHAttributedLabel.h"
#import "SCGIFImageView.h"
#import "ChatMessagesFeed.h"

#define StartImageContent @"<MsG-PiCtUre>"
#define EndImageContent @"</MsG-PiCtUre>"
#define kLocalImageStart @"localImageWithOutUpLoad"
@interface CustomMethod : NSObject

+ (NSString *)escapedString:(NSString *)oldString;
+ (void)drawImage:(ChatMessagesFeed *)feed;
+ (NSMutableArray *)addHttpArr:(NSString *)text;
+ (NSMutableArray *)addPhoneNumArr:(NSString *)text;
+ (NSMutableArray *)addEmailArr:(NSString *)text;
+ (NSString *)transformString:(NSString *)originalStr  emojiDic:(NSDictionary *)_emojiDic;
+ (void)drawImage:(OHAttributedLabel *)label withView:(UIView *)view;
+ (NSArray *)getImageArrFromMessage:(NSString *)message;

@end
