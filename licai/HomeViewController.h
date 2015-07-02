//
//  HomeViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MJRefresh.h"

#import "UserCenterViewController.h"
#import "GolfViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "MyController.h"

@interface HomeViewController : BaseViewController

@property(nonatomic,strong)UserCenterViewController *userCenterVc;
@property(nonatomic,strong)GolfViewController *golfVc;

@end
