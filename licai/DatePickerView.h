//
//  DatePickerView.h
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "NSDate+Helper.h"

@protocol onSelectDateProtocol <NSObject>
-(void)onSelectDate:(NSString *)str;
@end

@interface DatePickerView :  UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *mPickView;
    
}

@property(copy,nonatomic)NSString *selectStr;
@property(assign,nonatomic)id<onSelectDateProtocol> delegate;
@end
