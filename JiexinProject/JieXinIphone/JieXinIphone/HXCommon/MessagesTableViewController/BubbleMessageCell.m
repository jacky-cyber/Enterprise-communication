//
//  BubbleMessageCell.m
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

#import "BubbleMessageCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface BubbleMessageCell()


@end



@implementation BubbleMessageCell
#pragma mark - Initialization

- (void)dealloc
{
     self.bubbleView = nil;
     self.timeLb = nil;
     self.nameLb = nil;

    [super dealloc];
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.imageView.image = nil;
    self.imageView.hidden = YES;
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.detailTextLabel.text = nil;
    self.detailTextLabel.hidden = YES;
    
    BubbleView *aBubbleView =[[BubbleView alloc] initWithFrame:CGRectZero];
    self.bubbleView = aBubbleView;
    [aBubbleView release];
    [self.contentView addSubview:self.bubbleView];
//    [self bringSubviewToFront:self.bubbleView];

//    [self.contentView sendSubviewToBack:self.bubbleView];
    
    UILabel *aLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLb =aLabel;
    [aLabel release];
    self.timeLb.font = [UIFont systemFontOfSize:12.f];
    self.timeLb.textAlignment = NSTextAlignmentCenter;
    self.timeLb.backgroundColor = RGBCOLOR(208, 208, 208);
    self.timeLb.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.timeLb];
}

- (void)setBubbleViewWithChatMessageFeed:(ChatMessagesFeed *)feed withIsShowTime:(BOOL)isShow
{
    CGFloat bubbleHeight = [BubbleView bubbleCellHeightForObject:feed];
    if (isShow) {
        _timeLb.hidden = NO;
        self.bubbleView.frame = CGRectMake(0.0f,
                                           TIME_LABEL_HEIGHT,
                                           kScreen_Width,
                                           bubbleHeight);
    }
    else
    {
        _timeLb.hidden = YES;
        self.bubbleView.frame = CGRectMake(0.0f,
                                           0,
                                           kScreen_Width,
                                           bubbleHeight);

    }
    [self.bubbleView setChatMessageFeed:feed];
}

- (void)setTimeLbText:(NSString *)text
{
    _timeLb.text = text;
    CGSize size = [text sizeWithFont:_timeLb.font constrainedToSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(_timeLb.frame))];
    _timeLb.layer.cornerRadius = 3.0f;
    _timeLb.layer.borderColor = RGBCOLOR(208, 208, 208).CGColor;
    _timeLb.layer.borderWidth = 1.f;
    _timeLb.frame = CGRectMake(0, 0, size.width+4, size.height);
    _timeLb.layer.masksToBounds = YES;
    _timeLb.center = CGPointMake(SCREEN_WIDTH/2, size.height/2+2);
}

- (id)initWithBubbleStyle:(BubbleMessageStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        [self.bubbleView setStyle:style];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setters
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self.bubbleView setBackgroundColor:backgroundColor];
}

@end