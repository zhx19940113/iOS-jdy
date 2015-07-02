//
//  GolfViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "Define.h"
#import "EScrollerView.h"
#import "ProductTableViewCell.h"
#import "ProductDesViewController.h"
#import "BaseHttpClient.h"
#import "ProductBean.h"
#import "SearchViewController.h"
#import "LoginViewController.h"


@interface GolfViewController : BaseViewController<EScrollerViewDelegate,UITableViewDataSource,UITableViewDelegate,SearchViewDelegate>
{
    NSURLSessionDataTask *task;
    int currTotalNum;
    int totalNum;
}
@property(strong,nonatomic)  UITableView *mTableView;
@property(strong,nonatomic) UINavigationController *navControl;


@end
