//
//  ChangePasswordViewController.h
//  licai
//
//  Created by shuangqi on 15/2/5.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"

@interface ChangePasswordViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldField;
@property (weak, nonatomic) IBOutlet UITextField *reField;
@property (weak, nonatomic) IBOutlet UITextField *newpasswordField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)onClickSubmit:(id)sender;

@end
