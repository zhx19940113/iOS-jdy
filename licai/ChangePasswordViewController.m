//
//  ChangePasswordViewController.m
//  licai
//
//  Created by shuangqi on 15/2/5.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

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
     [self addNavBack];
    self.navigationItem.title=@"修改密码";
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

- (IBAction)onClickSubmit:(id)sender {
    if([self verify])
    {
        BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.oldField.text forKey:@"oldPassword"];
        [params setObject:self.newpasswordField.text forKey:@"newPassword"];
        
        
        httpClient.securityPolicy.allowInvalidCertificates = YES;
        
        
       
       
        [self showHUD:@"正在提交修改"];
        NSLog(@"%@",[ToolUtil getNetCommonParams:params]);
        
        [httpClient POST:URL_CHANGEPASSWORD parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
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
            NSLog(@"error:%@",error);
            
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 20)
        return NO; // return NO to not change text
    return YES;
}

-(BOOL)verify
{
    if([self.oldField.text isBlank])
    {
        [self showTextHUD:@"旧密码不能为空"];
        return NO;
    }
    else if([self.newpasswordField.text isBlank])
    {
        [self showTextHUD:@"新密码不能为空"];
        return NO;
    }
    else if([self.reField.text isBlank])
    {
        [self showTextHUD:@"重输密码不能为空"];
        return NO;
    }
    else if(![self.reField.text isEqualToString:self.newpasswordField.text])
    {
        [self showTextHUD:@"两次密码输入不相等"];
        return NO;
    }
    
    return YES;
}
@end
