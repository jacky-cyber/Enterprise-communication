//
//  ISTStaticDef.h
//  JieXinIphone
//
//  Created by tony on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#ifndef JieXinIphone_ISTStaticDef_h
#define JieXinIphone_ISTStaticDef_h

#define IOSVersion  [[[UIDevice currentDevice] systemVersion] floatValue]
#define kScreen_Height   [[UIScreen mainScreen] bounds].size.height
#define kScreen_Width    [[UIScreen mainScreen] bounds].size.width
#define kCommonCellHeight 40.0f
#define kCommonFont  15.0f
#define kLeftMargin   10.0f
#define kGroupCellHeight 60.0f
#define kSearchInfo @"输入姓名进行查询"

#define kReachChangeNotification  @"kReachChangeNotification"


//背景颜色
#define kMAIN_BACKGROUND_COLOR [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]

#define kDarkerGray [UIColor colorWithRed:35.0/255.0 green:24.0/255.0 blue:20.0/255.0 alpha:1.0]

#define kDarkGray [UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0]

#define klighterGray [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0]

#define klightGray [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0]

//主题颜色
#define kMAIN_THEME_COLOR [UIColor colorWithRed:0/255.0 green:149/255.0 blue:222/255.0 alpha:1.0]

#endif
