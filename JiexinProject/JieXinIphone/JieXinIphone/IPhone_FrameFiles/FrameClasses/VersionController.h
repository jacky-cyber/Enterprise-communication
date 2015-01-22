//
//  VersionController.h
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
#import "CustomAlertView.h"

@interface VersionController : NSObject <UIAlertViewDelegate,CustomeAlertViewDelegate,ASIHTTPRequestDelegate>
{
}

+ (VersionController *)shareVersionControllerler;
- (void)detectVersion;
@end