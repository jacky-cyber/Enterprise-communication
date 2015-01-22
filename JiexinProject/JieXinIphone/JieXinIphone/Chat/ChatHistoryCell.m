//
//  ChatHistoryCell.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatHistoryCell.h"
@interface ChatHistoryCell ()
@property (nonatomic, retain)NSString *message;
@property (nonatomic, retain)UIImageView *contentImageView;
@end


@implementation ChatHistoryCell

- (void)dealloc
{
    self.timeAndNameLabel = nil;
    self.timeLabel = nil;
    self.message = nil;
    self.messageLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.timeAndNameLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        _timeAndNameLabel.numberOfLines = 0;
        _timeAndNameLabel.textColor = RGBCOLOR(1, 165, 228);
        _timeAndNameLabel.backgroundColor = [UIColor clearColor];
        _timeAndNameLabel.font = [UIFont systemFontOfSize:kHistoryNameFont];
        [self.contentView addSubview:_timeAndNameLabel];
        
        self.timeLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:kHistoryTimeFont];
        [self.contentView addSubview:_timeLabel];

        
        
//        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        aLabel.font = [UIFont systemFontOfSize:kHistoryTimeFont];
//        aLabel.backgroundColor = [UIColor clearColor];
//        aLabel.textColor = [UIColor grayColor];
//        self.messageLabel = aLabel;
//        [aLabel release];
//        _messageLabel.numberOfLines = 0;
//        [self.contentView addSubview:_messageLabel];
        
//        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        aImageView.userInteractionEnabled = YES;
//        self.contentImageView = aImageView;
//        [aImageView release];
//        [self.contentView addSubview:_contentImageView];

        
    }
    return self;
}

- (void)setDatas:(ChatMessagesFeed *)feed
{
//    [_contentImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSString *name = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    
//    NSString *timenameStr = [NSString stringWithFormat:@"%@  %@",name,feed.date];
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:kHistoryNameFont] constrainedToSize:CGSizeMake(kScreen_Width-10, MAXFLOAT)];
    _timeAndNameLabel.text = name;
    _timeAndNameLabel.frame = CGRectMake(5, 5, size.width, size.height);
    
    
    NSString *timeStr = [TimeChangeWithTimeStamp getSSSTimeFromFFFTime:feed.sendDate];
    CGSize timeSize = [timeStr sizeWithFont:[UIFont systemFontOfSize:kHistoryTimeFont] constrainedToSize:CGSizeMake(kScreen_Width-10-CGRectGetWidth(_timeAndNameLabel.frame), MAXFLOAT)];
    _timeLabel.text = timeStr;
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_timeAndNameLabel.frame)+3, CGRectGetMaxY(_timeAndNameLabel.frame)-timeSize.height, timeSize.width, timeSize.height);

    
//    self.message = feed.message;
//    MessageType type = [self getMessageType:feed.message];
//    if (type == HeKaMsg)
//    {
////        UIImage *heKaImage = [UIImage imageNamed:@"greetincard.png"];
////        _contentImageView.image = heKaImage;
////        _contentImageView.frame = CGRectMake(5,  CGRectGetMaxY(_timeAndNameLabel.frame), heKaImage.size.width, heKaImage.size.height);
//        self.message = @"[贺卡]";
//
//    }
//    else if (type == PicMsg)
//    {
//        self.message = @"[图片]";
//    }
//    size = [self.message sizeWithFont:[UIFont systemFontOfSize:kHistoryMessageFont] constrainedToSize:CGSizeMake(kScreen_Width-10, MAXFLOAT)];
//    _messageLabel.text = self.message;
//    _messageLabel.frame = CGRectMake(5, CGRectGetMaxY(_timeAndNameLabel.frame), size.width, size.height);
    for (UIView *subView in [self.contentView subviews]) {
        if ([subView isKindOfClass:[OHAttributedLabel class]]) {
            [subView removeFromSuperview];
        }
    }
    feed.attributedLabel.frame = CGRectMake(5, CGRectGetMaxY(_timeAndNameLabel.frame), feed.attributedLabel.frame.size.width, feed.attributedLabel.frame.size.height);
    [self.contentView addSubview:feed.attributedLabel];
   
//    [self setNeedsDisplay];
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



- (void)drawRect:(CGRect)rect
{
//    CGSize textSize = [ChatHistoryCell textSizeForText:self.message];
//    CGRect textFrame = CGRectMake(5,
//                                  CGRectGetMaxY(_timeAndNameLabel.frame),
//                                  textSize.width,
//                                  textSize.height);
//    [self drawMessage:textFrame withText:self.message];
//    [super drawRect:rect];

}


- (void)drawMessage:(CGRect)rect withText:(NSString *)msg
{
	CGFloat upX=CGRectGetMinX(rect);
    CGFloat upY=CGRectGetMinY(rect);
    
    CGFloat width = kScreen_Width -5;;
    
    NSMutableArray *data = [NSMutableArray array];
//    [self getImageRange:msg :data];
    
    [msg drawInRect:_timeAndNameLabel.frame withFont:[UIFont systemFontOfSize:kHistoryMessageFont]];
//    if (msg)
//    {
//        //字符串前的空白字符
//		for (int i=0;i<[data count];i++) {
//			NSString *str=[data objectAtIndex:i];
//			if ([str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"]) {
//                if(upX+kFacialSizeWidth >= width)
//                {
//                    upX = CGRectGetMinX(rect);
//                    upY = upY + kHistoryMessageFont/0.75;
//                    
//                }
//				NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];
//				UIImage *img=[UIImage imageNamed:imageName];
//				[img drawInRect:CGRectMake(upX, upY+(kHistoryMessageFont/0.75 - kFacialSizeHeight)/2, kFacialSizeWidth, kFacialSizeHeight)];
//                upX=kFacialSizeWidth+upX;
//                
//                
//			}else {
//                for (int i=0; i<[str length]; i++)
//                {
//                    
//                    //取出每个字符
//                    NSString *everyStr = [str substringWithRange:NSMakeRange(i, 1)];
//                    CGSize size=[everyStr sizeWithFont:[UIFont systemFontOfSize:kHistoryMessageFont] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//                    if(upX+size.width >= width)
//                    {
//                        upX = CGRectGetMinX(rect);
//                        upY = upY +kHistoryMessageFont/0.75;
//                    }
//
//                    [everyStr drawInRect:CGRectMake(upX, upY, size.width, size.height) withFont:[UIFont systemFontOfSize:kHistoryMessageFont]];
//                    upX=size.width+upX;
//                    
//                }
//            }
//        }
//    }
    
    
    //    if (msg)
    //    {
    //        //字符串前的空白字符
    //
    //		for (int i=0;i<[data count];i++) {
    //			NSString *str=[data objectAtIndex:i];
    //			if ([str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"]) {
    //				NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];
    //				UIImage *img=[UIImage imageNamed:imageName];
    //				[img drawInRect:CGRectMake(upX, upY+2, kFacialSizeWidth, kFacialSizeHeight)];
    //				upX=kFacialSizeWidth+upX;
    //			}else {
    //				CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
    //				[str drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:fon];
    //				upX=upX+size.width;
    //			}
    //        }
    //    }
}


-(void)getImageRange:(NSString*)message :(NSMutableArray*)array
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *imageNameDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *keyArr = [imageNameDic allKeys];
    NSMutableString *str = [[[NSMutableString alloc] initWithString:message] autorelease];
    for(NSString *key in keyArr)
    {
        NSString *value = [imageNameDic objectForKey:key];
        BOOL isExist = YES;
        while(isExist)
        {
            NSRange range =  [str rangeOfString:value];
            if (range.length) {
                NSString *nameStr = [NSString stringWithFormat:@"<&%@&>",key];
                [str replaceCharactersInRange:range withString:nameStr];
            }
            else
            {
                isExist = NO;
            }
        }
        
    }
    
    NSRange range=[str rangeOfString:@"<&"];
    NSRange range1=[str rangeOfString:@"&>"];
    //判断当前字符串是否还有表情的标志。
    if (range.length&&range1.length)
    {
        if (range.location>0) {
            [array addObject:[str substringToIndex:range.location]];
            [array addObject:[str substringWithRange:NSMakeRange(range.location, range1.location+2-range.location)]];
            NSString *str1=[str substringFromIndex:range1.location+2];
            [self getImageRange:str1 :array];
        }else {
            NSString *nextstr=[str substringWithRange:NSMakeRange(range.location, range1.location+2-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str1=[str substringFromIndex:range1.location+2];
                [self getImageRange:str1 :array];
            }else {
                return;
            }
        }
        
    }else {
        [array addObject:str];
    }
    
}


+ (CGSize)textSizeForText:(NSString *)txt
{
    CGFloat width = kScreen_Width - 10;
    
    NSMutableArray *arr = [NSMutableArray array];
    [BubbleView getImageRange:txt :arr];
    
    CGFloat upX = 0;
    CGFloat upY = kHistoryMessageFont/0.75;
    CGFloat maxWith = 0;
    
    if (txt)
    {
        //字符串前的空白字符
		for (int i=0;i<[arr count];i++) {
			NSString *str=[arr objectAtIndex:i];
			if ([str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"]) {
                //				NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];
                //				UIImage *img=[UIImage imageNamed:imageName];
                //				[img drawInRect:CGRectMake(upX, upY+(15.0/0.75 - kFacialSizeHeight)/2, kFacialSizeWidth, kFacialSizeHeight)];
                if(upX >= width)
                {
                    upX = 0;
                    upY = upY + kHistoryMessageFont/0.75;
                    
                }
				upX=kFacialSizeWidth+upX;
                maxWith = upX > maxWith?upX:maxWith;
                
                
			}else {
                for (int i=0; i<[str length]; i++)
                {
                    //取出每个字符
                    NSString *everyStr = [str substringWithRange:NSMakeRange(i, 1)];
                    CGSize size=[everyStr sizeWithFont:[UIFont systemFontOfSize:kHistoryMessageFont] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    //                    [str drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:font];
                    
                    if(upX >= width)
                    {
                        upX = 0;
                        upY = upY + kHistoryMessageFont/0.75;
                    }
                    upX=size.width+upX;
                    maxWith = upX > maxWith?upX:maxWith;
                }
            }
        }
        return CGSizeMake(maxWith, upY);
    }
    
    return CGSizeMake(10, 20);
}

+ (CGFloat)heiForText:(NSString *)txt
{
	CGSize textSize = [self textSizeForText:txt];
	return 17+textSize.height;
}
                      

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
