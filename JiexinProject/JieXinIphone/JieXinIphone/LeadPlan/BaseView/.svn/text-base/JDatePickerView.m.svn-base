//
//  JDatePickerView.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JDatePickerView.h"
#import "JDateTime.h"
#import "JButton.h"
@implementation JDatePickerView
@synthesize day,minutes,hours,delegate,m_mon,m_year;
@synthesize checkDay,checkHour,checkMin,checkMon,checkYear,calendar;
int countCellIsTwo=0;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        shouldUseShadows = YES;
         calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self loadBackgroundColor];
        [self update];
         [self setDate:[NSDate date] animated:YES];
    }
    return self;
}
- (void)update{
    [self removeContent];
    [self addContent];
    [self fillWithCalendar];
    [self reloadData];
}
-(void)loadBackgroundColor{
    UIView *gradView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    gradView.backgroundColor=RGBCOLOR(83, 83, 83);
    gradView.alpha=0.6;
    [self addSubview:gradView];
    [gradView release];
}
#pragma mark - Content managemet

- (void)addContent{
    
    
    int heightTable=170;
    rowHeight =  heightTable/3+5;
    
    
    const NSInteger components = [self numberOfComponents];
    
    self.tables = [[NSMutableArray alloc] init];
    self.selectedRowIndexes = [[NSMutableArray alloc] init];
    UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0,kScreen_Height-260, kScreen_Width, 260)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:whiteView];
    UIView *baseView=[[UIView alloc]initWithFrame:CGRectMake(10,10, 296, heightTable)];
    baseView.tag=22222;
    baseView.backgroundColor=RGBCOLOR(235, 235, 235);
    [whiteView addSubview:baseView];
    [whiteView release];
    centralRowOffset = (baseView.frame.size.height - rowHeight)/2;
    CGRect tableFrame = CGRectMake(5, 0, 0, heightTable);
    for (NSInteger i = 0; i<components; ++i) {
        tableFrame.size.width = [self widthForComponent:i];
        
        UITableView *table = [[UITableView alloc] initWithFrame:tableFrame];
        table.rowHeight = rowHeight;
        table.contentInset = UIEdgeInsetsMake(centralRowOffset, 0, centralRowOffset, 0);
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.showsVerticalScrollIndicator = NO;
        
        table.dataSource = self;
        table.delegate = self;
        [baseView addSubview:table];
        
        [self.tables addObject:table];
        [self.selectedRowIndexes addObject:[NSNumber numberWithInteger:0]];
        tableFrame.origin.x += tableFrame.size.width+0.3;


    }
    if (shouldUseShadows) {
        UIView *upperShadow = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 300, heightTable*1/3)];
        upperShadow.alpha=0.3;
        //[v setBackgroundColor:[UIColor greenColor]];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = upperShadow.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[RGBCOLOR(254, 254, 254) CGColor] ,(id)[[UIColor clearColor] CGColor], nil];
        [upperShadow.layer insertSublayer:gradient atIndex:0];
        [upperShadow setUserInteractionEnabled:NO];
        
        [baseView addSubview:upperShadow];
        
        
        UIView *lowerShadow = [[UIView alloc] initWithFrame:CGRectMake(5.0f, heightTable-heightTable*1/3, 300, heightTable*1/3)];
        //[v setBackgroundColor:[UIColor greenColor]];
        CAGradientLayer *gradient2 = [CAGradientLayer layer];
        gradient2.frame = lowerShadow.bounds;
        gradient2.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[RGBCOLOR(250, 250, 250) CGColor], nil];
        lowerShadow.alpha=0.3;
        [lowerShadow.layer insertSublayer:gradient2 atIndex:0];
        [lowerShadow setUserInteractionEnabled:NO];
        
        [baseView addSubview:lowerShadow];
    }
    JButton *sureBt=[[JButton alloc]initButton:@"确定" image:nil type:BUTTONTYPE_USERSELECT fontSize:17 point:CGPointMake(10 ,baseView.frame.origin.y+10+baseView.frame.size.height) tag:222224];
    [sureBt setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [sureBt setBackgroundColor:RGBCOLOR(19, 147, 221)];
    sureBt.layer.cornerRadius=5.0;
    sureBt.alpha=0.7;
    [sureBt addTarget:self action:@selector(pressSureBt) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:sureBt];

    
    
}
- (NSInteger) numberOfComponents
{
    return 5;
}

#pragma mark - UITableView DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    const NSInteger component = [self componentFromTableView:tableView];
    if(component==2){
        return [JDateTime GetNumberOfDayByYear:[self.checkYear intValue] andByMonth:[self.checkMon intValue]];
    }
    return [self numberOfRowsInComponent:component];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"PickerCell";
    static const NSInteger tag = 4223;
    
    const NSInteger component = [self componentFromTableView:tableView];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *label = nil;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth=0.3f;
        cell.layer.borderColor=[RGBCOLOR(200, 200, 200)CGColor];
        if(IOSVersion>=7.0 )
            cell.backgroundColor=[UIColor whiteColor];
        const CGRect viewRect = cell.contentView.bounds;
        
        label = [self viewForComponent:component inRect:viewRect];
        label.frame = viewRect;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.tag = tag;
        
        cell.userInteractionEnabled = YES;
        label.userInteractionEnabled = YES;
        [cell.contentView addSubview:label];
        
    }
    else{
        
        label = (UILabel*)[cell.contentView viewWithTag:tag];
    }
  
    [self setDataForView:label row:indexPath.row inComponent:component];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    const NSInteger component = [self componentFromTableView:tableView];
    [self selectRow:indexPath.row inComponent:component animated:YES];
}

#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self alignTableViewToRowBoundary:(UITableView *)scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self alignTableViewToRowBoundary:(UITableView *)scrollView];
}
- (NSInteger)componentFromTableView:(UITableView *)tableView
{
    return [self.tables indexOfObject:tableView];
}
#pragma mark message
-(void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
    [self.selectedRowIndexes replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
    
    UITableView *table = [self.tables objectAtIndex:component];
    const CGPoint alignedOffset = CGPointMake(0, row*table.rowHeight - table.contentInset.top);
    [table setContentOffset:alignedOffset animated:animated];
    for(int i=row-1;i<=row+1;i++){
        UITableViewCell *cell = (UITableViewCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] ];
        UILabel *label=(UILabel*)[cell viewWithTag:4223];
        if(component==0){
            label.text=[label.text substringToIndex:4];
        }else{
            label.text=[label.text substringToIndex:2];
        }
        
        label.textColor=RGBCOLOR(130,130,131);
    }
    UITableViewCell *cell = (UITableViewCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] ];
    UILabel *label=(UILabel*)[cell viewWithTag:4223];
    label.textColor=RGBCOLOR(236, 128, 7);
    if(component==0){
        self. checkYear=label.text;
        label.text=[NSString stringWithFormat:@"%@年",label.text];
         UITableView *reloadTableViewDate = [self.tables objectAtIndex:2];
        [reloadTableViewDate reloadData];
        
        UITableViewCell *reloadCell = (UITableViewCell *)[reloadTableViewDate cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.checkDay intValue]-1 inSection:0] ];
        UILabel *reloadLabel=(UILabel*)[reloadCell viewWithTag:4223];
        reloadLabel.text=[NSString stringWithFormat:@"%@日",reloadLabel.text];
    }else if(component==1){
        self.checkMon=label.text;
        label.text=[NSString stringWithFormat:@"%@月",label.text];
        UITableView *reloadTableViewDate = [self.tables objectAtIndex:2];
        [reloadTableViewDate reloadData];
        
        UITableViewCell *reloadCell = (UITableViewCell *)[reloadTableViewDate cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.checkDay intValue]-1 inSection:0] ];
        UILabel *reloadLabel=(UILabel*)[reloadCell viewWithTag:4223];
        reloadLabel.text=[NSString stringWithFormat:@"%@日",reloadLabel.text];
    }else if(component==2){
        self.checkDay=label.text;
        label.text=[NSString stringWithFormat:@"%@日",label.text];
    }else if(component==3){
        self.checkHour=label.text;
        label.text=[NSString stringWithFormat:@"%@时",label.text];
    }else if(component==4){
        self.checkMin=label.text;
        label.text=[NSString stringWithFormat:@"%@分",label.text];
    }

    if ([self.delegate respondsToSelector:@selector(datePicker:didSelectRow:inComponent:)]) {
        [self.delegate datePicker:self didSelectRow:row inComponent:component];
    }
}
- (void)alignTableViewToRowBoundary:(UITableView *)tableView
{
    const CGPoint relativeOffset = CGPointMake(0, tableView.contentOffset.y + tableView.contentInset.top);
    const NSUInteger row = round(relativeOffset.y / tableView.rowHeight);
    
    const NSInteger component = [self componentFromTableView:tableView];
    [self selectRow:row inComponent:component animated:YES];
}
- (UILabel *) viewForComponent:(NSInteger)component inRect:(CGRect)rect
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor=RGBCOLOR(130, 130, 130);
    label.font = [UIFont systemFontOfSize:25.0];
    if(component==0)
        label.font = [UIFont systemFontOfSize:20.0];
    return label;
}
- (void) setDataForView:(UIView *)view row:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *label = (UILabel *) view;
    if(component==0){
        label.text=[self.m_year objectAtIndex:row%51];
    }
    if(component==1){
        label.text=[self.m_mon  objectAtIndex:row%12];
    }else
    if (component == 2) {
        label.text = [self.day objectAtIndex:row%31];
    }
    else if (component == 3){
        label.text = [self.hours objectAtIndex:row%24];
        
    }
    else if (component == 4){
        label.text = [self.minutes objectAtIndex:row%60];
        
    }

}
- (NSInteger) numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return [self.m_year count];
    }
    if(component==1){
    return [self.m_mon count];
    }
    if (component == 2) {
        return [self.day count];
    }
    else if (component == 3){
        return [self.hours count];
    }
    else if (component == 4){
        return [self.minutes count];
    }
    
    return 0;
}
- (void)fillWithCalendar{
    self. minutes = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    
    self.hours = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    self.day=@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    self.m_mon=@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    self.m_year=nil;
    self.m_year=[[NSMutableArray alloc]init];
    for(int i=2000;i<=2050;i++){
        [self.m_year addObject:[NSString stringWithFormat:@"%d",i]];
    }

}
- (void)removeContent
{
    // remove tables
    for (UITableView *table in self.tables) {
        [table removeFromSuperview];
    }
    self.tables = nil;
    self.selectedRowIndexes = nil;
}
-(void) reloadData{
    
    for (UITableView *table in self.tables) {
        [table reloadData];
    }
}
- (void)setDate:(NSDate *)date animated:(BOOL)animated{
    
    self.calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *dateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit  | NSMinuteCalendarUnit) fromDate:date];
    NSInteger year=[dateComponents year];
    NSInteger mon=[dateComponents month];
    NSInteger days=[dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    [self selectRow:year%100 inComponent:0 animated:YES];
    [self selectRow:mon-1 inComponent:1 animated:YES];
    [self selectRow:days-1 inComponent:2 animated:YES];
    [self selectRow:hour inComponent:3 animated:YES];
    [self selectRow:minute inComponent:4 animated:YES];
    
}
- (NSString*)getDate{
    return [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",self.checkYear,self.checkMon,self.checkDay,self.checkHour,self.checkMin];

}
- (NSInteger) selectedRowInComponent:(NSInteger)component{
    
    return [[self.selectedRowIndexes objectAtIndex:component] integerValue];
}
- (CGFloat) widthForComponent:(NSInteger)component
{
    CGFloat width = 290;
    
    switch (component) {
        case 0:
            width *= 0.25;
            break;
        case 1: case 2:case 3: case 4:
            width *= 0.75/4;
            break;
        default:
            return 0; // never
    }
    
    return round(width);
}

-(void)pressSureBt{
    self.hidden=YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectDateFinish:)]) {
        [self.delegate selectDateFinish:[self getDate]];
    }
    [self removeFromSuperview];
    
}


@end
