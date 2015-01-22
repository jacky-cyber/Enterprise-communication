//
//  JButton.m
//  TheStationAgent
//
//  Created by Jeffrey on 14-1-8.
//  Copyright (c) 2014年 Jeffrey. All rights reserved.
//

#import "JButton.h"

@implementation JButton
@synthesize buttonSize;

//设置各种类型的按钮
-(void)setButtonType:(enum ButtonType)_type{
    switch (_type) {
        case BUTTONTYPE_LEAD_TITLE:////适合日历中标题使用
            self.buttonSize=CGSizeMake(40, 25);
            break;
         case  BUTTONTYPE_CALENDAR://日历中使用的按钮
            self.buttonSize=CGSizeMake(45, 45);
            break;
        case BUTTONTYPE_BACK:
            self.buttonSize=CGSizeMake(50, 40);
            break;
        case BUTTONTYPE_ADDCALENDAR:
            self.buttonSize=CGSizeMake(100, 25);
            break;
        case BUTTONTYPE_USER://适合于日历中用户选择使用:
            self.buttonSize=CGSizeMake(30, 30);
            break;
        case BUTTONTYPE_ADD://适合于日历中用户选择使用:
            self.buttonSize=CGSizeMake(50, 30);
            break;
        case BUTTONTYPE_USERSELECT://领导日程选择
            self.buttonSize=CGSizeMake(298, 40);
            break;
        case BUTTON_TYPE_DOWN://向下列框
            self.buttonSize=CGSizeMake(25, 25);
            break;
        default:
            break;
    }
}
//初始化按钮
-(id)initButton:(NSString*)_title image:(NSString*)_image type:(enum ButtonType)_type fontSize:(int)_fontsize point:(CGPoint)_point tag:(int)_tags {
    self=[super initWithFrame:CGRectZero];
    if(self !=nil){
        [self setButtonType:_type];
        self.frame=CGRectMake(_point.x, _point.y, self.buttonSize.width, self.buttonSize.height);
        [self setBackgroundImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self setTitle:_title forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:_image] forState:UIControlStateHighlighted];
        self.titleLabel.font=[UIFont systemFontOfSize:_fontsize];
        self.tag=_tags;

        
    }
    return self;
}




@end
