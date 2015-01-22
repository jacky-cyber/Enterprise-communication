//
//  BubbleView.m
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//
//  Largely based on work by Sam Soffes
//  https://github.com/soffes
//
//  SSMessagesViewController
//  https://github.com/soffes/ssmessagesviewcontroller
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "BubbleView.h"
#import "MessageInputView.h"
#import "MessagesViewController.h"
#import "NSString+MessagesView.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatMessagesFeed.h"
#import "ImageDataHelper.h"
#import "SynUserIcon.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

#define kMarginTop 5.0f
#define kMarginBottom 5.0f
#define kPaddingTop 6.0f
#define kPaddingBottom 6.0f
#define kBubblePaddingRight 30.0f
#define kCustomTextFont   15.0f

#define kSendStyleNotification  @"kSendStyleNotification"

@interface BubbleView()

@property (retain, nonatomic) UIImage *incomingBackground;
@property (retain, nonatomic) UIImage *outgoingBackground;
@property (retain, nonatomic) UIImage *upLeftImage;
@property (retain, nonatomic) UIImage *upRightImage;
@property (retain, nonatomic) UIImageView *downImageView;//底图聊天框
@property (retain, nonatomic) UIImageView *upImageView;//上面的图 聊天框
@property (nonatomic, retain) UIActivityIndicatorView *activeView;
@property (nonatomic, retain) UIButton *sendFailedImageViewBt;
@property (nonatomic, retain) OHAttributedLabel *attributeLabel;


@property (nonatomic, retain, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;

- (void)setup;

@end



@implementation BubbleView

@synthesize style;
@synthesize text;
@synthesize headImageBtn;
@synthesize userId;
@synthesize thumbnailImageUrl;
@synthesize delegate;
#pragma mark - Initialization
- (void)dealloc
{
    self.text = nil;
    self.feed = nil;
    self.headImageBtn = nil;
    self.userId = nil;
    self.thumbnailImageUrl = nil;
    self.upLeftImage = nil;
    self.upRightImage = nil;
    self.upImageView = nil;
    self.downImageView = nil;
    self.nameLabel = nil;
    self.delegate = nil;
    self.activeView = nil;
    self.sendFailedImageViewBt = nil;
    self.duanxinBtn = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.incomingBackground = [[UIImage imageNamed:@"messageBubbleGray"] stretchableImageWithLeftCapWidth:23 topCapHeight:10];
    self.outgoingBackground = [[UIImage imageNamed:@"messageBubbleBlue"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    self.upLeftImage = [[UIImage imageNamed:@"coverBubbleLeft.png"] stretchableImageWithLeftCapWidth:23 topCapHeight:15];
     self.upRightImage = [[UIImage imageNamed:@"coverBubbleRight.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(menuControlDidHide) name:UIMenuControllerDidHideMenuNotification
                                                   object:nil];


        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, kScreen_Width-10, 15)];
        aLabel.font = [UIFont systemFontOfSize:12.f];
        aLabel.textColor = [UIColor grayColor];
        aLabel.textAlignment = NSTextAlignmentLeft;
        aLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel =aLabel;
        [self addSubview:_nameLabel];
        [aLabel release];
        self.headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageBtn.userInteractionEnabled = YES;
        self.headImageBtn.backgroundColor = [UIColor clearColor];
        self.headImageBtn.layer.masksToBounds = YES;
        self.headImageBtn.layer.cornerRadius = 5;
        self.headImageBtn.adjustsImageWhenHighlighted = NO;
        [self.headImageBtn addTarget:self action:@selector(onTouchHeadImgView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headImageBtn];

        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        active.frame = CGRectMake(0, 0, 5, 5);
        [active startAnimating];
        self.activeView = active;
        _activeView.hidden = YES;
        [active release];
        [self addSubview:_activeView];
        
        
        UIButton *aBt = [UIButton buttonWithType:UIButtonTypeCustom];
        aBt.frame = CGRectMake(0, 0, 20, 25);
        [aBt setImage:[UIImage imageNamed:@"sendFailed.png"] forState:UIControlStateNormal];
        [aBt setImageEdgeInsets:UIEdgeInsetsMake(6, 8, 7, 0)];
        [aBt addTarget:self action:@selector(menuResendTap) forControlEvents:UIControlEventTouchUpInside];
        self.sendFailedImageViewBt = aBt;
        _sendFailedImageViewBt.hidden = YES;
        [self addSubview:_sendFailedImageViewBt];

        self.downImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
        _downImageView.userInteractionEnabled = YES;
        [self addSubview:_downImageView];
        
        self.upImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
        _upImageView.userInteractionEnabled = YES;
        _upImageView.hidden = YES;
        [self addSubview:_upImageView];


        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        recognizer.minimumPressDuration = 0.5f;
        [self addGestureRecognizer:recognizer];
        [recognizer release];
        
        UILongPressGestureRecognizer *headRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headLongPressGestureRecognized:)];
        headRecognizer.minimumPressDuration = 0.5f;
        [self.headImageBtn addGestureRecognizer:headRecognizer];
        [headRecognizer release];
        
        [self setup];
    }
    return self;
}

- (void)onTouchHeadImgView:(id)sender
{
    NSLog(@"点击头像");
    if(self.delegate && [(NSObject *)self.delegate respondsToSelector:@selector(clickOnHeadImage:)])
    {
        [self.delegate clickOnHeadImage:self.nameLabel.text];
    }
}

- (void)onTouchThumbnailImgView:(id)sender
{
    NSLog(@"点击缩略图");
    if(self.delegate && [(NSObject *)self.delegate respondsToSelector:@selector(clickOnThumbnailImage:)])
    {
        NSString *msgid = self.feed.date;
        NSDictionary *dic = @{@"msg": self.text,@"msgid":msgid};
        [self.delegate clickOnThumbnailImage:dic];
    }
}

#pragma mark - Setters

- (void)setStyle:(BubbleMessageStyle)newStyle
{
    self.nameLabel.hidden = (newStyle == BubbleMessageStyleIncoming) ? NO : YES;
    UIImage *downImage = (newStyle == BubbleMessageStyleIncoming) ? self.incomingBackground : self.outgoingBackground;
    UIImage *upImage = (newStyle == BubbleMessageStyleIncoming) ? _upLeftImage : _upRightImage;
    self.downImageView.image = downImage;
    self.downImageView.alpha = 0.7;
    self.upImageView.image = upImage;
    style = newStyle;
}
- (void)setChatMessageFeed:(ChatMessagesFeed *)feed
{
    self.feed = feed;
    UIImage *image = [self headImageWithChatMessageFeed:feed];
    [self.headImageBtn setImage:image forState:UIControlStateNormal];
    self.nameLabel.text = feed.fromUserName;
    self.userId = [NSString stringWithFormat:@"%ld",(long)feed.fromUserId];
    self.text = feed.message;
    [self setSendStatus:feed.sendStatus];
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[OHAttributedLabel class]]) {
            [subView removeFromSuperview];
        }
    }
//    [self bringSubviewToFront:feed.attributedLabel];

    [self setBubbleContentDetail:feed];
    [self addSubview:feed.attributedLabel];

}

- (void)setSendStatus:(SendStatus)sendStatus
{
    switch (sendStatus) {
        case SendFailed:
            self.sendFailedImageViewBt.hidden = NO;
            [_activeView stopAnimating];
            _activeView.hidden = YES;
            break;
        case OnSending:
            self.sendFailedImageViewBt.hidden = YES;
            [_activeView startAnimating];
            _activeView.hidden = NO;
            break;
        case SendSuccess:
            self.sendFailedImageViewBt.hidden = YES;
            [_activeView stopAnimating];
            _activeView.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)setIsTextCoverImageShow:(BOOL)isShow
{
    _upImageView.hidden = !isShow;
}

#pragma mark - 设置详细内容 这里主要设置frame
- (void)setBubbleContentDetail:(ChatMessagesFeed *)feed
{
    CGFloat spacing = 40.0f;
    CGFloat headerSide = 40.0f;
    //设置头像frame的大小
    self.headImageBtn.frame = CGRectMake(((self.style == BubbleMessageStyleOutgoing) ? self.frame.size.width - spacing-2.0f : 2.0f),
                                         self.frame.size.height - spacing,
                                         headerSide,headerSide);
    //设置姓名frame
    self.nameLabel.frame = CGRectMake(2, CGRectGetMinY(self.headImageBtn.frame)-15, kScreen_Width-10, 15);

    CGSize bubbleSize = [BubbleView bubbleSizeFromTextSize:feed.attributedLabel.bounds.size];
    CGFloat topDiffer = 0;
    if (bubbleSize.height-kPaddingBottom-kPaddingTop < 40) {
        topDiffer = 40 - bubbleSize.height+kPaddingTop+kPaddingBottom;
    }
	CGRect bubbleFrame = CGRectMake(((self.style == BubbleMessageStyleOutgoing) ? self.frame.size.width - bubbleSize.width - spacing-2 : spacing+2),
                                    kMarginTop+topDiffer,
                                    bubbleSize.width,
                                    bubbleSize.height);
    self.myBubbleFrame = bubbleFrame;
    self.downImageView.frame = bubbleFrame;
    self.upImageView.frame = bubbleFrame;
    
    self.activeView.center = CGPointMake(((self.style == BubbleMessageStyleOutgoing) ?CGRectGetMinX(bubbleFrame)-10 : CGRectGetMaxX(bubbleFrame)+10), CGRectGetMinY(bubbleFrame)+CGRectGetHeight(bubbleFrame)/2);
    self.sendFailedImageViewBt.center = _activeView.center;
    
    //CONTENT
    CGFloat textX = (CGFloat)_downImageView.image.leftCapWidth + ((self.style == BubbleMessageStyleOutgoing) ? bubbleFrame.origin.x : headerSide);
    self.feed.attributedLabel.center = CGPointMake(textX+CGRectGetWidth(self.feed.attributedLabel.frame)/2, kMarginTop + kPaddingTop+ topDiffer + CGRectGetHeight(self.feed.attributedLabel.frame)/2);
}

#pragma mark - 头像
- (UIImage *)headImageWithChatMessageFeed:(ChatMessagesFeed *)feed
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.jpg",[[SynUserIcon sharedManager] getCurrentUserSmallIconPath],(long)feed.fromUserId];
    //存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        return [[[UIImage alloc] initWithContentsOfFile:filePath] autorelease];
    }
    else
    {
        return [UIImage imageNamed:@"headImage.png"];
    }
}

#pragma mark - 长按显示
- (void)headLongPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if(self.delegate && [(NSObject *)self.delegate respondsToSelector:@selector(longPressHeadImage:)])
        {
            [self.delegate longPressHeadImage:self.userId];
        }
    }
}


- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ( self.text && [self.text length])
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            [self setIsTextCoverImageShow:YES];
            [self becomeFirstResponder];
//            NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTap)];
            
            UIMenuItem *deleteOne =[[UIMenuItem alloc] initWithTitle:@"删除信息" action:@selector(deleteOneItemTap)];
            
            UIMenuItem *deleteAll = [[UIMenuItem alloc] initWithTitle:@"删除会话" action:@selector(deleteAllItemTap)];
    
            UIMenuItem *sendOther = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(sendOtherItemTap)];
            
            UIMenuItem *reSend = [[UIMenuItem alloc] initWithTitle:@"重新发送" action:@selector(reSendItemTap)];
            
            UIMenuItem *phone = [[UIMenuItem alloc] initWithTitle:@"打电话" action:@selector(phoneItemTap)];
            
            UIMenuItem *toChatWith = [[UIMenuItem alloc] initWithTitle:@"聊天" action:@selector(toChatWithItemTap)];

            UIMenuItem *switchSMS = [[UIMenuItem alloc] initWithTitle:@"作为短信发送" action:@selector(switchSMSSendItemTap)];
            
            UIMenuItem *switchMessage= [[UIMenuItem alloc] initWithTitle:@"作为消息发送" action:@selector(switchMessageSendItemTap)];

            NSMutableArray *menuArr = [NSMutableArray arrayWithObjects:deleteOne,deleteAll,sendOther, nil];
            //不是图片就可以复制
            if ([self.text rangeOfString:StartImageContent].location == NSNotFound || [self.text rangeOfString:EndImageContent].location == NSNotFound)
            {
                [menuArr addObject:copy];
            }
            if (self.style == BubbleMessageStyleIncoming) {
                [menuArr addObject:phone];
                [menuArr addObject:toChatWith];

            }
            if (self.style == BubbleMessageStyleOutgoing) {
                [menuArr addObject:reSend];
                if (self.duanxinBtn.selected)
                {
                    [menuArr addObject:switchMessage];
                }
                else
                {
                    [menuArr addObject:switchSMS];
                }
            }
            
            [copy release];
            [deleteOne release];
            [deleteAll release];
            [sendOther release];
            [reSend release];
            [phone release];
            [toChatWith release];
            
            [menuController setMenuItems:menuArr];
            [menuController setTargetRect:self.myBubbleFrame inView:self];
            menuController.arrowDirection = UIMenuControllerArrowDefault;
            [menuController setMenuVisible:YES animated:NO];
        }
    }
}


- (void)copyTap
{
    [self menuTap:CopyStyle];
}
- (void)deleteOneItemTap
{
    [self menuTap:DeleteOneStyle];
}
- (void)deleteAllItemTap
{
    [self menuTap:DeleteAllStyle];
}
- (void)sendOtherItemTap
{
    [self menuTap:SendOtherStyle];
}
- (void)reSendItemTap
{
    [self menuTap:ReSendStyle];
}
- (void)phoneItemTap
{
    [self menuTap:PhoneStyle];
}
- (void)toChatWithItemTap
{
    [self menuTap:ToChatWithStyle];
}
- (void)switchSMSSendItemTap
{
    [self menuTap:SwitchSMSSendStyle];
}
- (void)switchMessageSendItemTap
{
    [self menuTap:SwitchMessageSendStyle];
}

- (void)menuTap:(MenuItemStyle)menuStyle
{
    if (self.delegate &&  [(NSObject *)self.delegate respondsToSelector:@selector(onMenuItemTap:)])
    {
        [self.delegate onMenuItemTap:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:menuStyle],@"menuItem",[NSNumber numberWithInt:self.selectRow],@"row", nil]];
    }
}



#pragma mark - Bubble view
+ (UIFont *)font
{
    return [UIFont systemFontOfSize:kCustomTextFont];
}

//根据文字的大小算聊天框的大小
+ (CGSize)bubbleSizeFromTextSize:(CGSize)textSize
{
    return CGSizeMake(textSize.width + kBubblePaddingRight,
                      textSize.height + kPaddingTop + kPaddingBottom);
}
+ (CGSize)bubbleSizeForImage:(UIImage *)image
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
	return CGSizeMake(width + kBubblePaddingRight,
                      height + kPaddingTop + kPaddingBottom);
}
+ (CGFloat)bubbleCellHeightForObject:(ChatMessagesFeed *)feed
{
    return [BubbleView cellHeightForText:feed.attributedLabel];
}

+ (CGFloat)cellHeightForText:(OHAttributedLabel *)label
{
    //这里要保证容纳下名字和头像的高度
    CGFloat height = label.frame.size.height;
    if (height <40) {
        height = 40;
    }
    return height + kMarginTop + kMarginBottom + kPaddingTop + kPaddingBottom;
}

+ (CGFloat)cellHeightForImage:(UIImage *)image
{
    CGFloat imageSizeHeight =[BubbleView bubbleSizeForImage:image].height;
    //这里要保证容纳下名字和头像的高度
    if (imageSizeHeight < 40+kPaddingTop+kPaddingBottom) {
        imageSizeHeight = 40+kPaddingTop+kPaddingBottom;
    }
    return imageSizeHeight+ kMarginTop +kMarginBottom;
}

+ (NSString *)getImageDownLoadUrl:(NSString *)imageKey
{
    NSString *urlStr = @"";
    NSString *mainDomain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    if ([mainDomain hasPrefix:@"http"]) {
        
        urlStr = [NSString stringWithFormat:@"%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[imageKey trimWhitespace]]];
    }
    else
    {
        
        urlStr = [NSString stringWithFormat:@"http://%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[imageKey trimWhitespace]]];
    }
    return urlStr;
}



#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    retValue = [super canPerformAction:action withSender:sender];
    return retValue;
}

#pragma mark - uimenuViewcontroller
- (void)menuControlDidHide
{
    [self setIsTextCoverImageShow:NO];
    [self resignFirstResponder];
}
- (void)menuWillShow
{
    [self setIsTextCoverImageShow:YES];
}


@end