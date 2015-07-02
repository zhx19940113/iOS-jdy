//
//  MyController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/9.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "MJRefresh.h"
#import "ProductBean.h"
#import "ProductTableViewCell.h"
#import "DisCountViewController.h"
#import "ProductDesViewController.h"
#import "SearchViewController.h"

@interface MyController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SearchViewDelegate>
{
    NSURLSessionDataTask *task;
    int currTotalNum;
    int totalNum;
}

@property(strong,nonatomic)  UITableView *mTableView;
@property(strong,nonatomic) UINavigationController *navControl;
@end
