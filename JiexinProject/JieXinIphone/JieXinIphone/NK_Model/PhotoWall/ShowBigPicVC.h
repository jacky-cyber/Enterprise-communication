//
//  ShowBigPicVC.h
//  JieXinIphone
//
//  Created by macOne on 14-4-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"
@interface ShowBigPicVC : UIViewController<UIScrollViewDelegate>


- (IBAction)goBack:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)goToInfo:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *view_01;
@property (retain, nonatomic) IBOutlet UIView *view_02;
@property (retain, nonatomic) IBOutlet UIImageView *imageView_01;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

//需要前面穿传过来的参数
@property (retain,nonatomic) NSMutableArray *dataSourceArray;//
@property (assign,nonatomic) int currentImagePage;//
//
@property (retain,nonatomic) UIActivityIndicatorView *active;
@property (retain,nonatomic) NSTimer *showTimer;
@property (retain,nonatomic) UIButton *btn_add;


//
@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;


@end
