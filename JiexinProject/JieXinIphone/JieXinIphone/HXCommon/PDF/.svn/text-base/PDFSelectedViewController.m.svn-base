//
//  PDFSelectedViewController.m
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PDFSelectedViewController.h"

@interface PDFSelectedViewController ()

@end

@implementation PDFSelectedViewController

@synthesize searchStrings = _searchStrings;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if ((self = [super initWithStyle:style])) {
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self.clearsSelectionOnViewWillAppear = NO;
		self.contentSizeForViewInPopover = CGSizeMake(320.0, 320);
	}  
    //self.searchStrings = [NSMutableArray array];
}

- (void)reloadWithData:(NSArray *)data
{
	self.searchStrings = [NSMutableArray arrayWithArray:data];
	[(UITableView *)self.view reloadData];
}

- (void)dealloc 
{
    self.searchStrings = nil;
    self.delegate = nil;
    [super dealloc];
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [_searchStrings count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 56;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"AssociationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSString *string = [_searchStrings objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.text = string;
    
    return cell;
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
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)doSelected:(NSNumber *)index
{
	[_delegate searchStringSelected:[index intValue]];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (_delegate != nil)
	{
        // NSString *searchString = [_searchStrings objectAtIndex:indexPath.row];
        
		//[self performSelectorOnMainThread:@selector(loadWaiting) withObject:nil waitUntilDone:NO];
		UIActivityIndicatorView *acv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		acv.center = self.view.center;
		[self.view addSubview:acv];
		[acv startAnimating];
		[acv release];
		
		[self performSelector:@selector(doSelected:) withObject:[NSNumber numberWithInt:indexPath.row] afterDelay:0.2];
    }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end

