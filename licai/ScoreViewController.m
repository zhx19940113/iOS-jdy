//
//  ScoreViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/11.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController
@synthesize mTextView;
- (void)viewDidLoad {
    [super viewDidLoad];

     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4.0;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle};
    mTextView.attributedText = [[NSAttributedString alloc]initWithString:mTextView.text attributes:attributes];
    
    [mTextView setTextColor:[self getColor:@"#BEBEBE"]];
    [mTextView setFont:[UIFont fontWithName:FontWord size:16]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
