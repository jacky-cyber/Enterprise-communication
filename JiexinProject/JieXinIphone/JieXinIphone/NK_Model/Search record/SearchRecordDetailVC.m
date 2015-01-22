//
//  SearchRecordDetailVC.m
//  JieXinIphone
//
//  Created by macOne on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchRecordDetailVC.h"
#import "searchRecordCell.h"
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
    self.titleLabel.text = self.titleString;
    self.totalPage = 0;
    self.queryway = 0;
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
            NSLog(@"total = %d",self.totalPage);
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
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=queryall&pageNumber=%d&pageCount=%d",headStr,self.pageNumber,self.pageCount];
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
    return 220;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_01";
    searchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"searchRecordCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cell_id];
        cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    }
    cell.selectionStyle =     UITableViewCellSelectionStyleNone;
    [cell fillValue: [self.dataArray objectAtIndex:indexPath.section]];
    return cell;
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
