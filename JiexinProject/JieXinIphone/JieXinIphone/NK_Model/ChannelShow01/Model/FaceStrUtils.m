//
//  FaceStrUtils.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-5-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "FaceStrUtils.h"
#import "Emoji_Translation.h"

@implementation FaceStrUtils
@synthesize contentHeight;
@synthesize VIEW_WIDTH_MAX;

-(id)init{
    
    self = [super init];
    if(self){
        
    }
    return self;
}

- (void)drawText:(NSString *)string withFont:(UIFont *)font {
    
    int linelength= VIEW_WIDTH_MAX ;
    
    for ( int index = 0; index < string.length; index++) {
        
        
        
        NSString *character = [string substringWithRange:NSMakeRange( index, 1 )];
        
        
        CGSize size = [character sizeWithFont:font
                            constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
        
        if([character isEqualToString:@"\n"]){
            
            upX=VIEW_LEFT;
            upY+=VIEW_LINE_HEIGHT-2;
            
            isLineReturn=YES;
            
        }else {
            
            if ( upX > linelength) {
                
                isLineReturn = YES;
                
                upX = VIEW_LEFT;
                upY += VIEW_LINE_HEIGHT;
                contentHeight=upY+VIEW_LINE_HEIGHT;
            }
            
        }
        
        upX += size.width;
        
        lastPlusSize = size.width;
        
    }
}


-(int)getFaceStrViewHeight:(NSString *)str withWidth:(int)w{
    
    VIEW_WIDTH_MAX=w;
    contentHeight=0;
    
    NSString *str2 = [Emoji_Translation EmojiWithQixin:str];
    
    
    NSMutableArray *EmojiArr=[[NSMutableArray alloc] initWithCapacity:0];
    [ self getImageRange:str2 :EmojiArr];
    
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    
    isLineReturn = NO;
    
    upX = VIEW_LEFT;
    
    upY = VIEW_TOP;
    
    for (int index = 0; index < [EmojiArr count]; index++) {
        
        NSString *str = [EmojiArr objectAtIndex:index];
        
        if (  [str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"]) {
            
            NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            if ( image ) {
                if ( upX > ( VIEW_WIDTH_MAX ) ) {
                    
                    isLineReturn = YES;
                    
                    upX = VIEW_LEFT;
                    upY += VIEW_LINE_HEIGHT;
                    
                    contentHeight=upY+VIEW_LINE_HEIGHT;
                }
                
                upX += KFacialSizeWidth;
                
                lastPlusSize = KFacialSizeWidth;
            }
            else {
                [self drawText:str withFont:font];
            }
        }else {
            
            [self drawText:str withFont:font];
        }
    }
    
    if(contentHeight==0){
        contentHeight=VIEW_LINE_HEIGHT;
    }
    
    return contentHeight;
}

-(NSArray*)getImageRange:(NSString*)message : (NSMutableArray*)array {
    
    NSString * str = @"<&";
    NSString * str1 = @"&>";
    NSRange range=[message rangeOfString:str];
    NSRange range1=[message rangeOfString:str1];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            if(![[message substringToIndex:range.location] isEqualToString:@""])
            {
                [array addObject:[message substringToIndex:range.location]];
            }
            if(![[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)] isEqualToString:@""])
            {
                [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)]];
            }
            NSString *str=[message substringFromIndex:range1.location+str1.length];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location-range.location+str1.length)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+str1.length];
                [self getImageRange:str :array];
            }else {
                return array;
            }
        }
        
    } else if (message != nil&&![message isEqualToString:@""]) {
        [array addObject:message];
        return array;
    }
    return array;
}


@end
