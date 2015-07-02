//
//  ProductDesTableViewCell.h
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsBean.h"
@interface ProductDesTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;
@property (strong, nonatomic) IBOutlet UIView *fengeView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

-(void)setProductDetailsBean:(ProductDetailsBean *)mBean;
@end
