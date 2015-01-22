//
//  SearchRecordVC.m
//  JieXinIphone
//
//  Created by macOne on 14-4-22.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SearchRecordVC.h"
#import "searchRecordCell.h"
#import "SearchRecordVC_01.h"
@interface SearchRecordVC ()

@end

@implementation SearchRecordVC

@synthesize button_search;
@synthesize searchBar_search;
@synthesize textField_search;

#define TYPE_TAG 999

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
    self.view_02.hidden = YES;
    self.queryby = @"";
    self.queryway = 0;
    self.pageNumber = 1;
    self.pageCount = 12;
    self.dataArray = [NSMutableArray array];
    self.typeArray = [NSMutableArray array];
    [[STHUDManager sharedManager] showHUDInView:self.view_01];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initDataSource];
    [self initTableView];
    [self initType];
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
}
-(void)initTableView
{
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    self.tableView.separatorStyle =     UITableViewCellSeparatorStyleNone;
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
-(void)initType
{
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=queryalltype",headStr];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
//    NSLog(@"类型=%@",url);
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
            NSString *strAll = [[[dic valueForKey:@"date"]valueForKey:@"type"]objectAtIndex:0];
            NSArray *array_one = [strAll componentsSeparatedByString:@";"];
            for(int j=0;j<[array_one count];j++)
            {
                NSString *str_add = [[[array_one objectAtIndex:j] componentsSeparatedByString:@","]objectAtIndex:1];
                [self.typeArray addObject:str_add];
            }
        }
    }
    else
    {
        NSLog(@"没数据");
    }
    
}
-(void)initDataSource
{
    //    NSString *myencodeUrlStr = @"http://111.11.28.30:8083/File/denglu?logname=liangwenjing&username=123";
    //    NSString *headStr = @"http://10.120.145.55:8089/File/ClientInterface?";
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=queryall&pageNumber=%d&pageCount=%d",headStr,self.pageNumber,self.pageCount];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
    //    NSLog(@"初始化=%@",url);
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
            //            NSLog(@"totalPage=%d",self.totalPage);
         
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
-(void)recordOfSearch
{
    //    NSString *headStr = @"http://10.120.145.55:8089/File/ClientInterface?";
    NSString *headStr = [NSString stringWithFormat:@"http://%@/File/ClientInterface?",[self getHeadStr]];
    NSString *urlString = [NSString stringWithFormat:@"%@cmd=query&pageNumber=1&pageCount=100&queryway=%d&queryby=%@",headStr,self.queryway,self.queryby];
    NSString *myencodeUrlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSURL *url =[NSURL URLWithString:myencodeUrlStr];
    NSLog(@"搜索结果=%@",url);
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
            //
            self.totalPage = [[dic valueForKey:@"totalPage"]intValue];
            //
            //            NSLog(@"搜索结果的数量=%d",[self.dataArray count]);
        }
    }
    else
    {
        NSLog(@"没数据");
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define mark tableView
//没用的2个方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.queryby = searchBar_search.text;
    [searchBar_search resignFirstResponder];
    [self recordOfSearch];
}
-(void)goToSearch
{
    self.queryby = searchBar_search.text;
    [searchBar_search resignFirstResponder];
    [self recordOfSearch];
}
//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.queryby = textField_search.text;
    [textField resignFirstResponder];
    [self recordOfSearch];
    return YES;
}
-(void)goSearch
{
    self.queryby = textField_search.text;
    if([textField_search isFirstResponder])
    {
        [textField_search resignFirstResponder];
    }
    [self recordOfSearch];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section>0)
    {
        return 0;
    }
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section>0)
    {
        return nil;
    }
    UIView *headerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)]autorelease];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    
    //    220, 3, 90, 36
    UIImageView *view_left = [[[UIImageView alloc]initWithFrame:CGRectMake(100, 3, 210, 36)]autorelease];
    view_left.layer.cornerRadius = 18.0;
    view_left.userInteractionEnabled = YES;
    view_left.image = [UIImage imageNamed:@"searchReord-search_01.png"];
    [headerView addSubview:view_left];
    //
    //    searchBar_search = [[[UISearchBar alloc]initWithFrame:CGRectMake(5, 0, 170, 36)]autorelease];
    //    searchBar_search.placeholder = @"输入内容";
    //    [searchBar_search setText:self.queryby];
    //    searchBar_search.backgroundColor = [UIColor clearColor];
    //    searchBar_search.searchBarStyle = UISearchBarStyleMinimal;
    //    searchBar_search.showsCancelButton = NO;
    //    searchBar_search.showsBookmarkButton = NO;
    //    searchBar_search.showsScopeBar = NO;
    //    searchBar_search.delegate = self;
    //    [view_left addSubview:searchBar_search];
    //
    textField_search = [[[UITextField alloc]initWithFrame:CGRectMake(5, 0, 170, 36)]autorelease];
    [textField_search setBackgroundColor:[UIColor clearColor]];
    textField_search.placeholder = @"  输入内容";
    [textField_search setText:self.queryby];
    textField_search.delegate = self;
    textField_search.font = [UIFont systemFontOfSize:15];
    [view_left addSubview:textField_search];
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(170, textField_search.frame.origin.y, 30, textField_search.frame.size.height)];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [view_left addSubview:btn];
    //    5, 3, 210, 36
    UIImageView *view_right = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 90, 36)]autorelease];
    view_right.layer.cornerRadius = 18.0;
    view_right.userInteractionEnabled = YES;
    view_right.image = [UIImage imageNamed:@"searchReord-search_02.png"];
    [headerView addSubview:view_right];
    //
    button_search = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_search setFrame:CGRectMake(5, 0, 50, 36)];
    [button_search setBackgroundColor:[UIColor clearColor]];
    [button_search setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button_search.titleLabel.font = [UIFont systemFontOfSize:15];
    if(self.queryway==0)
    {
        [button_search setTitle:@"名称" forState:UIControlStateNormal];
    }
    else if(self.queryway==1)
    {
        [button_search setTitle:@"年份" forState:UIControlStateNormal];
    }
    else if(self.queryway==2)
    {
        [button_search setTitle:@"编号" forState:UIControlStateNormal];
    }
    else
    {
        [button_search setTitle:@"名称" forState:UIControlStateNormal];
    }
    [view_right addSubview:button_search];
    //
    UIButton *btn_choose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_choose setFrame:CGRectMake(65, button_search.frame.origin.y, 20, button_search.frame.size.height)];
    //    [btn_choose setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
    [btn_choose setBackgroundColor:[UIColor clearColor]];
    [btn_choose addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [view_right addSubview:btn_choose];
    //
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapBtn setFrame:CGRectMake(0, 0, view_right.frame.size.width, view_right.frame.size.height)];
    [tapBtn addTarget:self action:@selector(chooseQueryway) forControlEvents:UIControlEventTouchUpInside];
    [view_right addSubview:tapBtn];
    //
    return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
    //    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    //    return [self.dataArray count];
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
    //    [cell fillValue: [self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


- (IBAction)goBack:(id)sender {
    SearchRecordVC_01 *search_01 = [[SearchRecordVC_01 alloc]initWithNibName:@"SearchRecordVC_01" bundle:nil];
    [self.navigationController pushViewController:search_01 animated:YES];
    [search_01 release];
    return;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_view_01 release];
    [_view_02 release];
    [super dealloc];
}
- (IBAction)showTypes:(id)sender {
    
    if([self.view_01 viewWithTag:TYPE_TAG]==nil)
    {
        UIView *view_fifteen= [[[UIView alloc]initWithFrame:CGRectMake(200, 0, 110, 15*28)]autorelease];
        view_fifteen.tag = TYPE_TAG;
        for(int j=0;j<[self.typeArray count];j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0, 28*j, view_fifteen.frame.size.width, 28)];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            if(j==0)
            {
                [button setBackgroundImage:[UIImage imageNamed:@"searchReord-1-1.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"searchReord-1-2.png"] forState:UIControlStateHighlighted];
            }
            else if(j==[self.typeArray count])
            {
                [button setBackgroundImage:[UIImage imageNamed:@"searchReords-3-1.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"searchReord-3-2.png"] forState:UIControlStateHighlighted];
            }
            else
            {
                [button setBackgroundImage:[UIImage imageNamed:@"searchReords-2-1.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"searchReords-2-2.png"] forState:UIControlStateHighlighted];
            }
            [button setTitle:[NSString stringWithFormat:@"%@",[self.typeArray objectAtIndex:j]] forState:UIControlStateNormal];
            button.tag = j;
            [button addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
            [view_fifteen addSubview:button];
        }
        [self.view_01 addSubview:view_fifteen];
    }
    else
    {
        [[self.view_01 viewWithTag:TYPE_TAG] removeFromSuperview];
    }
}
-(void)chooseType:(UIButton *)button_chooseType
{
    self.queryway = 3;
    self.queryby = [NSString stringWithFormat:@"%d",button_chooseType.tag];
    [[self.view_01 viewWithTag:TYPE_TAG] removeFromSuperview];
    NSLog(@"%@",[self.typeArray objectAtIndex:button_chooseType.tag]);
    [self recordOfSearch];
}
-(void)chooseQueryway
{
    if(self.view_02.hidden == YES)
    {
        [self.view_01 addSubview:self.view_02];
        self.view_02.hidden = NO;
    }
    else
    {
        self.view_02.hidden = YES;
    }
}
- (void)viewDidUnload {
    [self setView_02:nil];
    [super viewDidUnload];
}
- (IBAction)searchWithName:(id)sender {
    self.queryway = 0;
    self.view_02.hidden = YES;
    [button_search setTitle:@"名称" forState:UIControlStateNormal];
}

- (IBAction)searchWithYear:(id)sender {
    self.queryway = 1;
    self.view_02.hidden = YES;
    [button_search setTitle:@"年份" forState:UIControlStateNormal];
    
}

- (IBAction)searchWithNumber:(id)sender {
    self.queryway = 2;
    self.view_02.hidden = YES;
    [button_search setTitle:@"编号" forState:UIControlStateNormal];
    
}
@end
