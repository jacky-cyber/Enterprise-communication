//
//  PicInfoVC.h
//  JieXinIphone
//
//  Created by macOne on 14-3-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentButton.h"
//
#import "CustomAlertView.h"
//
@interface PicInfoVC : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,CustomeAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UIView *view_01;

@property (retain,nonatomic) NSMutableArray *dataSourceArray_picInfo;//图片的相关信息
@property (assign,nonatomic) int currentImagePage_picInfo;
- (IBAction)goBack:(id)sender;
- (IBAction)chatAction:(id)sender;

@property(retain,nonatomic) NSMutableArray *array_oneOfcomment;//保存当前页的评论系信息
@property(retain,nonatomic) UIScrollView *aScrollView;

@property(retain,nonatomic) NSMutableDictionary *allDictionary;//保存了所有界面的数据 通过@"1",@"2",...

@property(retain,nonatomic) NSString *contentStr;//评论的内容

@property(assign,nonatomic) int commentCount;//标记回复的哪一个的(0:图片的。从1开始是下面回复的)
@property(retain,nonatomic) UITextField *textField_content;//

@property(assign,nonatomic) int under_timeY;//标记评论开始的y值

@end
