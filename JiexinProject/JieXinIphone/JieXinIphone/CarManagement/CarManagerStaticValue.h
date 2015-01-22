//
//  NSObject_CarManagerStaticValue.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-4-16.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    Car_daishen = 0,
     Car_yiche,
    Car_weitong,
    Car_yishen,
    Car_yiwan   
}CarConlumType;

typedef enum
{
    Car_commitByLeader = 1,
    Car_commitByAdmin,
    Car_custom
}CarCommitType;

typedef enum
{
    Car_mobileType = 0,
    Car_DepType
}CarSelectType;
