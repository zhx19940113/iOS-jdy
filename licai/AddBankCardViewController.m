//
//  AddBankCardViewController.m
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "AddBankCardViewController.h"

@interface AddBankCardViewController ()

@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    self.title=@"绑定银行卡";
    [self addNavBack];
     self.submitBtn.layer.cornerRadius=15.0;
    [self.successView setHidden:YES];
    self.isSuccess=NO;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickSubmit:(id)sender {
    if(!self.isSuccess)
    {
        if([self verify])
        {
            BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:self.realnameField.text forKey:@"accountName"];
            [params setObject:self.bankNameField.text forKey:@"bankName"];
            [params setObject:self.bankCardField.text forKey:@"bankCode"];
            
            [self showHUD:@"正在提交"];
            
            [httpClient POST:URL_ADD_BANKCARD parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
                [self hideHUD];
                NSLog(@"sss%@",responseObject);
                NSDictionary *responstDict = (NSDictionary *)responseObject;
                if (responstDict==nil) {
                    [self showTextHUD:@"网络错误"];
                }else{
                    if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
                    {
                        [self showTextHUD:@"添加成功"];
                        [self.successView setHidden:NO];
                        self.bankCardField.hidden=YES;
                        self.bankNameField.hidden=YES;
                        self.realnameField.hidden=YES;
                        self.msgText.text=[NSString stringWithFormat:@"已经成功绑定尾号为%@的银行卡",[self.bankCardField.text substringFromIndex:self.bankCardField.text.length-4]];
                        [self.submitBtn setTitle:@"立即提现" forState:UIControlStateNormal];
                        [self.iconImage setImage:[UIImage imageNamed:@"bank_ok"]];
                        self.isSuccess=YES;
                        
                    }else{
                        [self showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
                    }
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self hideHUD];
                [self showTextHUD:STR_NET_ERROR];
                
            }];

        }
    }
    else
    {
        WthdrawCashViewController  *settingVc=[[WthdrawCashViewController alloc] initWithNibName:@"WthdrawCashViewController" bundle:nil];
        [self.navigationController pushViewController:settingVc animated:YES];
    }
}

-(BOOL)verify
{
    if([self.bankCardField.text isBlank])
    {
        [self showTextHUD:@"卡号不能为空"];
        return NO;
    }
    else
        if([self.bankCardField.text length]<16)
        {
            [self showTextHUD:@"卡号不少于16位"];
            return NO;
        }
    else
    if([self.realnameField.text isBlank])
    {
        [self showTextHUD:@"名字不能为空"];
        return NO;
    }
    else
        if([self.bankNameField.text isBlank])
        {
            [self showTextHUD:@"银行卡号不能为空"];
            return NO;
        }
    return YES;
}

@end
