//
//  ShareViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductBean.h"
@interface ShareViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIImageView *wechatImageView;
@property (strong, nonatomic) IBOutlet UIImageView *wechatFriendImageView;
@property (strong, nonatomic) IBOutlet UIImageView *typeImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;


@property (strong, nonatomic) IBOutlet UILabel *number1Label;
@property (strong, nonatomic) IBOutlet UILabel *number2Label;
@property (strong, nonatomic) IBOutlet UILabel *number3Label;
@property (strong, nonatomic) IBOutlet UILabel *des1Label;
@property (strong, nonatomic) IBOutlet UILabel *des2Label;
@property (strong, nonatomic) IBOutlet UILabel *des3Label;
@property (strong, nonatomic) IBOutlet UIView *productView;
@property (strong, nonatomic) ProductBean *product;

-(void)setProductBean:(ProductBean *)mBean;
@end
