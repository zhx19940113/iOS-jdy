//
//  SettingViewController.m
//  licai
//
//  Created by shuangqi on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "SettingViewController.h"
#import "IntroViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    self.settingStr=@[@"用户名称",@"修改密码",@"引导页",@"广告推送",@"退出登录"];
    self.title=@"设置";
    
    [self addNavBack];
    
    
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    self.switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    [self.switchButton setOn:YES];
    [self.switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.switchButton];
    
    [self.switchButton setOn:[ToolUtil isPush]];
    
    
    
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    [ToolUtil savePush:isButtonOn];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingStr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdetify = @"tablecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdetify];
        if(indexPath.row==3)
        {
            cell.accessoryView=self.switchButton;
        }
    }
    cell.textLabel.text =[self.settingStr objectAtIndex:indexPath.row];
    // [cell.textLabel setFont:[UIFont fontWithName:FontWord size:15]];
    // [cell.imageView setImage:[UIImage imageNamed:[obj objectForKey:@"icon"]]];
    if(indexPath.row<3)
        cell.accessoryType   =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    if(indexPath.row==0)
    {
        cell.detailTextLabel.text=self.name;
    }
    
    
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
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row==4)
    {
        
        
        [ToolUtil loginout];
//            LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//            UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
//            [self presentViewController:navlogin animated:YES completion:nil];
        
        
        BACK(^{
            [self loginout];
        });
        [self onClickBack:nil];
      
    }
    else if(indexPath.row==1)
    {
        ChangePasswordViewController *cpvc=[[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
        [self.navigationController pushViewController:cpvc animated:YES];
    }
    else if(indexPath.row==0)
    {
        ChangeNameViewController *cnvc=[[ChangeNameViewController alloc] initWithNibName:@"ChangeNameViewController" bundle:nil];
        cnvc.delegate=self;
        cnvc.name=self.name;
        [self.navigationController pushViewController:cnvc animated:YES];
    }
    
    else if(indexPath.row==2)
    {
       IntroViewController *introV = [[IntroViewController alloc] initWithNibName:@"IntroViewController" bundle:nil];
        introV.issetting=YES;
        [self.navigationController presentViewController:introV animated:YES completion:nil];
    }
    
    
    
}

-(void) loginout
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    [httpClient POST:URL_LOGINOUT parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"success");
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"failure:%@",[error localizedDescription]);
       
    }];
    
}

-(void) onClickBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void) onChangeName:(NSString *)name
{
    self.name=name;
    [self.tableview reloadData];
}

@end
