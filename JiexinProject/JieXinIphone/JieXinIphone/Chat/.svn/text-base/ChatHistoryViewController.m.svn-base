//
//  ChatHistoryViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatHistoryViewController.h"
#import "ChatHistoryCell.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "MarkupParser.h"
#import "EditHeKaViewController.h"
#import "MailHelp.h"

#define EveryPage 10

@interface ChatHistoryViewController ()<OHAttributedLabelDelegate>

@property (nonatomic,assign) float iosChangeFloat;
@property (nonatomic, retain) PullTableView *listTableView;
@property (nonatomic, retain) UILabel *pageLabel;
@property (nonatomic, assign) int pageCount;
@property (nonatomic, assign) int nowPage;
@property (nonatomic, assign) int allMsgsCount;
@property (nonatomic, assign) int nowFromIndex;
@property (nonatomic, assign) int nowPageSzie;





@end

@implementation ChatHistoryViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDefaultDatas];

        // Custom initialization
    }
    return self;
}
- (void)initDefaultDatas
{
    self.messageDetailList = [NSMutableArray array];
   
    self.nowPage = 0;
    
    if (IOSVersion >= 7.0)
    {
        self.iosChangeFloat = 20;
    }
    else
    {
        self.iosChangeFloat = 0;
    }
}


- (void)dealloc
{
    self.messageDetailList = nil;
    self.listTableView = nil;
    self.pageLabel = nil;
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPageCount];

    [self initSubViews];

    [self initTableDatas];

	// Do any additional setup after loading the view.
}
- (void)initPageCount
{
    self.allMsgsCount = [[ChatDataHelper sharedService] queryCountMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId intValue]];
    self.pageCount = _allMsgsCount/EveryPage;
    if (_allMsgsCount%EveryPage != 0) {
        self.pageCount += 1;
    }
    self.nowPage = self.pageCount;
}

- (void)initTableDatas
{
    //    __block typeof(self)tmpObject = self;
    [self getFromIndexAndPageSize];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[STHUDManager sharedManager] showHUDInView:self.view];
        NSMutableArray *arr = [[ChatDataHelper sharedService] queryMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId intValue] withFromIndex:_nowFromIndex withPageSize:_nowPageSzie ];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[STHUDManager sharedManager] hideHUDInView:self.view];
            [self reloadMessageDetailListArr:arr];

            [self.listTableView reloadData];
//            NSInteger rows = [self.listTableView numberOfRowsInSection:0];
//            if(rows > 0) {
//                [self.listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
//                                      atScrollPosition:UITableViewScrollPositionBottom
//                                              animated:NO];
//            }

//            [self.listTableView scrollToBottomAnimated:YES];
            
        });
    });
}

//在数组里面添加AttributedLabel
- (ChatMessagesFeed *)addAttributedLabelToChatMessageFeed:(ChatMessagesFeed *)feed
{
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    label.userInteractionEnabled = YES;
    [self creatAttributedLabel:feed Label:label];
    feed.attributedLabel = label;
    [CustomMethod drawImage:feed];
    [label release];
    return feed;
}

- (void)creatAttributedLabel:(ChatMessagesFeed *)feed Label:(OHAttributedLabel *)label
{
    [label setNeedsDisplay];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *m_emojiDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray *httpArr = [CustomMethod addHttpArr:feed.message];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:feed.message];
    //    NSMutableArray *emailArr = [CustomMethod addEmailArr:feed.message];
    
    NSString *text = [CustomMethod transformString:feed.message emojiDic:m_emojiDic];
    text = [NSString stringWithFormat:@"<font color='gray' strokeColor='' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString *attString = [wk_markupParser attrStringFromMarkup:text];
    [attString setFont:[UIFont systemFontOfSize:13]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttString:attString withImages:wk_markupParser.images];
    [wk_markupParser release];
    NSString *string = attString.string;
    //    if ([emailArr count]) {
    //        for (NSString *emailStr in emailArr) {
    //            [label addCustomLink:[NSURL URLWithString:emailStr] inRange:[string rangeOfString:emailStr]];
    //        }
    //    }
    
    if ([phoneNumArr count]) {
        for (NSString *phoneNum in phoneNumArr) {
            [label addCustomLink:[NSURL URLWithString:phoneNum] inRange:[string rangeOfString:phoneNum]];
        }
    }
    
    if ([httpArr count]) {
        for (NSString *httpStr in httpArr) {
            [label addCustomLink:[NSURL URLWithString:httpStr] inRange:[string rangeOfString:httpStr]];
        }
    }
    label.delegate = self;
    CGRect labelRect = label.frame;
    labelRect.size.width = [label sizeThatFits:CGSizeMake(kScreen_Width-10, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(kScreen_Width-10, CGFLOAT_MAX)].height;
    label.frame = labelRect;
    label.underlineLinks = YES;//链接是否带下划线
    label.onlyCatchTouchesOnLinks = YES;
    [label.layer display];
}


- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    
    NSString *requestString = [linkInfo.URL absoluteString];
    NSLog(@"%@",requestString);
    //    NSMutableArray *httpArr = [CustomMethod addHttpArr:requestString];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:requestString];
    NSMutableArray *emailArr = [CustomMethod addEmailArr:requestString];
    if ([emailArr count])
    {
        [MailHelp sharedService].recipients = [NSArray arrayWithObjects:requestString, nil];
        [MailHelp sharedService].isShowScreenShot = NO;
        [[MailHelp sharedService] sendMailWithPresentViewController:self];
        
    }
    else if ([[UIApplication sharedApplication]canOpenURL:linkInfo.URL])
    {
        [[UIApplication sharedApplication]openURL:linkInfo.URL];
    }
    else if (linkInfo.phoneNumber) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",linkInfo.phoneNumber]]];
    }


    return NO;
}



- (void)initSubViews
{
    if (IOSVersion >= 7.0) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.iosChangeFloat, kScreen_Width, kNavHeight)];
    header.image = UIImageWithName(@"top_bar_bg.png");
    header.userInteractionEnabled = YES;
    [self.view addSubview:header];
    [header release];
    
    
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.text = @"聊天记录";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:titleLabel];
    [titleLabel release];

    
    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+kNavHeight, kScreen_Width, kScreen_Height-20-kNavHeight-50) style:UITableViewStylePlain];
    aTableView.pullTableIsLoadingMore = NO;
    [aTableView configRefreshType:NoRefresh];
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
    aTableView.layer.borderWidth = 1;
    aTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView = aTableView;
    [aTableView release];
    [self.view addSubview:_listTableView];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreen_Height-20+self.iosChangeFloat - 50, kScreen_Width, 50)];
    bottomImageView.image = [UIImage imageNamed:@"historyBottomBg.png"];
    bottomImageView.userInteractionEnabled = YES;
    [self.view addSubview:bottomImageView];
    [bottomImageView release];
    
    UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    leftBt.frame = CGRectMake(5, 0 , 50, 50);
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(17, 10, 17, 32);
    [leftBt addTarget:self action:@selector(onLeftBtnQuery) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:leftBt];
    
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    rightBt.frame = CGRectMake(75, 0 , 50, 50);
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(17, 10, 17, 32);
    [rightBt addTarget:self action:@selector(onRightBtnQuery) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:rightBt];

    self.pageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    _pageLabel.center = CGPointMake(50, 25);
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.textColor = [UIColor blackColor];
    _pageLabel.backgroundColor = [UIColor clearColor];
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",_nowPage,_pageCount];
    [bottomImageView addSubview:_pageLabel];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"deleteHistory.png"] forState:UIControlStateNormal];
    deleteBtn.frame = CGRectMake(kScreen_Width- 70, 10, 60, 30);
    [deleteBtn addTarget:self action:@selector(deleteNowChatHistoryPage) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:deleteBtn];

}

- (void)getFromIndexAndPageSize
{
    //最后一页的条数
    int lastPageMsgCount = EveryPage;
    if (_allMsgsCount%EveryPage != 0) {
        lastPageMsgCount = _allMsgsCount%EveryPage;
    }
    self.nowFromIndex = _allMsgsCount - EveryPage*(_pageCount-_nowPage)-lastPageMsgCount;
    self.nowPageSzie  = lastPageMsgCount;
    if (_nowPage!=_pageCount) {
        self.nowPageSzie = EveryPage;
    }
}

#pragma mark -跳到贺卡页面
- (void)turnToHeka:(NSString *)sender
{
    
    NSRange range = [sender rangeOfString:@"%Greeting%"];
    NSString *tempStr = [sender substringFromIndex:(range.location+range.length)];
    NSRange range1 = [tempStr rangeOfString:@"#"];
    NSString *image = [tempStr substringToIndex:range1.location];
    tempStr = [tempStr substringFromIndex:(range1.location+range1.length)];
    
    NSRange range3 = [tempStr rangeOfString:@"%Greeting%"];
    NSString *greetingStr = [tempStr substringToIndex:range3.location];
    //发现安卓穿过来的居然是big的图片
    NSRange nameRange = [image rangeOfString:@"card_big_"];
    if (nameRange.location != NSNotFound) {
        image = [NSString stringWithFormat:@"card_small_%@.jpg",[image substringFromIndex:(nameRange.location+nameRange.length)]];
    }

    EditHeKaViewController *edit = [[EditHeKaViewController alloc] initWithNibName:nil bundle:nil];
    edit.isCanEdit = NO;
    edit.imageName = [NSString stringWithFormat:@"%@.jpg",image];
    edit.greetingStr = greetingStr;
    [self.navigationController pushViewController:edit animated:YES];
    [edit release];
}
#pragma mark - 查询上一页
- (void)onLeftBtnQuery
{
    [self.messageDetailList removeAllObjects];

    if (self.nowPage <= 1)
    {
        return;
    }
    self.nowPage -= 1;
    //这里查询上一页
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",_nowPage,_pageCount];
    [self getFromIndexAndPageSize];
    NSMutableArray *arr = [[ChatDataHelper sharedService] queryMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId intValue] withFromIndex:_nowFromIndex withPageSize:_nowPageSzie ];
    [self reloadMessageDetailListArr:arr];
    [self.listTableView reloadData];
    [self scrollToTop];

}
- (void)onRightBtnQuery
{
    [self.messageDetailList removeAllObjects];

    if (self.nowPage >= _pageCount) {
        return;
    }
    self.nowPage += 1;
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",_nowPage,_pageCount];
    
    [self getFromIndexAndPageSize];
    NSMutableArray *arr = [[ChatDataHelper sharedService] queryMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId intValue] withFromIndex:_nowFromIndex withPageSize:_nowPageSzie ];
    [self reloadMessageDetailListArr:arr];
    [self.listTableView reloadData];
    [self scrollToTop];
}

- (void)reloadMessageDetailListArr:(NSMutableArray *)arr
{
    for (ChatMessagesFeed *feed in arr) {
        MessageType type = [self getMessageType:feed.message];
        if (type == HeKaMsg)
        {
            feed.message = @"[贺卡]";
        }
        else if(type == PicMsg)
        {
            feed.message = @"[图片]";
        }

        feed = [self addAttributedLabelToChatMessageFeed:feed];
        [_messageDetailList addObject:feed];
    }

}
- (void)scrollToTop
{
    NSInteger rows = [self.listTableView numberOfRowsInSection:0];
    if(rows > 0) {
        [self.listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
    }

}

- (void)deleteNowChatHistoryPage
{
    if (![self.messageDetailList count])
    {
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除聊天记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10086;
    [alertView show];
    [alertView release];
//    ChatMessagesFeed *firstFeed = [self.messageDetailList firstObject];
//    ChatMessagesFeed *lastFeed = [self.messageDetailList lastObject];
//    int fromId = firstFeed.Id;
//    int lastId = lastFeed.Id;
//    BOOL result = [[ChatDataHelper sharedService] deleteMessagesWithRelativeId:_conFeed.relativeId  withToUserId:[_conFeed.loginId intValue] withFromIndex:fromId toId:lastId];
}
- (void)onReturnBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageDetailList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //这里要自动定义
    ChatMessagesFeed *feed = [_messageDetailList objectAtIndex:indexPath.row];
    NSString *name = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    NSString *timenameStr = [NSString stringWithFormat:@"%@  %@",name,feed.date];
    CGSize sizeName = [timenameStr sizeWithFont:[UIFont systemFontOfSize:kHistoryNameFont] constrainedToSize:CGSizeMake(kScreen_Width-10, MAXFLOAT)];
    return sizeName.height+feed.attributedLabel.frame.size.height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置正常群组Cell
    static NSString * const ChatConCellIdentifier = @"ChatHistoryCellIdentifier";
    ChatHistoryCell *cell = (ChatHistoryCell *)[tableView dequeueReusableCellWithIdentifier:ChatConCellIdentifier];
    if (!cell)
    {
        cell = [[[ChatHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatConCellIdentifier] autorelease];
    }
    ChatMessagesFeed *feed = [_messageDetailList objectAtIndex:indexPath.row];
    [cell setDatas:feed];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessagesFeed *feed = [_messageDetailList objectAtIndex:indexPath.row];
    MessageType type = [self getMessageType:feed.message];
    if(type == HeKaMsg)
    {
        [self turnToHeka:feed.message];
    }
    
}

- (MessageType)getMessageType:(NSString *)msgContent
{
    if ([msgContent rangeOfString:@"%Greeting%"].location != NSNotFound)
    {
        return HeKaMsg;
    }
    else if ([msgContent rangeOfString:@"<MsG-PiCtUre>"].location != NSNotFound)
    {
        return PicMsg;
    }
    else
    {
        return TextMsg;
    }
}


#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
    NSLog(@"刷新");
    self.listTableView.pullLastRefreshDate = [NSDate date];
    self.listTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    //加载代码
    NSLog(@"加载");
    self.listTableView.pullTableIsLoadingMore = NO;
}

#pragma mark -
#pragma mark PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}



#pragma mark-alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10086) {
        if (buttonIndex == 1) {
            BOOL result = [[ChatDataHelper sharedService] deleteMessagesWithRelativeId:_conFeed.relativeId  withToUserId:[_conFeed.loginId intValue]];
            if (result)
            {
                self.allMsgsCount = [[ChatDataHelper sharedService] queryCountMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId intValue]];
                self.pageCount = _allMsgsCount/EveryPage;
                if (_allMsgsCount%EveryPage != 0) {
                    self.pageCount += 1;
                }
                self.nowPage = self.pageCount;
                _pageLabel.text = [NSString stringWithFormat:@"%d/%d",_nowPage,_pageCount];
                [self.messageDetailList removeAllObjects];
                [self.listTableView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllMessages object:nil];
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
