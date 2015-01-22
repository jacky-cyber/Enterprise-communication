//
//  CarDetailViewController.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JDatePickerView.h"
#import "SystemContactVC.h"


@interface CarDetailViewController : BaseViewController<UITextFieldDelegate,JDatePickerViewDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CarSelectDelegate>

{
    @private
    UIView    *baseView;//基视图
    UIButton  *_back_Btn;//返回按钮
    UILabel   *_titleLabel;//标题
    UILabel   *_heardLabel;//注

    UITextField   *textFlid;
    
    UIButton   *conmitBtn;//提交
    
    UIPickerView *_selectCar;
    
}
@property(nonatomic,retain)NSDictionary*m_datas;
@property (nonatomic, retain) NSArray *pickerArray;
@property (nonatomic, retain) NSArray *depArray;
@property (nonatomic, retain) NSMutableArray *userArray;

@property (nonatomic, retain) NSString *currentDepId;

//加载车辆申请表单视图
- (void)loadlistView;

//请求数据
- (void)requestData;

//设置提交数据内容
- (void)setTextFiledConnect;

@end



