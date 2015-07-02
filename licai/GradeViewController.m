//
//  GradeViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/11.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "GradeViewController.h"

@interface GradeViewController ()

@end

@implementation GradeViewController
{
    NSMutableArray *keyArray;
    NSMutableArray *valueArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    keyArray = [[NSMutableArray alloc] initWithObjects: @"v1",@"v2",@"v3",@"T1",@"T2",@"T3",nil];
    valueArray = [[NSMutableArray alloc] initWithObjects:@"0",@"200",@"300",@"400",@"500",@"600",nil];
    if ([self.mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [keyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"GradeTableViewCell";
    GradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GradeTableViewCell" owner:self options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[GradeTableViewCell class]]){
                cell = (GradeTableViewCell *)oneObject;
            }
        }
    }
    
    cell.gradeLabel.text = [keyArray objectAtIndex:row];
    cell.scoreLabel.text = [valueArray objectAtIndex:row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }

    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



@end
