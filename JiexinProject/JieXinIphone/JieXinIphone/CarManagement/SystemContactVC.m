//
//  SystemContactVC.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14/6/10.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SystemContactVC.h"
#import "ABContactsHelper.h"

@interface SystemContactVC ()

@end

@implementation SystemContactVC
@synthesize listView;
@synthesize source;
@synthesize selectDelegate;

- (id)initWithData:(NSMutableArray *)array andType:(CarSelectType)type
{
    self = [super init];
    if (self) {
        // Custom initialization
        if (iOSVersion < 7.0) {
            self.iosChangeFloat = 0;
        }else{
            self.iosChangeFloat = 20.f;
        }
        
        _type = type;
        self.source = array;
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
        case Car_DepType:
        {
            titleLabel.text = @"选择部门";
        }
            break;
            
        case Car_mobileType:
        {
             titleLabel.text = @"选择联系人";
        }
            break;
            
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
        case Car_DepType:
        {
            cell.textLabel.text = [[self.source objectAtIndex:indexPath.row] objectForKey:@"deptname"];
        }
            break;
            
        case Car_mobileType:
        {
            NSString *mobile = nil;
            cell.textLabel.text = [[self.source objectAtIndex:indexPath.row] objectForKey:@"name"];
            if ([[[self.source objectAtIndex:indexPath.row] objectForKey:@"mobile"] isKindOfClass:[NSString class]]) {
                mobile = [[self.source objectAtIndex:indexPath.row] objectForKey:@"mobile"];
            }
            else
            {
                mobile = [[[self.source objectAtIndex:indexPath.row] objectForKey:@"mobile"] stringValue];
            }
            cell.detailTextLabel.text = mobile;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(selectFinish:andType:)])
    {
        [self.selectDelegate selectFinish:indexPath.row andType:_type];
    }
    
    [self goBack:nil];
}


@end
