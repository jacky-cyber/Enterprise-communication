//
//  ISTPullRefreshTableView.m
//  ISTPetsV2
//
//  Created by 陈 爱彬 on 12-11-16.
//  Copyright (c) 2012年 陈 爱彬. All rights reserved.
//

#import "ISTPullRefreshTableView.h"
#import <QuartzCore/QuartzCore.h>

#define kPRHeaderOffsetY 60.f
#define kPRFooterOffsetY 40.0f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 38.f
#define kPRArrowHeight 38.f

#define kPRAnimationDuration .18f

#define kRRFooterViewHeight 40.0f

@interface PullLoadingView()

- (void)layouts;

@end

@implementation PullLoadingView
@synthesize atTop = _atTop;
@synthesize state = _state;
@synthesize loading = _loading;

- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top{
    self = [super initWithFrame:frame];
    if (self) {
        self.atTop = top;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = RGBACOLOR(226, 231, 237, 0);
        
        UIFont *ft = [UIFont systemFontOfSize:12.0f];
        _stateLabel = [[UILabel alloc] init];
        if (self.isAtTop) {
            _stateLabel.font = ft;
        }else{
            _stateLabel.font = [UIFont systemFontOfSize:14.0f];
        }
        _stateLabel.textColor = RGBCOLOR(87, 108, 137);
        _stateLabel.textAlignment = UITextAlignmentCenter;
        _stateLabel.backgroundColor = RGBACOLOR(226, 231, 237, 0);
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _stateLabel.text = @"下拉刷新";
        [self addSubview:_stateLabel];
        
        if (self.isAtTop) {
            _dateLabel = [[UILabel alloc] init];
            _dateLabel.font = ft;
            _dateLabel.textColor = RGBCOLOR(87, 108, 137);
            _dateLabel.backgroundColor = RGBACOLOR(226, 231, 237, 0);
            _dateLabel.textAlignment = UITextAlignmentCenter;
            _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_dateLabel];
            _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            
            _arrow = [CALayer layer];
            _arrow.frame = CGRectMake(0, 0, 20, 20);
            _arrow.contentsGravity = kCAGravityResizeAspect;
            _arrow.contents = (id)[UIImage imageWithCGImage:UIImageWithName(@"pullingArrowDown.png").CGImage scale:1 orientation:UIImageOrientationDown].CGImage;
            [self.layer addSublayer:_arrow];
            
//            _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            
            _arrow = [CALayer layer];
            _arrow.frame = CGRectMake(0, 0, 20, 20);
            _arrow.contentsGravity = kCAGravityResizeAspect;
            _arrow.contents = (id)[UIImage imageWithCGImage:UIImageWithName(@"pullingArrowDown.png").CGImage scale:1 orientation:UIImageOrientationDown].CGImage;
            [self.layer addSublayer:_arrow];

        }
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];
        //***
        [self layouts];
    }
    return self;
}
- (void)dealloc{
    RELEASE_SAFELY(_stateLabel);
    RELEASE_SAFELY(_dateLabel);
    RELEASE_SAFELY(_arrowView);
    RELEASE_SAFELY(_activityView);
    [super dealloc];
}
- (void)layouts{
    CGSize size = self.frame.size;
    CGRect stateFrame,dateFrame,arrowFrame;
    
    float x = 0,y,margin;
    if (self.isAtTop) {
        margin = (kPRHeaderOffsetY - 2*kPRLabelHeight)/2;

        y = size.height - margin - kPRLabelHeight;
        dateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        y = y - kPRLabelHeight;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = size.height - margin - kPRArrowHeight;
        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        
        UIImage *arrow = UIImageWithName(@"pullingArrowDown.png");
        _arrow.contents = (id)arrow.CGImage;
        //**
        _stateLabel.frame = stateFrame;
        _dateLabel.frame = dateFrame;
        _arrowView.frame = arrowFrame;
        _activityView.center = _arrowView.center;
        _arrow.frame = arrowFrame;
        _arrow.transform = CATransform3DIdentity;
    }else{
        margin = (kPRFooterOffsetY - kPRLabelHeight)/2;
        
//        y = size.height - margin - kPRLabelHeight;
        y = margin;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        _stateLabel.frame = stateFrame;
        
        x = kPRMargin;
        y = margin;
        _activityView.center = CGPointMake(4*x+kPRArrowWidth/2, margin+kPRArrowHeight/2);
    }
}
- (void)setState:(ISTPullRefreshState)state{
    [self setState:state animated:YES];
}
- (void)setState:(ISTPullRefreshState)state animated:(BOOL)animated{
    float duration = animated ? kPRAnimationDuration : 0.f;
    _state = state;
    if (_state == ISTPullRefreshStateLoading) {
        //Loading
        _loading = YES;
        if (self.isAtTop) {
            _arrow.hidden = YES;
            _stateLabel.text = @"努力加载中";
        }else{
            _stateLabel.text = @"请稍候";
        }
        _activityView.hidden = NO;
        [_activityView startAnimating];

    }else if (_state == ISTPullRefreshStatePulling && !_loading){
        //Scrolling    
        if (self.isAtTop) {
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            //翻转动画
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            [CATransaction commit];

            _stateLabel.text = @"松开立即刷新";
        }else{
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            _stateLabel.text = @"上拉刷新更多";
        }
    }else if (_state == ISTPullRefreshStateNormal && !_loading){
        //Reset        
        if (self.isAtTop) {
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DIdentity;
            [CATransaction commit];

            _stateLabel.text = @"下拉可刷新";
        }else{
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            _stateLabel.text = @"上拉刷新更多";
        }
    }else if (_state == ISTPullRefreshStateTheEnd){
        //End
        if (!self.isAtTop) {
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            _stateLabel.text = @"已经到底了";
        }
    }
}
- (void)setLoading:(BOOL)loading{
    _loading = loading;
}
- (void)updateRefreshDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [df stringFromDate:date];
    NSString *title = @"今天";
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
    int year = [components year];
    int month = [components month];
    int day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            title = @"今天";
        }else if (day == 1){
            title = @"昨天";
        }else if (day == 2){
            title = @"前天";
        }
        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
        dateString = [df stringFromDate:date];
        
    }
    _dateLabel.text = [NSString stringWithFormat:@"最后更新: %@",dateString];
    [df release];
}
@end

////////////////////////////////////////////////////////
////////////////////////////////////

@interface ISTPullRefreshTableView()

- (void)scrollToNextPage;
@end

@implementation ISTPullRefreshTableView
@synthesize pullingDelegate = _pullingDelegate;
@synthesize autoScrollToNextPage;
@synthesize reachedTheEnd = _reachedTheEnd;
@synthesize headerOnly = _headerOnly;
@synthesize footerOnly = _footerOnly;
@synthesize footerInAction = _footerInAction;
@synthesize isRefresh;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        isRefresh = NO;
        CGRect rect = CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height);
        _headerView = [[PullLoadingView alloc] initWithFrame:rect atTop:YES];
        _headerView.atTop = YES;
        [self addSubview:_headerView];
        [_headerView release];
        
        CGRect fRect = CGRectMake(0, 0, frame.size.width, kRRFooterViewHeight);
//        _footerView = [[PullLoadingView alloc] initWithFrame:fRect atTop:YES];
//        _footerView.atTop = NO;
//        [self addSubview:_footerView];
        _footerView = [[ISTTableFooterView alloc] initWithFrame:fRect];
        _footerView.backgroundColor = [UIColor clearColor];
        self.tableFooterView = _footerView;
        
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.pullingDelegate = aPullingDelegate;
    }
    return self;
}

- (void)setReachedTheEnd:(BOOL)reachedTheEnd{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd) {
        _footerView.state = ISTPullRefreshStateTheEnd;
        self.tableFooterView = nil;
        //删除，修复下到底后的跳跃问题
//        CGPoint offset = self.contentOffset;
//        offset.y -= kRRFooterViewHeight;
//        self.contentOffset = offset;
        
//        [self flashMessage:@"已经到底了"];
//        _footerInAction = NO;
    }else{
        if (self.tableFooterView == nil) {
           self.tableFooterView = _footerView;
        }
        _footerView.state = ISTPullRefreshStateNormal;
    }
}
- (void)setHeaderOnly:(BOOL)headerOnly{
    _headerOnly = headerOnly;
    if (_headerOnly) {
        self.tableFooterView = nil;
    }else{
        self.tableFooterView = _footerView;
    }
}
- (void)setFooterOnly:(BOOL)footerOnly
{
    _footerOnly = footerOnly;
    if (_footerOnly) {
        [_headerView removeFromSuperview];
        _headerView = nil;
    }
}
#pragma mark - Scroll methods
- (void)scrollToNextPage{
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;
    
    [UIView animateWithDuration:.7f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentOffset = CGPointMake(0, y);
    }completion:^(BOOL bl){
    }];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView{
    if ((_headerView != nil && _headerView.state == ISTPullRefreshStateLoading) || (_footerView != nil && _footerView.state == ISTPullRefreshStateLoading)) {
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
    
    float yMargin = contentSize.height - (offset.y + size.height );
    if (offset.y < -kPRHeaderOffsetY) {
        if (_headerView) {
            _headerView.state = ISTPullRefreshStatePulling;
        }
    }else if (offset.y > - kPRHeaderOffsetY && offset.y < 0){
        if (_headerView) {
            _headerView.state = ISTPullRefreshStateNormal;
        }
    }else if (yMargin < kRRFooterViewHeight){
        if (_footerView && _footerView.state != ISTPullRefreshStateTheEnd) {
            _footerView.state = ISTPullRefreshStatePulling;
        }
    }else if (yMargin > kRRFooterViewHeight && yMargin > 0){
        if (_footerView && _footerView.state != ISTPullRefreshStateTheEnd) {
            _footerView.state = ISTPullRefreshStateNormal;
        }
    }
}
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView{
    if ((_headerView && _headerView.state == ISTPullRefreshStateLoading) || (_footerView && _footerView.state == ISTPullRefreshStateLoading)) {
        return;
    }
    if (_headerView && _headerView.state == ISTPullRefreshStatePulling) {
        _footerInAction = NO;
        _headerView.state = ISTPullRefreshStateLoading;
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(kPRHeaderOffsetY, 0, 0, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidHeaderStartLoading:)]) {
            [_pullingDelegate pullingTableViewDidHeaderStartLoading:self];
        }
    }else if (_footerView && _footerView.state == ISTPullRefreshStatePulling){
        if (self.reachedTheEnd || self.headerOnly) {
            return;
        }
        _footerInAction = YES;
        _footerView.state = ISTPullRefreshStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
//            self.contentInset = UIEdgeInsetsMake(0, 0, kPRFooterOffsetY, 0);
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidFooterStartLoading:)]) {
            [_pullingDelegate pullingTableViewDidFooterStartLoading:self];
        }
    }
}
- (void)tableViewDidFinishedLoading{
    [self tableViewDidFinishedLoadingWithMessage:nil];
}
- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg{
    if (_headerView && _headerView.loading) {
        _headerView.loading = NO;
        [_headerView setState:ISTPullRefreshStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewHeaderLoadingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewHeaderLoadingFinishedDate];
        }
        [_headerView updateRefreshDate:date];
        [UIView animateWithDuration:kPRAnimationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
    else if (_footerView && _footerView.loading){
        _footerView.loading = NO;
        [_footerView setState:ISTPullRefreshStateNormal];
        
        [UIView animateWithDuration:kPRAnimationDuration*2 animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
}
- (void)flashMessage:(NSString *)msg{
    __block CGRect rect = CGRectMake(0, self.contentOffset.y - 32, self.bounds.size.width, 32);
    
    if (_msgLabel == nil) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.frame = rect;
        _msgLabel.font = [UIFont systemFontOfSize:18.0f];
        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _msgLabel.backgroundColor = [UIColor brownColor];
        _msgLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_msgLabel];
    }
    _msgLabel.text = msg;
    
    rect.origin.y += 32;
    [UIView animateWithDuration:.4f animations:^{
        _msgLabel.frame = rect;
    }completion:^(BOOL bl){
        rect.origin.y -= 32;
        [UIView animateWithDuration:.4f delay:1.2f options:UIViewAnimationOptionCurveLinear animations:^{
            _msgLabel.frame = rect;
        }completion:^(BOOL bl){
            [_msgLabel removeFromSuperview];
            _msgLabel = nil;
        }];
    }];
}
- (void)launchRefreshing{
    [self setContentOffset:CGPointMake(0, 0) animated:NO];
    [UIView animateWithDuration:kPRAnimationDuration animations:^{
        self.contentOffset = CGPointMake(0, -kPRHeaderOffsetY - 1);
    }completion:^(BOOL bl){
        if (self != nil) {
            [self tableViewDidEndDragging:self];
        }
    }];
}
#pragma mark NSKeyValueObserve
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGRect frame = _footerView.frame;
    CGSize contentSize = self.contentSize;
    frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height : contentSize.height;
    _footerView.frame = frame;
    if (self.autoScrollToNextPage && _footerInAction) {
        [self scrollToNextPage];
        _footerInAction = NO;
    }else if(_footerInAction){
//        CGPoint offset = self.contentOffset;
//        offset.y += 44.f;
//        self.contentOffset = offset;
        _footerInAction = NO;
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"contentSize"];
    RELEASE_SAFELY(_footerView);
    [super dealloc];
}

@end
