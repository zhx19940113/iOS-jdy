//
//  SettingViewController.h
//  licai
//
//  Created by shuangqi on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "ChangePasswordViewController.h"
#import "ChangeNameViewController.h"
#import "LoginViewController.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,onChangeNameProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong,nonatomic) NSArray *settingStr;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) UISwitch *switchButton;
@end
