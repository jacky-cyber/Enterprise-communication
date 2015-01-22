//
//  DocumentDetailViewController.h
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-4-1.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import  "ASINetworkQueue.h"

@interface DocumentDetailViewController : BaseViewController<ASIHTTPRequestDelegate>

@property (nonatomic,strong) NSArray  *dataArray;

@property (nonatomic,strong) ASINetworkQueue *networkQueue;

@property (nonatomic,strong) UIProgressView *progress;
@end
