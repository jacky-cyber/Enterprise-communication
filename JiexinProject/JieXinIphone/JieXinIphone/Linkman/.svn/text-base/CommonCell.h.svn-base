//
//  CommonCell.h
//  demo
//
//  Created by 高大鹏 on 14-2-19.
//  Copyright (c) 2014年 BeaconStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommonCellDelegate;
@interface CommonCell : UITableViewCell
{
    UILabel *title;
    UILabel *subTitle;
    UIImageView *logo;
    
    CellStyle cellStyle;
    UIButton *selectBtn;
}

@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *subTitle;
@property (nonatomic, retain) UIImageView *logo;
@property (nonatomic, retain) UIButton *selectBtn;
@property(nonatomic,assign)id<CommonCellDelegate> delegate;

- (void)setStyle:(CellStyle)style;

@end

@protocol CommonCellDelegate <NSObject>

-(void)selectCellWith:(CommonCell *)cell withSelected:(BOOL)flag;

@end