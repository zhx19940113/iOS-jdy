//
//  GradeViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/11.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "GradeTableViewCell.h"
@interface GradeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@end
