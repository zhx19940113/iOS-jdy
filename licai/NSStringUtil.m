//
//  NSStringUtil.m
//  yidao
//
//  Created by 钟惠雄 on 14-1-7.
//  Copyright (c) 2014年 钟惠雄. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSStringUtil


//电话 包括座机 手机 之类
+ (BOOL)validatePhone:(NSString *)phone {
    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

//email的
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//判断输入的密码不是中文
+ (BOOL)isDigitalOrAlpha : (NSString *) text {
    for (int i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        if (!isascii(uc)) {
            return NO;
        }
    }
    return YES;
}

@end
