//
//  BaseHttpClient.h
//  iweight
//
//  Created by 钟惠雄 on 14-7-22.
//  Copyright (c) 2014年 shierlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "APPConfig.h"
#import "Define.h"
#import "Urls.h"
#import "ToolUtil.h"
#define STR_NET_ERROR @"网络连接故障"
#define CODE_ERROR_LOGIN_FAILIULE -3
#define CODE_SUCCESS 1
//Respose key
#define KEY_RESPONSE_STATUS @"success"
#define KEY_RESPONSE_MSG @"msg"
#define KEY_RESPONSE_RESULT @"body"
#define PARAMS_KEY_USERID @"userId"
#define PARAMS_KEY_AUTH @"authenticationId"

@protocol HttpClientDelegate <NSObject>
-(void)uploadProgress:(long long)totalBytesWritten totalBytesExpectedToWrite:(long long)totalBytesExpectedToWrite;
@end

@interface BaseHttpClient : AFHTTPSessionManager
{
       NSOperationQueue *_queue;
}
+ (instancetype)sharedClient;

-(NSURLSessionDataTask *)get :(NSString *) path complete:(void(^)(id response)) complete;

-(NSURLSessionDataTask *)post :(NSString *) path params:(NSDictionary *)params complete:(void(^)(id response)) complete;

-(NSURLSessionDataTask *)upload :(NSString *) path
                          params:(NSDictionary *)params
                         images :(NSArray *) images
                        complete:(void(^)(id response)) complete;

-(AFHTTPRequestOperation * )uploadWithProgress :(NSString *) path
                                         params:(NSDictionary *)params
                                        images :(NSArray *) images
                                       complete:(void(^)(id response)) complete;

@property(assign,nonatomic)id<HttpClientDelegate> delegate;
@end
