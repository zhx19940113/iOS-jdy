//
//  ForgetChangePasswordViewController.h
//  licai
//
//  Created by shuangqi on 15/2/4.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"

@interface ForgetChangePasswordViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *repasswordField;
@property (nonatomic,strong) NSString *phone;
- (IBAction)onClickSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
