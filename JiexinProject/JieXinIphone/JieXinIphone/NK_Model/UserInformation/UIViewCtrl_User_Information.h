//
//  UIView_User_Information.h
//  JieXinIphone
//
//  Created by gabriella on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@interface UIViewCtrl_User_Information : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSInteger nRunCount;
    NSInteger nSuccessCount;
    NSInteger nFailCount;
    NSMutableArray *arr_quert;
}


@property (strong, nonatomic) NSString *m_sSignatureText;

@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UIView *view_02;
@property (assign, nonatomic) IBOutlet UIView *view_03;
@property (assign, nonatomic) IBOutlet UIView *view_04;
@property (assign, nonatomic) IBOutlet UIView *view_05;
@property (assign, nonatomic) IBOutlet UIScrollView *scrollview_01;
@property (assign, nonatomic) IBOutlet UILabel *label_01;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_01;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_02;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_03;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_04;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_05;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_06;
@property (assign, nonatomic) IBOutlet UITextField *viewfield_07;

@property (assign, nonatomic) IBOutlet UISegmentedControl *segmentctrl_01;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_01;

@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UIButton *button_02;
@property (assign, nonatomic) IBOutlet UIButton *button_03;
@property (assign, nonatomic) IBOutlet UIButton *button_04;
@property (assign, nonatomic) IBOutlet UIButton *button_05;


- (IBAction)onBtnReturn_Click:(id)sender;
- (IBAction)Close_KeyBroad:(id)sender;
- (IBAction)onTextField_BeginEdit:(id)sender;
- (IBAction)onTextField_EndEdit:(id)sender;
- (IBAction)onTextField_ValueChange;
- (IBAction)onBtnOpen_MySign:(id)sender;
- (IBAction)onBtnSave_Click:(id)sender;
- (IBAction)onBtnCloseMenu_Click:(id)sender;
- (IBAction)onBtnShowHead_Click:(id)sender;
- (IBAction)onBtnModifyHead_LongClick:(id)sender;
- (IBAction)onBtnCamera_Click:(id)sender;
- (IBAction)onBtnPhotoLibrary_Click:(id)sender;
- (IBAction)onBtnMyPhotos_Click:(id)sender;


-(NSString *)getDomaiId;
- (void) UPloadFiles:(NSString *) wPara withImage:(UIImage *)image;

- (void) ON_NOTIFICATION:(NSNotification *) wParam;

@end
