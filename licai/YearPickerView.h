//
//  YearPickerView.h
//  licai
//
//  Created by shuangqi on 15/2/9.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@protocol onSelectYearProtocol <NSObject>
-(void)onSelectYear:(NSString *)str;
@end

@interface YearPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *hPickView;
    
}

@property(copy,nonatomic)NSString *selectStr;
@property(assign,nonatomic)id<onSelectYearProtocol> delegate;

@end
