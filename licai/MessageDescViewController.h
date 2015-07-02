//
//  MessageDescViewController.h
//  licai
//
//  Created by shuangqi on 15/2/10.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpClient.h"
#import "BaseViewController.h"
#import "MessageBean.h"

@interface MessageDescViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (strong, nonatomic) MessageBean *message;

@end
