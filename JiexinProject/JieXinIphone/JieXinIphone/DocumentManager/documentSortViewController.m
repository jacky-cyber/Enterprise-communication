//
//  documentSortViewController.m
//  JieXinIphone
//
//  Created by  zhuang on 14-4-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "documentSortViewController.h"
#import "dataCell.h"
#import "programaCell.h"
#import "HttpServiceHelper.h"
#import "programaModel.h"
#import "programaModel.h"
#import "fileinfoModel.h"
#import "permissionModel.h"
#import "downloadrecordModel.h"
#import "filestatisticsModel.h"
#import "documentDataHelp.h"
#import "SVProgressHUD.h"
@interface documentSortViewController ()

@end

@implementation documentSortViewController
@synthesize bntTag;
@synthesize sortTableView;
@synthesize programaArray;
@synthesize tableViewArray;
@synthesize cnt;
@synthesize proid;
@synthesize proIdDic;
@synthesize baseArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        bntTag=1;
        cnt=0;
        proIdDic = [[NSMutableDictionary alloc]init];
        proid = [[NSString alloc]init];
        baseArr = [[NSMutableArray alloc]init];
        programaArray = [[NSMutableArray alloc]init];
        tableViewArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // self.view.backgroundColor = [UIColor redColor];
    //self.view.backgroundColor = [UIColor redColor];
    [self initSortTableViewDataWithDic:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"upId",@"0",@"groupId", nil]];
    [super createCustomNavBarWithoutLogo];
    [self initBaseView];
    [self initSortTableView];
    
}
-(void)initBaseView{
    //创建返回按钮
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBnt.frame = CGRectMake(10, statusBar+2, 40, 40);
    [backBnt setImage:[UIImage imageNamed:/*@"normalBack.png"*/@"nuiview_button_return.png"] forState:UIControlStateNormal];
    backBnt.tag = bntTag++;
    [backBnt addTarget:self action:@selector(bntClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBnt];
    
    //创建标题标签
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(320/2-50-60-12, statusBar+4+4, 100, 28)];
    titleLable.text = @"文档分类";
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLable];
    
    
    //创建shang部的按钮
    NSArray * titleArr = @[@"全部分类"];
    for(int i=0;i<[titleArr count];i++){
        UIButton* bnt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bnt.frame = CGRectMake(220, statusBar+2, 100, 40) ;
        [bnt setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        bnt.titleLabel.font = [UIFont systemFontOfSize:18];
        bnt.tag = bntTag++;
        //bnt.backgroundColor = [UIColor greenColor];
        [bnt addTarget:self action:@selector(bntClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bnt];
    }
}

-(void)initSortTableView{
    sortTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, statusBar+44, 320, [UIScreen mainScreen].bounds.size.height-40-20-40-20) style:UITableViewStylePlain];
    sortTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    sortTableView.delegate = self;
    sortTableView.dataSource = self;
    [self.view addSubview:sortTableView];
    
}
//初始化当前页面的数据
-(void)initSortTableViewDataWithDic:(NSDictionary*)dic{
    [SVProgressHUD showWithStatus:@"请等待...."];
    [[HttpServiceHelper sharedService] requestForType:kQuerycourseDocumentSortMange info:dic target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}
//文档分级的请求完成
- (void)requestFinished:(NSDictionary *)datas
{
    [SVProgressHUD dismiss];
    cnt++;
    NSArray * rowsArr = [[NSArray alloc]init];
    rowsArr = [datas objectForKey:@"rows"];
    NSString * total = [[NSString alloc]init];
    total = [datas objectForKey:@"total"];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for(int i=0;i<[total intValue];i++){
        NSDictionary * dic = [rowsArr objectAtIndex:i];
        programaModel * model = [[programaModel alloc]init];
        model.createtime = [dic objectForKey:@"createTime"];
        model.creater = [dic objectForKey:@"creater"];
        model.groupid = [dic objectForKey:@"groupId"];
        model.hassub = [dic objectForKey:@"hasSub"];
        model.upid = [dic objectForKey:@"id"];
        model.name = [dic objectForKey:@"name"];
        model.plevel = [dic objectForKey:@"plevel"];
        [arr addObject:model];
    }
    [programaArray addObject:arr];
    [sortTableView reloadData];
}

#pragma mark 请求网络失败
- (void)requestFailed:(id)sender
{
    [SVProgressHUD dismiss];
    NSLog(@"%@",sender);
}


-(void)bntClick:(UIButton*)sender{
    if (sender.tag==1){
        if(cnt>1)
        {
            cnt--;
            [sortTableView reloadData];
        }
        //返回上级
        else{
              [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else{
        //返回全部
        [SVProgressHUD showWithStatus:@"请等待...."];
        
        [[HttpServiceHelper sharedService] requestForType:kQuerycourseDocumentManage info:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"proId", nil] target:self successSel:@"requestFinished1:" failedSel:@"requestFailed1:"];
    }
    
    NSLog(@"%d",sender.tag);
}

#pragma tableViewDelegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([programaArray count]==0)return 0 ;
    else{
        NSLog(@"%d",[[programaArray objectAtIndex:cnt-1] count]);
        return [[programaArray objectAtIndex:cnt-1] count];}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CMainCell = @"CMainCell";
    programaCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"programaCell" owner:self options:nil];
    for (id oneObject in nibs)
        if ([oneObject isKindOfClass:[programaCell class]])
            cell = (programaCell *)oneObject;
   // cell.accessoryType = UITableViewCellAccessoryDetailButton;
    programaModel * model = [[programaModel alloc]init];
    model = [[programaArray objectAtIndex:cnt-1] objectAtIndex:indexPath.row];
    cell.programaNameLable.text =model.name;
    cell.choiceBnt.tag =indexPath.row;
    [cell.choiceBnt addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
    if([model.hassub isEqualToString:@"1"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        UIImage *image= [ UIImage imageNamed:@"uitableviewcell_06_image_01.png" ];
//        UIButton *button = [ UIButton buttonWithType:UIButtonTypeCustom ];
//        CGRect frame = CGRectMake( 0.0 , 0.0 , image.size.width , image.size.height );
//        button.tag=indexPath.row;
//        button. frame = frame;
//        [button setBackgroundImage:image forState:UIControlStateNormal ];
//        button. backgroundColor = [UIColor clearColor ];
//        [button addTarget:self action:@selector(buttonPressedAction:)  forControlEvents:UIControlEventTouchUpInside];
//        cell. accessoryView = button;
//
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
       return cell;
}
//栏目分级展开
-(void)buttonPressedAction:(UIButton*)sender{
    [SVProgressHUD showWithStatus:@"请等待...."];
    programaModel * model = [[programaModel alloc]init];
    model = [[programaArray objectAtIndex:cnt-1] objectAtIndex:sender.tag];
     [[HttpServiceHelper sharedService] requestForType:kQuerycourseDocumentManage info:[NSDictionary dictionaryWithObjectsAndKeys:model.upid,@"proId", nil] target:self successSel:@"requestFinished1:" failedSel:@"requestFailed1:"];
 
//    programaModel * model = [[programaModel alloc]init];
//    model = [[programaArray objectAtIndex:cnt-1] objectAtIndex:sender.tag];
//    
//    int sub =  [model.hassub intValue];
//    if(sub){
//        [self initSortTableViewDataWithDic:[NSDictionary dictionaryWithObjectsAndKeys:model.upid,@"upId",@"0",@"groupId", nil]];
//    }

    
}
//点击选择后请求文件的详细信息
- (void)requestFinished1:(NSDictionary *)datas
{
    [SVProgressHUD dismiss];
    NSArray * modelArr= @[@"programa",@"fileinfo",@"permission",@"downloadrecord",@"filestatistics"];
    for(int i=0;i<5;i++){
        [[documentDataHelp sharedService]deleteDocModelItem:[modelArr objectAtIndex:i]];
    }
    NSArray * fileArr= [datas objectForKey:@"rows"];
    for(int i =0;i<[fileArr count];i++){
        
        //    programaModel * programItem = [[programaModel alloc]init];
        /*
         字段含义
         name           栏目名称
         upid           父栏目
         hassub         是否有子栏目
         plevel         栏目等级
         createtime     创建时间
         creater        创建人
         updatetime     更新时间
         deleted        删除标记0/1
         groupid
         */
        // programItem.name
        
        //添加fileinfoModel到数据库
        fileinfoModel * fileinfoItem = [[fileinfoModel alloc]init];
        fileinfoItem.name =[[fileArr objectAtIndex:i] objectForKey:@"name"];
        fileinfoItem.fileid =[[fileArr objectAtIndex:i] objectForKey:@"id"];
        fileinfoItem.programaid = [[fileArr objectAtIndex:i] objectForKey:@"programaId"];
        fileinfoItem.title =[[fileArr objectAtIndex:i] objectForKey:@"title"];
        fileinfoItem.filedesc =[[fileArr objectAtIndex:i] objectForKey:@"filedesc"];
        fileinfoItem.filesize =[[fileArr objectAtIndex:i] objectForKey:@"size"];
        fileinfoItem.path =[[fileArr objectAtIndex:i] objectForKey:@"path"];
        fileinfoItem.ext =[[fileArr objectAtIndex:i] objectForKey:@"ext"];
        fileinfoItem.pdfpath =[[fileArr objectAtIndex:i] objectForKey:@"pdfpath"];
        fileinfoItem.uploadtime =[[fileArr objectAtIndex:i] objectForKey:@"uploadtime"];
        fileinfoItem.updatetime =[[fileArr objectAtIndex:i] objectForKey:@"updatetime"];
        fileinfoItem.uploaderid = [[fileArr objectAtIndex:i] objectForKey:@"uploaderId"];
        fileinfoItem.jpgStr = [[fileArr objectAtIndex:i] objectForKey:@"jpgpath"];
        fileinfoItem.jpgCount = [[fileArr objectAtIndex:i] objectForKey:@"jpgCount"];
        // fileinfoItem.groupid =
        [[documentDataHelp sharedService]insertDocModelItem:fileinfoItem];
        
        
        
        //添加permissionModel到数据库
        permissionModel* permissionItem = [[permissionModel alloc]init];
        permissionItem.candownload =[[fileArr objectAtIndex:i] objectForKey:@"canDownload"];
        permissionItem.canread =[[fileArr objectAtIndex:i] objectForKey:@"canRead"];
        permissionItem.fileid = [[fileArr objectAtIndex:i] objectForKey:@"id"];
        //permissionItem.userid =
        [[documentDataHelp sharedService]insertDocModelItem:permissionItem];
        
        
        
        //添加downloadrecordModel到数据库
        downloadrecordModel * downloadrecordItem = [[downloadrecordModel alloc]init];
        //downloadrecordItem.userid =
        downloadrecordItem.fileid =[[fileArr objectAtIndex:i] objectForKey:@"id"];
        //downloadrecordItem.downloadtime =
        //downloadrecordItem.watermarkcontent=
        [[documentDataHelp sharedService]insertDocModelItem:downloadrecordItem];
        
        
        
        //添加filestatisticsModel到数据库
        filestatisticsModel * filestatisticsItem = [[filestatisticsModel alloc]init];
        filestatisticsItem.fileid =[[fileArr objectAtIndex:i] objectForKey:@"id"];
        filestatisticsItem.downloadcount =[[fileArr objectAtIndex:i] objectForKey:@"downloadCount"];
        filestatisticsItem.readcount = [[fileArr objectAtIndex:i] objectForKey:@"readCount"];
        filestatisticsItem.updatetime =[[fileArr objectAtIndex:i] objectForKey:@"updatetime"];
        [[documentDataHelp sharedService]insertDocModelItem:filestatisticsItem];
        
    }
    for(int i=0;i<5;i++){
        NSMutableArray * readArr =[[documentDataHelp sharedService]readDocModelItem:[modelArr objectAtIndex:i]];
        NSLog(@"%@==%@",[modelArr objectAtIndex:i],readArr);
    }
    [baseArr removeAllObjects];
    [baseArr addObject:[[documentDataHelp sharedService]readDocModelItem:[modelArr objectAtIndex:1]]];
    [baseArr addObject:[[documentDataHelp sharedService]readDocModelItem:[modelArr objectAtIndex:4]]];
    
    //  [self.sortDelegate fileInfoData:baseArr];
    if([self.sortDelegate respondsToSelector:@selector(setBaseArr:)]){
        [self.sortDelegate setValue:baseArr forKey:@"baseArr"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark 请求网络失败
- (void)requestFailed1:(id)sender
{
    [SVProgressHUD dismiss];
    NSLog(@"%@",sender);
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
//    programaModel * model = [[programaModel alloc]init];
//    model = [[programaArray objectAtIndex:cnt-1] objectAtIndex:indexPath.row];
//    [[HttpServiceHelper sharedService] requestForType:kQuerycourseDocumentManage info:[NSDictionary dictionaryWithObjectsAndKeys:model.upid,@"proId", nil] target:self successSel:@"requestFinished1:" failedSel:@"requestFailed1:"];
    
    
        programaModel * model = [[programaModel alloc]init];
        model = [[programaArray objectAtIndex:cnt-1] objectAtIndex:indexPath.row];
    
        int sub =  [model.hassub intValue];
        if(sub){
              [SVProgressHUD showWithStatus:@"请等待...."];
            [self initSortTableViewDataWithDic:[NSDictionary dictionaryWithObjectsAndKeys:model.upid,@"upId",@"0",@"groupId", nil]];
        }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
