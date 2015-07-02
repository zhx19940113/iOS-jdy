//
//  DatePickerView.m
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
{
    NSMutableArray *array;
    NSMutableArray *array2;
    NSMutableArray *array3;
    
    
}
@synthesize selectStr,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mPickView = [[UIPickerView alloc] init];
        mPickView.dataSource = self;
        mPickView.delegate = self;
        [mPickView setFrame:CGRectMake(0, SCREEN_HEIGHT - mPickView.frame.size.height - 200, SCREEN_WIDTH, 0)];
        UIButton *confirBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, mPickView.frame.origin.y + mPickView.frame.size.height +30, SCREEN_WIDTH-30, 40)];
        [confirBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirBtn setBackgroundColor:[UIColor colorWithRed:244/255.0 green:103/255.0 blue:103/255.0 alpha:1.0]];
        [confirBtn addTarget:self action:@selector(onclickConfirm:) forControlEvents:UIControlEventTouchUpInside];
        confirBtn.layer.cornerRadius=15.0;
        [self addSubview:mPickView];
        [self addSubview:confirBtn];
        [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
        [mPickView selectRow:[[NSDate date] month] inComponent:1 animated:YES];
         [mPickView selectRow:[[NSDate date] day] inComponent:2 animated:YES];
        
        [mPickView selectRow:[[NSDate date] year]-2010 inComponent:0 animated:YES];
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



-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%ld年" ,row+2010];
            break;
        case 1:
            return [NSString stringWithFormat:@"%ld月" ,row+1];
            break;
        case 2:
            return [NSString stringWithFormat:@"%ld日" ,row+1];
            
            break;
    }
    return @"";
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSRange days;
    if(component==2)
    {
        NSInteger row0=[mPickView selectedRowInComponent:0];
        NSInteger row2=[mPickView selectedRowInComponent:1];
        NSDate *date=[NSDate dateFromString:[NSString stringWithFormat:@"%02ld-%02ld-01 00:00:00",row0+1960,row2+1]];
        NSCalendar *c = [NSCalendar currentCalendar];
        days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    }
    
    
    switch (component) {
        case 0:
            return [[NSDate date] year]-2010+1;
            break;
        case 1:
            if([mPickView selectedRowInComponent:0]+2010==[[NSDate date] year])
                return [[NSDate date] month];
            else return 12;
            break;
        case 2:
            if([mPickView selectedRowInComponent:0]+2010==[[NSDate date] year] && [[NSDate date] month]-[mPickView selectedRowInComponent:1])
                return [[NSDate date] day];
            else return days.length;
            
            break;
    }
    
    return 10;
}

-(void)onclickConfirm:(id)sender
{
    
    NSInteger row=[mPickView selectedRowInComponent:0];
    NSInteger row2=[mPickView selectedRowInComponent:1];
    NSInteger row3=[mPickView selectedRowInComponent:2];
    
    selectStr = [NSString stringWithFormat:@"%ld年%ld月%ld日",row+2010,row2+1,row3+1];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(onSelectDate:)])
        [self.delegate onSelectDate:selectStr];
    
    [self setHidden:YES];
    
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    NSLog(@"didSelectRow");
    //    NSString *yearStr = [NSString stringWithFormat:@"%d年",1960 +row];
    //    NSString *monthStr = [NSString stringWithFormat:@"%d月",1 +row];
    //    NSString *dayStr = [NSString stringWithFormat:@"%d日",1 +row];
    //
    //    NSString *selectDay = [NSString stringWithFormat:@"%@%@%@",yearStr,monthStr,dayStr];
    //selectStr = [selectDay copy];
    
    if(component<=1)
    {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
