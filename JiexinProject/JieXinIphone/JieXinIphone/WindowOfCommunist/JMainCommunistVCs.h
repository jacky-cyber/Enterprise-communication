//
//  JMainCommunistVCs.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-5-20.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "JFinancialLists.h"
@interface JMainCommunistVCs :  BaseViewController<UIScrollViewDelegate,JFinancialListsDelegate>
@property(nonatomic,retain)UIScrollView *mainBgView;
@property(nonatomic,retain)NSMutableArray *ListCommunist;

@end
