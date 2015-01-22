//
//  EditContentViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol SaveHeKaContentDelegate <NSObject>

- (void)saveHeKaContent:(id)sender;

@end
@interface EditContentViewController :BaseViewController

@property (nonatomic, assign) id<SaveHeKaContentDelegate>delegate;
@property (nonatomic, retain) NSString *content;
@end
