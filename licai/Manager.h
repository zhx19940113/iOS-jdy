//
//  Manager.h
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface Manager : NSObject
//ID = 402880f64b25f6fa014b2602a033000e;
//city = "\U5317\U4eac";
//cityCode = "<null>";
//"create_time" = "2015-01-26 19:31:21";
//"create_user_id" = 1;
//"create_user_name" = admin;
//detaAddress = "\U4fdd\U5b9a\U8857\U9053";
//detaAddressCode = "<null>";
//district = "\U4fdd\U5b9a";
//districtCode = "<null>";
//name = "\U738b\U4e94";
//province = "\U5317\U4eac";
//provinceCode = "<null>";
//telephone = 01032888888;
//"update_time" = "2015-01-26 19:31:21";
//"update_user_id" = 1;
//"update_user_name" = admin;

@property(copy,nonatomic)NSString *city;
@property (copy,nonatomic) NSString *name;
@property(copy,nonatomic)NSString *telephone;
@property(copy,nonatomic)NSString *province;
@property(copy,nonatomic)NSString *detaAddress;
@property(copy,nonatomic)NSString *district;
@end
