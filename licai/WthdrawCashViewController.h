//
//  WthdrawCashViewController.h
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpClient.h"
#import "BaseViewController.h"
#import "BankCardListViewController.h"
#import "onSelectBankCardProtocol.h"


@interface WthdrawCashViewController : BaseViewController<onSelectBankCardProtocol,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyText;
@property (weak, nonatomic) IBOutlet UILabel *bankNameText;
@property (weak, nonatomic) IBOutlet UILabel *bankCodeText;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
- (IBAction)onClickSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *TopView;

@property (weak, nonatomic) IBOutlet UILabel *changeBankText;
@property (strong,nonatomic) BankCardBean *bank;
@property double amount;
@end
