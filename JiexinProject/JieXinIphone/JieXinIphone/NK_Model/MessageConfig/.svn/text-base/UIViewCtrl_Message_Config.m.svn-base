//
//  UIViewCtrl_Message_Config.m
//  GreatTit04_Application
//
//  Created by gabriella on 14-3-3.
//  Copyright (c) 2014年 gabriella. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewCtrl_Message_Config.h"
#import "GroupDataHelper.h"

@interface UIViewCtrl_Message_Config ()

@end

@implementation UIViewCtrl_Message_Config

@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize view_03 = _view_03;
@synthesize arrgroupinfo = _arrgroupinfo;
@synthesize switch_01 = _switch_01;
@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize scrollview_01 = _scrollview_01;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];

    [self.view_03.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_03.layer setBorderWidth:1.0f];
    [self.view_03.layer setCornerRadius:5.0f];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:kStatBarShowMsg] boolValue] == NO)
    {
        self.switch_01.on = NO;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }else{
        self.switch_01.on = YES;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_01 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }

    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:kReceiveGroupMsg] boolValue] == NO)
    {
        self.groupMessageSwitch.on = NO;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }else{
        self.groupMessageSwitch.on = YES;
        UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateNormal];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateSelected];
        [self.button_02 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGroupListDataNotification:)
                                                 name:kGroupListData
                                               object:nil];
    
    [self requestGroupList];
      
    [self changeStatus];
    [self.groupMessageSwitch addTarget:self action:@selector(changeStatus) forControlEvents:UIControlEventValueChanged];
    
}

-(void)changeStatus
{
    if(self.groupMessageSwitch.on == NO)
    {
        self.view_03.hidden = YES;
    }
    else
    {
        self.view_03.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_groupMessageSwitch release];
    [_arrgroupinfo release]; _arrgroupinfo = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupListData object:nil];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setGroupMessageSwitch:nil];
    [super viewDidUnload];
}

- (IBAction) onSwtich_ValueChange:(id) sender{
   
    if (sender == self.switch_01) {  //通知栏显示消息内容
        
        [[NSUserDefaults standardUserDefaults]setBool:((UISwitch *)sender).on forKey:kStatBarShowMsg];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else if (sender == self.groupMessageSwitch){ //接受群消息
        [self changeStatus];
        [[NSUserDefaults standardUserDefaults]setBool:((UISwitch *)sender).on forKey:kReceiveGroupMsg];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{   // 讨论组消息设定
        for (int i = 0; i < [self.arrgroupinfo count]; i++) {
            if (sender == [[self.arrgroupinfo objectAtIndex:i] valueForKey:@"Switch_Controller"]) {
                
                UIButton *tmp_btn = [[self.arrgroupinfo objectAtIndex:i] valueForKey:@"Button_Controller"];
                
                if (((UISwitch *)sender).on == YES) {
                    UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateNormal];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateSelected];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateHighlighted];
                    [[GroupDataHelper sharedService] updateGroupReceiveStatus:@"YES" ById:[[self.arrgroupinfo objectAtIndex:i] valueForKey:@"groupId"]];
                }else{
                    UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateNormal];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateSelected];
                    [tmp_btn setBackgroundImage:image_01 forState:UIControlStateHighlighted];
                    [[GroupDataHelper sharedService] updateGroupReceiveStatus:@"NO" ById:[[self.arrgroupinfo objectAtIndex:i] valueForKey:@"groupId"]];
                }
                
                
                break;
            };
        }
    }
}

#pragma mark -
#pragma mark HttpRequest Methods

- (void)requestGroupList
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"group"},@{@"grouptype":@"1"}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark -
#pragma mark NotificationReturnDatas

- (void)receiveGroupListDataNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    
    self.arrgroupinfo = nil;
    [self.scrollview_01 setContentSize:CGSizeMake(self.scrollview_01.layer.frame.size.width, self.scrollview_01.layer.frame.size.height)];
    [self.view_03 setFrame:CGRectMake(self.view_03.layer.frame.origin.x, self.view_03.layer.frame.origin.y, self.view_03.layer.frame.size.width, 1)];
    NSMutableArray *arrgroupids = [[NSMutableArray alloc] init];
    for (UIView *subview in [self.view_03 subviews]) {
        [subview removeFromSuperview];
    }
    
    
    NSMutableArray *sourceArr = [[infoDic objectForKey:@"list"] objectForKey:@"group"];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    if([sourceArr isKindOfClass:[NSArray class]])
    {
        returnArr = [NSMutableArray arrayWithArray:sourceArr];
    }
    else if([sourceArr isKindOfClass:[NSDictionary class]])
    {
        returnArr = [NSMutableArray arrayWithObject:sourceArr];
    }
    
    for (NSMutableDictionary *dic in returnArr)
    {
        //查询当前数据库是否存在，不存在插入
        NSMutableArray *groupDBInfo = [[[NSMutableArray alloc] init] autorelease];
        groupDBInfo = [[GroupDataHelper sharedService] getAllGroupid];
        if (![groupDBInfo containsObject:[dic objectForKey:@"id"]])
        {
            [self insertGroupToDB:dic];
        }
        else
        {
            [self updateDB:dic];
        }
        [arrgroupids addObject:[dic objectForKey:@"id"]];
    }
    if ([arrgroupids count]!=0) {
          self.arrgroupinfo = [[GroupDataHelper sharedService] getGroupReceiveStateByIds:arrgroupids];
    }
  
    for (int i = 0; i < [self.arrgroupinfo count]; i++) {
        UIView *tmp_view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 45.0f * i, 300.0f, 44.0f)] autorelease];
        UIView *tmp_view_01 = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 44.0f)] autorelease];
        UILabel *tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 197.0f, 18.0f)] autorelease];
        UISwitch *tmp_switch = [[[UISwitch alloc] init] autorelease];
        UIButton *tmp_button = [[[UIButton alloc] init] autorelease];
        
        [tmp_switch setFrame:self.switch_01.frame];
        [tmp_button setFrame:self.button_01.frame];
        [tmp_view setBackgroundColor:[UIColor whiteColor]];
        [tmp_view_01 setBackgroundColor:[UIColor whiteColor]];
        [tmp_label setText:[[self.arrgroupinfo objectAtIndex:i] valueForKey:@"groupName"]];
        NSString *sSwitchStatuse = [[self.arrgroupinfo objectAtIndex:i] valueForKey:@"receive_state"];
        if (sSwitchStatuse != nil && [sSwitchStatuse compare:@"NO"] == NSOrderedSame) {
            [tmp_switch setOn:NO];
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateNormal];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateSelected];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }else{
            [tmp_switch setOn:YES];
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateNormal];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateSelected];
            [tmp_button setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }
        
        [tmp_switch addTarget:self action:@selector(onSwtich_ValueChange:) forControlEvents:UIControlEventValueChanged];
        [tmp_button addTarget:self action:@selector(onBtnSwitchSkin_Click:) forControlEvents:UIControlEventTouchUpInside];
        [[self.arrgroupinfo objectAtIndex:i] setValue:tmp_switch forKey:@"Switch_Controller"];
        [[self.arrgroupinfo objectAtIndex:i] setValue:tmp_button forKey:@"Button_Controller"];
        
        [tmp_view addSubview:tmp_switch];
        [tmp_view addSubview:tmp_view_01];
        [tmp_view addSubview:tmp_label];
        [tmp_view addSubview:tmp_button];
        [self.view_03 addSubview:tmp_view];
    }
    [self.view_03 setFrame:CGRectMake(self.view_03.layer.frame.origin.x, self.view_03.layer.frame.origin.y, self.view_03.layer.frame.size.width, 45.0 * [self.arrgroupinfo count] - 1)];
    
    NSInteger nContentHeight = self.view_03.layer.frame.origin.y + self.view_03.layer.frame.size.height;
    
    if (nContentHeight > self.scrollview_01.layer.frame.size.height) {
        [self.scrollview_01 setContentSize:CGSizeMake(self.scrollview_01.layer.frame.size.width, nContentHeight + 20)];
    }
    [arrgroupids release];
    
    //[self. reloadData];
}

#pragma mark -
#pragma mark operateDB Methods

- (void)insertGroupToDB:(NSDictionary *)dic
{
    NSInteger grouptype = 1;
    if ([[dic objectForKey:@"type"] integerValue]==1)
    {
        grouptype = 2;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (grouptype,groupId,groupName,creatorID,time,num) VALUES (%d,'%@','%@','%@','%@',%d)",grouptype,[dic objectForKey:@"id"],[dic objectForKey:@"name"],[dic objectForKey:@"creatorID"],[dic objectForKey:@"time"],[[dic objectForKey:@"num"] integerValue]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}

- (void)updateDB:(NSDictionary *)dic
{
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE groupInfoTable SET groupName='%@',time ='%@',num=%d WHERE  groupId='%@'",[dic objectForKey:@"name"],[dic objectForKey:@"time"],[[dic objectForKey:@"num"] integerValue],[dic objectForKey:@"id"]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}

- (IBAction) onBtnSwitchSkin_Click:(id)sender{
    
    if (sender == self.button_01) {
        self.switch_01.on = !self.switch_01.on;
        
        if (self.switch_01.on == NO) {
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateNormal];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateSelected];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }else{
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateNormal];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateSelected];
            [self.button_01 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }
        [self onSwtich_ValueChange:self.switch_01];
    }else if (sender == self.button_02) {
        self.groupMessageSwitch.on = !self.groupMessageSwitch.on;
        
        if (self.groupMessageSwitch.on == NO) {
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_off.png"];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateNormal];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateSelected];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }else{
            UIImage *image_01 = [UIImage imageNamed:@"uiview_image_switch_on.png"];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateNormal];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateSelected];
            [self.button_02 setBackgroundImage:image_01 forState:UIControlStateHighlighted];
        }
        [self onSwtich_ValueChange:self.groupMessageSwitch];
    }else{
        for (int i = 0; i < [self.arrgroupinfo count]; i++) {
            if (sender == [[self.arrgroupinfo objectAtIndex:i] valueForKey:@"Button_Controller"]) {
                UISwitch *tmp_switch = [[self.arrgroupinfo objectAtIndex:i] valueForKey:@"Switch_Controller"];
                tmp_switch.on = !tmp_switch.on;
                [self onSwtich_ValueChange:[[self.arrgroupinfo objectAtIndex:i] valueForKey:@"Switch_Controller"]];
                
                break;
            };
        }
    }
    
    
}

@end
