//
//  CardMainViewController.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#define SCREENRECT [UIScreen mainScreen].bounds
#define TitleViewHeight 50
#define DelViewHeight 40


#import "CardMainViewController.h"
#import "KxMenu.h"
#import "CardCell.h"
#import "Card_helper.h"
#import "CardApplyViewController.h"

@interface CardMainViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSIndexPath *currentIndex;
@property (nonatomic) BOOL isSelf;
@property (nonatomic) int clickCount;
@property (nonatomic) BOOL showDelBtnFlag;
@property (nonatomic) BOOL isSelectAll;
@property (nonatomic) BOOL isCellAnimation;
@property (nonatomic,strong) NSMutableArray *delFlagArr;
@property (nonatomic,strong) NSIndexPath *lastDelIndex;
@property (nonatomic,strong) NSString * jurisdiction;
@property (nonatomic,strong) NSString *currentHandle;//点击过滤
@property (nonatomic,strong) NSString *handleStr;
@property (nonatomic,strong) NSString *user_id;
@end

@implementation CardMainViewController
@synthesize dataArr;
@synthesize tableview;
@synthesize currentIndex;
@synthesize isSelf;
@synthesize clickCount;
@synthesize showDelBtnFlag;
@synthesize isSelectAll;
@synthesize delFlagArr;
@synthesize lastDelIndex;
@synthesize jurisdiction;
@synthesize isCellAnimation;
@synthesize user_id;
@synthesize currentHandle;
@synthesize handleStr;

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
    self.view.backgroundColor=[UIColor whiteColor];
    
    dataArr=[[NSMutableArray alloc] initWithCapacity:100];
    delFlagArr=[[NSMutableArray alloc] initWithCapacity:100];//数据解析完之后，需要全部初始化为no
    
    isSelf=NO;
    clickCount=0;
    showDelBtnFlag=NO;
    isSelectAll=NO;
    isCellAnimation=NO;
    
    [self LoginRequest];
    
    [super createCustomNavBarWithoutLogo];
    [self initNavView];
    [self initTableViewTitleView];
    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:newCardApply
                                               object:nil];
    
}

-(void)refreshData:(NSNotification *)datas{
    
    if([datas.name isEqualToString:@"newCardApply"]){
        [self dataRequest:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:newCardApply object:nil];
    }
    
}

- (void)initNavView
{
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat, SCREENRECT.size.width, 44)];
    [self.view addSubview:baseView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,2, 40, 40);
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:backBtn];
    
    NSString *titleStr=@"名片申请";
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.frame.origin.x+backBtn.frame.size.width,2, 120, 40)];
    label.text = titleStr;
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:label];
    
    UIButton *FileterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FileterBtn.frame = CGRectMake(SCREENRECT.size.width-26-10-26-10-4,(44-26)/2, 26, 26);
    [FileterBtn setImage:[UIImage imageNamed:@"filter_normal"] forState:UIControlStateNormal];
    [FileterBtn addTarget:self action:@selector(FilterAction:) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:FileterBtn];
    
    
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame = CGRectMake(SCREENRECT.size.width-26-10,(44-26)/2, 26, 26);
    [typeBtn setImage:[UIImage imageNamed:@"addContentToDetail"] forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:typeBtn];
    
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initTableView{
    
    CGFloat y=self.iosChangeFloat +44+TitleViewHeight;
    CGFloat height=SCREENRECT.size.height-44-TitleViewHeight-20;
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREENRECT.size.width, height)];
    tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    if(IOSVersion>=7.0){
        tableview.separatorInset=  UIEdgeInsetsMake(0, -15, 0, 0);
    }
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];
}

-(void)initTableViewTitleView{
    
    
    UIView *titleView= [[UIView alloc] init];
    CGFloat y=self.iosChangeFloat +44;
    titleView.frame=CGRectMake(0, y, kScreen_Width, TitleViewHeight);
    [self.view addSubview:titleView];
    
    UILabel *titleLabel=[[UILabel alloc] init];
    titleLabel.frame=CGRectMake(0, 0, 70, TitleViewHeight);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=@"时间";
    titleLabel.textColor=[UIColor darkGrayColor];
    [titleView addSubview:titleLabel];
    
    UILabel *peopleLabel=[[UILabel alloc] init];
    peopleLabel.frame=CGRectMake(70, 0, 100, TitleViewHeight);
    peopleLabel.textAlignment=NSTextAlignmentCenter;
    peopleLabel.text=@"人员信息";
    peopleLabel.textColor=[UIColor darkGrayColor];
    [titleView addSubview:peopleLabel];
    
    UILabel *numLabel=[[UILabel alloc] init];
    numLabel.frame=CGRectMake(178, 0, 65, TitleViewHeight);
    numLabel.textAlignment=NSTextAlignmentCenter;
    numLabel.text=@"数量";
    numLabel.textColor=[UIColor darkGrayColor];
    [titleView addSubview:numLabel];
    
    UILabel *stateLabel=[[UILabel alloc] init];
    stateLabel.frame=CGRectMake(243, 0, 77, TitleViewHeight);
    stateLabel.textAlignment=NSTextAlignmentCenter;
    stateLabel.text=@"状态";
    stateLabel.textColor=[UIColor darkGrayColor];
    [titleView addSubview:stateLabel];
    
    UILabel *bgLabel=[[UILabel alloc] init];
    bgLabel.frame=CGRectMake(0, TitleViewHeight-1, kScreen_Width, 0.5);
    bgLabel.backgroundColor=[UIColor darkGrayColor];
    [titleView addSubview:bgLabel];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.dataArr[indexPath.row];
    NSString *department =  dic[@"department"];
    
    int height=50;
    if(self.currentIndex){
        if(self.currentIndex.row==indexPath.row){
            if(isSelf){
                if(clickCount%2==1){
                    height = 50;
                }else{
                    if([self.jurisdiction isEqualToString:@"2"]){
                        if([self.handleStr isEqualToString:@"0"]){
                            height = 300;
                        }else{
                            if(![department isEqualToString:@""]){
                                height=244;
                            }else{
                                height=244-22;
                            }
                        }
                    }else{
                        if(![department isEqualToString:@""]){
                            height=244;
                        }else{
                            height=244-22;
                        }
                    }
                }
            }else{
                if([self.jurisdiction isEqualToString:@"2"]){
                    if([self.handleStr isEqualToString:@"0"]){
                        height = 300;
                    }else{
                        if(![department isEqualToString:@""]){
                            height=244;
                        }else{
                            height=244-22;
                        }
                    }
                }else{
                    if(![department isEqualToString:@""]){
                        height=244;
                    }else{
                        height=244-22;
                    }
                    
                }
            }
        }
    }
    
    
    return height;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cell";
    int row=indexPath.row;
    CardCell *cell=[tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CardCell" owner:self options:nil];
        
        for (id oneObject in nibs)
            if ([oneObject isKindOfClass:[CardCell class]])
                cell = (CardCell *)oneObject;
        
        UIButton *delBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        delBtn.frame=CGRectMake(5, (50-20)/2, 20, 20);
        delBtn.tag=10;
        [delBtn addTarget:self action:@selector(clickDel:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView addSubview:delBtn];
        
    }
    
    UIButton *delBtn=(UIButton *)[cell.contentView viewWithTag:10];
    if(showDelBtnFlag){
        delBtn.hidden=NO;
        [cell moveBgView:YES];
        BOOL delFlag =  [delFlagArr[row] boolValue];
        if(isSelectAll){
            if(!delFlag){
                [delBtn setImage:[UIImage imageNamed:@"fuxuan_1"] forState:UIControlStateNormal];
            }else{
                [delBtn setImage:[UIImage imageNamed:@"fuxuan_2"] forState:UIControlStateNormal];
            }
        }else{
            if(!delFlag){
                [delBtn setImage:[UIImage imageNamed:@"fuxuan_1"] forState:UIControlStateNormal];
            }else{
                [delBtn setImage:[UIImage imageNamed:@"fuxuan_2"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        delBtn.hidden = YES;
        [cell moveBgView:NO];
    }
    
    [cell.agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchDown];
    cell.agreeBtn.layer.cornerRadius=5;
    cell.agreeBtn.layer.masksToBounds=YES;
    [cell.refuseBtn addTarget:self action:@selector(refuseAction:) forControlEvents:UIControlEventTouchDown];
    cell.refuseBtn.layer.cornerRadius=5;
    cell.refuseBtn.layer.masksToBounds=YES;
    NSDictionary *dic=self.dataArr[row];
    cell.dataDic=dic;
    [cell setDataValue];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.currentIndex){
        if(self.currentIndex.row==indexPath.row){
            isSelf=YES;
            clickCount++;
        }else{
            isSelf=NO;
            clickCount=0;
        }
    }else{
        isSelf=NO;
        clickCount=0;
    }
    
    NSDictionary *dic=self.dataArr[indexPath.row];
    self.handleStr =  dic[@"state"];
    self.currentIndex=indexPath;
    
    [tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}


-(void)agreeAction:(UIButton *)sender{
    
    CardCell *cell  =  (CardCell *)sender.superview.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableview indexPathForCell:cell];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    [[STHUDManager sharedManager] showHUDInView:self.view];
    //传入userid,获取申请人相关信息
    [[Card_helper sharedService] requestForType:Card_ApprovalRequest info:@{@"id":dic[@"appid"],@"handState":@"1"} target:self successSel:@"ApprovalRequestFinished:" failedSel:@"ApprovalRequestFailed:"];
}

-(void)refuseAction:(UIButton *)sender{
    CardCell *cell  =  (CardCell *)sender.superview.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableview indexPathForCell:cell];
    [[STHUDManager sharedManager] showHUDInView:self.view];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    [[Card_helper sharedService] requestForType:Card_ApprovalRequest info:@{@"id":dic[@"appid"],@"handState":@"2"} target:self successSel:@"ApprovalRequestFinished:" failedSel:@"ApprovalRequestFailed:"];
    
}

-(void)ApprovalRequestFinished:(NSDictionary *)datas{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    if([datas[@"resultcode"] isEqualToString:@"0"]){
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"操作成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        [self dataRequest:nil];
    }
    
}

-(void)ApprovalRequestFailed:(id)sender{
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"操作失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    
    [alertView show];
    
}

-(void)clickDel:(UIButton *)sender{
    
    
    NSData *unselectData = UIImagePNGRepresentation([UIImage imageNamed:@"fuxuan_1"]);
    NSData *selectData=UIImagePNGRepresentation([UIImage imageNamed:@"fuxuan_2"]);
    
    UIImage *clickImage=sender.imageView.image;
    NSData *clickData=UIImagePNGRepresentation(clickImage);
    
    if([clickData isEqualToData:unselectData]){
        [sender setImage:[UIImage imageWithData:selectData] forState:UIControlStateNormal];
    }else if([clickData isEqualToData:selectData]){
        [sender setImage:[UIImage imageWithData:unselectData] forState:UIControlStateNormal];
    }
    
    CardCell *cell= (CardCell *)sender.superview.superview.superview ;
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    BOOL currentDelFlag= [[delFlagArr objectAtIndex:indexPath.row] boolValue];
    currentDelFlag=!currentDelFlag;
    
    [delFlagArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:currentDelFlag]];
    
    self.lastDelIndex=indexPath;
}

-(void)FilterAction:(UIButton *)sender{
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"全部"
                     image:nil
                    target:self
                    action:@selector(filter:) index:0],
      
      [KxMenuItem menuItem:@"待审核"
                     image:nil
                    target:self
                    action:@selector(filter:) index:1],
      
      
      [KxMenuItem menuItem:@"已通过"
                     image:nil
                    target:self
                    action:@selector(filter:) index:2],
      
      [KxMenuItem menuItem:@"未通过"
                     image:nil
                    target:self
                    action:@selector(filter:) index:3]
      
      ];
    
    
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x-5, sender.frame.origin.y+40, sender.frame.size.width+10, sender.frame.size.height) menuItems:menuItems];
}

-(void)filter:(KxMenuItem *)sender{
    int index=sender.index;
    if(index!=0){
        currentHandle=[NSString stringWithFormat:@"%d",index-1];
    }else{
        currentHandle=nil;
    }
    [self dataRequest:currentHandle];
}

-(void)chooseAction:(UIButton *)sender{
    
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"新申请"
                     image:nil
                    target:self
                    action:@selector(newApplyCard:) index:0],
      
      //      [KxMenuItem menuItem:@"删除"
      //                     image:nil
      //                    target:self
      //                    action:@selector(delCard:) index:1],
      //
      ];
    
    //    KxMenuItem *first=menuItems[0];
    //    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x-5, sender.frame.origin.y+40, sender.frame.size.width+10, sender.frame.size.height) menuItems:menuItems];
}

-(void)newApplyCard:(id)sender{
    
    CardApplyViewController *avc = [[CardApplyViewController alloc] initWithJurisdiction:self.jurisdiction withUserId:self.user_id];
    [self.navigationController pushViewController:avc animated:YES];
    [avc release];
    
}

-(void)delCard:(id)sender{
    
    showDelBtnFlag=YES;
    [self.tableview reloadData];
    
    [self initDelView];
    
    
}

-(void)initDelView{
    
    UIView *tempView=[self.view viewWithTag:100];
    if(tempView){
        return ;
    }
    
    UIView *delView=[[UIView alloc] init];
    delView.frame=CGRectMake(0, SCREENRECT.size.height-DelViewHeight, kScreen_Width, DelViewHeight);
    delView.tag=100;
    [self.view addSubview:delView];
    
    UIButton *selectAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    selectAllBtn.frame=CGRectMake(0, 0, kScreen_Width/2-1, DelViewHeight);
    selectAllBtn.backgroundColor=[UIColor lightGrayColor];
    [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllBtn setTitleColor:[UIColor colorWithRed:80/255.0f green:161/255.0f blue:198/255.0f alpha:1] forState:UIControlStateNormal];
    [selectAllBtn addTarget:self action:@selector(selectAllMessage:) forControlEvents:UIControlEventTouchDown];
    [delView addSubview:selectAllBtn];
    
    UIButton *delBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.frame=CGRectMake(kScreen_Width/2+1, 0, kScreen_Width/2-1, DelViewHeight);
    delBtn.backgroundColor=[UIColor lightGrayColor];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor colorWithRed:80/255.0f green:161/255.0f blue:198/255.0f alpha:1] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delMessage:) forControlEvents:UIControlEventTouchDown];
    [delView addSubview:delBtn];
}

//点击删除所有
-(void)selectAllMessage:(UIButton *)sender{
    
    isSelectAll=YES;
    for(int i=0;i<dataArr.count;i++){
        [delFlagArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
    }
    [self.tableview reloadData];
}

-(void)delMessage:(UIButton *)sender{
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"确认删除"
                     image:nil
                    target:self
                    action:@selector(sureDel:) index:0],
      
      [KxMenuItem menuItem:@"取消"
                     image:nil
                    target:self
                    action:@selector(cancle:) index:1],
      
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, SCREENRECT.size.height-DelViewHeight, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
    
    
}

-(void)sureDel:(id)sender{
    
    UIView *delView=[self.view viewWithTag:100];
    [delView removeFromSuperview];
    
    NSMutableIndexSet * indexSet=[[NSMutableIndexSet alloc] init];
    for(int i=0;i<delFlagArr.count;i++){
        BOOL delFlag=[[delFlagArr objectAtIndex:i] boolValue];
        if(delFlag){
            [indexSet addIndex:i];
        }
    }
    [dataArr removeObjectsAtIndexes:indexSet];
    [delFlagArr removeObjectsAtIndexes:indexSet];
    
    //    showDelBtnFlag=NO;
    
    isSelf=NO;
    clickCount=0;
    showDelBtnFlag=NO;
    isSelectAll=NO;
    self.currentIndex=nil;
    
    [self.tableview reloadData];
    
}

-(void)cancle:(id)sender{
    
    
}

- (void)LoginRequest
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    //传入userid,获取申请人相关信息
    [[Card_helper sharedService] requestForType:Card_LoginRequest info:nil target:self successSel:@"LoginRequestFinished:" failedSel:@"LoginRequestFailed:"];
}

- (void)LoginRequestFinished:(NSDictionary *)datas
{
    self.jurisdiction = datas[@"jurisdiction"];
    self.user_id=datas[@"userId"];
    [self dataRequest:nil];
}

-(void)dataRequest:(NSString *)handlestate{
    
    if(self.jurisdiction){
        
        NSDictionary *dic=@{@"userId":self.user_id,@"handState":handlestate==nil?@"":handlestate} ;
        
        if([self.jurisdiction isEqualToString:@"1"]){//员工查询所有数据
            [[Card_helper sharedService] requestForType:Card_UserRequest info:dic target:self successSel:@"RequestFinished:" failedSel:@"RequestFailed:"];
        }else if([self.jurisdiction isEqualToString:@"0"]){//管理员
            [[Card_helper sharedService] requestForType:Card_AdminRequest info:dic target:self successSel:@"RequestFinished:" failedSel:@"RequestFailed:"];
        }else if([self.jurisdiction isEqualToString:@"2"]){//领导
            [[Card_helper sharedService] requestForType:Card_LeaderRequest info:dic target:self successSel:@"RequestFinished:" failedSel:@"RequestFailed:"];
        }
    }else{
      
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有权限" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil ];
        alertView.tag=10001;
        [alertView show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag==10001){
         [self back];
    }
}

- (void)LoginRequestFailed:(id)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
}

-(void)RequestFinished:(NSDictionary *)datas{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    self.dataArr = [datas[@"list"] mutableCopy];
    if(self.dataArr.count==0){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有名片申请数据" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil ];
        [alertView show];
        
        [self.tableview reloadData];
    }else{
        for(int i=0;i<dataArr.count;i++){
            [delFlagArr addObject:[NSNumber numberWithBool:NO]];
        }
        
        isSelf=NO;
        clickCount=0;
        showDelBtnFlag=NO;
        isSelectAll=NO;
        isCellAnimation=NO;
        self.currentIndex=nil;
        
        [self.tableview reloadData];
        
    }
}

-(void)RequestFailed:(id)sender{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
