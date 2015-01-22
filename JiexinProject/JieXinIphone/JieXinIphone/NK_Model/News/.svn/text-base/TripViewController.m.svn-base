//
//  TripViewController.m
//  JieXinIphone
//
//  Created by apple on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "TripViewController.h"
#import "UIViewExt.h"
#import "CKCalendarView.h"

@interface TripViewController ()

@end

@implementation TripViewController
@synthesize personArr;
@synthesize flag;

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
    UIBarButtonItem *leftButtonItem = [[ UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    leftButtonItem.image=[UIImage imageNamed:@"1.png"];
    self.topNav.topItem.leftBarButtonItem=leftButtonItem;

    
    UIBarButtonItem *itemrightBt = [[UIBarButtonItem alloc] initWithTitle:@"aa" style:UIBarButtonItemStylePlain target:self action:@selector(qiehua)];
    self.topNav.topItem.rightBarButtonItem = itemrightBt;
    
    //创建日历视图
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    calendar.frame = CGRectMake(self.topNav.left, self.topNav.bottom, 320, 470);
    [self.view addSubview:calendar];
    
    
    personArr=[[NSArray alloc] initWithObjects:@"aaa",@"bbb",@"ccc", nil];
    flag=NO;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [personArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSInteger row=indexPath.row;
    cell.textLabel.text=personArr[row];
    cell.textLabel.textColor=[UIColor whiteColor];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor=[UIColor blueColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row=indexPath.row;
    self.topNav.topItem.rightBarButtonItem.title=personArr[row];
    
    UITableView *tableview=(UITableView *)[self.view viewWithTag:101];
    if(tableview!=nil){
        [tableview removeFromSuperview];
        flag=!flag;
    }
}

#pragma mark - Method Action
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)qiehua
{
    
    if(!flag){
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame= CGRectMake(110,self.topNav.bottom , 200, 120 );
        tableView.tag=101;
        [self.view addSubview:tableView];
        
        tableView.backgroundColor=[UIColor blackColor];
        tableView.dataSource=self;
        tableView.delegate=self;
    }else{
        UITableView *tableview=(UITableView *)[self.view viewWithTag:101];
        [UIView animateWithDuration:1
                         animations:^{
                             CGRect rect=CGRectMake(self.topNav.right, tableview.frame.origin.y, 0, 0) ;
                             tableview.frame=rect;
                             tableview.alpha=1.0f;
                             
                            
                         }completion:^(BOOL finished) {
                             if(tableview!=nil){
                                 [tableview removeFromSuperview];
                             }
                }
         ];
        
        
    }
    flag=!flag;
    
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
