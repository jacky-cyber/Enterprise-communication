//
//  DomumentShareController.m
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-3-31.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//
#define READ @"readcount"
#define DOWN @"downloadcount"
#define SCREENRECT [UIScreen mainScreen].bounds

#define PAGE_ONE   2

#import "DomumentShareController.h"
#import "dataCell.h"
#import "DocumentDetailViewController.h"
#import "HttpServiceHelper.h"
#import "documentDataHelp.h"
#import "programaModel.h"
#import "fileinfoModel.h"
#import "permissionModel.h"
#import "downloadrecordModel.h"
#import "filestatisticsModel.h"
#import "SVProgressHUD.h"
#import "documentSortViewController.h"

@interface DomumentShareController ()

@property (nonatomic,strong) UIButton *tempBtn;
@end

@implementation DomumentShareController
@synthesize viewTag;
@synthesize delegate;
@synthesize pageFlag;
@synthesize dataArr;
@synthesize variableArr;
@synthesize baseArr;

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
    
    [super createCustomNavBarWithoutLogo];
    self.searchField.delegate=self;
    [self.searchField addTarget:self action:@selector(searchDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    pageFlag=NO;
    
    dataArr=[[NSMutableArray alloc] initWithCapacity:100];
    variableArr=[[NSMutableArray alloc] initWithCapacity:100];
    baseArr=[[NSMutableArray alloc] initWithCapacity:100];
    
    [self initNavView];
    
    [self initTableView];

    _tempBtn=self.lastBtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)initNavView
{
    
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat, SCREENRECT.size.width, 44)];
    [self.view addSubview:baseView];
    //baseView.backgroundColor = [UIColor redColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,2, 40, 40);
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:backBtn];
    
    NSString *titleStr;
    if(viewTag==0){
        titleStr=@"共享文档";
    }else{
        titleStr=@"我的上传";
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(/*(SCREENRECT.size.width-150)/2-100*/backBtn.frame.origin.x+backBtn.frame.size.width,2, 120, 40)];
    label.text = titleStr;
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:label];
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame = CGRectMake(SCREENRECT.size.width-40-10,2, 40, 40);
    [typeBtn setTitle:@"类目" forState:UIControlStateNormal];
    typeBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [typeBtn setTitleColor:[UIColor colorWithRed:22/255.0f green:139/255.0f blue:217/255.0f alpha:1] forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(chooseType) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:typeBtn];
    
    
}

-(void)initTableView{
    
    CGFloat y=_lastBtn.frame.origin.y+_lastBtn.frame.size.height+42+2;
    CGFloat height=SCREENRECT.size.height-y-33-40+20- (CGFloat)(iOSVersion<7.0? 20:0);
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREENRECT.size.width, height)];
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    // _tableview.separatorInset=  UIEdgeInsetsMake(0, 15, 0, 15);
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.rowHeight=50;
    [self.view addSubview:_tableview];
}




//跳转到类目页面
-(void)chooseType{
    
    documentSortViewController *sortController =  [[documentSortViewController alloc] init];
    sortController.sortDelegate=self;
    [self.navigationController pushViewController:sortController animated:YES];
    [delegate hiddenOrShowBottomView:YES];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)changeBtnImage:(UIButton *)button{
    
    int tagNum=button.tag;
    
    [self moveAnimation:tagNum];
    
    [button setTitleColor:[UIColor colorWithRed:22/255.0f green:139/255.0f blue:217/255.0f alpha:1] forState:UIControlStateNormal];
    if(_tempBtn){
        [_tempBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    [button setShowsTouchWhenHighlighted:YES];
    _tempBtn=button;
    
    switch (tagNum) {
        case 1:
        {
            if([dataArr count]==0){
                return ;
            }
            dataArr=baseArr;
            [_tableview reloadData];
            break;
        }
        case 2:
        {
            if([dataArr count]==0){
                return ;
            }
            variableArr=[self orderBy:READ];
            dataArr=variableArr;
            [_tableview reloadData];
            break;
        }
        case 3:
        {
            if([dataArr count]==0){
                return ;
            }
            variableArr=[self orderBy:DOWN];
            dataArr=variableArr;
            [_tableview reloadData];
            break;
        }
    }
    
    
   
}


-(void)moveAnimation:(int)num{
    int x=0+SCREENRECT.size.width/3*(num-1);
    
    [UIView animateWithDuration:0.5 animations:^{
       CGRect rect  =  self.lineLabel.frame;
        rect.origin.x=x;
        self.lineLabel.frame=rect;
    }];
    

}


//浏览排序和下载排序
-(NSMutableArray *)orderBy:(NSString *)str{
    
    NSMutableArray *myMutableArr = [[NSMutableArray alloc] init] ;
    
    int i=0;
    for(NSDictionary *dic in baseArr[1]){
        NSDictionary *tempDic= [[NSDictionary alloc] initWithObjectsAndKeys:dic[@"downloadcount"],@"downloadcount",dic[@"readcount"],@"readcount",[NSNumber numberWithInt:i],@"index", nil];
        [myMutableArr addObject:tempDic];
        i++;
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:str ascending:YES]];
    [myMutableArr sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArr=[[NSMutableArray alloc] initWithCapacity:100];
    
    NSMutableArray *fileArr=[[NSMutableArray alloc] initWithCapacity:100];
    NSMutableArray *fstaticArr=[[NSMutableArray alloc] initWithCapacity:100];
    for(NSDictionary *dic in myMutableArr){
        
        NSDictionary *fileDic= baseArr[0][[dic[@"index"] integerValue]];
        NSDictionary *statDic=baseArr[1][[dic[@"index"] integerValue]];
        [fileArr addObject:fileDic];
        [fstaticArr addObject:statDic];
        
    }
    [tempArr addObject:fileArr];
    [tempArr addObject:fstaticArr];
    return tempArr;
}

#pragma mark tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(viewTag==0){
        if ([dataArr count]!=0) {
            return [dataArr[0] count];
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cell";
    dataCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"dataCell" owner:self options:nil];
        
        for (id oneObject in nibs)
            if ([oneObject isKindOfClass:[dataCell class]])
                cell = (dataCell *)oneObject;
    }
    
    int row=indexPath.row;
    NSDictionary *info=dataArr[0][row];
  
    cell.docNameLabel.text=[info valueForKey:@"name"];
    NSString *timeStr=[info valueForKey:@"updatetime"];
    cell.docTimeLabel.text=[timeStr substringToIndex: [timeStr rangeOfString:@" "].location];
    
    NSDictionary *stics=dataArr[1][row];
    cell.docReadLabel.text=[NSString stringWithFormat:@"%@",stics[@"readcount"]];
    cell.docDownLabel.text=[NSString stringWithFormat:@"%@",stics[@"downloadcount"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *infodic = dataArr[0][indexPath.row];
    NSDictionary *statdic= dataArr[1][indexPath.row];
    NSArray *arr=[[NSArray alloc] initWithObjects:infodic,statdic, nil];
    
    DocumentDetailViewController *detailController = [[DocumentDetailViewController alloc] initWithNibName:@"DocumentDetailViewController" bundle:nil];
    detailController.dataArray=arr;
    
    [self.navigationController pushViewController:detailController animated:YES];
    [delegate hiddenOrShowBottomView:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [delegate hiddenOrShowBottomView:NO];
}


#pragma mark keyborad
-(void)keyboardWillShow:(NSNotification *)notification{
    
    NSDictionary *dic=[notification valueForKey:@"userInfo"];
    NSValue * keyboradValue=[dic objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyboradRect;
    [keyboradValue getValue:&keyboradRect];
    if(pageFlag){
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect=self.view.frame;
            rect.origin.y=-keyboradRect.size.height+44;
            self.view.frame=rect;
            
        }];
        
        UIView *clickView=[[UIView alloc] initWithFrame:CGRectMake(0, keyboradRect.size.height-22, SCREENRECT.size.width, 200)];
        UITapGestureRecognizer *tapGest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKey)];
        clickView.tag=1002;
        [clickView addGestureRecognizer:tapGest];
        clickView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:clickView];
    }
    
}

-(void)keyboardWillHidden:(NSNotification *)notification{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        
        CGRect rect=self.view.frame;
        rect.origin.y=0;
        self.view.frame=rect;
        
    }];
    
    UIView *view=[self.view viewWithTag:1002];
    [view removeFromSuperview];
}

-(void)closeKey{
    
    
    CGRect rect=self.view.frame;
    int y=rect.origin.y;
    if(y!=0){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect2=rect;
            rect2.origin.y=0;
            self.view.frame=rect2;
        }];
        
        UIView *view=[self.view viewWithTag:1002];
        [view removeFromSuperview];
        
    }
    
}

#pragma mark textField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField==self.searchField){
        [self.searchField resignFirstResponder];
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    
    return YES;
}

-(void)searchDidChange:(UITextField *)textField{
    
    NSString *searchStr=textField.text;
    NSMutableArray *resultArr=[[NSMutableArray alloc] initWithCapacity:0];
    
    if([dataArr count]==0){
       
        return ;
    }
    
    if(textField==self.searchField){//如果是搜索框
        
        if(textField.text==nil || textField.text.length==0){//如果内容清空
            NSLog(@"监听方法------%@",textField.text);
            [textField resignFirstResponder];
            if(_tempBtn == nil ||  _tempBtn.tag==1){  //如果是默认列表
                resultArr=baseArr;
            }else{  //如果是排序之后的列表
                resultArr = variableArr;
            }
            dataArr=resultArr;
            
            [_tableview reloadData];
            
            
            return ;
        }
        
        if(_tempBtn == nil ||  _tempBtn.tag==1){  //如果是默认列表
            resultArr=[self  fuzzyMatching:searchStr withArr:baseArr];
        }else{  //如果是排序之后的列表
            resultArr =  [self fuzzyMatching:searchStr withArr:variableArr];
        }
        
        if([resultArr[0] count]!=0){
            dataArr = resultArr;
            [_tableview reloadData];
        }else{
            dataArr = resultArr;
            [_tableview reloadData];
        }
    }
    
}

-(NSMutableArray *)fuzzyMatching:(NSString *)str withArr:(NSMutableArray *)arr{
    
    NSMutableArray *resultArr=[[NSMutableArray alloc] initWithCapacity:100];
    NSMutableArray *tempArr=[[NSMutableArray alloc] initWithCapacity:100];
    NSMutableArray *infoArr=[[NSMutableArray alloc] initWithCapacity:100];
    NSMutableArray *statArr=[[NSMutableArray alloc] initWithCapacity:100];
    
    int i=0;
    for(NSDictionary *dic in arr[0]){
        NSString *name=[dic objectForKey:@"name"];
        NSRange range=[name rangeOfString:str];
        if(range.location!=NSNotFound){
            NSDictionary *tempDic=[[NSDictionary alloc] initWithObjectsAndKeys:dic,@"dic",[NSNumber numberWithInt:i] ,@"index",nil];
            [tempArr addObject:tempDic];
        }
        i++;
    }
    
    for(NSDictionary *dic in tempArr){
        int index=[[dic valueForKey:@"index"] intValue];
        [infoArr addObject:[dic valueForKey:@"dic"]];
        [statArr addObject:arr[1][index] ];
    }
    [resultArr addObject:infoArr];
    [resultArr addObject:statArr];
    
    return resultArr;
    
}

-(void)setBaseArr:(NSMutableArray *)baseArray{
    
   

    
    if([baseArray[0] count]==0){
        
        [dataArr removeAllObjects];
        [_tableview reloadData];
        
     
        NSLog(@"没有数据");
        return ;
    }
    
    baseArr=baseArray;
    dataArr=[[NSMutableArray alloc] initWithArray:baseArray] ;
    dataArr= baseArr;
    
    
    [_tableview reloadData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
