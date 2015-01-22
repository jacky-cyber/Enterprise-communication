//
//  MessageView.m
//  FaceBoardDome
//
//  Created by kangle1208 on 13-12-12.
//  Copyright (c) 2013年 Blue. All rights reserved.
//

#import "MessageView.h"

#import "Emoji_Translation.h"


#define FACE_ICON_NAME      @"^[0][0-5][0-9]$"


@implementation MessageView
@synthesize VIEW_WIDTH_MAX;
@synthesize data;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)showMessage:(NSString *)message withWidth:(int)w{
    VIEW_WIDTH_MAX=w;
    NSString *str2 = [Emoji_Translation EmojiWithQixin:message];
    
    
    NSMutableArray *EmojiArr=[[NSMutableArray alloc] initWithCapacity:0];
    [ self getImageRange:str2 :EmojiArr];
    
    NSLog(@"%@",EmojiArr);
    self.data = EmojiArr;
    
    [self setNeedsDisplay];
    
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

- (void)drawRect:(CGRect)rect {
    
    
	if ( data ) {
        
        //        NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:FACE_DIC];
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        
        isLineReturn = NO;
        
        upX = VIEW_LEFT;
        
        upY = VIEW_TOP;
        
		for (int index = 0; index < [data count]; index++) {
            
			NSString *str = [data objectAtIndex:index];
            
			if (  [str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"]) {
                
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];
                
                UIImage *image = [UIImage imageNamed:imageName];
                
                if ( image ) {
                    
                    if ( upX > ( VIEW_WIDTH_MAX ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                        
                    }
                    
                    [image drawInRect:CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight)];
                    
                    upX += KFacialSizeWidth;
                    
                    lastPlusSize = KFacialSizeWidth;
                }
                else {
                    [self drawText:str withFont:font];
                }
			}
            else {
                
                [self drawText:str withFont:font];
			}
        }
	}
}

- (void)drawText:(NSString *)string withFont:(UIFont *)font{
    
    int linelength= VIEW_WIDTH_MAX  ;
    
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
            }
            
        }
        [character drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:font];
        
        upX += size.width;
        
        lastPlusSize = size.width;
        
    }
}


@end
