//
//  ProductDesViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDesTableViewCell.h"
#import "ProductDetailsBean.h"
#import "BaseHttpClient.h"
#import "Define.h"
#import "MJRefresh.h"
#import "UIImageView+MJWebCache.h"
#import "Share2ViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DisCountViewController.h"
#import "LoginViewController.h"

@interface ProductDesViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    NSURLSessionDataTask *task;
}
@property (copy,nonatomic) NSString *PARAMS_PRODUCT_ID;
@property (copy,nonatomic) NSString *PARAMS_PRODUCT_TYPE;
@property (strong, nonatomic) ProductBean *product;
@end
