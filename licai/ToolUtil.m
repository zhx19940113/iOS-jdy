//
//  ToolUtil.m
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ToolUtil.h"
#import "AppDelegate.h"
@implementation ToolUtil



/**
 *	@brief	是否第一次启动
 *
 *	@return	<#return value description#>
 */
+(BOOL)isFirstStart
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings boolForKey:NSDEFAULT_FIRST_START];
}


+(void)saveFirstStart:(BOOL)isfirststart
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:NSDEFAULT_FIRST_START];
    [settings setBool:isfirststart forKey:NSDEFAULT_FIRST_START];
    [settings synchronize];
}


+(void)savePush:(BOOL)ispush
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:NSDEFAULT_IS_PUSH];
    [settings setBool:ispush forKey:NSDEFAULT_IS_PUSH];
    [settings synchronize];
}
+(BOOL)isPush
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings boolForKey:NSDEFAULT_IS_PUSH];
}

/**
 *	@brief	保存用户名密码
 *
 *	@param 	userName 	<#userName description#>
 *	@param 	pwd 	<#pwd description#>
 */
+(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd andJdycode:(NSString *)jdycode andMemberId:(NSString *)memberId
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:NSDEFAULT_USERNAME];
    [settings removeObjectForKey:NSDEFAULT_PASSWORD];
    [settings removeObjectForKey:NSDEFAULT_JDYCODE];
    [settings removeObjectForKey:NSDEFAULT_MEMBERID];
    [settings setObject:userName forKey:NSDEFAULT_USERNAME];
    [settings setObject:pwd forKey:NSDEFAULT_PASSWORD];
    [settings setObject:jdycode forKey:NSDEFAULT_JDYCODE];
    [settings setObject:memberId forKey:NSDEFAULT_MEMBERID];
    
    [settings synchronize];
}

/**
 *	@brief	保存token
 *
 *	@param 	authToken 	<#authToken description#>
 */
+(void)saveAuthToken:(NSString *)authToken
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:NSDEFAULT_TOKEN];
    [settings setObject:authToken forKey:NSDEFAULT_TOKEN];
    [settings synchronize];
}

+(NSString *)getToken
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:NSDEFAULT_TOKEN];
}

+(NSString *)getUserName
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:NSDEFAULT_USERNAME];
}
+(NSString *)getPwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:NSDEFAULT_PASSWORD];
}

+(NSString *)getJdycode
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:NSDEFAULT_JDYCODE];
}

+(NSString *)getMemberId
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:NSDEFAULT_MEMBERID];
}

/**
 *	@brief	是否登陆
 *
 *	@return	<#return value description#>
 */
+(BOOL)isLogin
{
    NSString *token=[self getMemberId];
    if(token==nil || [token isEqualToString:@""])
        return NO;
    else return YES;
}

//注销数据
+ (void)loginout
{
    [ToolUtil saveUserNameAndPwd:@"" andPwd:@"" andJdycode:@"" andMemberId:@""];
    [ToolUtil saveAuthToken:@""];
}

+(NSDictionary *) getNetCommonParams:(NSMutableDictionary *)params
{
    if([ToolUtil isLogin])
    {
        if(params==nil)
        {
            params=[[NSMutableDictionary alloc] init];
            [params setValue:[ToolUtil getJdycode] forKey:@"jdycode"];
            [params setValue:[ToolUtil getMemberId] forKey:@"memberId"];
            
            //memberId
        }
        else
        {
            [params setValue:[ToolUtil getJdycode] forKey:@"jdycode"];
            [params setValue:[ToolUtil getMemberId] forKey:@"memberId"];
        }
    }
    
    
    return params;
}

+(void) shareWeChat:(int)scene andVc:(BaseViewController*)vcObject andData:(ProductBean *)product;
{
    
    BaseViewController *vc=(BaseViewController*)vcObject;
     NSLog(@"%@",product);
    if(product.ID==nil)
    product.ID=@"";
    
  
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:product.ID forKey:@"productId"];
    
    [vc showHUD:@"正在分享..."];
    
    [httpClient POST:URL_WX_SHARE_URL parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        [vc hideHUD];
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        NSLog(@"%@",responseObject);
        if (responstDict==nil) {
            [vc showTextHUD:@"网络错误"];
        }else{
            if([responstDict objectForKey:@"ID"])
            {
                
                WXMediaMessage *message = [WXMediaMessage message];
                message.title = product.shareSubject;
                message.description =product.productSubject;
                [message setThumbImage:[UIImage imageNamed:@"type.png"]];
                // "/"+map.get("ID")+"-"+map.get("prodTypeCode")+"-"+rid;
                WXWebpageObject *ext = [WXWebpageObject object];
                ext.webpageUrl = [NSString stringWithFormat:@"%@%@%@-%@-%@",URL_BASE,URL_WX_SHARE_RESULT_URL,product.ID,product.prodTypeCode,[responstDict objectForKey:@"ID"]];
                
                message.mediaObject = ext;
                message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
                
                SendMessageToWXReq* req =[[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                req.scene = scene;
                [WXApi sendReq:req];
                
                 AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                 app.productId=product.ID;
                
                
            }else{
                [vc showTextHUD:[responstDict objectForKey:KEY_RESPONSE_MSG]];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [vc hideHUD];
        [vc showTextHUD:STR_NET_ERROR];
        
    }];
    
    
    
}

+(void) updateShareCount:(NSString*)ID;
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:ID forKey:@"productId"];
      NSLog(@"1111%@",ID);
    
    [httpClient POST:URL_SHARE_COUNT_URL parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"%@",error);
    }];
}

@end
