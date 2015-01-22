//
//  Car_customCell.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-4-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cellBtnSelectedDelegate;

@interface Car_customCell : UITableViewCell

@property (nonatomic, assign) CarConlumType conlumType;
@property (nonatomic, retain) UILabel *listName;
@property (nonatomic, retain) UILabel *userName;
@property (nonatomic, retain) UILabel *useTime;
@property (nonatomic, retain) UILabel *stateLb;
@property (nonatomic, retain) UIButton *commitBtn;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, assign) id<cellBtnSelectedDelegate>delegate;

- (void)setCommitBtnState:(BOOL)flag1 andCancelBtn:(BOOL)flag2;
- (void)commitList:(UIButton *)sender;
- (void)cancelList:(UIButton *)sender;

//设置搜索cell里面view的显示情况
- (void)setSearchCellDatas:(NSDictionary *)infoDic;
@end

@protocol cellBtnSelectedDelegate <NSObject>

-(void)commitCellWithConlum:(CarConlumType)type andBtnTag:(int)tag;
-(void)cancelCellWithConlum:(CarConlumType)type andBtnTag:(int)tag;

@end