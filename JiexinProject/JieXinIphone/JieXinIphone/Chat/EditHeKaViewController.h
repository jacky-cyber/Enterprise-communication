//
//  EditHeKaViewController.h
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol EditHeKaDelegate <NSObject>

- (void)sendHeKaWith:(id)sender;

@end
@interface EditHeKaViewController : BaseViewController
@property (nonatomic, retain)NSString *imageName;
@property (nonatomic, retain) NSString *greetingStr;
@property (nonatomic, assign) id <EditHeKaDelegate> delegate;
@property (nonatomic, assign) BOOL isCanEdit;
@end
