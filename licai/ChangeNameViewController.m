//
//  ChangeNameViewController.m
//  licai
//
//  Created by shuangqi on 15/2/5.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

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
    self.navigationItem.title=@"修改名称";
    
    self.nameField.delegate=self;
    [self addNavBack];
    self.nameField.text=self.name;
    
}

- (IBAction)onClickSubmit:(id)sender {
    
    if([self verify])
    {
        BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.nameField.text forKey:@"name"];
        
      
        
        
        
        [self showHUD:@"正在提交修改"];
        
        [httpClient POST:URL_CHANGENAME parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
            [self hideHUD];
            NSDictionary *responstDict = (NSDictionary *)responseObject;
            if (responstDict==nil) {
                [self showTextHUD:@"网络错误"];
            }else{
                if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
                {
                    [self showTextHUD:@"修改成功"];
                    [self.delegate onChangeName:self.nameField.text];
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
-(BOOL)verify
{
    if([self.nameField.text isBlank])
    {
        [self showTextHUD:@"名称不能为空"];
        return NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 10)
        return NO; // return NO to not change text
    return YES;
}
@end
