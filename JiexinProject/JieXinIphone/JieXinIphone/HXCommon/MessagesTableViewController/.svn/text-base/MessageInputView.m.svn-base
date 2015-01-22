//
//  MessageInputView.m
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

#import "MessageInputView.h"
#import "BubbleView.h"

#define MsgBtnsHeight  25.0f

@interface MessageInputView ()


- (void)setup;
- (void)setupTextView;
- (void)setupSendButton;

@end



@implementation MessageInputView

#pragma mark - Initialization

- (void)dealloc
{
    self.textView = nil;
    self.sendButton = nil;
    self.imageButton = nil;
    self.addContentBtn = nil;
    self.msgBtnsView = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg.png"]];
        [self setup];
    }
    return self;
}

- (void)setup
{
//    self.image = [UIImage imageNamed:@"menu_bg.png"];
    self.backgroundColor = [UIColor clearColor];
    //    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    
    [self setupTextView];
    [self setupButton];
}

- (void)setupTextView{
    
    MsgSendBtnsView *aMsg = [[MsgSendBtnsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 25)];
    self.msgBtnsView = aMsg;
    [aMsg release];
    self.msgBtnsView.backgroundColor = [UIColor clearColor];
    self.msgBtnsView.msgBtn.selected = YES;
    self.msgBtnsView.delegate = self;
    [self addSubview:_msgBtnsView];
    
    UIImageView *aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-44, kScreen_Width, 44)];
    aView.userInteractionEnabled = YES;
    aView.image = [UIImage imageNamed:@"historyBottomBg.png"];
    aView.backgroundColor = [UIColor whiteColor];
    [self addSubview:aView];
    [aView release];

    //TODO:需要优化
    UIImage *fieldBackImg = [UIImage imageNamed:@"comment_bar_field"];
    UIImageView *inputFieldBack = [[UIImageView alloc] initWithFrame:CGRectMake(61, 25+7.0f, kScreen_Width-62-61, fieldBackImg.size.height/2)];
    [inputFieldBack.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [inputFieldBack.layer setBorderWidth:1.0f];
    [inputFieldBack.layer setCornerRadius:5.0f];

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
//    {
////        UIImage *fieldBackImg = [UIImage imageNamed:@"comment_bar_field"];
////        UIImageView *inputFieldBack = [[UIImageView alloc] initWithFrame:CGRectMake(38, 7.0f, 320-76, fieldBackImg.size.height/2)];
////        inputFieldBack.image =fieldBackImg;
//        inputFieldBack.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//        [aView addSubview:inputFieldBack];
//        
//        CGFloat width = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? (320-76) : 690.0f;
//        CGFloat height = [MessageInputView textViewLineHeight] * [MessageInputView maxLines];
//        
//        self.textView = [[CustomTextView alloc] initWithFrame:CGRectMake(38, 10.0f, width, height)];
//        [self.textView setPlaceholder:@"消息发送"];
//        self.textView.placeholderColor = [UIColor grayColor];
//        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(13.0f, 0.0f, 14.0f, 7.0f);
//        self.textView.contentInset = UIEdgeInsetsMake(-4.0, 0.0f, 13.0f, 0.0f);
//        self.textView.scrollEnabled = YES;
//        self.textView.scrollsToTop = NO;
//        self.textView.userInteractionEnabled = YES;
//        self.textView.font = [BubbleView font];
//        self.textView.textColor = [UIColor blackColor];
//        self.textView.backgroundColor = [UIColor clearColor];
//        self.textView.keyboardAppearance = UIKeyboardAppearanceDefault;
//        self.textView.keyboardType = UIKeyboardTypeDefault;
//        self.textView.returnKeyType = UIReturnKeyDefault;
//        [aView addSubview:self.textView];
//    }
//    else
//    {
    
        
//        inputFieldBack.image =fieldBackImg;
        inputFieldBack.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        inputFieldBack.userInteractionEnabled = YES;
        [self addSubview:inputFieldBack];
        [inputFieldBack release];
        //CGFloat width = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? (320-76) : 690.0f;
        //CGFloat height = [MessageInputView textViewLineHeight] * [MessageInputView maxLines];
        
        //CGRectMake(38, 3.0f, width, height)
        //CGRectInset(inputFieldBack.frame, 0, 3)
        CustomTextView *aText = [[CustomTextView alloc] initWithFrame:CGRectInset(inputFieldBack.bounds, 0, 3)];
        self.textView = aText;
        [aText release];
        [self.textView setPlaceholder:@"网络消息"];
    if (iOSVersion<7.0) {
        self.textView.placeholderColor = [UIColor clearColor];
    }else
    {
        self.textView.placeholderColor = [UIColor grayColor];
    }
    //self.textView = [[UITextView alloc] initWithFrame:CGRectMake(38, 3.0f, width, height)];
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(-13.0f, 0.0f, -14.0f, 0.0f);
        self.textView.contentInset = UIEdgeInsetsMake(-4.0f, 0.0f, 0.0f, 0.0f);
        self.textView.scrollEnabled = YES;
        self.textView.font = [UIFont systemFontOfSize:15];
        self.textView.scrollsToTop = NO;
        self.textView.userInteractionEnabled = YES;
        self.textView.font = [BubbleView font];
        self.textView.textColor = [UIColor blackColor];
        self.textView.backgroundColor = [UIColor redColor];
        self.textView.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.textView.keyboardType = UIKeyboardTypeDefault;
        self.textView.returnKeyType = UIReturnKeyDefault;
        [inputFieldBack addSubview:self.textView];
        self.textView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
//    }
}


- (void)setupButton
{
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width -61.0f, 7.0f+MsgBtnsHeight, 60.0f, 30.0f);
    UIImage *sendBack = [UIImage imageNamed:@"comment_canSend.png"];
    //    UIImage *sendBackHighLighted = [UIImage imageNamed:@"comment_canSend"];
    [self.sendButton setBackgroundImage:sendBack forState:UIControlStateNormal];
    self.sendButton.enabled = NO;
    self.sendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:self.sendButton];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.frame = CGRectMake(2, 7.0f+MsgBtnsHeight, 30.0f, 30.0f);
    UIImage *imageLibrary = [UIImage imageNamed:@"imagelibrary.png"];
    //    UIImage *sendBackHighLighted = [UIImage imageNamed:@"comment_canSend"];
    [self.imageButton setBackgroundImage:imageLibrary forState:UIControlStateNormal];
    self.imageButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    self.imageButton.enabled = YES;
    [self addSubview:self.imageButton];
    
    self.addContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addContentBtn.frame = CGRectMake(33, 10.0f+MsgBtnsHeight, 25.0f, 25.0f);
    //    UIImage *sendBackHighLighted = [UIImage imageNamed:@"comment_canSend"];
    [self.addContentBtn setBackgroundImage:[UIImage imageNamed:@"addContentToDetail.png"] forState:UIControlStateNormal];
    self.addContentBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    self.addContentBtn.enabled = YES;
    [self addSubview:self.addContentBtn];
    
}

#pragma mark - MsgSendBtnsDelegate

- (void)msgBtnTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(msgBtnTap)]) {
        [self.delegate msgBtnTap];
    }
}

- (void)duanxinBtnTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(duanxinBtnTap)]) {
        [self.delegate duanxinBtnTap];
    }
}


#pragma mark - Message input view
+ (CGFloat)textViewLineHeight
{
    return 20.0f; // for fontSize 15.0f
}

+ (CGFloat)maxLines
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 5.0f : 8.0f;
}

+ (CGFloat)maxHeight
{
    return ([MessageInputView maxLines] + 1.0f) * [MessageInputView textViewLineHeight];
}

@end