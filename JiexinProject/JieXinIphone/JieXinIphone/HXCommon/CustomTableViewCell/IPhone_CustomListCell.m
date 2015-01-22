//
//  IPhone_CustomListCell.m
//  SunboxSoft_MO_iPhone
//
//  Created by 雷 克 on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IPhone_CustomListCell.h"
#import "SynUserIcon.h"
#define kPcIconWidth 20.0f
@implementation IPhone_CustomListCell
{
    CGSize _titleSize;
    CGSize _numStrSize;
    NSString *_currentUserId;
}
@synthesize pcIcon = _pcIcon;
@synthesize iconImageView;
@synthesize iconDelegate = _iconDelegate;
@synthesize delegate = _delegate;
@synthesize titleLabel, lSubtitleLabel, rSubtitleLabel,titleStr = _titleStr,numStr = _numStr,selectBtn = _selectBtn,heartLabel = _heartLabel;
@synthesize cellSenderStyle = _cellSenderStyle,heartStr = _heartStr;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"list_select.png"];
        self.selectedBackgroundView = imageView;
        [imageView release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(5, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
        [button setImage:[UIImage imageNamed:@"fuxuan_1.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"fuxuan_2.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        _selectBtn = button;
        self.userInteractionEnabled = YES;
        [self addSubview:button];
        
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 5.0f, 280, 20.0f)];
        tl.backgroundColor = [UIColor clearColor];
        tl.textColor = kDarkerGray;
        tl.numberOfLines = 2.0;
        tl.textAlignment = NSTextAlignmentLeft;
        tl.font = [UIFont systemFontOfSize:kCommonFont];
        [self.contentView addSubview:tl];
        self.titleLabel = tl;
        [tl release];
    
        UILabel *lst = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 26.0f, 120, 20.0f)];
        lst.backgroundColor = [UIColor clearColor];
        lst.numberOfLines = 2.0;
        lst.textColor = kDarkerGray;
        lst.font = [UIFont systemFontOfSize:kCommonFont];
        [self.contentView addSubview:lst];
        self.lSubtitleLabel = lst;
        [lst release];
        
        UILabel *rst = [[UILabel alloc] initWithFrame:CGRectMake(170, 26.0f, 55, 20.0f)];
        rst.backgroundColor = [UIColor clearColor];
        rst.numberOfLines = 2.0;
        rst.textAlignment = NSTextAlignmentLeft;
        rst.textColor = klighterGray;
        rst.font = [UIFont systemFontOfSize:kCommonFont];
        [self.contentView addSubview:rst];
        self.rSubtitleLabel = rst;
        [rst release];
        
        //心情标签
        UILabel *tempHeartLabel = [[UILabel alloc] initWithFrame:CGRectMake(170+50, 26.0f, 150, 20.0f)];
        tempHeartLabel.backgroundColor = [UIColor clearColor];
        tempHeartLabel.numberOfLines = 2.0;
        tempHeartLabel.textAlignment = NSTextAlignmentLeft;
        tempHeartLabel.textColor = klighterGray;
        tempHeartLabel.font = [UIFont systemFontOfSize:kCommonFont];
        [self.contentView addSubview:tempHeartLabel];
        self.heartLabel = tempHeartLabel;
        [tempHeartLabel release];
        
        UIImageView *iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(5, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
        iconIV.backgroundColor = [UIColor clearColor];
        self.iconImageView = iconIV;
        // 圆角
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.layer.cornerRadius = 6.0;
        //self.iconImageView.layer.borderWidth = 1.0;
        //self.iconImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        //在iconTv上加一个按钮
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setFrame:CGRectMake(0, 0, CGRectGetWidth(self.iconImageView.frame), CGRectGetHeight(self.iconImageView.frame))];
        [tempBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.iconImageView.userInteractionEnabled = YES;
        [self.iconImageView addSubview:tempBtn];
        
        [self.contentView addSubview:iconIV];
        
        UIImageView *tempPcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width - kPcIconWidth, (kCommonCellHeight - 25)/2.0, kPcIconWidth - 5, 25.0)];
        tempPcImageView.backgroundColor = [UIColor clearColor];
        self.pcIcon = tempPcImageView;
        [self.contentView addSubview:self.pcIcon];
        [tempPcImageView release];
        [iconIV release];
    }
    return self;
}

- (void)dealloc
{
    self.pcIcon = nil;
    [iconImageView release];
    [titleLabel release];
    [lSubtitleLabel release];
    [rSubtitleLabel release];
    
    [super dealloc];
}

-(void)selectCell:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self.delegate selectCellWith:self withSelected:sender.selected];
}

- (void)setCellData:(NSDictionary*)dataDic
{
    NSString *titleString = [dataDic objectForKey:CellTitle];
    if([titleString length])
    {
        self.titleLabel.text = titleString;
    }
    NSString *lstString = [dataDic objectForKey:CellLeftSubtitle];
    if([lstString length])
    {
        self.lSubtitleLabel.text = lstString;
    }

    NSString *rstString = [dataDic objectForKey:CellRightSubtitle];
    if([rstString length])
    {
        self.rSubtitleLabel.text = rstString;
    }
    
    NSString *imageUrl = [dataDic objectForKey:CellIcon];
    if([imageUrl length])
    {
        if(![imageUrl hasPrefix:@"http"])
        {
            NSString *domain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
            imageUrl = [NSString stringWithFormat:@"%@%@",domain,imageUrl];
        }
        NSURL *url = [NSURL URLWithString:imageUrl];
        if(url)
        {
            [self.iconImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_demo.png"]];
        }
        self.titleLabel.frame = CGRectMake(47 + 8.0f, 5.0f, 220, 20.0f);
        self.lSubtitleLabel.frame = CGRectMake(47 + 8.0f, 26.0f, 120, 20.0f);
        self.rSubtitleLabel.frame = CGRectMake(170, 26.0f, 120, 20.0f);
    }
    if(![titleString length])
    {
        self.lSubtitleLabel.frame = CGRectMake(47 + 8.0f, (kCommonCellHeight - 20.0f)/2.0, 200, 20.0f);
    }
    //TO DO:
    else
    {
        self.titleLabel.frame = CGRectMake(8.0f, 5.0f, 262, 20.0f);
        self.lSubtitleLabel.frame = CGRectMake(8.0f, (kCommonCellHeight - 20.0f)/2.0, 120, 20.0f);
        self.rSubtitleLabel.frame = CGRectMake(170, (kCommonCellHeight - 20.0f)/2.0, 120, 20.0f);
        self.iconImageView.image = nil;
    }
    
//    self.iconImageView.image = [UIImage imageNamed:@"icon_demo.png"];
//    self.titleLabel.frame = CGRectMake(47 + 8.0f, 5.0f, 220, 20.0f);
//    self.lSubtitleLabel.frame = CGRectMake(47 + 8.0f, 26.0f, 110, 20.0f);
//    self.rSubtitleLabel.frame = CGRectMake(180, 26.0f, 110, 20.0f);
}

-(void)setTitleStr:(NSString *)titleStr
{
     self.lSubtitleLabel.text = titleStr;
    _titleSize = [titleStr sizeWithFont:[UIFont systemFontOfSize:kCommonFont]];
}

-(void)setNumStr:(NSString *)numStr
{
    self.rSubtitleLabel.text = numStr;
    //该方法
    _numStrSize = [numStr sizeWithFont:[UIFont systemFontOfSize:kCommonFont]];
    self.rSubtitleLabel.frame = CGRectMake(CGRectGetMinX(self.rSubtitleLabel.frame), (kCommonCellHeight - 20.0f)/2.0, _numStrSize.width, 20.0f);
}

-(void)setPcIconWithImageName:(NSString *)imageName
{
    if([imageName isEqualToString:@"in-PC1.png"])
    {
        [self.pcIcon setFrame:CGRectMake(kScreen_Width - kPcIconWidth - 5, (kCommonCellHeight - 20)/2.0, kPcIconWidth, 20.0)];
    }else
    {
        [self.pcIcon setFrame:CGRectMake(kScreen_Width - kPcIconWidth, (kCommonCellHeight - 25)/2.0, kPcIconWidth - 5, 25.0)];
    }
    [self.pcIcon setImage:[UIImage imageNamed:imageName]];
}

-(void)setHeartStr:(NSString *)heartStr
{
    self.heartLabel.text = heartStr;
}

-(void)updateFrameWith:(CGFloat)seat withButton:(BOOL)flag withIcon:(CellIConStyle)style withUserId:(NSString *)id
{
    _selectBtn.hidden = !flag;
    [self changeIconImageViewWith:style withUserid:id];
    if(!flag){//没有button
        if(style == Department_icon)
        {
            //部门
            self.lSubtitleLabel.frame = CGRectMake(seat + 8.0f , (kCommonCellHeight - 20.0f)/2.0,_titleSize.width, 20.0f);
            self.rSubtitleLabel.frame = CGRectMake(seat + 8.0f  + 5 + _titleSize.width, (kCommonCellHeight - 20.0f)/2.0, _numStrSize.width, 20.0f);
        }else{
            [self.iconImageView setFrame:CGRectMake(seat + 5, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
            self.lSubtitleLabel.frame = CGRectMake(seat + 8.0f + 25, (kCommonCellHeight - 20.0f)/2.0,_titleSize.width, 20.0f);
            self.rSubtitleLabel.frame = CGRectMake(seat + 8.0f + 25 + 5 + _titleSize.width, (kCommonCellHeight - 20.0f)/2.0, _numStrSize.width, 20.0f);
            //心情标签
            self.heartLabel.frame = CGRectMake(CGRectGetMaxX(rSubtitleLabel.frame), (kCommonCellHeight - 20.0f)/2.0, kScreen_Width - CGRectGetMaxX(rSubtitleLabel.frame) - kPcIconWidth, 20.0f);
        }
    }
    else
    {
        if(style == Department_icon)
        {
            [_selectBtn setFrame:CGRectMake(seat + 5, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
            self.lSubtitleLabel.frame = CGRectMake(seat + 30+ 8.0f, (kCommonCellHeight - 20.0f)/2.0, _titleSize.width, 20.0f);
            self.rSubtitleLabel.frame = CGRectMake(seat + 30+ 8.0f + 5 + _titleSize.width, (kCommonCellHeight - 20.0f)/2.0, _numStrSize.width, 20.0f);
        }
        else
        {
            [self.iconImageView setFrame:CGRectMake(seat + 5 + 30, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
            [_selectBtn setFrame:CGRectMake(seat + 5, (kCommonCellHeight - 25)/2.0, 25.0, 25.0)];
            self.lSubtitleLabel.frame = CGRectMake(seat + 25 + 30+ 8.0f, (kCommonCellHeight - 20.0f)/2.0, _titleSize.width, 20.0f);
            self.rSubtitleLabel.frame = CGRectMake(seat + 25 + 30+ 8.0f + 5 + _titleSize.width, (kCommonCellHeight - 20.0f)/2.0, _numStrSize.width, 20.0f);
            //心情标签
            self.heartLabel.frame = CGRectMake(CGRectGetMaxX(rSubtitleLabel.frame), (kCommonCellHeight - 20.0f)/2.0, kScreen_Width - CGRectGetMaxX(rSubtitleLabel.frame)-kPcIconWidth, 20.0f);
        }
    }
}


-(void)changeIconImageViewWith:(CellIConStyle)style withUserid:(NSString *)id
{
    _currentUserId = [NSString stringWithString:id];
    switch (style) {
        case Department_icon:
        {
            [iconImageView setImage:[UIImage imageNamed:@""]];
            [self.pcIcon setImage:[UIImage imageNamed:@""]];
        }
            break;
        case Girl_OffLine:
            [iconImageView setImage:[UIImage imageNamed:@"fm_offline.png"]];
            break;
        case Girl_BusyLine:
            [iconImageView setImage:[UIImage imageNamed:@"fm_busy.png"]];
            break;
        case Girl_Invisible:
            [iconImageView setImage:[UIImage imageNamed:@"fm_invisible.png"]];
            break;
        case Girl_OnLine:
            [self.iconImageView setImage:[UIImage imageNamed:@"fm_online.png"]];
            break;
        case Boy_BusyLine:
            [iconImageView setImage:[UIImage imageNamed:@"m_busy.png"]];
            break;
        case Boy_OffLine:
            [iconImageView setImage:[UIImage imageNamed:@"m_offline.png"]];
            break;
        case Boy_Invisible:
            [iconImageView setImage:[UIImage imageNamed:@"m_invisible.png"]];
            break;
        case Boy_OnLine:
            [iconImageView setImage:[UIImage imageNamed:@"m_online.png"]];
            break;
        default:
            //[iconImageView setImage:[UIImage imageNamed:@""]];
            break;
    }
    
    if(![id isEqualToString:@""]){
        //看某文件是否存在
        NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],id]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath] != NO) {
            if(style == Girl_OffLine || style == Boy_OffLine)
            {
                [iconImageView setImage:[ToolUtil convertToGrayStyle:[UIImage imageWithContentsOfFile:filePath]]];
            }
            else
            {
                [iconImageView setImage:[UIImage imageWithContentsOfFile:filePath]];
            }
        }
    }
}

-(void)iconBtnClick:(UIButton *)sender
{
    if([self.iconDelegate respondsToSelector:@selector(clickIconImageWithUserId:)])
    {
        [self.iconDelegate clickIconImageWithUserId:_currentUserId];
    }else
    {
        NSLog(@"没走代理！");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
