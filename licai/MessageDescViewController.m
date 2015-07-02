//
//  MessageDescViewController.m
//  licai
//
//  Created by shuangqi on 15/2/10.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "MessageDescViewController.h"

@interface MessageDescViewController ()

@end

@implementation MessageDescViewController

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
    [self addNavBack];
    self.title=@"我的消息";
    self.desc.text=self.message.content;
   [self updateMsg];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) updateMsg
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    [httpClient POST:[NSString stringWithFormat:@"%@%@",URL_READEDMSG_URL,self.message.ID] parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
       NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

@end
