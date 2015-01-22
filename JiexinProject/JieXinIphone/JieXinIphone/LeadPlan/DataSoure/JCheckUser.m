//
//  JCheckUser.m
//  JieXinIphone
//
//  Created by apple on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JCheckUser.h"
#import "HttpServiceHelper.h"
JCheckUser *check=nil;
@implementation JCheckUser
@synthesize leader,userId,resultcode,userType;
-(id)init{
    if((check=[super init])){
        [[HttpServiceHelper sharedService] requestForType:KQueryUserCalendarRight info:@{@"UserName":[[NSUserDefaults standardUserDefaults] objectForKey:User_Name]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    }
    return check;
}

+(JCheckUser*)shareCheckUser{
    return check;
}

- (void)requestFinished:(NSDictionary *)datas
{
    self.userId=[datas objectForKey:@"userId"];

    self.leader=nil;
    //
    leader= [[NSMutableArray alloc]init];
    NSDictionary *all_leader = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"",@"userId", nil];
    [self.leader addObject:all_leader];
    [self.leader addObjectsFromArray:[datas objectForKey:@"leader"]];
   
    NSLog(@"self.learder = %@",self.leader);
    //
    [JCheckUser shareCheckUser];
    self.resultcode=[datas objectForKey:@"resultcode"];
    self.userType=[datas objectForKey:@"userType"];
    NSLog(@"%@",[datas objectForKey:@"leader"]);
    
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(userCalendar:)])
    {
        [self.calendarDelegate userCalendar:self];
    }
}

- (void)requestFailed:(id)sender
{
    NSLog(@"failed:");
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(userCalendar:)])
    {
        [self.calendarDelegate userCalendar:nil];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[AppDelegate shareDelegate].rootNavigation popToRootViewControllerAnimated:YES];
}

@end