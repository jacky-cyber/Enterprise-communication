//
//  integratedVC.m
//  JieXinIphone
//
//  Created by macOne on 14-4-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "integratedVC.h"
#import "integratedDetailVC.h"
#import "integratedNewCell.h"
#import "documentDataHelp.h"
#import "integratedCell_02.h"
@interface integratedVC ()

@end

@implementation integratedVC

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
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    [[STHUDManager sharedManager] showHUDInView:self.view_01];
    self.max=0;
    self.pageNumber = 1;
    self.pageCount = 12;
    [self initData];
    [self initTableView];
    // Do any additional setup after loading the view from its nib.
}
-(NSString *)getHeadStr
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *headString= @"";
    if([string isEqualToString:@"111.11.28.30"])
    {
        headString=@"111.11.28.30:8087";
    }
    else
    {
        headString=@"111.11.28.9:8087";
    }
    return headString;
}
-(void)initData
{
    //    NSString *headStr = @"http://111.11.28.9:8087/integratedSzq/phoneInterface.action?";
    NSString *headStr = [NSString stringWithFormat:@"http://%@/integratedSzq/phoneInterface.action?",[self getHeadStr]];
    NSString *dizhi = [NSString stringWithFormat:@"%@cmd=querycourselist&pageNumber=%d&pageCount=%d",headStr,self.pageNumber,self.pageCount];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]intValue]==0)
        {
            //正确数据
            self.dataArray = [NSMutableArray arrayWithArray:[dic valueForKey:@"data"]];
            //
            self.totalPage = [[dic valueForKey:@"totalPage"]intValue];
            //
        }
    }
    else
    {
        NSLog(@"没数据");
    }
}
-(void)refreshData
{
    
    self.pageNumber++;
    NSLog(@"%d %d",self.pageNumber,self.totalPage);
    if(self.pageNumber>self.totalPage)
    {
        return;
    }
    NSString *headStr = [NSString stringWithFormat:@"http://%@/integratedSzq/phoneInterface.action?",[self getHeadStr]];
    NSString *dizhi = [NSString stringWithFormat:@"%@cmd=querycourselist&pageNumber=%d&pageCount=%d",headStr,self.pageNumber,self.pageCount];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]intValue]==0)
        {
            //正确数据
            [self.dataArray addObjectsFromArray:[dic valueForKey:@"data"]];
            //
            [self.tableView_current reloadData];
        }
    }
    else
    {
        NSLog(@"没数据");
    }
    
}
-(void)initTableView
{
    self.tableView_current = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    self.tableView_current.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0f];
    self.tableView_current.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView_current.delegate = self;
    self.tableView_current.dataSource = self;
    [self.view_01 addSubview:self.tableView_current];
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if(section == [self.dataArray  count]-1)
//    {
//        return 50;
//    }
//    else
//    {
//        return 0;
//    }
//    
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if(section == [self.dataArray  count]-1)
//    {
//        UIView *view_foot = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)]autorelease];
////        [view_foot.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
////        [view_foot.layer setBorderWidth:1.0f];
////        [view_foot.layer setCornerRadius:5.0f];
//        view_foot.backgroundColor = [UIColor whiteColor];
//        //
//        UIButton *button_more = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button_more setFrame:CGRectMake(0, 3, 320, 47)];
//        button_more.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//        [button_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button_more setTitle:@"更多" forState:UIControlStateNormal];
//        [button_more addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
//        [view_foot addSubview:button_more];
//        return view_foot;
//    }
//    else
//    {
//        return nil;
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == [self.dataArray  count]-1)
    {
        return 44;
    }
    else
    {
        return 1;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == [self.dataArray  count]-1)
    {
        UIView *view_foot = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)]autorelease];
        [view_foot.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
        [view_foot.layer setBorderWidth:1.0f];
        [view_foot.layer setCornerRadius:5.0f];
        view_foot.backgroundColor = [UIColor whiteColor];
        //
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        v.image = [UIImage imageNamed:@"PicInfo_separate.png"];
        [view_foot addSubview:v];
        //
        UIButton *button_more = [UIButton buttonWithType:UIButtonTypeCustom];
        [button_more setFrame:CGRectMake(0, 3, 320, 41)];
        button_more.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button_more setTitle:@"更多" forState:UIControlStateNormal];
        [button_more addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
        [view_foot addSubview:button_more];
        return view_foot;
    }
    else
    {
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        v.image = [UIImage imageNamed:@"PicInfo_separate.png"];
        return v;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmp_dic = [self.dataArray objectAtIndex:indexPath.section];
    NSString *msg_title = [tmp_dic valueForKey:@"title"];
    float he = 0;
    if([msg_title length]<=15)
    {
        he= 41.0f;
    }
    else if([msg_title length]>15&&[msg_title length]<=30)
    {
        he= 61.0;
    }
    else
    {
        he= 81.0;
    }
    return he;
    
//    NSDictionary *tmp_dic = [self.dataArray objectAtIndex:indexPath.section];
//    NSString *msg_title = [tmp_dic valueForKey:@"title"];
//    float he = 0;
//    if([msg_title length]<=15)
//    {
//        he= 46.0f;
//    }
//    else if([msg_title length]>15&&[msg_title length]<=30)
//    {
//        he= 66.0;
//    }
//    else
//    {
//        he= 86.0;
//    }
//    he = he +15;
//    return he;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    integratedCell_02 *cell = [[[integratedCell_02 alloc]init]autorelease];
    
    [cell fillValue:[self.dataArray objectAtIndex:indexPath.section]];
    cell.tableview_01 = tableView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
//    integratedNewCell *cell = [[[integratedNewCell alloc]init]autorelease];
//    
//    [cell fillValue:[self.dataArray objectAtIndex:indexPath.section]];
//    cell.tableview_01 = tableView;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray== nil) {
        return;
    }
//    integratedNewCell *cell = (integratedNewCell*)[self.tableView_current cellForRowAtIndexPath:indexPath];
//    cell.redPoint.hidden  = YES;
    //小红点隐藏
    
    integratedDetailVC *detailVC = [[[integratedDetailVC alloc]initWithNibName:@"integratedDetailVC" bundle:nil]autorelease];
    detailVC.dictionary = [self.dataArray objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)dealloc {
    [_view_01 release];
    [super dealloc];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
