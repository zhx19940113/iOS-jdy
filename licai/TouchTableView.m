//
//  TouchTableView.m
//  licai
//
//  Created by shuangqi on 15/2/13.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "TouchTableView.h"

@implementation TouchTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize touchDelegate = _touchDelegate;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesBegan:touches withEvent:event];
    
    
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        
        [_touchDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
        
    {
        
        [_touchDelegate tableView:self touchesBegan:touches withEvent:event];
        
    }
    
}









@end
