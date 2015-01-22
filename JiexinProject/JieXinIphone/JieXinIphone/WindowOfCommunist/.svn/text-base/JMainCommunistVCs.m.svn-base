//
//  JMainCommunistVCs.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JMainCommunistVCs.h"
#import "JTitleLabel.h"
#import "JButton.h"
#import "HttpServiceHelper.h"
#import "documentDataHelp.h"
#import "JCommunistListVC.h"

@interface JMainCommunistVCs (){
    int currentPage;
    int allPage;
}
@property (nonatomic,strong)  NSArray *pointArr;

@end

@implementation JMainCommunistVCs
@synthesize mainBgView,pointArr,ListCommunist;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=RGBCOLOR(240, 240, 240);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	currentPage=1;
    ListCommunist=[[NSMutableArray alloc] initWithCapacity:100];
    
    self.pointArr = [[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    
    [super createCustomNavBarWithoutLogo];
    [self reloadCommunistListData];
    [self loadBackView];
}
-(void)reloadCommunistListData{
    [[STHUDManager sharedManager]showHUDInView:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQueryallcategorya info:nil target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    [self performSelector:@selector(requestFailed:)  withObject:nil afterDelay:5];
}
- (void)requestFinished:(NSDictionary *)datas{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
    [self.ListCommunist addObjectsFromArray: [datas objectForKey:@"data"]];
    
    allPage=[datas[@"totalPage"] intValue];
    [self loadDataAndView];
}
-(void)loadDataAndView{
    self.view.backgroundColor=RGBCOLOR(240, 240, 240);
    UIButton*morebtn = (UIButton *)[self.mainBgView viewWithTag:1001];
    if(morebtn!=nil){
        [morebtn removeFromSuperview];
    }
    
    int fontTag=-1,height=0;
    for(int i=0;i<[self.ListCommunist count];i++){
        
        if(fontTag==-1) {
            height=0;
            
        }else{
            JFinancialLists *fontView=(JFinancialLists*)[self.view viewWithTag:fontTag];
            height=fontView.frame.origin.y+fontView.frame.size.height+2;
        }
        
        JFinancialLists *finaView=[[JFinancialLists alloc]initWithFrame:CGRectMake(0, height, 320, 50)];
        finaView.delegate=self;
        finaView.tag=i+400;
        fontTag=i+400;
        [finaView setTitleLabel:[self.ListCommunist[i] objectForKey:@"categoryname"]];
        [self.mainBgView addSubview:finaView];
        
        for(NSDictionary *dic in self.pointArr){
            if([[dic objectForKey:@"sysid"] isEqualToString:@"03"]&&[finaView.titleLabe.text isEqualToString:[dic objectForKey:@"categoryid"]]){
                [finaView  showOrHiddenRedLabel:NO];
                break;
            }else{
                [finaView  showOrHiddenRedLabel:YES];
            }
            
        }
        [finaView release];
    }
    //删除无用的categoryid
    for (NSDictionary *dic in self.pointArr){
        if( [[dic objectForKey:@"sysid"] isEqualToString:@"03"]){
            BOOL isHasValue=NO;
            for(int i=0;i<[self.ListCommunist count];i++){
                JFinancialLists *finaView=(JFinancialLists*)[self.mainBgView viewWithTag:i+400];
                if([finaView.titleLabe.text isEqualToString:[dic objectForKey:@"categoryid"]]){
                    isHasValue=YES;
                    break;
                }
            }
            if(!isHasValue)
                [[documentDataHelp sharedService] deleteTestList:@"03" withCategoryid:[dic objectForKey:@"categoryid"]];
        }
    }

    self.mainBgView.contentSize=CGSizeMake(320, (self.ListCommunist.count+1)*60+60);
}


- (void)requestFailed:(id)sender{
     [[STHUDManager sharedManager]hideHUDInView:self.view];
}
#pragma mark 加载视图
//加载返回按钮
-(void)loadBackView{
    mainBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height-46-self.iosChangeFloat)];
    self.mainBgView.delegate=self;
    [self.view addSubview:self.mainBgView];
    //返回按钮
    JButton *backButton=[[JButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tag:110];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    JTitleLabel *titleView=[[JTitleLabel alloc]initJTitleLabel:@"党务视窗" rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    [titleView release];
    
}
//触发方法
-(void)tapTheViewToSuper:(int)tag{
    JFinancialLists *financial=(JFinancialLists*)[self.mainBgView viewWithTag:tag];
    [[documentDataHelp sharedService] deleteTestList:@"03" withCategoryid:financial. titleLabe.text];
    [financial showOrHiddenRedLabel:YES];
    JCommunistListVC *communist=[[JCommunistListVC alloc]init];
    [communist setRequestName:financial.titleLabe.text];
    [self.navigationController pushViewController:communist animated:YES];
    
    
}
- (void)onBtnReturn_Click
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
