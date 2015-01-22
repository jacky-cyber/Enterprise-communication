//
//  JTitleLabel.m
//  TheStationAgent
//
//  Created by Jeffrey on 14-1-9.
//  Copyright (c) 2014年 Jeffrey. All rights reserved.
//

#import "JTitleLabel.h"

@implementation JTitleLabel

-(id)initJTitleLabel:(NSString*)_name rect:(CGRect)_rect fontSize:(int)_size fontColor:(UIColor*)_color{
    if(self=[super initWithFrame:_rect]){
        self.text=_name;
        self.backgroundColor=[UIColor clearColor];
        if(_color){
            self.textColor=_color;
        }
        self.textAlignment=NSTextAlignmentCenter;
        self.font=[UIFont systemFontOfSize:_size];
        
    }
    return self;
}

@end
