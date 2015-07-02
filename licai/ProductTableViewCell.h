//
//  ProductTableViewCell.h
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "ProductBean.h"
#import "ShareViewController.h"

@interface ProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pruductTypeImageView;
@property (strong, nonatomic) IBOutlet UILabel *productNameLable;
@property (strong, nonatomic) IBOutlet UILabel *productDetailsLabel;

@property (strong, nonatomic) IBOutlet UILabel *number1Label;
@property (strong, nonatomic) IBOutlet UILabel *number2Label;
@property (strong, nonatomic) IBOutlet UILabel *number3Label;
@property (strong, nonatomic) IBOutlet UILabel *des1Label;
@property (strong, nonatomic) IBOutlet UILabel *des2Label;
@property (strong, nonatomic) IBOutlet UILabel *des3Label;
@property (strong, nonatomic) UIViewController *msender;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *discountBtn;


-(void)setBean:(ProductBean *)mBean;
@end
