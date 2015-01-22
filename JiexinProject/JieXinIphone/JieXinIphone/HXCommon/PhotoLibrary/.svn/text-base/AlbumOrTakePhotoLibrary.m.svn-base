//
//  AlbumOrTakePhotoLibrary.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AlbumOrTakePhotoLibrary.h"


@implementation AlbumOrTakePhotoLibrary

static AlbumOrTakePhotoLibrary *sharedInstance= nil;

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
