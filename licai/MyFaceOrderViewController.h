//
//  MyFaceOrderViewController.h
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CommonHeaderView.h"
#import "FaceTableViewCell.h"
#import "BaseHttpClient.h"
#import "OrderFeedBackViewController.h"

typedef enum {
    FaceType,
    /** Bar chart style with bar background color  */
    OrderType,
    WithdrawCashType
    
} FaceOrderType;

@interface MyFaceOrderViewController :BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property FaceOrderType type;
@property (weak, nonatomic) IBOutlet CommonHeaderView *headerView;
@property(strong,nonatomic) NSMutableArray *datalist;
@property(strong,nonatomic) NSString *countText;
@property(strong,nonatomic) FaceTableViewCell *headcell;
@end
