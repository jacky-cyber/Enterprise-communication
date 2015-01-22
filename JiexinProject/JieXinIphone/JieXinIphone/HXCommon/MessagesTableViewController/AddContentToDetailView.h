//
//  AddContentToDetailView.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-9.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    duanXin_BtnType = 100,
    heKa_BtnType,
    album_BtnType,
    camera_BtnType
    
}AddToDetailBtnTag;

@protocol AddContentDelegate <NSObject>

- (void)selectBtnTap:(AddToDetailBtnTag)tag;

@end

@interface AddContentToDetailView : UIView
@property (nonatomic, assign) id <AddContentDelegate> delegate;


@end
