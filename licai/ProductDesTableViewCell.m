//
//  ProductDesTableViewCell.m
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ProductDesTableViewCell.h"

@implementation ProductDesTableViewCell
@synthesize nameLabel,fengeView,desLabel;
- (void)awakeFromNib {
    [fengeView setFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width +5, -10, 1, nameLabel.frame.size.height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
