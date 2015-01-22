    //
//  MessagesViewController.m
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

#import "MessagesViewController.h"
#import "MessageInputView.h"
#import "NSString+MessagesView.h"
#import "UIView+AnimationOptionsForCurve.h"
#import "SDImageCache.h"
#import "ImageViewController.h"
#import "MsgCategoryVC.h"
#import "FaceKeyBoardDeal.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



#define ios_7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@interface MessagesViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat contentViewHeight;
- (void)setup;

@end



@implementation MessagesViewController
@synthesize resignKBBtn = _resignKBBtn;
#pragma mark - Initialization

- (void)dealloc
{
    self.tableView = nil;
    self.messageInputView = nil;
    self.emotionView = nil;
    self.addDetailView = nil;
    self.resignKBBtn = nil;
    self.msgBtnsView = nil;
    [super dealloc];
}
- (void)setup
{
    float changeFloat = 0;
    if (ios_7) {
        changeFloat = 20.f;
    }
    
    CGSize size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 20);

    self.contentViewHeight = SCREEN_HEIGHT - 20+changeFloat;
    CGRect tableFrame = CGRectMake(0.0f, 44 + changeFloat, size.width, size.height - 44 - 44-25);
    ISTPullRefreshTableView *aTable = [[ISTPullRefreshTableView alloc] initWithFrame:tableFrame pullingDelegate:self];
    self.tableView = aTable;
    [aTable release];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.reachedTheEnd = YES;
    self.tableView.delegate = self;
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.dataSource = self;
    self.tableView.headerOnly = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];


    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT-25 + changeFloat, size.width, INPUT_HEIGHT+25);
    MessageInputView *aInput = [[MessageInputView alloc] initWithFrame:inputFrame] ;
    self.messageInputView = aInput;
    [aInput release];
    self.messageInputView.delegate = self;
    self.messageInputView.textView.delegate = self;
//    self.messageInputView.backgroundColor = [UIColor whiteColor ];
    [self.messageInputView.sendButton addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageInputView.imageButton addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageInputView.addContentBtn addTarget:self action:@selector(addContentToDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageInputView];
    
    if(!self.previousTextViewContentHeight)
    {
        if (ios_7) {
            self.previousTextViewContentHeight = [[self.messageInputView.textView layoutManager]usedRectForTextContainer:[self.messageInputView.textView  textContainer]].size.height;
        }else{
            self.previousTextViewContentHeight  = self.messageInputView.textView .contentSize.height;
        }
    }

    
//    UIColor *color = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
    [self setBackgroundColor:[UIColor whiteColor]];

//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionDown;
//    swipe.numberOfTouchesRequired = 1;
//    [self.messageInputView addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTouchesRequired =1;
    [self.tableView addGestureRecognizer:tap];
    [tap release];

    
//    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [touchBtn addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
//    touchBtn.frame = self.tableView.frame;
//    touchBtn.backgroundColor = [UIColor yellowColor];
//    //self.resignKBBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.resignKBBtn = touchBtn;
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self handleTap:nil];
//}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTap:) name:@"handleTap" object:nil];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self scrollToBottomAnimated:NO];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboard:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboard:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"*** %@: didReceiveMemoryWarning ***", self.class);
}


#pragma mark - View rotation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.tableView reloadData];
    [self.tableView setNeedsLayout];
}

- (void)hideKeyboard:(id)sender
{
    [self.messageInputView.textView resignFirstResponder];
}

#pragma mark- add image action
- (void)selectImage:(UIButton *)sender
{
//    PhotoLibrary *library = [PhotoLibrary allocWithZone:NSDefaultMallocZone()];
//    [library settingDelegate:self popAt:CGRectZero];
//    [library choosePhoto];
    [self.view endEditing:YES];
    if (self.addDetailView)
    {
        [self.addDetailView removeFromSuperview];
        self.addDetailView = nil;
    }

    CGRect inputViewFrame = self.messageInputView.frame;

    if (self.emotionView) {
        [self.emotionView removeFromSuperview];
        self.emotionView = nil;

        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);
        
        
    }
    else
    {
        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight-216 - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);

        EmotionView *aEmotion = [[EmotionView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight-216, kScreen_Width, 216)];
        self.emotionView = aEmotion;
        [aEmotion release];
        _emotionView.delegate = self;
        [self.view addSubview:_emotionView];
        
    }
    [self changeTableViewContentInset];
    [self scrollToBottomAnimated:YES];
}

- (void)addContentToDetail:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.emotionView)
    {
        [self.emotionView removeFromSuperview];
        self.emotionView = nil;
    }
    
    CGRect inputViewFrame = self.messageInputView.frame;
    
    if (self.addDetailView) {
        [self.addDetailView removeFromSuperview];
        self.addDetailView = nil;
        
        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);
        
        
    }
    else
    {
        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight -216 - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);
        
        AddContentToDetailView *content = [[AddContentToDetailView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight-216, kScreen_Width, 216)];
        self.addDetailView = content;
        [content release];
        _addDetailView.delegate = self;
        [self.view addSubview:_addDetailView];
        
    }
    [self changeTableViewContentInset];
    [self scrollToBottomAnimated:YES];

}

- (void)selectEmotionFinish:(NSDictionary *)infoDic
{
    if ([self.messageInputView.textView.text length])
    {
        //这里是为了 在某一个点 插入表情而不是加到最后
        NSString *text = [self.messageInputView.textView.text stringByReplacingCharactersInRange:self.messageInputView.textView.selectedRange withString:[infoDic objectForKey:@"image"]];
        self.messageInputView.textView.text = text;
    }
    else
    {
        self.messageInputView.textView.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"image"]];
    }
    [self textViewDidChange:self.messageInputView.textView];
}

- (void)selectMsgDetail:(NSDictionary *)infoDic
{
    if ([self.messageInputView.textView.text length])
    {
        //这里是为了 在某一个点 插入短信而不是加到最后
        NSString *text = [self.messageInputView.textView.text stringByReplacingCharactersInRange:self.messageInputView.textView.selectedRange withString:[infoDic objectForKey:@"msgContent"]];
        self.messageInputView.textView.text = text;
    }
    else
    {
        self.messageInputView.textView.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"msgContent"]];
    }

    [self textViewDidChange:self.messageInputView.textView];
}


- (void)selectBtnTap:(AddToDetailBtnTag)tag
{
    }

#pragma mark - PhotoLibrary delegate
- (void)selectImage:(UIImage *)image withInfo:(id)info
{
    [self sendImage:image];
}

#pragma mark - Actions
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    self.messageInputView.textView.text = text;
//    [self finishSendText:nil];
} // override in subclass

- (void)sendPressed:(UIButton *)sender
{
    [self sendPressed:sender
             withText:[self.messageInputView.textView.text trimWhitespace]];
}

- (void)sendImage:(UIImage *)image
{}// override in subclass

//- (void)handleSwipe:(UIGestureRecognizer *)guestureRecognizer
//{
////    [self.messageInputView.textView resignFirstResponder];
//    [self hideKeyboard:guestureRecognizer];
//    if (CGRectGetMinY(self.emotionView.frame)<kScreen_Height) {
//        self.emotionView.frame = CGRectMake(CGRectGetMinX(self.emotionView.frame), kScreen_Height, CGRectGetWidth(self.emotionView.frame), CGRectGetHeight(self.emotionView.frame));
//        self.emotionView = nil;
//        
//        CGRect inputViewFrame = self.messageInputView.frame;
//        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
//                                          kScreen_Height - inputViewFrame.size.height,
//                                          inputViewFrame.size.width,
//                                          inputViewFrame.size.height);
//
//    }
//}

- (void)handleTap:(UITapGestureRecognizer *)guestureRecognizer
{
//    if ([guestureRecognizer locationInView:self.view].y > CGRectGetMinY(self.messageInputView.frame)) {
//        return;
//    }
    [self hideKeyboard:guestureRecognizer];
    if (CGRectGetMinY(self.emotionView.frame)<kScreen_Height) {
        self.emotionView.frame = CGRectMake(CGRectGetMinX(self.emotionView.frame), kScreen_Height, CGRectGetWidth(self.emotionView.frame), CGRectGetHeight(self.emotionView.frame));
        self.emotionView = nil;
        
        CGRect inputViewFrame = self.messageInputView.frame;
        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);
        
    }
    
    if (CGRectGetMinY(self.addDetailView.frame)<kScreen_Height) {
        self.addDetailView.frame = CGRectMake(CGRectGetMinX(self.addDetailView.frame), kScreen_Height, CGRectGetWidth(self.addDetailView.frame), CGRectGetHeight(self.addDetailView.frame));
        self.addDetailView = nil;
        
        CGRect inputViewFrame = self.messageInputView.frame;
        self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                 self.contentViewHeight - inputViewFrame.size.height,
                                                 inputViewFrame.size.width,
                                                 inputViewFrame.size.height);
        
    }

    self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), CGRectGetWidth(self.tableView.frame), self.messageInputView.frame.origin.y-CGRectGetMinY(self.tableView.frame));
//    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
//                                           0.0f,
//                                           self.view.frame.size.height - self.messageInputView.frame.origin.y - 44,
//                                           0.0f);
//    
//    self.tableView.contentInset = insets;
//    self.tableView.scrollIndicatorInsets = insets;
    
//    [self scrollToBottomAnimated:YES];

}


#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BubbleMessageStyle style = [self messageStyleForRowAtIndexPath:indexPath];
    
    //和图片混
    NSString *CellID = [NSString stringWithFormat:@"MessageCell%d", style];
    BubbleMessageCell *cell = (BubbleMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    if(!cell) {
        cell = [[[BubbleMessageCell alloc] initWithBubbleStyle:style
                                              reuseIdentifier:CellID] autorelease];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    // override in subclass
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
    // Override in subclass
}

#pragma mark - Messages view controller
- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil; // Override in subclass
}

- (NSString *)timeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil; // Override in subclass
}
- (CGFloat)timeHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 0; // Override in subclass
}
- (NSString *)thumbnailImagePathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;// Override in subclass
}

- (NSString *)originalImagePathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;// Override in subclass
}

- (NSString *)headerPathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;// Override in subclass
}

- (NSString *)userIdAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;// Override in subclass
}

- (void)finishSendText:(NSString *)text;
{
    [self.messageInputView.textView setText:text];
    [self textViewDidChange:self.messageInputView.textView];
//    [self performSelector:@selector(test:) withObject:nil afterDelay:0.3];
    [self.tableView reloadData];
    [self scrollToBottomAnimated:YES];
}

- (void)finishSendImage
{
    [self.tableView reloadData];
    [self scrollToBottomAnimated:YES];
}

//- (void)test:(NSString *)text;{
//    [self.messageInputView.textView setText:text];
//    [self textViewDidChange:self.messageInputView.textView];
//}

- (void)setBackgroundColor:(UIColor *)color
{
//    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = color;

}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    if(rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}

//- (NSString *)stringToCopyForCopyableLabel:(BubbleView *)copyableLabel{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(handleWillShowKeyboard:)
//												 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(handleWillHideKeyboard:)
//												 name:UIKeyboardWillHideNotification
//                                               object:nil];
//    return nil;
//}




#pragma mark - Text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
        [self scrollToBottomAnimated:YES];
    //[self.tableView addSubview:self.resignKBBtn];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    //[self.resignKBBtn removeFromSuperview];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //点击了非删除键
    if( [text length] == 0 ) {
        
        if ( range.length > 1 || range.location != textView.text.length-1) {
            
            return YES;
        }
        else {
            
            [FaceKeyBoardDeal faceBackDeal:textView];
            [self textViewDidChange:textView];
            return NO;
        }
    }
    else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *str=textView.text;
    NSInteger maxLength = kLongMessageLength;
    if (self.messageInputView.msgBtnsView.duanxinBtn.selected) {
        maxLength = kDuanXinLength;
    }
    if (!textView.markedTextRange && str.length > maxLength) {
        str=[str substringToIndex:maxLength];
        textView.text= str;
    }
    CGFloat maxHeight = [MessageInputView maxHeight];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)
    {
        NSRange range = [textView selectedRange];
        NSString *tmpStr = textView.text;
        textView.text = nil;
        textView.text = tmpStr;
        [textView setSelectedRange:range];
    }
    
//    NSRange range = [textView selectedRange];
//    NSString *tmpStr = textView.text;
//    textView.text = nil;
//    textView.text = tmpStr;
//    [textView setSelectedRange:range];
    
    CGFloat textViewContentHeight;
    if (ios_7) {
//        textViewContentHeight = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
       textViewContentHeight = [[textView layoutManager]usedRectForTextContainer:[textView textContainer]].size.height;

    }else{
        textViewContentHeight = textView.contentSize.height;
    }
    //这里是匹配输入框的
    if (ios_7)
    {
        if (textViewContentHeight > CGRectGetHeight(textView.frame)) {
            [textView setContentOffset:CGPointMake(0, textViewContentHeight-CGRectGetHeight(textView.frame)+10)];
        }
    }
    else
    {
        if (textViewContentHeight > CGRectGetHeight(textView.frame)) {
            [textView setContentOffset:CGPointMake(0, textViewContentHeight-CGRectGetHeight(textView.frame))];
        }
    }
    
    CGFloat changeInHeight = textViewContentHeight - self.previousTextViewContentHeight;
    
//    changeInHeight = (textViewContentHeight >= maxHeight) ? maxHeight-self.previousTextViewContentHeight: changeInHeight;
    changeInHeight = (textViewContentHeight >= maxHeight) ? maxHeight-self.previousTextViewContentHeight : changeInHeight;
    if(changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
//                             UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, self.tableView.contentInset.bottom + changeInHeight, 0.0f);
//                             self.tableView.contentInset = insets;
//                             self.tableView.scrollIndicatorInsets = insets;
//                             self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame)-changeInHeight);
//                             [self scrollToBottomAnimated:NO];
                             
                             CGRect inputViewFrame = self.messageInputView.frame;
                             self.messageInputView.frame = CGRectMake(0.0f,
                                                               inputViewFrame.origin.y - changeInHeight,
                                                               inputViewFrame.size.width,
                                                               inputViewFrame.size.height + changeInHeight);
                             [self changeTableViewContentInset];
                         }
                         completion:^(BOOL finished) {
                         }];
        
        self.previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
    }
    
    self.messageInputView.sendButton.enabled = ([textView.text trimWhitespace].length > 0);
}

#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)keyboardWillShowHide:(NSNotification *)notification
{
    if (self.emotionView) {
        [self.emotionView removeFromSuperview];
        self.emotionView = nil;
    }
    if (self.addDetailView) {
        [self.addDetailView removeFromSuperview];
        self.addDetailView = nil;
    }
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:[UIView animationOptionsForCurve:curve]
                     animations:^{
                         
                         [self changeMessageInputViewFrame:keyboardRect];
                                              }
                     completion:^(BOOL finished) {
                     }];
}

- (void)changeMessageInputViewFrame:(CGRect)rect
{
    CGFloat keyboardY = [self.view convertRect:rect fromView:nil].origin.y;
    CGRect inputViewFrame = self.messageInputView.frame;
    self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                             keyboardY - inputViewFrame.size.height,
                                             inputViewFrame.size.width,
                                             inputViewFrame.size.height);
    [self changeTableViewContentInset];

}

- (void)changeTableViewContentInset
{
    self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), CGRectGetWidth(self.tableView.frame),self.messageInputView.frame.origin.y-CGRectGetMinY(self.tableView.frame));
    if (CGRectGetMaxY(self.messageInputView.frame) < self.view.frame.size.height)
    {
        NSLog(@"滚动到最底部");
        [self scrollToBottomAnimated:NO];
    }
//    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
//                                           0.0f,
//                                           self.view.frame.size.height - self.messageInputView.frame.origin.y - 44,
//                                           0.0f);
//    
//    self.tableView.contentInset = insets;
//    self.tableView.scrollIndicatorInsets = insets;

}

@end