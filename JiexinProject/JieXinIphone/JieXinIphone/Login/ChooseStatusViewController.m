//
//  ChooseStatusViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChooseStatusViewController.h"


@interface ChooseStatusViewController ()

@property (nonatomic, retain) NSArray *listArr;

@end

@implementation ChooseStatusViewController

- (void)dealloc
{
    self.listArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *offline = [NSString stringWithFormat:@"%d",Status_Offline];
    NSString *online = [NSString stringWithFormat:@"%d",Status_Online];
    NSString *busy = [NSString stringWithFormat:@"%d",Status_Busy];
    NSString *leave = [NSString stringWithFormat:@"%d",Status_Leave];
    NSString *hidden = [NSString stringWithFormat:@"%d",Status_Hidden];
    
    self.listArr = @[@{kStatusTitle: @"离线",kStatusValue: offline},@{kStatusTitle: @"在线",kStatusValue: online},@{kStatusTitle: @"忙碌",kStatusValue: busy},@{kStatusTitle: @"离开",kStatusValue: leave},@{kStatusTitle: @"隐身",kStatusValue: hidden}];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[_listArr objectAtIndex:indexPath.row] objectForKey:kStatusTitle];
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(chooseStatusFinish:)]) {
        [_delegate chooseStatusFinish:[_listArr objectAtIndex:indexPath.row]];
        //发送dismissPopver通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TapInsideCategory" object:nil userInfo:nil];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
