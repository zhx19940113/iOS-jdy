//
//  GradeTableViewCell.m
//  licai
//
//  Created by 钟惠雄 on 15/2/11.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "GradeTableViewCell.h"

@implementation GradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context,[[UIColor grayColor] CGColor]);
    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
   // CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
   // CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}

@end
