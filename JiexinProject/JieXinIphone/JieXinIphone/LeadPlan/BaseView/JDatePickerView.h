//
//  JDatePickerView.h
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDatePickerView;
@protocol JDatePickerViewDelegate<NSObject>
-(void)datePicker:(JDatePickerView*)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
//modified by liqiang
- (void)selectDateFinish:(NSString *)dateStr;
@end
@interface JDatePickerView : UIView<UITableViewDelegate, UITableViewDataSource>{
    CGFloat rowHeight;
    CGFloat centralRowOffset;
    
    NSArray *minutes;
    NSArray *hours;
    NSArray *day;
    NSArray *m_mon;
    NSMutableArray *m_year;
    
    BOOL shouldUseShadows;

}
@property (nonatomic, copy)NSCalendar *calendar;
@property(nonatomic,copy)NSString*checkYear,*checkMon,*checkDay,*checkHour,*checkMin;
@property(nonatomic,retain)NSArray*hours,*minutes,*m_mon;
@property(nonatomic,retain)NSArray*day;
@property (nonatomic, strong)NSMutableArray *tables,*m_year;
@property (nonatomic, strong)NSMutableArray *selectedRowIndexes;
@property(nonatomic,retain)id<JDatePickerViewDelegate>delegate;
-(NSString*)getDate;
@end
