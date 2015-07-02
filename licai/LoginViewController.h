//
//  LoginViewController.h
//  licai
//
//  Created by shuangqi on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RegViewController.h"
#import "ForgetPasswordViewController.h"
#import "BaseHttpClient.h"
#import "ForgetChangePasswordViewController.h"


@interface LoginViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *regLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgetLabel;
- (IBAction)onClickLogin:(id)sender;

@end
