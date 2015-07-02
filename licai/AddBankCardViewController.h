//
//  AddBankCardViewController.h
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "WthdrawCashViewController.h"

@interface AddBankCardViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *bankCardField;
@property (weak, nonatomic) IBOutlet UITextField *realnameField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameField;
- (IBAction)onClickSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UILabel *msgText;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic) BOOL isSuccess;
@end
