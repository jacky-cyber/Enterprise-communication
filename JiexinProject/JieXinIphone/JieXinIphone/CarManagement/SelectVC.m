//
//  SelectVC.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14/6/11.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SelectVC.h"
#import "User.h"

@interface SelectVC ()

@end

@implementation SelectVC

@synthesize listView;
@synthesize source;
@synthesize selectDelegate;

- (id)initWithData:(NSMutableArray *)array andType:(SelectType)type
{
    self = [super init];
    if (self) {
        // Custom initialization
        if (iOSVersion < 7.0) {
            self.iosChangeFloat = 0;
        }else{
            self.iosChangeFloat = 20.f;
        }
        
        self.source = [[[NSArray alloc] initWithArray:array] autorelease];
        _type = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,self.iosChangeFloat, 50, 40);
    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside ];
    [backBtn setImage:[UIImage imageNamed:@"nuiview_button_return.png" ]forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.iosChangeFloat, 100, 40)];
    switch (_type) {
        case DepType:
        {
            titleLabel.text = @"请选择部门";
        }break;
        case JobType:
        {
           titleLabel.text = @"请选择职位";
        }break;
        case LeaderType:
        {
            titleLabel.text = @"请选择审批人";
        }break;
        case UserType:
        {
            titleLabel.text = @"请选择姓名";
        }break;
            
        default:
            break;
    }
    titleLabel.textColor = kDarkerGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    // Do any additional setup after loading the view.
    self.listView = [[[UITableView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat + 44, kScreen_Width, kScreen_Height - 20 - 44) style:UITableViewStylePlain] autorelease];
    listView.delegate = self;
    listView.dataSource = self;
    [self.view addSubview:listView];
}

- (void)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate and Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    switch (_type) {
        case DepType:
        {
            cell.textLabel.text = [[self.source objectAtIndex:indexPath.row] objectForKey:@"department"];
        }break;
        case JobType:
        {
            cell.textLabel.text = [[self.source objectAtIndex:indexPath.row] objectForKey:@"jobName"];
        }break;
        case LeaderType:
        {
            cell.textLabel.text = [[self.source objectAtIndex:indexPath.row] objectForKey:@"leaderName"];
        }break;
        case UserType:
        {
            User *user = [self.source objectAtIndex:indexPath.row];
            cell.textLabel.text = user.nickname;
        }break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(selectFinished:andType:)])
    {
        [self.selectDelegate selectFinished:indexPath.row andType:_type];
    }
    
    [self goBack:nil];
}


@end
