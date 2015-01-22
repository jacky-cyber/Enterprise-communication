//
//  ApplyPickerView.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-27.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ApplyPickerView.h"

@implementation ApplyPickerView
{
    NSInteger currentRow;
}
@synthesize selectPicker;
@synthesize source;

- (void)dealloc
{
    self.selectPicker = nil;
    self.source = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame andSourceData:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
        currentRow = 0;
        self.source = [NSArray arrayWithArray:array];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(270, 1, 40, 20);
    [confirmBtn setImage:[UIImage imageNamed:@"done_1.png"] forState:UIControlStateNormal];
    [confirmBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 10)];
    [confirmBtn addTarget:selectPicker action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(230, 1, 40, 20);
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 12, 0, 12)];
    [cancelBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:selectPicker action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    self.selectPicker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 22, kScreen_Width, self.bounds.size.height - 22)] autorelease];
    selectPicker.showsSelectionIndicator = YES;
    selectPicker.delegate = self;
    selectPicker.dataSource = self;
    [self addSubview:selectPicker];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.source count];
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.source objectAtIndex:row] objectForKey:@"Title"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    currentRow = row;
}

- (void)confirm:(UIButton *)sender
{
//    NSDictionary *dic = @{@"Title":[[self.source objectAtIndex:currentRow] objectForKey:@"Title"],@"id":[[self.source objectAtIndex:currentRow] objectForKey:@"id"]};
    NSDictionary *dic = [self.source objectAtIndex:currentRow];
    if (self.pickerdelegate && [self.pickerdelegate respondsToSelector:@selector(itemSelected:andView:)])
    {
        [self.pickerdelegate itemSelected:dic andView:self];
    }
}

- (void)cancel:(UIButton *)sender
{
    if (self.pickerdelegate && [self.pickerdelegate respondsToSelector:@selector(itemCanceled)])
    {
        [self.pickerdelegate itemCanceled];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
