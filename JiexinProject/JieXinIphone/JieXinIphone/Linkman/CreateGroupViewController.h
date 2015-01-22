//
//  CreateGroupViewController.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LinkDepartmentView.h"

@interface CreateGroupViewController :BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *groupName;
    LinkDepartmentView *linkDepartmentView;
    NSMutableArray *personSelectedArr;
    GroupType type;
}

@property (nonatomic, retain) UITextField *groupName;
@property (nonatomic, retain) LinkDepartmentView *linkDepartmentView;
@property (nonatomic, retain) NSMutableArray *personSelectedArr;
@property (nonatomic, assign) GroupType type;

- (id)initWithType:(GroupType)groupType;

@end
