//
//  RegViewController.m
//  licai
//
//  Created by shuangqi on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "RegViewController.h"
#import "AppDelegate.h"

@interface RegViewController ()

@end

@implementation RegViewController

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
    self.title=@"注册";
    self.regBtn.layer.cornerRadius=15.0;
    self.verBtn.layer.cornerRadius=15.0;
    self.bindWechatBtn.layer.cornerRadius=15.0;
    
    self.phonefield.delegate=self;
    self.phonefield.tag=1;
    
    self.verfield.delegate=self;
    self.verfield.tag=2;
    
    
    self.passwordfield.delegate=self;
    self.passwordfield.tag=3;
    
    self.repasswordfield.delegate=self;
    self.repasswordfield.tag=4;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onClickVer:(id)sender {
    
    if([self.phonefield.text isBlank])
    {
        [self showTextHUD:@"手机号码不能为空"];
        return;
    }else if(![self.phonefield.text validateMobile])
    {
        [self showTextHUD:@"手机号码不正确"];
        return;
    }
    
    [self.verBtn setTitle:@"正在获取..." forState:UIControlStateNormal];
    
    [self.verBtn setUserInteractionEnabled:NO];
    [self.verBtn setAdjustsImageWhenDisabled:NO];
    [self getCheckcode];
}

- (IBAction)onClickBindWechat:(id)sender {
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"bo_licai";
    req.openID = WX_ID;
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.regviewController=self;
    [WXApi sendAuthReq:req viewController:self delegate:app];
}

- (IBAction)onClickReg:(id)sender {
    if([self regVerify])
    {
        [self showHUD];
        
        /**
         * 注册提交
         * 提交方式 post
         * 参数：phone 手机号码
         *           password 密码
         *           verifyCode 短信验证码
         *           wcSDKOpenId 微信sdk openId
         *           unionId 微信unionId
         */
        
        NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
        [paramsDict setObject:self.phonefield.text forKey:@"phone"];
        [paramsDict setObject:self.passwordfield.text forKey:@"password"];
        [paramsDict setObject:self.verfield.text forKey:@"verifyCode"];
        [paramsDict setObject:self.openId forKey:@"wcSDKOpenId"];
        [paramsDict setObject:self.unionID forKey:@"unionId"];
        
        [[BaseHttpClient sharedClient] post:URL_REGISTER params:paramsDict complete:^(id response) {
            [self hideHUD];
            NSDictionary *responstDict = (NSDictionary *)response;
            NSLog(@"ss%@",response);
            if (responstDict==nil) {
                [self showTextHUD:@"网络错误"];
            }else{
                if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == 1)
                {
                    [self showTextHUD:@"注册成功，请登录！"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
                }
                
            }
        }];
        
        
        
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    long tag=textField.tag;
    
    if (tag==1 && range.location >= 11)
        return NO; // return NO to not change text
    else if (tag==2 && range.location >= 4)
        return NO;
    else if (tag==3 && range.location >= 20)
        return NO;
    else if (tag==4 && range.location >= 20)
        return NO;
    
    return YES;
}

-(BOOL)regVerify
{
    if([self.phonefield.text isBlank])
    {
        [self showTextHUD:@"手机号码不能为空"];
        return NO;
    }else if(![self.phonefield.text validateMobile])
    {
        [self showTextHUD:@"手机号码不正确"];
        return NO;
    }
    else if([self.verfield.text isBlank])
    {
        [self showTextHUD:@"验证码不能为空"];
        return NO;
    }
    else if([self.passwordfield.text isBlank])
    {
        [self showTextHUD:@"密码不能为空"];
        return NO;
    }
    else if([self.repasswordfield.text isBlank])
    {
        [self showTextHUD:@"重复密码不能为空"];
        return NO;
    }
    else if(![self.repasswordfield.text isEqualToString:self.passwordfield.text])
    {
        [self showTextHUD:@"两次密码输入不相等"];
        return NO;
    }
    else if(self.openId==nil || self.unionID==nil)
    {
        [self showTextHUD:@"请先绑定微信"];
        return NO;
    }
    
    return YES;
}


-(void) setReGetCheck
{
    [self.verBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    [self.verBtn setUserInteractionEnabled:YES];
    [self.verBtn setAdjustsImageWhenDisabled:YES];
}
-(void)timeFireMethod{
    self.secondsCountDown--;
    [self.verBtn setTitle:[NSString stringWithFormat:@"%dS",self.secondsCountDown] forState:UIControlStateNormal];
    
    if(self.secondsCountDown==0){
        [self.countDownTimer invalidate];
        
        self.countDownTimer=nil;
        [self setReGetCheck];
    }
}

//获取验证码
-(void)getCheckcode
{
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.phonefield.text forKey:@"phone"];
    
    
    [httpClient POST:URL_CHECKCODE parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responstDict = (NSDictionary *)responseObject;

        if (responstDict==nil) {
            [self showTextHUD:STR_NET_ERROR];
        }else{
            if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
            {
                self.secondsCountDown=60;
                self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [self timeFireMethod];
                
                
            }else{
                [self showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
                [self setReGetCheck];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self hideHUD];
        [self showTextHUD:STR_NET_ERROR];
        [self setReGetCheck];
    }];
}
//获取openId
-(void)getNetOpenId:(NSString*)code
{
    [self showHUD:@"正在绑定..."];
    
    NSString *url=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_ID,WX_Secret,code];
   
    AFHTTPRequestOperationManager *httpRequestManager= [AFHTTPRequestOperationManager manager];
    
    httpRequestManager.securityPolicy.allowInvalidCertificates = YES;
    httpRequestManager.responseSerializer.acceptableContentTypes = self.netTypes;
   
    
    [httpRequestManager GET:url parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [self hideHUD];
                        NSDictionary *responstDict = (NSDictionary *)responseObject;
                        NSLog(@"url%@",responstDict);
                        if (responstDict==nil) {
                            [self showTextHUD:STR_NET_ERROR];
                        }else if([responstDict objectForKey:@"openid"]){
                            self.openId=[responstDict objectForKey:@"openid"];
                            [self getNetUnionID:[responstDict objectForKey:@"access_token"]];
                        }
                        else
                        {
                            [self showTextHUD:@"数据错误"];
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        [self hideHUD];
                        [self showTextHUD:STR_NET_ERROR];
                    }];
    
    
    
}
//获取UnionId
-(void)getNetUnionID:(NSString*) access_token
{
    [self showHUD:@"正在绑定..."];
    NSString *url=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,self.openId];
     NSLog(@"url%@",url);
    
    AFHTTPRequestOperationManager *httpRequestManager= [AFHTTPRequestOperationManager manager];
    
    httpRequestManager.securityPolicy.allowInvalidCertificates = YES;
    httpRequestManager.responseSerializer.acceptableContentTypes = self.netTypes;
    
    [httpRequestManager GET:url parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [self hideHUD];
                        NSDictionary *responstDict = (NSDictionary *)responseObject;
                        NSLog(@"url%@",responstDict);
                        if (responstDict==nil) {
                            [self showTextHUD:STR_NET_ERROR];
                        }
                        else if([responstDict objectForKey:@"unionid"]){
                            NSLog(@"url%@",[responstDict objectForKey:@"unionid"]);
                            self.unionID=[responstDict objectForKey:@"unionid"];
                            [self showTextHUD:@"绑定成功"];
                        }
                        else
                        {
                            [self showTextHUD:@"数据错误"];
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //   [self hideDialog];
                        NSLog(@"url%@",error.userInfo);
                        [self hideHUD];
                        [self showTextHUD:STR_NET_ERROR];
                    }];
    
    
}
-(void) dealloc
{
    if(self.countDownTimer!=nil)
    {
        [self.countDownTimer invalidate];
        self.countDownTimer=nil;
    }
}

@end
