//
//  TouchTableView.h
//  licai
//
//  Created by shuangqi on 15/2/13.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchTableViewDelegate <NSObject>

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end



@interface TouchTableView : UITableView
{

}
@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;
@end
