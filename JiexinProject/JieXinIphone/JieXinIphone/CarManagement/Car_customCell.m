//
//  Car_customCell.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-4-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "Car_customCell.h"
#import "Car_helper.h"
#import "TimeChangeWithTimeStamp.h"
@implementation Car_customCell

@synthesize listName,userName,useTime;
@synthesize commitBtn,cancelBtn;
@synthesize conlumType;

- (void)dealloc
{
    self.listName = nil;
    self.userName = nil;
    self.useTime = nil;
    self.commitBtn = nil;
    self.cancelBtn = nil;
    self.stateLb = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.listName  = [[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)] autorelease];
        listName.textColor = [UIColor blackColor];
        listName.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:listName];
        
        self.userName  = [[[UILabel alloc] initWithFrame:CGRectMake(15, listName.bottom, 50, 30)] autorelease];
        userName.textColor = [UIColor blackColor];
        userName.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:userName];
        
        self.useTime  = [[[UILabel alloc] initWithFrame:CGRectMake(userName.right, listName.bottom, 150, 30)] autorelease];
        useTime.textColor = [UIColor blackColor];
        useTime.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:useTime];
        
        self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(useTime.right+25, 20, 60, 30);
        [commitBtn setTitle:@"分派" forState:UIControlStateNormal];
        commitBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
        [commitBtn addTarget:self action:@selector(commitList:) forControlEvents:UIControlEventTouchUpInside];
        [commitBtn.layer setMasksToBounds:YES];
        [commitBtn.layer setCornerRadius:5.0];
        commitBtn.backgroundColor = [UIColor colorWithRed:243/255.0 green:167/255.0 blue:11/255.0 alpha:1];
        [self.contentView addSubview:commitBtn];
        
//        [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
//        NSLog(@"====%@",User_CarPower);
//        if (User_CarPower != 0) {
            self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(useTime.right+25, 20, 60, 30);
            [cancelBtn setTitle:@"撤销" forState:UIControlStateNormal];
            cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
            [cancelBtn addTarget:self action:@selector(cancelList:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn.layer setMasksToBounds:YES];
        [cancelBtn.layer setCornerRadius:5.0];
            cancelBtn.backgroundColor = [UIColor colorWithRed:243/255.0 green:167/255.0 blue:11/255.0 alpha:1];
            [self.contentView addSubview:cancelBtn];
        
        self.stateLb = [[[UILabel alloc] initWithFrame:CGRectMake(useTime.right+25, 20, 70, 30)] autorelease];
        _stateLb.font = [UIFont systemFontOfSize:15.0f];
        _stateLb.backgroundColor = [UIColor clearColor];
        _stateLb.hidden = YES;
        _stateLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_stateLb];
//        }
        
     }
    return self;
}

- (void)setCommitBtnState:(BOOL)flag1 andCancelBtn:(BOOL)flag2
{
    commitBtn.hidden = !flag1;
    cancelBtn.hidden = !flag2;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark button方法

- (void)commitList:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commitCellWithConlum:andBtnTag:)])
    {
        [self.delegate commitCellWithConlum:conlumType andBtnTag:sender.tag];
    }
}

- (void)cancelList:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelCellWithConlum:andBtnTag:)])
    {
        [self.delegate cancelCellWithConlum:conlumType andBtnTag:sender.tag];
    }
}

#pragma mark -//设置搜索cell里面view的显示情况
- (void)setSearchCellDatas:(NSDictionary *)infoDic
{
    self.listName.text = [infoDic objectForKey:@"name"];
    self.userName.text = [infoDic objectForKey:@"userName"];
    self.useTime.text = [infoDic objectForKey:@"time"];
    self.commitBtn.hidden = YES;
    self.cancelBtn.hidden = YES;
    
//    待审批0，已撤销1，未通过2，已审批3，已完成4
    int state = [[infoDic objectForKey:@"state"] intValue];
    switch (state) {
        case 0:
            _stateLb.text = @"待审批";
            break;
        case 1:
            _stateLb.text = @"已撤销";
            break;

        case 2:
            _stateLb.text = @"未通过";
            break;

        case 3:
            _stateLb.text = @"已审批";
            break;

        case 4:
            _stateLb.text = @"已完成";
            break;
            
        default:
            break;
    }
    //权限  0是管理员
    NSString *power = [[NSUserDefaults standardUserDefaults] objectForKey:User_CarPower];
//    NSString *loginUserName = [[NSUserDefaults standardUserDefaults] objectForKey:User_Name];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *userId = [infoDic objectForKey:@"userId"];
    if ([power isEqualToString:@"0"] && state!=1 && state!=2)
    {
        self.cancelBtn.hidden = NO;
        _stateLb.hidden = YES;
    }
    //自己的才显示  1是已撤销  2未通过
    else if ([sessionID isEqualToString:userId] && state!=1 && state!=2)
    {
        if ([TimeChangeWithTimeStamp isBeyond4HoursWithFromTime:[infoDic objectForKey:@"time"] withNowDate:[NSDate date]]) {
            self.cancelBtn.hidden = NO;
            _stateLb.hidden = YES;
        }
        else
        {
            self.cancelBtn.hidden = YES;
            _stateLb.hidden = NO;
        }
    }
    else
    {
        self.cancelBtn.hidden = YES;
        _stateLb.hidden = NO;
    }
}


@end
