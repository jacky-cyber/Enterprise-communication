//
//  ImageAndStrTextView.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-4-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//


#define kCursorVelocity 1.0f/8.0f

#import "ImageAndStrTextView.h"

@implementation ImageAndStrTextView
@synthesize contentArr;
@synthesize startRange;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setContentArr:(NSMutableArray *)contentArray{
    contentArr=contentArray;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
	if ( contentArr ) {
        
//        NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:FACE_DIC];
        
        
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        
        isLineReturn = NO;
        
        upX = VIEW_LEFT;
        
        upY = VIEW_TOP;
        
		for (int index = 0; index < [contentArr count]; index++) {
            
			NSString *str = [contentArr objectAtIndex:index];
			if ( [str hasPrefix:@"<&emoji"]&&[str hasSuffix:@"&>"] ) {
                
            NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length-4)];

                UIImage *image = [UIImage imageNamed:imageName];
                
                if ( image ) {
                    
                    if ( upX > ( VIEW_WIDTH_MAX ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                    }
                    
                    [image drawInRect:CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight)];
                    
                    //光标咋就不动呢
//                    CGFloat cursorLocation = MAX(startRange.location+(NSInteger)(upX*kCursorVelocity*20), 0);
//                    CGFloat cursorLocation=upX;
//                    NSRange selectedRange = {cursorLocation, 0};
//                    self.selectedRange = selectedRange;
//                    NSLog(@"location=%d,length=%d",selectedRange.location,selectedRange.length);
                    
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
    
    int linelength= VIEW_WIDTH_MAX - KCharacterWidth  ;
    
    for ( int index = 0; index < string.length; index++) {
        
        NSString *character = [string substringWithRange:NSMakeRange( index, 1 )];
        
        CGSize size = [character sizeWithFont:font
                            constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
        
        if ( upX > linelength) {
            
            isLineReturn = YES;
            
            upX = VIEW_LEFT;
            upY += VIEW_LINE_HEIGHT;
        }
        
        [character drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:font];
        
        
        upX += size.width;
        
        lastPlusSize = size.width;
        
    }
}


@end
