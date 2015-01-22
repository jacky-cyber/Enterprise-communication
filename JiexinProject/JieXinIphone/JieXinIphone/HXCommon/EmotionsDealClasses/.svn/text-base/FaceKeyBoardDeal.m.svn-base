//
//  FaceKeyBoardDeal.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-4.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "FaceKeyBoardDeal.h"

@implementation FaceKeyBoardDeal
//输入回退
+ (void)faceBackDeal:(UITextView *)textView
{
    NSString *inputString;
    inputString = textView.text;
    
    if (!inputString || !inputString.length) {
        return;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^]]{1,}\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    //获得所有匹配了表达式的字符串。
    NSArray *array =  nil;
    array = [regex matchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    //找到最后一个[]匹配的字符串  而且判断是否是结尾
    NSTextCheckingResult* b = [array lastObject];
    NSRange  tmpRange = b.range;
    NSInteger stringLength = inputString.length;
    NSString *tmpStr = nil;
    if ((tmpRange.location+tmpRange.length) == stringLength) {
        NSString *str1 = [inputString substringWithRange:tmpRange];
        //找到最后这[] 然后去匹配是否在表情的plist 里面
        NSString *reverseFacePath = [[NSBundle mainBundle] pathForResource:@"reversalFaceList" ofType:@"plist"];
        NSDictionary *reverseFaceDic = [NSDictionary dictionaryWithContentsOfFile:reverseFacePath];
        NSString *imageName = [reverseFaceDic objectForKey:str1];

        if (imageName) {
            tmpStr = [inputString substringToIndex:tmpRange.location];
        }else
        {
            tmpStr = [inputString substringToIndex:stringLength-1];
        }
    }
    else
    {
        tmpStr = [inputString substringToIndex:stringLength-1];
    }
    
    textView.text = tmpStr;
}

+ (NSString *)faceSendStr:(NSString *)textStr
{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *m_emojiDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *reverseFacePath = [[NSBundle mainBundle] pathForResource:@"reversalFaceList" ofType:@"plist"];
    NSDictionary *reverseFaceDic = [NSDictionary dictionaryWithContentsOfFile:reverseFacePath];
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^]]{1,}\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    //    获得所有匹配了表达式的字符串。
    NSMutableArray *nameArr = [NSMutableArray array];
    NSArray *array =  nil;
    array = [regex matchesInString:textStr options:0 range:NSMakeRange(0, [textStr length])];
    for(NSTextCheckingResult* b in array)
    {
        NSString *str1 = [textStr substringWithRange:b.range];
        NSString *imageName = [reverseFaceDic objectForKey:str1];
        if (imageName) {
            NSString *image = [m_emojiDic objectForKey:imageName];
            NSDictionary *dic = @{@"name": str1,@"image":image};
            [nameArr addObject:dic];
        }
    }
    
    for(NSDictionary *dic in nameArr)
    {
        NSString *name = [dic objectForKey:@"name"];
        NSString *image = [dic objectForKey:@"image"];
        textStr =[textStr stringByReplacingOccurrencesOfString:name withString:image];
    }
    return textStr;
}

@end
