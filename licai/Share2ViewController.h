//
//  Share2ViewController.h
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "BaseViewController.h"

@interface Share2ViewController : BaseViewController
@property (strong, nonatomic) ProductBean *product;
@property (weak, nonatomic) IBOutlet UIImageView *sharefriend;
@property (weak, nonatomic) IBOutlet UIImageView *shareCicle;

-(void)setProductBean:(ProductBean *)mBean;
@end
