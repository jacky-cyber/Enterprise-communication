//
//  LinkContactsView.m
//  JieXinIphone
//
//  Created by tony on 14-2-28.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkContactsView.h"
#import "TKAddressBook.h"
#import "NSString+TKUtilities.h"
#import "UIImage+TKUtilities.h"
#import "ContactsBt.h"
#import "STHUDManager.h"
#import "User.h"


@interface LinkContactsView()

@property (readwrite, nonatomic) ABAddressBookRef addressBooks;

@end
@implementation LinkContactsView
{
    BOOL _isNotFirst;//不是第一次刷新数据
}

@synthesize tableListView = _tableListView;
@synthesize delegate = _delegate;
@synthesize addressBookArray = _addressBookArray;
@synthesize searchResultArray = _searchResultArray;
-(void)dealloc
{
    if(_addressBookArray)
        [_addressBookArray release];
    if(_searchResultArray)
        [_searchResultArray release];
    [self.datasArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSMutableArray *tempDatasArray = [[NSMutableArray alloc] init];
         self.datasArray = tempDatasArray;
        [tempDatasArray release];
        self.backgroundColor = kMAIN_BACKGROUND_COLOR;
        
        NSMutableArray *tempAddressBookArray = [[NSMutableArray alloc] init];
        self.addressBookArray = tempAddressBookArray;
        [tempAddressBookArray release];
        
        NSMutableArray *tempSearchArray = [[NSMutableArray alloc] init];
        self.searchResultArray = tempSearchArray;
        [tempSearchArray release];
        
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    PullTableView *tableView = [[PullTableView alloc] init];
    [tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    tableView.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.tableListView = tableView;
    self.tableListView.dataSource = self;
    [self.tableListView configRefreshType:OnlyHeaderRefresh];
    self.tableListView.pullDelegate = self;
    self.tableListView.delegate = self;
    [tableView release];
    [self addSubview:self.tableListView];
    self.tableListView.sectionIndexColor = [UIColor blueColor];
    [[STHUDManager sharedManager] showHUDInView:self];
    //[self getAddressBookDataModel];
}

#pragma mark - TableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return nil;
//    } else {
    NSArray *arr  = [[NSMutableArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
    [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    NSMutableArray *returnArr = [NSMutableArray arrayWithArray:arr];
    if ([returnArr count]) {
        [returnArr removeObjectAtIndex:0];
    }
    return returnArr;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return 0;
//    } else {
//        if (title == UITableViewIndexSearch) {
//            [tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
//            return -1;
//        } else {
            return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
       // }
   // }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//	if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return 1;
//	} else {
        return [_datasArray count];
   // }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//	if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return nil;
//    } else {
        return [[_datasArray objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
   // }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellHeight + 10.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//	if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [_filteredListContent count];
//    } else {
        return [[_datasArray objectAtIndex:section] count];
   // }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCustomCellID = @"QBPeoplePickerControllerCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    for(UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    
    TKAddressBook *addressBook = nil;
    addressBook = (TKAddressBook *)(TKAddressBook *)[[self.datasArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    //图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    iconImageView.image = [UIImage imageNamed:@"m_online.png"];
    [cell.contentView addSubview:iconImageView];
    [iconImageView release];
    
    //人名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+40, 5, 150, 20)];
    nameLabel.font = [UIFont systemFontOfSize:kCommonFont];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    [cell.contentView addSubview:nameLabel];
    if ([[addressBook.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0)
    {
        nameLabel.text = addressBook.name;
    } else {
        nameLabel.text = @"No Name";
    }
    [nameLabel release];
    
    //电话
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+40, 5+20, 150, 20)];
    phoneLabel.font = [UIFont systemFontOfSize:kCommonFont];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0];
    [cell.contentView addSubview:phoneLabel];
    if ([[addressBook.tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0)
    {
        phoneLabel.text = addressBook.tel;
    } else {
        phoneLabel.text = @"No mobilephone";
    }
    [phoneLabel release];
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
//        {
            ContactsBt *phoneBt = [ContactsBt buttonWithType:UIButtonTypeCustom];
            [phoneBt addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
            phoneBt.btStr = addressBook.tel;
            phoneBt.frame = CGRectMake(235, (cell.frame.size.height -25)/2.0 , 15, 25);
            [phoneBt setBackgroundImage:[UIImage imageNamed:@"tab_dial_normal.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:phoneBt];
    
            ContactsBt *mesBt = [ContactsBt buttonWithType:UIButtonTypeCustom];
            User *aUser = [[[User alloc] init] autorelease];
            aUser.nickname = addressBook.name;
            aUser.mobile = addressBook.tel;
            [mesBt addTarget:self action:@selector(sendMES:) forControlEvents:UIControlEventTouchUpInside];
            mesBt.user = aUser;
//            mesBt.user = 
            mesBt.frame = CGRectMake(265, (cell.frame.size.height -20)/2.0 , 30, 20);
            [mesBt setBackgroundImage:[UIImage imageNamed:@"messageBtn.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:mesBt];
//        }
//    }
    
    
//    if ([[addressBook.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
//        cell.textLabel.text = addressBook.name;
//    } else {
//        cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
//        cell.textLabel.text = @"No Name";
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - 判断是否能访问通讯录
- (void)whetherCanVisitAddressBook
{
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        NSString *applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
        NSString *str = [NSString stringWithFormat:@"%@%@%@",@"请到系统\"设置>隐私>通讯录\"中开启\"",applicationName,@"\"访问权限"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"同步通讯录被阻止了"
                                                        message:str
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
}

#pragma mark -  Create addressbook data model
-(void)getAddressBookDataModel
{
    // Create addressbook data model
    if(_isNotFirst)
        [[STHUDManager sharedManager] showHUDInView:self];
    NSMutableArray *addressBookTemp = [NSMutableArray array];
    if([[UIDevice currentDevice].systemVersion floatValue]<6.0)
    {
        self.addressBooks = ABAddressBookCreate();
        
    }
    else
    {
        self.addressBooks = ABAddressBookCreateWithOptions(nil, nil);
        //ios 6.0 添加等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(self.addressBooks, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    [self whetherCanVisitAddressBook];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(_addressBooks);
    CFIndex nPeople = ABAddressBookGetPersonCount(_addressBooks);
    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        
        /*
         Save thumbnail image - performance decreasing
         UIImage *personImage = nil;
         if (person != nil && ABPersonHasImageData(person)) {
         if ( &ABPersonCopyImageDataWithFormat != nil ) {
         // iOS >= 4.1
         CFDataRef contactThumbnailData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
         personImage = [[UIImage imageWithData:(NSData*)contactThumbnailData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactThumbnailData);
         CFDataRef contactImageData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatOriginalSize);
         CFRelease(contactImageData);
         
         } else {
         // iOS < 4.1
         CFDataRef contactImageData = ABPersonCopyImageData(person);
         personImage = [[UIImage imageWithData:(NSData*)contactImageData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactImageData);
         }
         }
         [addressBook setThumbnail:personImage];
         */
        
        NSString *nameString = (NSString *)abName;
        NSString *lastNameString = (NSString *)abLastName;
        
        if ((id)abFullName != nil) {
            nameString = (NSString *)abFullName;
        } else {
            if ((id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        if(!nameString || [nameString isEqualToString:@""])
            addressBook.name = @"名字为空";
        else
         addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        addressBook.rowSelected = NO;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            
            for (NSInteger m = 0; m < valuesCount; m++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, m);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = [(NSString*)value telephoneWithReformat];
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        [addressBookTemp addObject:addressBook];
        [addressBook release];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
    self.addressBookArray = addressBookTemp;
    if (allPeople) {
        CFRelease(allPeople);
    }
    if (_addressBooks) {
        CFRelease(self.addressBooks);
    }
    
    // Sort data
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    for (TKAddressBook *addressBook in addressBookTemp) {
        NSInteger sect = [theCollation sectionForObject:addressBook
                                collationStringSelector:@selector(name)];
        addressBook.sectionNumber = sect;
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (TKAddressBook *addressBook in addressBookTemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:addressBook.sectionNumber] addObject:addressBook];
    }
    
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(name)];//会崩溃
        [self.datasArray addObject:sortedSection];
    }
    //self.datasArray = addressBookTemp;
    [[STHUDManager sharedManager] hideHUDInView:self];
    [self.tableListView reloadData];
}

- (void)callPhone:(ContactsBt *)sender
{
    if([self.delegate respondsToSelector:@selector(linkContactsCallPhone:)])
    {
        [self.delegate linkContactsCallPhone:sender];
    }
}

-(void)sendMES:(ContactsBt *)sender
{
    if([self.delegate respondsToSelector:@selector(linkContactsSendSMS:)])
    {
        [self.delegate linkContactsSendSMS:sender];
    }
}

- (void) refreshTable
{
    //添加刷新代码
    _isNotFirst = YES;
    self.datasArray = [NSMutableArray array];
    [self getAddressBookDataModel];
    self.tableListView.pullLastRefreshDate = [NSDate date];
    self.tableListView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    //添加加载代码
    self.tableListView.pullTableIsLoadingMore = NO;
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.5f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.5f];
}


#pragma mark - 查询操作（通过谓词查询）
- (void)searchWithKey:(NSString *)keyStr
{
    if ([keyStr isEqualToString:@""]) {
        return;
    }
    
    NSString *keyName = @"";
    keyName = [TKAddressBook keyName];
    /**< 模糊查找*/
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", keyName, keyStr];
    /**< 精确查找*/
    //  NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", keyName, searchText];
    
    NSLog(@"predicate %@",predicateString);
    
    NSMutableArray  *filteredArray = [NSMutableArray arrayWithArray:[_addressBookArray filteredArrayUsingPredicate:predicateString]];
    
    _searchResultArray = filteredArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
