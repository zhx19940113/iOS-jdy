//
//  WthdrawCashViewController.m
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "WthdrawCashViewController.h"

@interface WthdrawCashViewController ()

@end

@implementation WthdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void) initUI
{
    self.submitBtn.layer.cornerRadius=15.0;
    self.navigationItem.title=@"提现";
    [self addNavBack];
    
    
    UITapGestureRecognizer* frogetRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickChange:)];
    self.changeBankText.userInteractionEnabled=YES;
    [self.changeBankText addGestureRecognizer:frogetRecognizer];
    [self.TopView setBackgroundColor:[UIColor colorWithRed:0.27 green:0.67 blue:1.0 alpha:1.0]];
    [self getCanMoney];
    
    
    self.bankNameText.text=@"未绑定银行卡";
    self.bankCodeText.text=@"";
    
    
}

-(void)OnClickChange:(UITapGestureRecognizer*)recognizer
{
    BankCardListViewController  *settingVc=[[BankCardListViewController alloc] initWithNibName:@"BankCardListViewController" bundle:nil];
    settingVc.delegate=self;
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (IBAction)onClickSubmit:(id)sender {
    [self saveAmount];
    
}


-(void) getCanMoney
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [httpClient POST:[NSString stringWithFormat:@"%@%@",URL_GET_CAN_CASH,[ToolUtil getMemberId]] parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *doubi = responseObject;
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        
        
        
        if (responseObject==nil) {
            [self showTextHUD:@"网络错误"];
        }else{
            
            self.amountField.text=shabi;
            self.amount=[shabi doubleValue];
            self.moneyText.text=shabi;
            
        }
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
        if(self.bank==nil)
        [self getCanBank];
        else
        {
            [self setBankData:self.bank];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showTextHUD:STR_NET_ERROR];
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
        
        
    }];
}


-(void) getCanBank
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    
    [httpClient POST:[NSString stringWithFormat:@"%@%@",URL_GET_MEMBANK,[ToolUtil getMemberId]] parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        
        if (responstDict==nil) {
            [self showTextHUD:@"网络错误"];
        }else{
            
            NSLog(@"%@",responstDict);
            NSArray *banks=[responstDict objectForKey:@"data"];
            
            if(banks.count>0)
            {
                [self setBankData:[BankCardBean objectWithKeyValues:[banks objectAtIndex:0]]];
                
               
            }
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showTextHUD:STR_NET_ERROR];
        
    }];
}

-(void) saveAmount
{
    if([self verify])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认提现" message:[NSString stringWithFormat:@"请确认本次提现金额为：%.2f元",[self.amountField.text floatValue]] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alert show];
        alert.delegate=self;
        
       
    }
}



-(void) changeBankCard
{
    
        BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.bank.ID forKey:@"ID"];
        
    
        [httpClient POST:URL_CHANGE_HAND_CARD parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
           
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
          
            
        }];
    
}



-(void) setBankData:(BankCardBean *)bank
{
    self.bank=bank;
    [self.bankCodeText setTextColor:[UIColor blackColor]];
    if(bank!=nil)
    {
        self.bankNameText.text=self.bank.bankName;
        NSLog(@"尾数%@",[bank.bankCode substringFromIndex:bank.bankCode .length-4]);
        if(![bank.bankCode isBlank] && ![[bank.bankCode substringFromIndex:bank.bankCode .length-4] containsString:@"null"]
           && bank.bankCode !=nil && bank.bankCode !=[NSNull null])
            self.bankCodeText.text=[NSString stringWithFormat:@"(尾数%@)",[bank.bankCode substringFromIndex:bank.bankCode .length-4]];
        else
            self.bankCodeText.text = @"暂无账号";
    }else
    {
        self.bankCodeText.text = @"暂无账号";
    }
    
    
    
}

-(BOOL)verify
{
    if([self.amountField.text isBlank])
    {
        [self showTextHUD:@"金额不能为空"];
        return NO;
    }
    else if([self.amountField.text doubleValue]<=0)
    {
        [self showTextHUD:@"金额必须大于0"];
        return NO;
    }
    else if([self.amountField.text doubleValue]>self.amount)
    {
        [self showTextHUD:@"金额不能大于可用金额"];
        return NO;
    }
    
    return YES;
}

-(void)onSelectBankCard:(BankCardBean *)data
{
    [self setBankData:data];
    BACK(^{
         [self changeBankCard];
    });
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtIndex:%d",buttonIndex);
    
    
    if(buttonIndex==1)
    {
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.bank.bankCode1 forKey:@"bankCode"];
    [params setObject:self.amountField.text forKey:@"withdCash"];
    [params setObject:[ToolUtil getMemberId] forKey:@"memId"];
    
    
    [self showHUD:@"正在提交..."];
    [httpClient POST:URL_SUBMIT_CASH parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        [self hideHUD];
        NSData *doubi = responseObject;
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        
        
        [self showTextHUD:[NSString stringWithFormat:@"提现成功,您现在可用金额为%@",shabi]];
        [self onClickBack:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        [self hideHUD];
        [self showTextHUD:STR_NET_ERROR];
        
    }];
    }
}

@end
