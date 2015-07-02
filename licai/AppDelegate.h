//
//  AppDelegate.h
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking.h>
#import <IQKeyboardManager.h>
#import "IntroViewController.h"
#import "ToolUtil.h"
#import "LoginViewController.h"
#import "RegViewController.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
@property (strong, nonatomic) RegViewController *regviewController;
@property (strong, nonatomic) BaseViewController *shareVc;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) UIWindow *window;


@end

