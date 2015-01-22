//
//  JButton.h
//  TheStationAgent
//
//  Created by Jeffrey on 14-1-8.
//  Copyright (c) 2014年 Jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
//按钮类型
enum ButtonType {
    BUTTONTYPE_BACK,//适合于返回控钮
    BUTTONTYPE_LEAD_TITLE ,  //适合日历中标题使用
    BUTTONTYPE_USER,//适合于日历中用户选择使用
    BUTTONTYPE_CALENDAR,//日历中使用的按钮
    BUTTONTYPE_ADD,
    BUTTONTYPE_ADDCALENDAR,
    BUTTONTYPE_USERSELECT,
    BUTTON_TYPE_DOWN
    
};
@interface JButton : UIButton{
    CGSize buttonSize;

}
@property(nonatomic,assign)CGSize buttonSize;//按钮大小
-(id)initButton:(NSString*)_title image:(NSString*)_image type:(enum ButtonType)_type fontSize:(int)_fontsize point:(CGPoint)_point tag:(int)_tags;//初始化按钮




@end
