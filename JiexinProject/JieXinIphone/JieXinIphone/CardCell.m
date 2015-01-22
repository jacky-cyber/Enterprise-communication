//
//  CardCell.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CardCell.h"


@implementation CardCell
@synthesize dataDic;
@synthesize isShowDetail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setDataValue{
    //    self.dataDic=dic;
    NSString *timeStr=self.dataDic[@"apptime"];
    NSArray *timeArr=[timeStr componentsSeparatedByString:@"-"];
    self.timeLabel.text=[NSString stringWithFormat:@"%@/%@",timeArr[1],timeArr[2]];
    self.nameLabel.text=self.dataDic[@"userName"];
    self.numLabel.text=[NSString stringWithFormat:@"%@盒",self.dataDic[@"amount"]];
    
    NSString *state=self.dataDic[@"state"];
    if([state isEqualToString:@"0"]){
        self.statuLabel.text=@"待审核";
        self.statuLabel.textColor=[UIColor colorWithRed:84/255.0f green:27/255.0f blue:0/255.0f alpha:1];
    }else if([state isEqualToString:@"1"]){
        self.statuLabel.text=@"已通过";
        self.statuLabel.textColor=[UIColor colorWithRed:76/255.0f green:143/255.0f blue:26/255.0f alpha:1];
    }else if([state isEqualToString:@"2"]){
        self.statuLabel.text=@"未通过";
        self.statuLabel.textColor=[UIColor colorWithRed:206/255.0f green:26/255.0f blue:38/255.0f alpha:1];
    }
    
    self.nameDetailLabel.text=self.dataDic[@"appName"];
    self.jobLabel.text=self.dataDic[@"job"];
    self.addressLabel.text=self.dataDic[@"caddress"];
    self.zipLabel.text=[NSString stringWithFormat:@"%@",self.dataDic[@"pcode"]] ;
    self.mobileLabel.text=[NSString stringWithFormat:@"%@",self.dataDic[@"mobile"]] ;
    self.telphoneLabel.text=[NSString stringWithFormat:@"%@",self.dataDic[@"phone"]];
    self.faxLabel.text=[NSString stringWithFormat:@"010 %@", self.dataDic[@"fax"] ];
    self.emailLabel.text=self.dataDic[@"email"];
    
    NSString *department=self.dataDic[@"department"];
    
    if([department isEqualToString:@""]){
        self.bottomView.frame=CGRectMake(0, 75, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    }else{
        self.departLabel.text=department;
        self.bottomView.frame=CGRectMake(0, 99, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    }
}

-(void)moveBgView:(BOOL)flag{
    
    [UIView animateWithDuration:0.5 animations:^{
        if(flag){
            self.bgView.frame=CGRectMake(30, 0, self.bgView.frame.size.width, self.bgView.frame.size.height);
        }else{
            self.bgView.frame=CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height);
        }
        
    }];
}

@end
