//
//  LoginSetView.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LoginSetView.h"

typedef enum
{
    DomainStyle=10,
    SoundStyle,
    ShakeStyle,
}OpeStyle;

@interface LoginSetView()

@property (nonatomic, retain) UITextField *domainField;
@property (nonatomic, retain) UIButton *soundBt;
@property (nonatomic, retain) UIButton *shakeBt;
@property (nonatomic, retain) NSMutableArray *datasArr;


@end

@implementation LoginSetView

- (void)dealloc
{
    self.domainField = nil;
    self.soundBt = nil;
    self.shakeBt = nil;
    self.datasArr  =nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initDefaultDatas];
        [self initSubviews];
    }
    return self;
}

- (void)initDefaultDatas
{
    
    self.datasArr = [NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"输入服务器地址",@"title",[NSNumber numberWithInt:DomainStyle],@"style", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"新消息声音提醒",@"title",[NSNumber numberWithInt:SoundStyle],@"style", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"新消息震动提醒",@"title",[NSNumber numberWithInt:ShakeStyle],@"style", nil], nil];
}
- (void)initSubviews
{
    UIImage *bgImage =  nil;
    if (kScreen_Height>480) {
        bgImage = [UIImage imageNamed:@"login_bg_P5.png"];
    }
    else
    {
        bgImage = [UIImage imageNamed:@"login_bg_P5.png"];
    }
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-20)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.backgroundColor = [UIColor whiteColor];
//    bgImageView.image = bgImage;
    [self addSubview:bgImageView];
    [bgImageView release];
    
    UIImage *topBar = [UIImage imageNamed:@"top_bar_bg.png"];
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topBar.size.width/2, kNavHeight)];
    topImageView.userInteractionEnabled = YES;
    topImageView.image = topBar;
    [self addSubview:topImageView];
    [topImageView release];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 100, kNavHeight);
    [back setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    [back addTarget:self action:@selector(onBackBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, kNavHeight-5)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.text = @"登录设置";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLabel];
    [titleLabel release];


    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetWidth(self.frame) -110, 0, 110, kNavHeight);
    [sureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [sureBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [sureBtn setTitleColor:RGBCOLOR(1, 165, 228) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(onSureBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];

    
    for (int i = 0; i < 3; i++) {
        UIImage *cellImage = [UIImage imageNamed:@"loginSetCellBg.png"];
        UIImageView *cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kNavHeight+20+(45+15)*i, kScreen_Width-20, cellImage.size.height/2)];
        cellImageView.layer.cornerRadius = 3.f;
        cellImageView.image = cellImage;
        cellImageView.userInteractionEnabled = YES;
        [self addSubview:cellImageView];
        [cellImageView release];
        
        NSString *text = [[_datasArr objectAtIndex:i] objectForKey:@"title"];
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.f]];
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(3, (cellImage.size.height/2-size.height)/2, size.width, size.height)];
        label.textColor = [UIColor grayColor];
        label.text = text;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:17.f];
        [cellImageView addSubview:label];
        [label release];
        
        
        UIImage *selectedImage = UIImageWithName(@"selectBtn.png");
        UIImage *unSelectedImage = UIImageWithName(@"unSelectBtn.png");
        OpeStyle style = (OpeStyle)[[[_datasArr objectAtIndex:i] objectForKey:@"style"] intValue];
        if (style == DomainStyle)
        {
            self.domainField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+4, 0, CGRectGetWidth(cellImageView.frame)-CGRectGetMaxX(label.frame)-4, CGRectGetHeight(cellImageView.frame))];
            _domainField.textAlignment = NSTextAlignmentCenter;
            _domainField.returnKeyType = UIReturnKeyDone;
            [_domainField addTarget:self action:@selector(textDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
            _domainField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _domainField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            _domainField.text=[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
            [cellImageView addSubview:_domainField];
        }
        else if(style == SoundStyle)
        {
            self.soundBt = [UIButton buttonWithType:UIButtonTypeCustom];
            [_soundBt setImage:unSelectedImage forState:UIControlStateNormal];
            [_soundBt setImage:selectedImage forState:UIControlStateSelected];
            [_soundBt addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
            _soundBt.frame = CGRectMake(CGRectGetWidth(cellImageView.frame)- selectedImage.size.width/2 - 5, (CGRectGetHeight(cellImageView.frame)-selectedImage.size.height/2)/2, selectedImage.size.width/2, selectedImage.size.height/2);
            _soundBt.selected = [[NSUserDefaults standardUserDefaults] boolForKey:kIsPalySound];
            [cellImageView addSubview:_soundBt];
        }
        else if (style == ShakeStyle)
        {
            self.shakeBt = [UIButton buttonWithType:UIButtonTypeCustom];
            [_shakeBt setImage:unSelectedImage forState:UIControlStateNormal];
            [_shakeBt setImage:selectedImage forState:UIControlStateSelected];
            [_shakeBt addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
            _shakeBt.frame = CGRectMake(CGRectGetWidth(cellImageView.frame)- selectedImage.size.width/2 - 5, (CGRectGetHeight(cellImageView.frame)-selectedImage.size.height/2)/2, selectedImage.size.width/2, selectedImage.size.height/2);
            _shakeBt.selected = [[NSUserDefaults standardUserDefaults] boolForKey:kIsCanShake];
            [cellImageView addSubview:_shakeBt];

        }
    }
    
}

- (void)onBackBtnTap
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake( CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                     }
                     completion:^(BOOL finish){
                         [self removeFromSuperview];
                     }];
}

- (void)onSelectBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
- (void)onSureBtnTap
{
    if (_domainField.text && ![_domainField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain]]) {
        //此时做一个处理，看域名是否更改了
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMain_DomainChanged];//域名更改了
        [[NSUserDefaults standardUserDefaults] setValue:_domainField.text forKey:Main_Domain];
        [AppDelegate shareDelegate].sameIP = NO;
    }
    else
    {
        //没有更改
        [AppDelegate shareDelegate].sameIP = YES;
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kMain_DomainChanged];
    }
    [[NSUserDefaults standardUserDefaults] setBool:_soundBt.selected forKey:kIsPalySound];
    [[NSUserDefaults standardUserDefaults] setBool:_shakeBt.selected forKey:kIsCanShake];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self onBackBtnTap];

}


- (void)textDone:(UITextField *)textField
{
    [textField resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
