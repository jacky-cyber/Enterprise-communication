//
//  SearchRecordDetailVC.m
//  JieXinIphone
//
//  Created by macOne on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchRecordDetailVC.h"
#import "searchRecordCell.h"
#import "searchRecordCell_new.h"
@interface SearchRecordDetailVC ()

@end

@implementation SearchRecordDetailVC

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
    self.titleLabel.text = self.titleString;
    self.totalPage = 0;
    self.pageNumber = 1;
    self.pageCount = 12;
    self.dataArray = [NSMutableArray array];
    [self initDataSource];
    [self initTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initTableView
{
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view_01 addSubview: self.tableView];
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];

}
-(NSString *)getHeadStr
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *headString= @"";
    if([string isEqualToString:@"111.11.28.30"])
    {
        headString=@"111.11.28.30:8083";
    }
    else
    {
        headString=@"111.11.28.9:8089";
    }
    return headString;
}
-(void)initDataSource
{
    //    NSString *headStr = @"http://10.120.145.55:8089/File/ClientInterface?";
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=query&pageNumber=%d&pageCount=%d&queryway=%d&queryby=%@",headStr,self.pageNumber,self.pageCount,self.queryway,self.queryby];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
//    NSLog(@"搜索结果url = %@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]integerValue]==0)
        {
            if([self.dataArray count]!=0)
            {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:[dic valueForKey:@"date"]];
            self.totalPage = [[dic valueForKey:@"totalPage"]intValue];
//            NSLog(@"total = %d",self.totalPage);
        }
    }
    else
    {
        NSLog(@"没数据");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refreshData
{
    self.pageNumber++;
    if(self.pageNumber>self.totalPage)
    {
        return;
    }
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=query&pageNumber=%d&pageCount=%d&queryway=%d&queryby=%@",headStr,self.pageNumber,self.pageCount,self.queryway,self.queryby];
//    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
//    NSString *urlString = [NSString stringWithFormat:@"%@cmd=queryall&pageNumber=%d&pageCount=%d",headStr,self.pageNumber,self.pageCount];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"resultcode"]integerValue]==0)
        {
            [self.dataArray addObjectsFromArray:[dic valueForKey:@"date"]];
            [self.tableView reloadData];
        }
    }
    else
    {
        NSLog(@"没数据");
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==[self.dataArray count]-1)
    {
        if(self.totalPage>1)
        {
            return 44;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == [self.dataArray  count]-1)
    {
        UIView *view_foot = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)]autorelease];
        UIButton *button_more = [UIButton buttonWithType:UIButtonTypeCustom];
        [button_more setFrame:CGRectMake(100, 3, 120, 44)];
        button_more.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button_more setTitle:@"更多" forState:UIControlStateNormal];
        [button_more addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
        [view_foot addSubview:button_more];
        return view_foot;
    }
    else
    {
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
   NSString *nameStr =[NSString stringWithFormat:@"名称:%@",[dic valueForKey:@"filename"]];
   NSString *numberStr =[NSString stringWithFormat:@"编号:%@",[dic valueForKey:@"filenum"]];
//    NSLog(@"section = %d , %d",[nameStr length],[numberStr length]);
    
    UILabel *label_11 = [[[UILabel alloc]init]autorelease];
    label_11.frame = CGRectMake(10, 5, 280, 20);
    label_11.font = [UIFont systemFontOfSize:16];
    label_11.textAlignment = UITextAlignmentLeft;
    label_11.text = nameStr;
    [label_11 setNumberOfLines:0];
    label_11.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize titleSize1 = [label_11.text sizeWithFont:label_11.font constrainedToSize:CGSizeMake(label_11.frame.size.width, MAXFLOAT) lineBreakMode:label_11.lineBreakMode];
    [label_11 setFrame:CGRectMake(label_11.frame.origin.x, label_11.frame.origin.y, label_11.frame.size.width, titleSize1.height)];
    
    UILabel *label_12 = [[[UILabel alloc]init]autorelease];
    label_12.frame = CGRectMake(10, 5, 280, 20);
    label_12.font = [UIFont systemFontOfSize:16];
    label_12.textAlignment = UITextAlignmentLeft;
    label_12.text = numberStr;
    [label_12 setNumberOfLines:0];
    label_12.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize titleSize2 = [label_12.text sizeWithFont:label_12.font constrainedToSize:CGSizeMake(label_12.frame.size.width, MAXFLOAT) lineBreakMode:label_12.lineBreakMode];
    [label_12 setFrame:CGRectMake(label_12.frame.origin.x, label_12.frame.origin.y, label_12.frame.size.width, titleSize2.height)];
    float he = 189;
    he = he +10;
    int m = label_11.frame.size.height/20.0;
    int n = label_12.frame.size.height/20.0;
//    NSLog(@"label_11.height = %f  m = %d",label_11.frame.size.height,m);
//    NSLog(@"label_12.height = %f  n =%d",label_12.frame.size.height,n);
    he = he+20*(m+n);
    return he;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchRecordCell_new *cell = [[[searchRecordCell_new alloc]init]autorelease];
    
    [cell fillValue:[self.dataArray objectAtIndex:indexPath.section]];
    cell.tableview_01 = tableView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
//    static NSString *cell_id = @"cell_01";
//    searchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
//    if (cell == nil) {
//        UINib *nib = [UINib nibWithNibName:@"searchRecordCell" bundle:nil];
//        [tableView registerNib:nib forCellReuseIdentifier:cell_id];
//        cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
//    }
//    cell.selectionStyle =     UITableViewCellSelectionStyleNone;
//    [cell fillValue: [self.dataArray objectAtIndex:indexPath.section]];
//    return cell;
}
- (void)dealloc {
    [_view_01 release];
    [_titleLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setView_01:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
