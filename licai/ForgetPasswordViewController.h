//
//  ForgetPasswordViewController.h
//  licai
//
//  Created by shuangqi on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "ForgetChangePasswordViewController.h"

@interface ForgetPasswordViewController :BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *VerBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UILabel *textLable;
- (IBAction)onClickSubmit:(id)sender;
@property BOOL isGetCheckCode;
@property (nonatomic,strong) NSString *phone;

@end
