//
//  FaceTableViewCell.m
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "FaceTableViewCell.h"

@implementation FaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.row1 setTextColor:[UIColor colorWithRed:0.44 green:0.50 blue:0.53 alpha:1.0]];
    [self.row2 setTextColor:[UIColor colorWithRed:0.44 green:0.50 blue:0.53 alpha:1.0]];
    [self.row3 setTextColor:[UIColor colorWithRed:0.44 green:0.50 blue:0.53 alpha:1.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
