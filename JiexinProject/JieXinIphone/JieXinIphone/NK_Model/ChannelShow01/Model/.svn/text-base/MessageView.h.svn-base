//
//  MessageView.h
//  FaceBoardDome
//
//  Created by kangle1208 on 13-12-12.
//  Copyright (c) 2013年 Blue. All rights reserved.
//


#import <UIKit/UIKit.h>

#define KFacialSizeWidth    20
#define KFacialSizeHeight   20
#define KCharacterWidth     8


#define VIEW_LINE_HEIGHT    24
#define VIEW_LEFT           0
#define VIEW_RIGHT          10
#define VIEW_TOP            0
//#define VIEW_WIDTH_MAX      244

@interface MessageView : UIView {

    CGFloat upX;

    CGFloat upY;

    CGFloat lastPlusSize;

    CGFloat viewWidth;

    CGFloat viewHeight;

    BOOL isLineReturn;
    
}

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic) BOOL isFromMe;
@property (nonatomic) int VIEW_WIDTH_MAX;

- (void)showMessage:(NSArray *)message withWidth:(int)w;

@end
