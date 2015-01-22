//
//  BubbleView.h
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

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import "UIImage-Extensions.h"
#import "OHAttributedLabel.h"
#import "ChatDataHelper.h"
#import "SDImageCache.h"
#import "ChatMessagesFeed.h"

#define kFacialSizeWidth  15
#define kFacialSizeHeight 15

@class BubbleView;
@class MessagesViewController;
typedef enum {
	BubbleMessageStyleOutgoing = 0,
	BubbleMessageStyleIncoming = 1
} BubbleMessageStyle;


typedef enum
{
    CopyStyle = 100,
    PhoneStyle= 101,
    DeleteOneStyle,     //删除本条信息
    DeleteAllStyle,  //删除全部信息
    ReSendStyle,  //重新发送
    ToChatWithStyle, //和他聊天
    SendOtherStyle,  //转发
    SwitchSMSSendStyle,//转为短信发送
    SwitchMessageSendStyle,//转为消息发送
}MenuItemStyle;

typedef enum {
    SwitchMessageSendType =1000,//转为信息发送
    SwitchSMSSendType = 1001,//转为短信发送
} SwitchSendType;


@protocol BubbleViewDelegate
- (void)onMenuItemTap:(NSDictionary *)infoDic;

@optional
- (void)clickOnThumbnailImage:(id)sender;
- (void)clickOnHeadImage:(id)sender;
- (void)longPressHeadImage:(id)sender;

@end

@interface BubbleView : UIView

@property (assign, nonatomic) BubbleMessageStyle style;
@property (nonatomic, retain) ChatMessagesFeed *feed;
@property (copy, nonatomic) NSString *text;
@property (retain, nonatomic) UIButton *headImageBtn;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *thumbnailImageUrl;
@property (assign, nonatomic) BOOL isCanSendOther;
@property (nonatomic, assign) CGRect myBubbleFrame;
@property (assign, nonatomic) id<BubbleViewDelegate>delegate;
@property (assign, nonatomic) int selectRow;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *duanxinBtn;

#pragma mark - Bubble view
+ (UIFont *)font;
+ (CGSize)bubbleSizeForImage:(UIImage *)image;
+ (CGFloat)cellHeightForText:(OHAttributedLabel *)label;
+ (CGFloat)cellHeightForImage:(UIImage *)image;
- (void)setNameLbText:(NSString *)str;
- (void)setChatMessageFeed:(ChatMessagesFeed *)feed;
- (void)setSendStatus:(SendStatus)sendStatus;
+ (CGFloat)bubbleCellHeightForObject:(ChatMessagesFeed *)feed;
+ (NSString *)getImageDownLoadUrl:(NSString *)imageKey;



@end