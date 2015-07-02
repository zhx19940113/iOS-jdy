//
//  OrderFeedBackViewController.h
//  iweight
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 shierlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "MessageBean.h"
#import "MJExtension.h"
#import "SelectHtViewController.h"
#import "DatePickerView.h"



@interface OrderFeedBackViewController : BaseViewController<SelectImageDelegate,onSelectDateProtocol>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectHttBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectDateBtn;
- (IBAction)onClickSubmit:(id)sender;
- (IBAction)onClickHt:(id)sender;
- (IBAction)onClickDate:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *yhmField;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) DatePickerView *birthdayView;
@end
