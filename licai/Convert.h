//
//  Convert.h
//
//  Created by 张泽涛 on 14-1-21.
//  Copyright (c) 2014年 ST alliance AS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Convert : NSObject

+(NSData*)stringToByte:(NSString*)string;
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转16进制数
+(NSString *)hexStringFromString:(NSString *)string;
//byte[]数组转16进制字符串
+(NSString *) bytesToHexString:(Byte [])mByte mSize:(int) mSize;
//byte[]数组转16进制字符串
+(NSString *) bytesHLToHexString:(Byte [])mByte mSize:(int) mSize;
//16进制字符串转int
+(int)hexStringToInt:(NSString *)hexStr;
@end
