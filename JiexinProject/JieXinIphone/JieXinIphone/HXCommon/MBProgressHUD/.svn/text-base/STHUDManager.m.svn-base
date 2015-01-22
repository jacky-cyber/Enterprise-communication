//
//  STHUDManager.m
//  LoginDemo
//
//  Created by Xiaoming Han on 12-8-7.
//  Copyright (c) 2012年 ispirit. All rights reserved.
//

#import "STHUDManager.h"
#import "HttpReachabilityHelper.h"

#define BgViewTag  1001

static STHUDManager *_sharedManager = nil; 

@implementation STHUDManager
@synthesize HUD = _HUD;
@synthesize viewArray = _viewArray;

- (void)dealloc
{
    //移走通知
    [_viewArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_HUD release];
    [super dealloc];
}

- (id)init {
    NSMutableArray *tempViewArray = [[NSMutableArray alloc] init];
    self.viewArray = tempViewArray;
    [tempViewArray release];
    
    self = [super init];
    if (self) {
        
        _isHidden = YES;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _HUD = [[MBProgressHUD alloc] initWithWindow:window];
        [_HUD setFrame:CGRectMake(0, 55, 320, kScreen_Height - 55 -55)];
        [window addSubview:_HUD];
        
//        _HUD.dimBackground = YES;
        _HUD.delegate = self;
//        _HUD.minSize = CGSizeMake(135.f, 135.f);
        _HUD.square = YES;

        //注册一个通知，用来隐藏等待框
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUDWithYes) name:kReachChangeNotification object:nil];
    }
    return self;
}

-(void)hideHUDWithYes
{
    NSArray *tempArray = [NSArray arrayWithArray:_viewArray];
    for(UIView *view in tempArray)
    {
        [self hideHUDInView:view];
    }
}

#pragma mark -
#pragma mark Singleton

+ (STHUDManager *)sharedManager
{
    @synchronized(self) {
        if (_sharedManager == nil) {
            _sharedManager = [[super alloc] init];
        }
    }
    return _sharedManager;
    

}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (_sharedManager == nil) {
            _sharedManager = [super allocWithZone:zone];
            return _sharedManager;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - public methods
- (void)hideHUDWithLabel:(NSString *)label
{
    _HUD.labelText = label;
    [_HUD hide:YES afterDelay:0.5];
    _isHidden = YES;
}

- (void)hideHUDWithLabel:(NSString *)label afterDelay:(NSTimeInterval)delay
{
    
    _HUD.labelText = label;
    [_HUD hide:YES afterDelay:delay];
    _isHidden = YES;
}

- (void)hideHUD:(BOOL)animated
{
    [_HUD hide:animated];
    _isHidden = YES;

}
- (void)showHUD
{
    if (_isHidden) {
        [_HUD show:YES];
        _isHidden = NO;
    }

}
- (void)showHUDWithLabel:(NSString *)label
{
    [self showHUDWithLabel:label detail:nil];
}
- (void)showHUDWithLabel:(NSString *)label detail:(NSString *)detail
{
    _HUD.labelText = label;
    _HUD.detailsLabelText = detail;
    
    [self showHUD];

}
- (void)showHUDWithCustomView:(UIView *)view label:(NSString *)label
{
    _HUD.customView = view;
	_HUD.labelText = label;
    // Set custom view mode
    _HUD.mode = MBProgressHUDModeCustomView;
    [self showHUD];

}

- (void)showHUDInView:(UIView *)view
{
    NSLog(@"111");
//    CGFloat changeFloat = 0;
//    if (IOSVersion >= 7.0) {
//        changeFloat = 20;
//    }
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, changeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight)];
//    bgView.tag = BgViewTag;
//    bgView.backgroundColor = [UIColor clearColor];
//    [view addSubview:bgView];
//    [bgView release];
    
    if([[HttpReachabilityHelper sharedService] checkNetwork:@"对不起网络不通"]){
        [_viewArray addObject:view];
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}
- (void)showHUDInViewToMySelf:(UIView *)view{
    if([[HttpReachabilityHelper sharedService] checkNetwork:@"对不起网络不通"]){
        [_viewArray addObject:view];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        //    [hud hide:NO afterDelay:10];
        [view insertSubview:hud atIndex:1000];
        [hud show:YES];
        [hud release];
    }
}
- (void)showHUDInView:(UIView *)view hideHUDAfterDelay:(NSTimeInterval)delay
{
    if([[HttpReachabilityHelper sharedService] checkNetwork:@"对不起网络不通"]){
        [_viewArray addObject:view];
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self performSelector:@selector(hideHUDInView:) withObject:view afterDelay:10];
    }
}


- (void)hideHUDInView:(UIView *)view
{
    if([_viewArray containsObject:view])
        [_viewArray removeObject:view];
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)removeAllWaittingViews
{
    for(UIView *aview in _viewArray)
    {
        [MBProgressHUD hideHUDForView:aview animated:NO];
    }
}


#if NS_BLOCKS_AVAILABLE

- (void)showHUDWithLabel:(NSString *)label processingBlock:(void (^)())process finishBlock:(void (^)())finish
{
    [self showHUDWithLabel:label];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do a taks in the background
        process();
        // Hide the HUD in the main tread 
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finish) {
                finish();
            }
            else {
                [self hideHUD:YES];
            }
        });
    });

}
#endif

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    _HUD.labelText = nil;
    _HUD.detailsLabelText = nil;
    _HUD.mode = MBProgressHUDModeIndeterminate;
}

@end
