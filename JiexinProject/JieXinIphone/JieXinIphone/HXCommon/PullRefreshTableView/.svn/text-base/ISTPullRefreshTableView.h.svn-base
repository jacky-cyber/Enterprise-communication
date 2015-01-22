//
//  ISTPullRefreshTableView.h
//  ISTPetsV2
//
//  Created by 陈 爱彬 on 12-11-16.
//  Copyright (c) 2012年 陈 爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISTTableFooterView.h"

//刷新加载的view
@interface PullLoadingView : UIView{
    UILabel *_stateLabel;
    UILabel *_dateLabel;
    UIImageView *_arrowView;
    UIActivityIndicatorView *_activityView;
    CALayer *_arrow;
    BOOL _loading;
}
@property (nonatomic,getter = isLoading) BOOL loading;
@property (nonatomic,getter = isAtTop) BOOL atTop;
@property (nonatomic,assign) ISTPullRefreshState state;
//初始化
- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;
//刷新时间
- (void)updateRefreshDate:(NSDate *)date;

@end

@protocol PullingRefreshTableViewDelegate;

@interface ISTPullRefreshTableView : UITableView
<UIScrollViewDelegate>
{
    PullLoadingView *_headerView;
    UILabel *_msgLabel;
    BOOL _loading;
//    BOOL _isFooterInAction;
    NSInteger _bottomRow;
}
@property (nonatomic,assign) id <PullingRefreshTableViewDelegate>pullingDelegate;
@property (nonatomic,retain) ISTTableFooterView *footerView;
@property (nonatomic) BOOL autoScrollToNextPage;
@property (nonatomic) BOOL reachedTheEnd;
@property (nonatomic,getter = isHeaderOnly) BOOL headerOnly;
@property (nonatomic,getter = isFooterOnly) BOOL footerOnly;
@property (nonatomic,getter = isFooterInAction) BOOL footerInAction;
@property (nonatomic, assign) BOOL isRefresh;

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;
- (void)tableViewDidFinishedLoading;
- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;
- (void)launchRefreshing;
- (void)flashMessage:(NSString *)msg;
- (void)cancel;

@end

@protocol PullingRefreshTableViewDelegate <NSObject>

@optional
- (void)pullingTableViewDidHeaderStartLoading:(ISTPullRefreshTableView *)tableView;

@optional
- (void)pullingTableViewDidFooterStartLoading:(ISTPullRefreshTableView *)tableView;

- (NSDate *)pullingTableViewHeaderLoadingFinishedDate;
- (NSDate *)pullingTableViewFooterLoadingFinishedDate;

@end

