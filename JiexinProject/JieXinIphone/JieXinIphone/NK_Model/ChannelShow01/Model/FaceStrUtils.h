//
//  FaceStrUtils.h
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KFacialSizeWidth    20
#define KFacialSizeHeight   20
#define KCharacterWidth     8


#define VIEW_LINE_HEIGHT    24
#define VIEW_LEFT           0
#define VIEW_RIGHT          10
#define VIEW_TOP            0


@interface FaceStrUtils : NSObject
{
    CGFloat upX;
    
    CGFloat upY;
    
    CGFloat lastPlusSize;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
    BOOL isLineReturn;

}
@property (nonatomic) int VIEW_WIDTH_MAX;
@property (nonatomic) int contentHeight;

-(int)getFaceStrViewHeight:(NSString *)str withWidth:(int)w;
@end
