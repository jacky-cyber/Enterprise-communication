#import "humanResourceListsVC.h"
#import "myTitleLabel.h"
#import "myButton.h"
#import "humanResourceLists.h"
#import "HttpServiceHelper.h"
#import "humanResourceManagementVC.h"
#import "documentDataHelp.h"

@interface humanResourceListsVC ()

@property (nonatomic) int currentPage;
@property (nonatomic) int allPage;

@property (nonatomic,strong)  NSArray *pointArr;

@end

@implementation humanResourceListsVC
@synthesize mainBgView,ListFinanicia;
@synthesize currentPage;
@synthesize allPage;
@synthesize pointArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPage=1;
    self.ListFinanicia=[[NSMutableArray alloc] initWithCapacity:100];
    
    self.pointArr = [[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    [super createCustomNavBarWithoutLogo];
    [self loadBackView];
    [self reloadFinancialListData];
    
}


-(void)reloadFinancialListData{
    [[STHUDManager sharedManager]showHUDInViewToMySelf:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQueryhumanResourceAllcategory info:@{@"pageNumber":[NSString stringWithFormat:@"%d",currentPage],@"pageCount":[NSString stringWithFormat:@"%d",12]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}
- (void)requestFinished:(NSDictionary *)datas{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
    [self.ListFinanicia addObjectsFromArray: [datas objectForKey:@"data"]];
    
    allPage=[datas[@"totalPage"] intValue];
    [self loadDataAndView:allPage>1];
}
-(void)loadDataAndView:(BOOL)flag{
    
    UIButton*morebtn = (UIButton *)[self.mainBgView viewWithTag:1001];
    if(morebtn!=nil){
        [morebtn removeFromSuperview];
    }
    [self deleteErrorCategoryidWithDbArray:self.pointArr andWithListArray:self.ListFinanicia andWithSysId:@"09"];
    int fontTag=-1,height=0;
   
  
    for(int i=0;i<[self.ListFinanicia count];i++){
        
        if(fontTag==-1) {
            height=0;
            fontTag=[[self.ListFinanicia[i] objectForKey:@"categoryid"] intValue];
        }else{
            humanResourceLists *fontView=(humanResourceLists*)[self.view viewWithTag:fontTag];
            height=fontView.frame.origin.y+fontView.frame.size.height+2;
            fontTag=[[self.ListFinanicia[i] objectForKey:@"categoryid"] intValue];
        }
        
        int categoryid=[[self.ListFinanicia[i] objectForKey:@"categoryid"] intValue];
        humanResourceLists *finaView=[[humanResourceLists alloc]initWithFrame:CGRectMake(0, height, 320, 50)];
        finaView.delegate=self;
        finaView.tag=categoryid;
        [finaView setTitleLabel:[self.ListFinanicia[i] objectForKey:@"name"]];
        
        [self.mainBgView addSubview:finaView];
        
        
        for(NSDictionary *dic in self.pointArr){
            int newsId=[dic[@"categoryid"] intValue];
            
            if(categoryid==newsId){
                [finaView  showOrHiddenRedLabel:NO];
                break;
            }else{
                [finaView  showOrHiddenRedLabel:YES];
            }
        }
        [finaView release];
        
    }
    
    
    id finaView = [self.mainBgView.subviews lastObject] ;
    CGRect rect;
    if([finaView isKindOfClass:[humanResourceLists class]]){
        humanResourceLists *listview=(humanResourceLists *)finaView;
        rect=CGRectMake(0,listview.frame.origin.y+listview.frame.size.height+10 , kScreen_Width, 60);
    }else{
        UILabel *redLabel=(UILabel *)finaView;
        rect=CGRectMake(0,redLabel.frame.origin.y+3+redLabel.frame.size.height+50 , kScreen_Width, 60);
    }
    if(flag){
        UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom] ;
        moreBtn.frame=rect;
        moreBtn.tag=1001;
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchDown];
        [self.mainBgView addSubview:moreBtn];
    }
    self.mainBgView.contentSize=CGSizeMake(320, (self.ListFinanicia.count+1)*60+60);
}
 //删除无用的categoryid,异常处理
-(void)deleteErrorCategoryidWithDbArray:(NSArray*)dbArray andWithListArray:(NSArray*)listArray andWithSysId:(NSString*)sysid{
    for (int i=0; i<[dbArray count]; i++) {
        BOOL isHaveID = NO;
        
       NSString* dbTag=[NSString stringWithFormat:@"%@",[dbArray[i] objectForKey:@"categoryid"]];
        for (int j=0; j<[listArray count]; j++) {
           NSString* realTag=[NSString stringWithFormat:@"%@",[listArray[j] objectForKey:@"categoryid"]];
            if ([dbTag isEqualToString:realTag]) {
                isHaveID = YES;
                break;
            }
            
        }
        if (!isHaveID) {
            [[documentDataHelp sharedService] deleteTestList:sysid withCategoryid:dbTag];
        }
        
    }

}
-(void)loadMore:(UIButton *)sender{
    
    currentPage++;
    if(currentPage>allPage){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    [[STHUDManager sharedManager]showHUDInView:self.view];
    [[HttpServiceHelper sharedService] requestForType:kQueryhumanResourceAllcategory info:@{@"pageNumber":[NSString stringWithFormat:@"%d",currentPage],@"pageCount":[NSString stringWithFormat:@"%d",12]} target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
    
}

- (void)requestFailed:(id)sender{
    [[STHUDManager sharedManager]hideHUDInView:self.view];
}
#pragma mark 加载视图
//加载返回按钮
-(void)loadBackView{
    self.mainBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+46, kScreen_Width, kScreen_Height-46-self.iosChangeFloat)];
    self.mainBgView.delegate=self;
    self.mainBgView.backgroundColor=RGBCOLOR(240, 240, 240);
    [self.view addSubview:self.mainBgView];
    
    //返回按钮
    myButton *backButton=[[myButton alloc]initButton:nil image:@"nuiview_button_return.png" type:BUTTONTYPE_BACK fontSize:0 point:CGPointMake(5, self.iosChangeFloat+2) tags:110];
    [backButton addTarget:self action:@selector(onBtnReturn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    myTitleLabel *titleView=[[myTitleLabel alloc]initTitleLabel:@"人力资源" rect:CGRectMake(40, self.iosChangeFloat, 200,44) fontSize:17 fontColor:RGBCOLOR(101, 99,100)];
    titleView.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:titleView];
    
    
}
//触发方法
-(void)tapTheViewToSuper:(int)tag{
    
    [[documentDataHelp sharedService] deleteTestList:@"09" withCategoryid:[NSString stringWithFormat:@"%d",tag]];
    
    humanResourceLists *listview = (humanResourceLists *) [self.mainBgView viewWithTag:tag];
    [listview showOrHiddenRedLabel:YES];
    
    humanResourceManagementVC *financial=[[humanResourceManagementVC alloc]init];
    [financial setRequestTag:tag name:listview.titleLabe.text];
    [self.navigationController pushViewController:financial animated:YES];
    
    
}
- (void)onBtnReturn_Click
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
