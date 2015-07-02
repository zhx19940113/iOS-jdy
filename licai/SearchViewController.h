//
//  SearchViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "TouchTableView.h"

@protocol SearchViewDelegate <NSObject>
-(void)setRequstURL:(NSString *) urlStr keyword:(NSString *)keyStr;
@end
@interface SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,TouchTableViewDelegate>
- (IBAction)onClickDismiss:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *msearchBar;
@property (strong, nonatomic) IBOutlet TouchTableView *mTableView;
@property (strong, nonatomic) IBOutlet UIButton *hideBtn;
@property(assign,nonatomic)id<SearchViewDelegate> delegate;
@end
