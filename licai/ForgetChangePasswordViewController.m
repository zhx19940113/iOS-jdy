//
//  ForgetChangePasswordViewController.m
//  licai
//
//  Created by shuangqi on 15/2/4.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ForgetChangePasswordViewController.h"

@interface ForgetChangePasswordViewController ()

@end

@implementation ForgetChangePasswordViewController

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
    self.submitBtn.layer.cornerRadius=15.0;
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) onClickBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onClickSubmit:(id)sender {
    if([self regVerify])
    {
         BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.phone forKey:@"phone"];
        [params setObject:self.passwordField.text forKey:@"password"];
        
        [self showHUD:@"正在修改密码"];
        [httpClient POST:URL_FORGET_CHANGEPASSWORD parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [self hideHUD];
            NSDictionary *responstDict = (NSDictionary *)responseObject;
            if (responstDict==nil) {
                [self showTextHUD:@"网络错误"];
            }else{
                
                if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
                {
                    [self showTextHUD:@"密码修改成功"];
                    [self onClickBack:nil];
                    
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

-(BOOL)regVerify
{
   if([self.passwordField.text isBlank])
    {
        [self showTextHUD:@"密码不能为空"];
        return NO;
    }
    else if([self.repasswordField.text isBlank])
    {
        [self showTextHUD:@"重复密码不能为空"];
        return NO;
    }
    else if(![self.repasswordField.text isEqualToString:self.passwordField.text])
    {
        [self showTextHUD:@"两次密码输入不相等"];
        return NO;
    }
    
    return YES;
}
@end
