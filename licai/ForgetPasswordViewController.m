//
//  ForgetPasswordViewController.m
//  licai
//
//  Created by shuangqi on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) initUI
{
    self.title=@"忘记密码";
    [self addNavBack];
    self.VerBtn.layer.cornerRadius=15.0;
    self.isGetCheckCode=YES;
    self.mobileField.delegate=self;
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
    if([self verify])
    {
        BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        if(self.isGetCheckCode)
        {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
           [params setObject:self.mobileField.text forKey:@"phone"];
            
            [self showHUD:@"正在获取验证码..."];
            [httpClient POST:URL_FORGET_CHECKCODE parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [self hideHUD];
                
                
                NSDictionary *responstDict = (NSDictionary *)responseObject;
                if (responstDict==nil) {
                    [self showTextHUD:@"网络错误"];
                }else{
                   
                    if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
                    {
                        [self showTextHUD:@"验证码已经下发，请耐性等待"];
                        self.isGetCheckCode=NO;
                        self.textLable.text=@"验证码";
                        [self.VerBtn setTitle:@"提交验证" forState:UIControlStateNormal];
                        self.phone=self.mobileField.text;
                        self.mobileField.text=@"";
                        
                    }else{
                        [self showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
                    }
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self hideHUD];
                [self showTextHUD:STR_NET_ERROR];
            }];

        }
        else
        {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:self.phone forKey:@"phone"];
            [params setObject:self.mobileField.text forKey:@"code"];
            
            [self showHUD:@"正在验证"];
            [httpClient POST:URL_FORGET_VERCHECKCODE parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [self hideHUD];
                
                NSDictionary *responstDict = (NSDictionary *)responseObject;
                if (responstDict==nil) {
                    [self showTextHUD:@"网络错误"];
                }else{
                    
                    if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
                    {
                        [self showTextHUD:@"验证成功"];
                        ForgetChangePasswordViewController *fcpvc=[[ForgetChangePasswordViewController alloc] initWithNibName:@"ForgetChangePasswordViewController" bundle:nil];
                        fcpvc.phone=self.phone;
                        [self.navigationController pushViewController:fcpvc animated:YES];
                        
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
    
}

-(void) onClickBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)verify
{
    if(self.isGetCheckCode)
    {
    if([self.mobileField.text isBlank])
    {
        [self showTextHUD:@"手机号码不能为空"];
        return NO;
    }else if(![self.mobileField.text validateMobile])
    {
        [self showTextHUD:@"手机号码不正确"];
        return NO;
    }
    }
    else if([self.mobileField.text isBlank])
    {
        [self showTextHUD:@"验证码不能为空"];
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (self.isGetCheckCode && range.location >= 11)
        return NO; // return NO to not change text
    else if(!self.isGetCheckCode && range.location >= 4)
        return NO;
    
    return YES;
}
@end
