//
//  MethodsValue.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#define kScreen_Height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_Width   [[UIScreen mainScreen] bounds].size.width

#define kLocalDBPath   [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"LocalDB.db"]]

#define kRequestOfflineDate [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"kRequestOfflineDate"]
//#define kHomeDocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define kdocumentDBPath   [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"documentDB.db"]]

//存储网络的数据数据库版本
#define kLocalVersion [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],@"LocalVersion"]
//是否重新下载数据库的版本 （为改变表结构而生）
#define kLocalIsDownDb [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain],@"LocalIsDownDb"]




//rgb颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


//设备为IPHONE5
#define DEVICE_IPHONE5 [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO

//设备IOSVersion
#define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

//设备IOSVersion为6.0之后
#define iOSVersion_6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0

#define UIImageWithName(imageName) [UIImage imageNamed:imageName]

#define UIImageGetImageFromName(__POINTER) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__POINTER ofType:nil]]
//安全释放
#define RELEASE_SAFELY(_POINTER) if (nil != (_POINTER)){[_POINTER release];_POINTER = nil; }

