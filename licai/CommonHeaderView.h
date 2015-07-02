//
//  CommonHeaderView.h
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@interface CommonHeaderView : UIView
@property (strong, nonatomic) UILabel *countText;
@property (strong, nonatomic) UILabel *unitText;
@property (strong, nonatomic) UILabel *descText;
-(void) initUI;
-(void) setLableText:(NSString*)count andDesc:(NSString*) desc;
-(void) setCLableText:(NSString*)count;
-(void) setDLableText:(NSString*)desc;
@end
