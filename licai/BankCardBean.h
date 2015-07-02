//
//  BankCardBean.h
//  licai
//
//  Created by shuangqi on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//ID = 8a6714784b5abc1a014b5cdb06420023;
//accountName = "\U5566\U5566\U5566\U5566";
//bankCode = 1255566666666666;
//bankName = "\U770b\U770b\U54af\U54e6\U54e6";
@interface BankCardBean : NSObject
@property (copy,nonatomic)NSString *ID;
@property (copy,nonatomic)NSString *accountName;
@property (copy,nonatomic)NSString *bankCode;
@property (copy,nonatomic)NSString *bankCode1;
@property (copy,nonatomic)NSString *bankName;
@end
