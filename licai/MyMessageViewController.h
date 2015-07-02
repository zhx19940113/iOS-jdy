//
//  MyMessageViewController.h
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "MessageBean.h"
#import "MJExtension.h"
#import "MessageDescViewController.h"

@interface MyMessageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)  NSMutableArray *messages;
@end
