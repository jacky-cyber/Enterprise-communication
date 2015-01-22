//
//  MessagesViewController.h
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
#import "BubbleMessageCell.h"
#import "MessageSoundEffect.h"
#import "ISTPullRefreshTableView.h"
#import "MessageInputView.h"
#import "NSString+MessagesView.h"
#import "PhotoLibrary.h"
#import "EmotionView.h"
#import "MsgSendBtnsView.h"
#import "AddContentToDetailView.h"



#define INPUT_HEIGHT    44
#define HEADER_HEIGHT   50.0f

#define kLongMessageLength  4000
#define kDuanXinLength  250


@interface MessagesViewController : FrameBaseViewController <
UITableViewDataSource,
UITableViewDelegate,
UITextViewDelegate,
PullingRefreshTableViewDelegate,
BubbleViewDelegate,
EmotionDelegate,
AddContentDelegate,
MsgInputBtnsDelegate>

@property (retain, nonatomic) ISTPullRefreshTableView *tableView;
@property (retain, nonatomic) MessageInputView *messageInputView;
@property (nonatomic, retain) EmotionView *emotionView;
@property (nonatomic,retain) AddContentToDetailView *addDetailView;
@property (assign, nonatomic) CGFloat previousTextViewContentHeight;
@property (retain, nonatomic) UIButton *resignKBBtn;
@property (nonatomic, retain) MsgSendBtnsView *msgBtnsView;


#pragma mark - Actions
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text;
- (void)sendPressed:(UIButton *)sender;
- (void)handleSwipe:(UIGestureRecognizer *)guestureRecognizer;
- (void)handleTap:(UITapGestureRecognizer *)guestureRecognizer;

- (void)hideKeyboard:(id)sender;

#pragma mark - Messages view controller
- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)timeForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)timeHeightAtIndexPath:(NSIndexPath *)indexPath;
//网络图片和本地图片
- (NSString *)thumbnailImagePathForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)originalImagePathForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)headerPathForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)userIdAtIndexPath:(NSIndexPath *)indexPath;


- (void)finishSendText:(NSString *)text;
- (void)finishSendImage;
- (void)setBackgroundColor:(UIColor *)color;
- (void)scrollToBottomAnimated:(BOOL)animated;

#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification;
- (void)handleWillHideKeyboard:(NSNotification *)notification;
- (void)keyboardWillShowHide:(NSNotification *)notification;

@end