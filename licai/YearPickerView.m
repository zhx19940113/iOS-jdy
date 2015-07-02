//
//  YearPickerView.m
//  licai
//
//  Created by shuangqi on 15/2/9.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "YearPickerView.h"

@implementation YearPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    NSMutableArray *array;
}
@synthesize selectStr,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        array = [[NSMutableArray alloc] init];
        for (int i=0; i<11; i++) {
            [array addObject:[NSString stringWithFormat:@"%d年",2015+i]];
        }
        
        hPickView = [[UIPickerView alloc] init];
        hPickView.dataSource = self;
        hPickView.delegate = self;
        [hPickView setFrame:CGRectMake(0, SCREEN_HEIGHT - hPickView.frame.size.height - 200, SCREEN_WIDTH, 0)];
        UIButton *confirBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, hPickView.frame.origin.y + hPickView.frame.size.height +30, SCREEN_WIDTH-30, 40)];
        [confirBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirBtn setBackgroundColor:[UIColor colorWithRed:244/255.0 green:103/255.0 blue:103/255.0 alpha:1.0]];
        [confirBtn addTarget:self action:@selector(onclickConfirm:) forControlEvents:UIControlEventTouchUpInside];
        confirBtn.layer.cornerRadius=15.0;
        
        
        [self addSubview:hPickView];
        [self addSubview:confirBtn];
        [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.99]];
        
        [hPickView selectRow:0 inComponent:0 animated:YES];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }140-199
 */
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [array objectAtIndex:row];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [array count];
}

-(void)onclickConfirm:(id)sender
{
    NSInteger row=[hPickView selectedRowInComponent:0];
    selectStr = [array objectAtIndex:row];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(onSelectYear:)])
        [self.delegate onSelectYear:[NSString stringWithFormat:@"%ld",2015+row]];
    [self setHidden:YES];
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    
    //  selectStr = [array objectAtIndex:row];
}

@end
