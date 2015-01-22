//
//  VersionController.m
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VersionController.h"
#import "HttpServiceHelper.h"
#define kAppUpdate        @"APPUpdateUrl"


//#define Version_Url @"http://192.168.1.7:8000/CheckUpdate.aspx"

@implementation VersionController
{
    BOOL _isNotHint;
}

static VersionController *shareVersionInstance = nil;
+ (VersionController *)shareVersionControllerler
{
	@synchronized(self)
	{	
		if(shareVersionInstance == nil)
		{
			shareVersionInstance = [[VersionController alloc] init];
		}
	}
	
	return shareVersionInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)detectVersion
{
    [self fretchAppVersion];
}

- (void)fretchAppVersion
{
    [[HttpServiceHelper sharedService] requestForType:Http_FretchAppVersion info:nil target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}

- (void)requestFinished:(NSDictionary *)datas
{
    //服务器版本号
    NSString *postVersionString = [datas objectForKey:@"Version"];
    NSArray *postVersionarr = [postVersionString componentsSeparatedByString:@"."];
    
    //本地版本号
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSArray *versionarr = [versionString componentsSeparatedByString:@"."];
    int count = (int)MAX([postVersionarr count], [versionarr count]);
    BOOL isUpdate = NO;
    for (int i = 0; i < count; i++) {
        //服务器版本号
        int postVersion = 0;
        if (i < [postVersionarr count]) {
            postVersion = [[postVersionarr objectAtIndex:i] intValue];
        }
        
        //本地版本号
        int localVersion = 0;
        if (i < [versionarr count]) {
            localVersion = [[versionarr objectAtIndex:i] intValue];
        }
        
        //比对两个版本号
        if (postVersion != localVersion) {
            if (localVersion < postVersion) {
                //如果本地版本号小，更新
                isUpdate = YES;
            }
            break;  //已经比对出结果
        }
    }
    
    NSString *downloadUrl = [datas objectForKey:@"URL"];
    [[NSUserDefaults standardUserDefaults] setObject:downloadUrl forKey:kAppUpdate];
    
    if (![[datas objectForKey:@"MustUpdate"] isEqualToString:@"false"])//强制更新
    {
        if (isUpdate)
        {
            NSString *msg = [datas objectForKey:@"Info"];
            CustomAlertView *aler = [[[CustomAlertView alloc] initWithAlertStyle:MustUpdate_style withObject:msg] autorelease];
            aler.delegate = self;
            [[AppDelegate shareDelegate].window addSubview:aler];

        }
    }
    else
    {
        if (isUpdate)
        {
            _isNotHint = [[NSUserDefaults standardUserDefaults] boolForKey:@"isnothint"];
            
            if (!_isNotHint)
            {
                NSString *msg = [datas objectForKey:@"Info"];
                CustomAlertView *aler = [[[CustomAlertView alloc] initWithAlertStyle:Update_Style withObject:msg] autorelease];
                aler.delegate = self;
                [[AppDelegate shareDelegate].window addSubview:aler];
                
            
            }
            else
            {
                [self doUpdate:downloadUrl];
            }
        }
    }
}

- (void)requestFailed:(id)sender
{
    NSLog(@"failed:");
}

- (void)update
{
    NSString *downloadUrl = [[NSUserDefaults standardUserDefaults] stringForKey:kAppUpdate];
    [self doUpdate:downloadUrl];
}


- (void)hintOrNotTransmission:(BOOL)status
{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"isnothint"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)doUpdate:(NSString *)url
{
    NSString *downloadUrl = url;
    if(![url hasPrefix:@"itms-services:"])
    {
        downloadUrl = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",downloadUrl];
        
    }
    NSURL *appurl = [NSURL URLWithString:downloadUrl];
    
    if([[UIApplication sharedApplication] canOpenURL:appurl])
    {
        
        [[UIApplication sharedApplication] openURL:appurl];
    }
}


- (void)dealloc
{
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

@end
