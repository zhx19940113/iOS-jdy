//
//  MyFaceCicleViewController.h
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpClient.h"
#import "BaseViewController.h"
#import "CommonHeaderView.h"
#import "UUChart.h"
#import "SBTableAlert.h"
#import "YearPickerView.h"
#import "NSDate+Helper.h"

typedef enum {
    FcFaceType,
    FcCicleType
    
} FaceCicleType;

@interface MyFaceCicleViewController : BaseViewController<UUChartDataSource,SBTableAlertDelegate, SBTableAlertDataSource,onSelectYearProtocol>
@property (weak, nonatomic) IBOutlet CommonHeaderView *headerView;
@property (strong, nonatomic) UUChart *chartView;
@property FaceCicleType type;
@property (weak, nonatomic) IBOutlet UUChart *lineView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) YearPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UILabel *yearText;
- (IBAction)onClickSelectYear:(id)sender;

@end
