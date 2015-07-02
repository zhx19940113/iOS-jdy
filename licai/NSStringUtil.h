//
//  NSStringUtil.h
//  yidao
//
//  Created by 钟惠雄 on 14-1-7.
//  Copyright (c) 2014年 钟惠雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtil : NSObject
+ (BOOL)validatePhone:(NSString *)phone;
+(BOOL)validateEmail:(NSString *)email;
+ (BOOL)isDigitalOrAlpha : (NSString *) text;
@end
