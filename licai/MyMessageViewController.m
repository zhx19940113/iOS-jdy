//
//  MyMessageViewController.m
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "MyMessageViewController.h"

@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

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
    self.title=@"通知";
    
    
     self.messages=[[NSMutableArray alloc] init];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self getMsgList];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.messages!=nil){
        return [self.messages count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"tablecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdetify];
    }
    
    
    MessageBean *message = [MessageBean objectWithKeyValues:[self.messages objectAtIndex:indexPath.row]];
    [cell.textLabel setText:message.title];
    [cell.detailTextLabel setText:[[message.create_time replaceCharcter:@"-" withCharcter:@"/"] substringToIndex:10]];
     cell.accessoryType   =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    if(message.isRead==1)
    {
        [cell.textLabel setTextColor:[UIColor grayColor]];
    }
    else  [cell.textLabel setTextColor:[UIColor blackColor]];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     MessageBean *message = [MessageBean objectWithKeyValues:[self.messages objectAtIndex:indexPath.row]];
     MessageDescViewController *mvc=[[MessageDescViewController alloc] init];
     mvc.message=message;
     [self.navigationController pushViewController:mvc animated:YES];
}

-(void) getMsgList
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    [httpClient POST:URL_MY_MESSAGE parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = (NSArray *)responseObject;
       [self.messages removeAllObjects];
       [self.messages addObjectsFromArray:array];
        
        if(self.messages.count==0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showTextHUD:STR_NET_ERROR];
        NSLog(@"%@",error);
        
    }];
}

@end
