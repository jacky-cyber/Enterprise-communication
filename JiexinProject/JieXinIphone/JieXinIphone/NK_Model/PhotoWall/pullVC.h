//
//  pullVC.h
//  JieXinIphone
//
//  Created by macOne on 14-3-7.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"



@interface pullVC : FrameBaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>


- (IBAction)goBack:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *view_01;
@property (retain, nonatomic) IBOutlet UIButton *addImagesBtn;

- (IBAction)addImagesAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *rightCorner_second;


@property (retain,nonatomic) NSMutableArray *dataSourceArray;
@property (assign,nonatomic) int page;
@property (assign,nonatomic) int page_number;
@property (assign,nonatomic) BOOL isCanLoadMore;

@property (assign,nonatomic) int currentImagePage;//放大后的滑动图

@property (retain,nonatomic) NSMutableDictionary *dic_cell;//保存cell的identify

@property (retain,nonatomic) UITextField *field_content;
@property (retain,nonatomic) UIImage *prepare_image;

@property (retain,nonatomic) UIImageView *imageView_xuanze;//上传图片时选择了图片之后现实图的imageview

@property (nonatomic,retain) UIImage *normalImage; //保留选择上传图片得最原始状态
@property (nonatomic,assign) int xuanzhuancount;//记录旋转次数

@end
