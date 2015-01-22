//
//  AttachmentShowViewController.h
//  SunboxSoft
//
//  Created by 雷 克 on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachmentShowViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *contentWebView;
}
@property (nonatomic, retain) UIWebView *conentWebView;

- (void)loadContent:(NSString *)contentUrl;
@end
