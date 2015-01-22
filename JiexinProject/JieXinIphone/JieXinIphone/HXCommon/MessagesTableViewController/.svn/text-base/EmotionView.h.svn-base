//
//  EmotionView.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmotionDelegate <NSObject>

- (void)selectEmotionFinish:(NSDictionary *)infoDic;

@end

@interface EmotionView : UIView

@property (nonatomic, retain) NSMutableArray *imagesNameArr;
@property (nonatomic, retain) NSMutableDictionary *imageNameDic;
@property (nonatomic, retain) UIScrollView  *bgScrollView;
@property (nonatomic, assign) id <EmotionDelegate> delegate;


@end
