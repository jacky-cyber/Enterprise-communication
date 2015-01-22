//
//  CarOrderVC.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-4.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol  GoBackDelegate <NSObject>

- (void)doRefreshAfterBack;

@end
@interface CarOrderVC : BaseViewController

@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UIButton  *back_Btn;
@property(nonatomic,strong)UIButton  *actionBtn;
@property(nonatomic,strong)UILabel   *titleLabel;

@property (nonatomic, retain) NSString *formId;


- (id)initWithFormId:(NSString *)formid andType:(CarCommitType)type andConlum:(CarConlumType)conlum;

@end
