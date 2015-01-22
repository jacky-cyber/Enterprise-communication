//
//  ScrollButtonView.h
//  DownloadPdf
//
//  Created by 云鹤 张 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollButtonViewDelegate <NSObject>

- (void)ScrollButtonViewDidSelectedIndex:(NSInteger)index;
@end

@interface ScrollButtonView : UIView<UIScrollViewDelegate>
{
    id<ScrollButtonViewDelegate> delegate;
    UIScrollView *mainScroller;
    NSInteger selectedIndex;
    NSInteger totalCount;
    
}

@property (nonatomic, retain) UIScrollView *mainScroller;
@property (nonatomic ,retain) id<ScrollButtonViewDelegate> delegate; 
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger totalCount;

- (void) creatView:(NSMutableArray *) titleArray ;

@end
