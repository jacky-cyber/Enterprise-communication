//
//  CustomTextView.h
//  PetParadise
//
//  Created by 张 云鹤 on 12-9-29.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
- (id)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)holder;
- (void)setPlaceholderStr:(NSString *)str;

@end
