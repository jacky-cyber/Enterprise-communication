//
//  IPad_MangementServiceHelper.h
//  SunboxSoft_MO_iPad
//
//  Created by liqiang on 12-8-31.
//
//

#import <Foundation/Foundation.h>
#import "STFormDataRequest.h"
#import "Reachability.h"


@interface Car_helper: NSObject<UIAlertViewDelegate,ASIHTTPRequestDelegate>
{
    NSMutableDictionary *requests;
    NSMutableArray *httpRequests;
    
    NetworkStatus netStatus;
    Reachability* internetReach;
}

+ (Car_helper *)sharedService;
- (void)requestForType:(HttpRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector;
- (void)httpsCancel;
- (void)cancelRequestForDelegate:(id)delegate;

@property(nonatomic,strong) NSString *dizhi;


@end
