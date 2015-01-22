//
//  ISTDatePicker.h
//  SunboxSoft_MO_iPhone
//
//  Created by IAN on 12-11-7.
//
//

#import <UIKit/UIKit.h>
@protocol ISTDatePickerControllerDelegate;
@interface ISTDatePickerController : UIView
{
    UIView *contentView;
    UIDatePicker *datePicker;
}

@property(nonatomic,assign)id<ISTDatePickerControllerDelegate> delegate;
@property(nonatomic,readonly)NSInteger firstOtherButtonIndex;
@property(nonatomic,readonly)NSInteger okButtonIndex;
@property(nonatomic,readonly)NSInteger cancelButtonIndex;

-(id)initWithDate:(NSDate *)date;
-(id)initWithDate:(NSDate *)date otherItemTitles:(NSArray *)itemTitles;
-(void)setDateAnimated:(NSDate *)date;

-(void)show;
-(void)dismissWithButtonIndex:(NSInteger)buttonIndex;
@end

@protocol ISTDatePickerControllerDelegate <NSObject>

@optional
-(void)istDatePickerController:(ISTDatePickerController *)datePicker didSelectDate:(NSDate *)date;
-(BOOL)istDatePickerController:(ISTDatePickerController *)datePicker shouldDismissWithButtonIndex:(NSInteger)buttonIndex;

-(void)istDatePickerController:(ISTDatePickerController *)datePicker clickedOtherButtonAtIndex:(NSInteger) buttonIndex;

@end