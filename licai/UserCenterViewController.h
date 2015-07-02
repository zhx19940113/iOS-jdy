//
//  UserCenterViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "Define.h"
#import "SettingViewController.h"
#import "PECropViewController.h"
#import "BaseHttpClient.h"
#import "UIImageView+WebCache.h"
#import "BankCardListViewController.h"
#import "WthdrawCashViewController.h"
#import "MyFaceOrderViewController.h"
#import "MyFaceCicleViewController.h"
#import "MyMessageViewController.h"
#import "GradeViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "JMWhenTapped.h"
#import "Share2ViewController.h"
#import "ScoreViewController.h"

@interface UserCenterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,PECropViewControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic) IBOutlet UITableView *mTableView;
@property(strong,nonatomic) UIImageView *headpic;
@property(strong,nonatomic) BaseViewController *pViewController;
@property(strong,nonatomic) UILabel *nameLabel;
@property(strong,nonatomic) UILabel *gradeNumLabel;
@property(strong,nonatomic) UILabel *scoreNumLabel;
@property(strong,nonatomic) NSMutableDictionary *userInfo;
@property BOOL isGetNet;
-(void) getUserInfo;




@end
