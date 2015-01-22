//
//  JDetailForCommunistVC.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-3-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface JDetailForCommunistVC : BaseViewController<UIAlertViewDelegate>
@property(nonatomic,retain)NSDictionary *content;
@property(nonatomic,retain)NSURL* contentUrl;
@property(nonatomic,copy)NSString*courseId;
@end
