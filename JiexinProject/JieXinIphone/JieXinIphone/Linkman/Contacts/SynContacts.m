//
//  SynContacts.m
//  SunboxApp_Standard_IPhone2.0
//
//  Created by tony on 13-8-12.
//  Copyright (c) 2013年 liqiang. All rights reserved.
//

#import "SynContacts.h"
#define SynFailedTag  1000
#define LocalGroupName @"LocalGroupName"
#import "User.h"

@implementation SynContacts
{
    NSMutableArray *_currentArray;
}
@synthesize addressBookRef = _addressBookRef;
-(id)init
{
    self = [super init];
    _currentArray = [[NSMutableArray alloc] init];
    if(!self)
    {
        return nil;
    }
    
    return self;
}

-(void)dealloc
{
    if(_addressBookRef)
    {
        CFRelease(_addressBookRef);
    }
    if(_currentArray)
        [_currentArray release];
    [super dealloc];
}

#pragma mark - 同步
- (void)synContacts:(NSMutableArray *)arr
{
    [self creatAddressBookRef];
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
    _currentArray = [NSMutableArray arrayWithArray:arr];//当前操作的数据
    [self creatGroupRef];
}

- (void)creatAddressBookRef
{
    if([[UIDevice currentDevice].systemVersion floatValue]<6.0)
    {
        self.addressBookRef = ABAddressBookCreate();
        
    }
    else
    {
        self.addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
        //ios 6.0 添加等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    
}

- (void)creatGroupRef
{
    //是否有该分组
    BOOL isHaveGrounp = false;
    NSString *bundleName = @"企信通讯录";
    //[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    NSString *localGroupName = [[NSUserDefaults standardUserDefaults] objectForKey:LocalGroupName];
    
    //得到所有分组
    CFArrayRef groupRefArray = ABAddressBookCopyArrayOfAllGroups(self.addressBookRef);
    
    for (NSInteger i=0; i<CFArrayGetCount(groupRefArray); i++)
    {
        ABRecordRef groupRef = CFArrayGetValueAtIndex(groupRefArray, i);
        NSString *groupRefName = (NSString*)ABRecordCopyValue(groupRef, kABGroupNameProperty);
        //如果已经有这个分组则不创建，||[groupRefName isEqualToString:@"SunboxApp_Standard_IPad"]||[groupRefName isEqualToString:@"SunboxApp_Standard_IPhone2.0"]
        if ([groupRefName isEqualToString:localGroupName]||[groupRefName isEqualToString:bundleName]) {
           // BOOL canRemoveGroup = NO;
            //删除该分组
            //canRemoveGroup = ABAddressBookRemoveRecord(self.addressBookRef, groupRef, nil);
//            if (!canRemoveGroup) {
//                [self synContactsFinishWithStr:@"同步失败。"];
//            }
//
            isHaveGrounp = YES;
           // [self synContactsFinishWithStr:@"添加联系人成功。"];
            break;
        }
        else
        {
            isHaveGrounp = NO;
        }
    }
    
    ABRecordRef groupRef = ABGroupCreate();
    
    BOOL couldSetValue = NO;
    couldSetValue = ABRecordSetValue(groupRef, kABGroupNameProperty, bundleName, NULL);
    if (!couldSetValue) {
        [self synContactsFinishWithStr:@"创建群组失败！"];
    }
    
    if(!isHaveGrounp){
        BOOL couldAddRecord = NO;
        couldAddRecord = ABAddressBookAddRecord(self.addressBookRef, groupRef, NULL);
        if (!couldAddRecord) {
            NSLog(@"分组创建失败!");
           // [self synContactsFinishWithStr:@"创建群组失败！"];
        }
        else
        {
            NSLog(@"分组创建成功!");
            //[self synContactsFinishWithStr:@"创建群组成功！"];
        }
    }
     CFRelease(groupRef);
    BOOL couldSaveAddressBook = NO;
    couldSaveAddressBook = ABAddressBookSave(self.addressBookRef, nil);
    if (!couldSaveAddressBook) {
        [self synContactsFinishWithStr:@"创建群组失败！"];
    }
    if (![bundleName isEqualToString:localGroupName]) {
        [[NSUserDefaults standardUserDefaults] setValue:bundleName forKey:LocalGroupName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self addGrounpMembers:_currentArray];
}

- (void)addGrounpMembers:(NSMutableArray *)membersArr
{
    //得到要添加人的分组
    NSString *localGroupName = [[NSUserDefaults standardUserDefaults] objectForKey:LocalGroupName];
    CFArrayRef groupRefArray = ABAddressBookCopyArrayOfAllGroups(self.addressBookRef);
    ABRecordRef nowGroupRef;
    for (NSInteger i=0; i<CFArrayGetCount(groupRefArray); i++)
    {
        ABRecordRef groupRef = CFArrayGetValueAtIndex(groupRefArray, i);
        NSString *groupRefName = (NSString*)ABRecordCopyValue(groupRef, kABGroupNameProperty);
        if ([groupRefName isEqualToString:localGroupName])
        {
            nowGroupRef = groupRef;
        }
    }
    
    //获取通讯录中指定分组中所有的联系人
    NSArray *array = (NSArray *)ABGroupCopyArrayOfAllMembers(nowGroupRef);//ABAddressBookCopyArrayOfAllPeople(self.addressBookRef);
    BOOL isHaveUser = FALSE;//是否有该用户
    for(User *dic in membersArr)
    {
        for (id obj in array) {//判断某个用户是否存在
            ABRecordRef people = (ABRecordRef)obj;
            //获取用户的名称
            NSString *lastName = (NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            if([dic.nickname isEqualToString:lastName])
            {
                //如果名字相同，则更新现有信息，如果没有该联系人，则添加信息
                NSLog(@"该名字%@已经存在",lastName);
                isHaveUser = YES;
                if([self updateContactUser:dic withGroupRecordRef:nowGroupRef withPeopleRecordRef:people])
                {
                    [self synContactsFinishWithStr:@"更新联系人成功!"];
                }
                break;
            }else
            {
                isHaveUser = NO;
            }
        }
        
        if(!isHaveUser)
        {
            //如果没有该记录，则添加
             ABRecordRef memberRef = ABPersonCreate();
            if([self addContactUser:dic withGroupRecordRef:nowGroupRef withPeopleRecordRef:memberRef])
            {
                [self synContactsFinishWithStr:@"添加联系人成功!"];
            }
        }
    }
    
    CFErrorRef error = NULL;
    ABAddressBookSave(self.addressBookRef, &error);
    
}

-(BOOL)addContactUser:(User *)contactUserDic withGroupRecordRef:(ABRecordRef)nowGroupRef withPeopleRecordRef:(ABRecordRef)memberRef
{
    BOOL flag = true;
    NSString *name = contactUserDic.nickname;//[contactUserDic objectForKey:@"Name"];
    //NSMutableArray *phoneArr = [contactUserDic objectForKey:@"phoneArr"];
    //NSMutableArray *mobilePhoneArr = [contactUserDic objectForKey:@"mobilePhoneArr"];
    NSString *email = contactUserDic.email;//[contactUserDic objectForKey:@"email"];
    NSString *department = contactUserDic.deparment.departmentname;//[contactUserDic objectForKey:@"department"];
    
    if ([name length]) {
        BOOL couldSetNameValue = NO;
        couldSetNameValue = ABRecordSetValue(memberRef, kABPersonLastNameProperty, name, NULL);
        if (!couldSetNameValue) {
            NSLog(@"failed");
            flag = FALSE;
        }
    }
    
    BOOL couldSetPhoneValue = NO;
    ABMutableMultiValueRef tmpMutableMultiPhones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
    NSString *telphone = contactUserDic.telephone;
    if ([telphone length]) {
        ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, telphone, kABWorkLabel, NULL);
    }

    NSString *phone = contactUserDic.mobile;
    if ([phone length]) {
        ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, phone, kABPersonPhoneMobileLabel, NULL);
    }
        
    couldSetPhoneValue =ABRecordSetValue(memberRef, kABPersonPhoneProperty, tmpMutableMultiPhones, NULL);
        
    if (!couldSetPhoneValue) {
        flag = FALSE;
    }
    
    
    if ([email length]) {
        ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiEmail, email, kABHomeLabel, NULL);
        ABRecordSetValue(memberRef, kABPersonEmailProperty, multiEmail,NULL);
    }
    
    
    BOOL couldAddRecord = NO;
    couldAddRecord = ABAddressBookAddRecord(self.addressBookRef, memberRef, NULL);
    if (!couldAddRecord) {
        NSLog(@"failed");
        flag = FALSE;
    }
    
    BOOL couldAddMember = NO;
    //将通讯录添加到指定的分组中！
    couldAddMember = ABGroupAddMember(nowGroupRef, memberRef, NULL);
    if (!couldAddMember) {
        NSLog(@"failed");
        flag = FALSE;
    }
    
    CFRelease(memberRef);
    return flag;
}

-(BOOL)updateContactUser:(User *)contactUserDic withGroupRecordRef:(ABRecordRef)nowGroupRef withPeopleRecordRef:(ABRecordRef)people
{
    //更新已有的数据
    BOOL flag = true;
    NSString *email = contactUserDic.email;
    BOOL couldSetPhoneValue = NO;
    ABMutableMultiValueRef tmpMutableMultiPhones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
    NSString *telphone = contactUserDic.telephone;
    if ([telphone length]) {
                ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, telphone, kABWorkLabel, NULL);
    }
    NSString *phone = contactUserDic.mobile;
    if ([phone length]) {
            ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, phone, kABPersonPhoneMobileLabel, NULL);
        }
        
    couldSetPhoneValue =ABRecordSetValue(people, kABPersonPhoneProperty, tmpMutableMultiPhones, NULL);
        
    if (!couldSetPhoneValue) {
        flag = FALSE;
    }
    
    
    if ([email length]) {
        ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiEmail, email, kABHomeLabel, NULL);
        ABRecordSetValue(people, kABPersonEmailProperty, multiEmail,NULL);
    }
    
    return flag;
}

//同步失败
- (void)synContactsFinishWithStr:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.tag = SynFailedTag;
    [alertView show];
    [alertView release];
}

@end
