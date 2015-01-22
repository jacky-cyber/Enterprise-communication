//
//  ChatDetailImageBtn.h
//  JieXinIphone
//
//  Created by liqiang on 14-5-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessagesFeed.h"

@interface ChatDetailImageBtn : UIButton

@property (nonatomic, retain) NSString *imageStr;
@property (nonatomic, retain) ChatMessagesFeed *feed;

@end
