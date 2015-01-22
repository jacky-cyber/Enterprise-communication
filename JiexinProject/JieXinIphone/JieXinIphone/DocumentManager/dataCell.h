//
//  dataCell.h
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-3-31.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UILabel *docNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *docTimeLabel;
@property (nonatomic,strong) IBOutlet UILabel *docReadLabel;
@property (nonatomic,strong) IBOutlet UILabel *docDownLabel;
@end
