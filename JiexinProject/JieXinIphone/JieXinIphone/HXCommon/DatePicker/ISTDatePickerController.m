//
//  ISTDatePicker.m
//  SunboxSoft_MO_iPhone
//
//  Created by IAN on 12-11-7.
//
//

#import "ISTDatePickerController.h"

@implementation ISTDatePickerController
@synthesize delegate;
@synthesize firstOtherButtonIndex = _firstOtherButtonIndex,okButtonIndex = _okButtonIndex,cancelButtonIndex = _cancelButtonIndex;

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}


-(id)initWithDate:(NSDate *)date
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:frame]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        }
        else
        {
            self.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.7f];

        }
        
        CGRect contentFrame = frame;
        contentFrame.size.height = 260;
        contentFrame.origin.y = frame.size.height - contentFrame.size.height;
        contentView = [self contentViewWithFrame:contentFrame otherItemTitles:nil];
        [self addSubview:contentView];
        [contentView release];
        
        [self setDateAnimated:date];
    }
    return self;
}


-(id)initWithDate:(NSDate *)date otherItemTitles:(NSArray *)itemTitles
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        
        CGRect contentFrame = frame;
        contentFrame.size.height = 260;
        contentFrame.origin.y = frame.size.height - contentFrame.size.height;
        contentView = [self contentViewWithFrame:contentFrame otherItemTitles:itemTitles];
        [self addSubview:contentView];
        [contentView release];
        
        [self setDateAnimated:date];
    }
    return self;
}


- (UIView *)contentViewWithFrame:(CGRect)frame otherItemTitles:(NSArray *)itemTitles
{
    //CGRect screenRect = [UIScreen mainScreen].bounds;
    //self = [super initWithFrame:frame];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    // Initialization code
    NSInteger btnIndex = 0;
    NSMutableArray *barBtnArray = nil;
    if(itemTitles != nil){
        barBtnArray = [NSMutableArray arrayWithCapacity:itemTitles.count+3];
        _firstOtherButtonIndex = btnIndex;
        
        for (NSString *title in itemTitles) {
            UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(clickedOtherButton:)];
            barBtn.tag = btnIndex++;
            [barBtnArray addObject:barBtn];
            [barBtn release];
        }
    }else{
        barBtnArray = [NSMutableArray arrayWithCapacity:3];
        _firstOtherButtonIndex = -1;
    }
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    [barBtnArray addObject:barBtn];
    [barBtn release];
    
    barBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(onOKBtnPressed:)];
    _okButtonIndex = btnIndex;
    barBtn.tag = btnIndex++;
    [barBtnArray addObject:barBtn];
    [barBtn release];
    
    barBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(onCancelBtnPressed:)];
    _cancelButtonIndex = btnIndex;
    barBtn.tag = btnIndex++;
    [barBtnArray addObject:barBtn];
    [barBtn release];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
    toolBar.items = barBtnArray;
    [view addSubview:toolBar];
    [toolBar release];
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height-44)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    //[[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"]
    datePicker.locale = [NSLocale currentLocale];
    [view addSubview:datePicker];
    [datePicker release];
    
    return view;
}

-(void)setDateAnimated:(NSDate *)date
{
    [datePicker setDate:date animated:YES];
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)dismissWithButtonIndex:(NSInteger)buttonIndex
{
    BOOL result = YES;
    if ([self.delegate respondsToSelector:@selector(istDatePickerController:shouldDismissWithButtonIndex:)]) {
        result = [self.delegate istDatePickerController:self shouldDismissWithButtonIndex:buttonIndex];
    }
    
    if (result == NO) {
        return;
    }
    [self removeFromSuperview];
}

-(void)onOKBtnPressed:(id)sender
{
    NSDate *selectedDate = datePicker.date;
    if ([self.delegate respondsToSelector:@selector(istDatePickerController:didSelectDate:)]) {
        [self.delegate istDatePickerController:self didSelectDate:selectedDate];
    }
    [self dismissWithButtonIndex:self.okButtonIndex];
}

-(void)onCancelBtnPressed:(id)sender
{
    [self dismissWithButtonIndex:self.cancelButtonIndex];
}

-(void)clickedOtherButton:(UIBarButtonItem *)barButton
{
    NSInteger btnIndex = barButton.tag;
    if ([self.delegate respondsToSelector:@selector(istDatePickerController:clickedOtherButtonAtIndex:)]) {
        [self.delegate istDatePickerController:self clickedOtherButtonAtIndex:btnIndex];
    }
    [self dismissWithButtonIndex:btnIndex];
}

@end
