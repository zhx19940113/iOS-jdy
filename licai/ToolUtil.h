//
//  ToolUtil.h
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"
#import "WXApi.h"
#import "BaseViewController.h"
#import "ProductBean.h"
#import "BaseHttpClient.h"

@interface ToolUtil : NSObject
+(BOOL)isFirstStart;
+(void)saveFirstStart:(BOOL)isfirststart;

+(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd andJdycode:(NSString *)jdycode andMemberId:(NSString *)memberId;
+(NSString *)getUserName;
+(NSString *)getPwd;
+(NSString *)getMemberId;
+(NSString *)getJdycode;
+(NSString *)getToken;
+(void)saveAuthToken:(NSString *)authToken;
+(void)getAuthToken;
+(void)savePush:(BOOL)ispush;
+(BOOL)isPush;
+(BOOL)isLogin;
//注销数据
+ (void)loginout;
+(NSDictionary *) getNetCommonParams:(NSDictionary *)params;

+(void) shareWeChat:(int)scene andVc:(id)vcObject andData:(ProductBean *)product;
+(void) updateShareCount:(NSString*)ID;
@end
