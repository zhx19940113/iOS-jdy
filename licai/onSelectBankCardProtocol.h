//
//  onSelectBankCardProtocol.h
//  licai
//
//  Created by shuangqi on 15/2/9.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#ifndef licai_onSelectBankCardProtocol_h
#define licai_onSelectBankCardProtocol_h
#import "BankCardBean.h"
@protocol onSelectBankCardProtocol <NSObject>
-(void)onSelectBankCard:(BankCardBean *)data;
@end

#endif
