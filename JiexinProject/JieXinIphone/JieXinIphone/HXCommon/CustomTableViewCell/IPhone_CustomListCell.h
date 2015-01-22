//
//  IPhone_CustomListCell.h
//  SunboxSoft_MO_iPhone
//
//  Created by 雷 克 on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef enum
{
    Sender_DetailMess = 1,//表示最后一级，点击即进入详细信息
    Sender_IsLeaf,//是叶子节点，点击后对应DetailMess节点
    Sender_NoLeaf,//不是叶子节点，表示它下面还有叶子节点
    Sender_NoAction//点击它下面什么都没有
}CellSenderStyle;

typedef enum
{
    Department_icon = 1,//部门图标
    Boy_OnLine = 2,
    Boy_OffLine = 3,//男孩离线图标
    Boy_BusyLine,
    Boy_Invisible,//不可见
    Girl_OnLine,//女孩在线图标
    Girl_OffLine,
    Girl_BusyLine,
    Girl_Invisible//离开
}CellIConStyle;

#define  CellTitle          @"CellTitle"
#define  CellLeftSubtitle   @"CellLeftSubtitle"
#define  kIsGrayBg           @"kIsGrayBg"
#define  CellRightSubtitle  @"CellRightSubtitle"
#define  CellHeight         48
#define  CellIcon           @"CellIconImage"

@protocol IPhone_CustomListCellDelegate;
@protocol IPhone_CustomListCellIconDelegate;
@interface IPhone_CustomListCell : UITableViewCell
{
    UIImageView *iconImageView;
    UILabel *titleLabel,*lSubtitleLabel,*rSubtitleLabel;
    UIButton *selectBtn;
}
@property(nonatomic,assign)id<IPhone_CustomListCellDelegate> delegate;
@property(nonatomic,assign)id<IPhone_CustomListCellIconDelegate> iconDelegate;
@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UILabel *titleLabel,*lSubtitleLabel,*rSubtitleLabel,*heartLabel;
@property(nonatomic,assign)CellSenderStyle cellSenderStyle;
@property(nonatomic,retain)NSString *titleStr;
@property(nonatomic,retain)NSString *numStr;//在线状态或在线/总人数
@property(nonatomic,retain)UIImageView *pcIcon;
@property(nonatomic,retain)NSString *heartStr;
@property(nonatomic,retain)UIButton *selectBtn;

-(void)changeIconImageViewWith:(CellIConStyle)style withUserid:(NSString *)id;
- (void)setCellData:(NSDictionary*)dataDic;
-(void)setPcIconWithImageName:(NSString *)imageName;
-(void)updateFrameWith:(CGFloat)seat withButton:(BOOL)flag withIcon:(CellIConStyle)style withUserId:(NSString *)id;
@end

@protocol IPhone_CustomListCellDelegate <NSObject>

-(void)selectCellWith:(IPhone_CustomListCell *)cell withSelected:(BOOL)flag;

@end

@protocol IPhone_CustomListCellIconDelegate <NSObject>

-(void)clickIconImageWithUserId:(NSString *)id;

@end


