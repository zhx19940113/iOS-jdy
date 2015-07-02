//
//  DisCountViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "Manager.h"
@interface DisCountViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
      NSURLSessionDataTask *task;
}

@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@property (strong,nonatomic)NSString *productId;
@end
