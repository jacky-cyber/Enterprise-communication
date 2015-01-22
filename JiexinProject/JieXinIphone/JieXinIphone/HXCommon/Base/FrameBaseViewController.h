//
//  FrameBaseViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrameBaseViewController : UIViewController

@property (nonatomic,retain) UIButton *improvePersonalDataBt;
@property (nonatomic, assign) CGFloat iosChangeFloat;
@property (nonatomic, assign) int  index;
@property (nonatomic,retain) UIButton *newsPersonalDataBt;
@property(nonatomic,strong) NSTimer *showTimer;
@end
