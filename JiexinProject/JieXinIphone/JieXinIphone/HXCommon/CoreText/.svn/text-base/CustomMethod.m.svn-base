//
//  CustomMethod.m
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import "CustomMethod.h"
#import "ImageDataHelper.h"
#import "ChatDetailImageBtn.h"

#define  kSepearateSign  @"</"

@implementation CustomMethod

+ (NSString *)escapedString:(NSString *)oldString
{
    NSString *escapedString_lt = [oldString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    NSString *escapedString = [escapedString_lt stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return escapedString;
}


+ (void)drawImage:(ChatMessagesFeed *)feed
{
    OHAttributedLabel *label = feed.attributedLabel;
    for (NSArray *info in label.imageInfoArr) {
        
        NSString *imageStr = [info objectAtIndex:0];
        BOOL isGif = NO;
        UIImage *image = nil;
        if ([imageStr hasPrefix:@"emoji_"]) {
            image = [UIImage imageNamed:imageStr];
        }
        else if ([imageStr rangeOfString:@"%Greeting%"].location != NSNotFound)
        {
            image = [UIImage imageNamed:@"greetincard.png"];
        }
        else
        {
            NSArray *arr = [imageStr componentsSeparatedByString:@";"];
            if ([arr count]==2) {
                NSString  *smallImageName = [arr objectAtIndex:1];
                NSString *bigImageName  = [arr objectAtIndex:0];

                image = [[ImageDataHelper sharedService] getChatDetailImageWithName:smallImageName];
                if ([bigImageName hasSuffix:@".gif"]) {
                    isGif = YES;
                }
            }
        }
            
        [image drawInRect:CGRectFromString([info objectAtIndex:2])];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectFromString([info objectAtIndex:2])];
        imageView.userInteractionEnabled = YES;
        imageView.image = image;
        [label addSubview:imageView];
        [label bringSubviewToFront:imageView];
        
        
        if (isGif) {
            UIImage *gifSymbolImage = [UIImage imageNamed:@"gif_symbol.png"];
            UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame)-gifSymbolImage.size.width, CGRectGetHeight(imageView.frame)-gifSymbolImage.size.height, gifSymbolImage.size.width, gifSymbolImage.size.height)];
            gifImageView.userInteractionEnabled = YES;
            gifImageView.image = gifSymbolImage;
            [imageView addSubview:gifImageView];
        }
        if (![[info objectAtIndex:0] hasPrefix:@"emoji_"]) {
            ChatDetailImageBtn *imageBtn = [ChatDetailImageBtn buttonWithType:UIButtonTypeCustom];
            imageBtn.frame = imageView.bounds;
            imageBtn.imageStr = [info objectAtIndex:0];
            imageBtn.feed = feed;
            [imageBtn addTarget:self action:@selector(imageBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:imageBtn];
        }
        
        
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
//        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
//        SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
//        imageView.frame = CGRectFromString([info objectAtIndex:2]);
//        [label addSubview:imageView];//label内添加图片层
//        [label bringSubviewToFront:imageView];
    }
}

+ (void)imageBtnTap:(ChatDetailImageBtn *)sender
{
    [sender.feed.attributedLabel chatDetailImageTap:sender.imageStr];
}

+ (void)drawImage:(OHAttributedLabel *)label withView:(UIView *)view
{
    for (NSArray *info in label.imageInfoArr) {
//        NSLog(@"%@",info);
        
        UIImage *image = [UIImage imageNamed:[info objectAtIndex:0]];
        //        [image drawInRect:CGRectFromString([info objectAtIndex:2])];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectFromString([info objectAtIndex:2])];
        imageView.userInteractionEnabled = YES;
        imageView.image = image;
        [view addSubview:imageView];
        [view bringSubviewToFront:imageView];
        
        
        //        NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
        //        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        //        SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
        //        imageView.frame = CGRectFromString([info objectAtIndex:2]);
        //        [label addSubview:imageView];//label内添加图片层
        //        [label bringSubviewToFront:imageView];
    }
}

#pragma mark - 正则匹配电话号码，网址链接，Email地址
+ (NSMutableArray *)addHttpArr:(NSString *)text
{
    //匹配网址链接
    NSString *regex_http = @"(https?|ftp|file)+://[^\\s]*";
    NSArray *array_http = [text componentsMatchedByRegex:regex_http];
    NSMutableArray *httpArr = [NSMutableArray arrayWithArray:array_http];
    return httpArr;
}

+ (NSMutableArray *)addPhoneNumArr:(NSString *)text
{
    //匹配电话号码
    NSString *regex_phonenum = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";
    NSArray *array_phonenum = [text componentsMatchedByRegex:regex_phonenum];
    NSMutableArray *phoneNumArr = [NSMutableArray arrayWithArray:array_phonenum];
    return phoneNumArr;
}

+ (NSMutableArray *)addEmailArr:(NSString *)text
{
    //匹配Email地址
    NSString *regex_email = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*";
    NSArray *array_email = [text componentsMatchedByRegex:regex_email];
    NSMutableArray *emailArr = [NSMutableArray arrayWithArray:array_email];
    return emailArr;
}

+ (NSString *)transformString:(NSString *)originalStr emojiDic:(NSDictionary *)_emojiDic
{
//    //匹配表情，将表情转化为html格式
//    NSString *text = originalStr;
//    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
//    if ([array_emoji count]) {
//        for (NSString *str in array_emoji) {
//            NSRange range = [text rangeOfString:str];
//            NSString *i_transCharacter = [_emojiDic objectForKey:str];
//            if (i_transCharacter) {
//                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='16' height='16'>",i_transCharacter];
//                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:imageHtml];
//            }
//        }
//    }
//    //返回转义后的字符串
//    return text;
    //匹配表情，将表情转化为html格式
    //表情
    NSString *text = originalStr;
    NSArray *emojiKeys = [_emojiDic allKeys];
    for (NSString *key in emojiKeys)
    {
        NSString *value = [_emojiDic objectForKey:key];
        NSRange range = [text rangeOfString:value];
        NSString *i_transCharacter = key;
        if (range.location != NSNotFound && range.length) {
            NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='25' height='25'>",i_transCharacter];
            text = [text stringByReplacingOccurrencesOfString:value withString:imageHtml];
        }
    }
    if ([text rangeOfString:@"%Greeting%"].location != NSNotFound)
    {
        UIImage *image = [UIImage imageNamed:@"greetincard.png"];
        text = [NSString stringWithFormat:@"<img src='%@' width='%f' height='%f'>",text,image.size.width,image.size.height];
        return text;
    }
    BOOL isImageExist = YES;
    while (isImageExist) {
        NSRange firstRange = [text rangeOfString:@"<MsG-PiCtUre>"];
        NSRange lastRange = [text rangeOfString:@"</MsG-PiCtUre>"];
        
        //如果开始 和 结尾 都有的话才算找到了图片
        if (firstRange.location != NSNotFound && lastRange.location != NSNotFound) {
            NSString *tmpStr = [text substringWithRange:NSMakeRange(firstRange.location+firstRange.length, lastRange.location-firstRange.location-firstRange.length)];
            NSArray *arr = [tmpStr componentsSeparatedByString:@";"];
            if ([arr count]==2) {
               UIImage *image = [[ImageDataHelper sharedService] getChatDetailImageWithName:[arr objectAtIndex:1]];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%f' height='%f'>",tmpStr,image.size.width,image.size.height];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(firstRange.location, lastRange.location+lastRange.length-firstRange.location) withString:imageHtml];
            }
            else
            {
                isImageExist = NO;
            }
        }
        else
        {
            isImageExist = NO;
        }
    }
   text = [text stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    text = [text stringByReplacingOccurrencesOfString:@"&ltimg" withString:@"<img"];
    //返回转义后的字符串
    return text;
}

+ (NSArray *)getImageArrFromMessage:(NSString *)message
{
    NSString *string = [NSString stringWithFormat:@"%@[^<]{1,}%@",StartImageContent,EndImageContent];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:string options:NSRegularExpressionCaseInsensitive error:nil];

    NSArray *resultArr = [regex matchesInString:message options:0 range:NSMakeRange(0, [message length])];
    return  resultArr;
}

@end
