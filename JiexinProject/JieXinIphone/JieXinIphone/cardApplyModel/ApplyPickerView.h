//
//  ApplyPickerView.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerConfirmDelegate <NSObject>

- (void)itemSelected:(NSDictionary *)item andView:(UIView *)view;
- (void)itemCanceled;

@end

@interface ApplyPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, retain) UIPickerView *selectPicker;
@property (nonatomic, retain) NSArray *source;
@property (nonatomic, assign) id<PickerConfirmDelegate> pickerdelegate;

- (id)initWithFrame:(CGRect)frame andSourceData:(NSArray *)array;

@end
