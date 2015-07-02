//
//  BankCardListViewController.h
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpClient.h"
#import "BaseViewController.h"
#import  "AddBankCardViewController.h"
#import "BankCardBean.h"
#import "SWTableViewCell.h"
#import "MJExtension.h"
#import "WthdrawCashViewController.h"
#import "onSelectBankCardProtocol.h"


@interface BankCardListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)  NSMutableArray *banks;
@property(assign,nonatomic)id<onSelectBankCardProtocol> delegate;

@end
