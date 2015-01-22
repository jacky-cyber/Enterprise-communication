//
//  FinanciaCell.h
//  JieXinIphone
//
//  Created by 黄亮亮 on 14-3-31.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanciaCell : UITableViewCell

{
    UIImageView *_connectBG;
    UILabel *_title;
    UILabel *_titleLable;
    UILabel *_yeatLaber;
    UILabel *_contentLable;
    UILabel * _courseid;
    UIImageView *_dataBG;
    UIImageView *_connectView;
    UIImageView *_fengeView;
    UIImageView *_jiantou;
    
}
-(void)setCellTitle:(NSString*)title andTime:(NSString*)time andDepart:(NSString *)depart;
@property (nonatomic,strong)UILabel *_titleLable;
@property (nonatomic,strong)UILabel *_yeatLaber;

@property (nonatomic,strong)UILabel *_contentLable;

@property (nonatomic,strong)UILabel *_courseid;
@property (nonatomic,strong)UILabel *_title;
@property (nonatomic,strong) UILabel *departLabel;

@property (nonatomic,strong)UIImageView *_connectView;

@end
