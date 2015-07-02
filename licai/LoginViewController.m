//
//  LoginViewController.m
//  licai
//
//  Created by shuangqi on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.submitBtn.layer.cornerRadius=15.0;
    self.navigationItem.title=@"登录";
    
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickReg:)];
    self.regLabel.userInteractionEnabled=YES;
    [self.regLabel addGestureRecognizer:singleRecognizer];
    
    
    UITapGestureRecognizer* frogetRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickForget:)];
    self.forgetLabel.userInteractionEnabled=YES;
    [self.forgetLabel addGestureRecognizer:frogetRecognizer];
    [self addNavBack];
    
    self.usernameText.delegate=self;
    
}

-(void) OnClickReg:(UITapGestureRecognizer*)recognizer
{
    RegViewController *regVc = [[RegViewController alloc] initWithNibName:@"RegViewController" bundle:nil];
    [self.navigationController pushViewController:regVc animated:YES];
}

-(void) OnClickForget:(UITapGestureRecognizer*)recognizer
{
    ForgetPasswordViewController *regVc = [[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:regVc];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void) onClickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

   
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 11)
        return NO; // return NO to not change text
    return YES;
}

- (IBAction)onClickLogin:(id)sender {
    if([self loginVerify])
    {
        [self showHUD:@"正在登录..."];
        NSMutableDictionary *param_dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usernameText.text,@"userName",self.passwordText.text,@"password",nil];
        
        
        BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        
        [httpClient POST:URL_LOGIN parameters:param_dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [self hideHUD];
            if(responseObject==nil)
            {
                [self showTextHUD:STR_NET_ERROR];
            }
            else
            {
                
                NSDictionary *result=(NSDictionary*) responseObject;
               
                if([[result objectForKey:@"success"] integerValue] ==1)
                {
                    
                    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
                        if([cookie.name isEqualToString:@"JSESSIONID"])
                        {
                            [ToolUtil saveAuthToken:cookie.value];
                            
                             NSLog(@"cookie%@", cookie.value);
                        }
                    }
                    
//                    NSDictionary *fields = [(NSHTTPURLResponse*)task.response allHeaderFields]; //afnetworking写法
//                    if (fields!=nil) {
//                        [ToolUtil saveAuthToken:fields];
//                    }
                    
                
                    
                    
                    NSString *jdycode=[[result objectForKey:@"attributes"] objectForKey:@"jdycode"];
                    NSString *memberid=[[result objectForKey:@"attributes"] objectForKey:@"ID"];
                    
                    //保存用户名密码
                    [ToolUtil saveUserNameAndPwd:self.usernameText.text andPwd:self.passwordText.text andJdycode:jdycode andMemberId:memberid];
                    [self showTextHUD:@"登录成功"];
                    [self onClickBack:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginSUCCESS object:nil];
                    
                }
                else {
                    [self showTextHUD:@"用户名或密码错误"];
                }
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self hideHUD];
            [self showTextHUD:STR_NET_ERROR];
        }];
        
        
        
        
    }
    
    
    
    
    
    
    
}



-(BOOL)loginVerify
{
    if([self.usernameText.text isBlank])
    {
        [self showTextHUD:@"手机号码不能为空"];
        return NO;
    }else if(![self.usernameText.text validateMobile])
    {
        [self showTextHUD:@"手机号码不正确"];
        return NO;
    }else if([self.passwordText.text isBlank])
    {
        [self showTextHUD:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}
@end
