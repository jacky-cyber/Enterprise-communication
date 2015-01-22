//
//  UIView_Privacy_Config.h
//  GreatTit04_Application
//
//  Created by gabriella on 14-2-26.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewCtrl_Privacy_Config : FrameBaseViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    long lTmpFileSize;
    long lTmpImageSize;
}

@property (strong, nonatomic) NSString *m_sTmpFileSize;
@property (strong, nonatomic) NSString *m_sTmpImageSize;
@property (assign, nonatomic) IBOutlet UITableView *tableview_01;

- (IBAction)onBtnReturn_Click:(id)sender;
- (long) fileSizeForDir:(NSString*)path;
- (void) clearFileForDir:(NSString*)path;

@end
