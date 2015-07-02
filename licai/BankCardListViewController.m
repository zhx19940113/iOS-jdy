//
//  BankCardListViewController.m
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BankCardListViewController.h"

@interface BankCardListViewController ()

@end

@implementation BankCardListViewController

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
    self.title=@"我的银行卡";
    [self addNavBack];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    [rightBtn addTarget:self action:@selector(onClickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"add_bank_card"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.banks=[[NSMutableArray alloc] init];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    [self getBankList];
    
    
}
-(void) onClickAdd:(id) sender
{
    AddBankCardViewController  *settingVc=[[AddBankCardViewController alloc] initWithNibName:@"AddBankCardViewController" bundle:nil];
    [self.navigationController pushViewController:settingVc animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) getBankList
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    [httpClient POST:URL_BANK_LIST parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *responstDic = (NSDictionary *)responseObject;
        [self.banks removeAllObjects];
        [self.banks addObjectsFromArray:[responstDic objectForKey:@"data"]];
        
        if(self.banks.count==0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showTextHUD:STR_NET_ERROR];
        NSLog(@"%@",error);
        
    }];
}



- (void)deleteBank:(long)indexPath {
    
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    BankCardBean *bank = [BankCardBean objectWithKeyValues:[self.banks objectAtIndex:indexPath]];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:bank.ID forKey:@"ID"];
    
    

    
    [self showHUD:@"正在删除..."];
    [httpClient POST:[NSString stringWithFormat:@"%@%@",URL_BANK_DELETE,bank.ID] parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        [self hideHUD];
//        NSDictionary *responstDict = (NSDictionary *)responseObject;
//        if (responstDict==nil) {
//            [self showTextHUD:@"网络错误"];
//        }else{
//            if([[responstDict objectForKey:KEY_RESPONSE_STATUS] integerValue]  == CODE_SUCCESS)
//            {
//                [self showTextHUD:@"删除成功"];
//                [self.banks removeObjectAtIndex:indexPath];
//                [self.tableView reloadData];
//                
//            }else{
//                [self showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
//            }
//        }
        
        [self.banks removeObjectAtIndex:indexPath];
        [self.tableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self hideHUD];
        [self.banks removeObjectAtIndex:indexPath];
        [self.tableView reloadData];

      //  [self showTextHUD:STR_NET_ERROR];
        
        
    }];
    
}



#pragma mark -实现datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.banks!=nil){
        return [self.banks count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyMessageTableViewCell";
    SWTableViewCell *cell =(SWTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.97f green:0.31f blue:0.31 alpha:1.0f]
                                                    title:@"删除"];
        
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.leftUtilityButtons = nil;
        cell.rightUtilityButtons = rightUtilityButtons;
        cell.delegate = self;
        
        
    }
    
    
    BankCardBean *bank = [BankCardBean objectWithKeyValues:[self.banks objectAtIndex:indexPath.row]];
    [cell.textLabel setText:bank.bankName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"尾号：%@          持卡人：%@",[bank.bankCode substringFromIndex:bank.bankCode .length-4],bank.accountName]];
    
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BankCardBean *bank = [BankCardBean objectWithKeyValues:[self.banks objectAtIndex:indexPath.row]];
    bank.bankCode1=bank.bankCode;
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(onSelectBankCard:)])
    {
        [self.delegate onSelectBankCard:bank];
        [self onClickBack:nil];
    }
    else
    {
        WthdrawCashViewController  *settingVc=[[WthdrawCashViewController alloc] initWithNibName:@"WthdrawCashViewController" bundle:nil];
        settingVc.bank=bank;
        [self.navigationController pushViewController:settingVc animated:YES];
    }
    
}


-(void) swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [self deleteBank:index];
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
    
}


@end
