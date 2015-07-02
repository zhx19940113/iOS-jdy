//
//  BaseHttpClient.m
//  iweight
//
//  Created by 钟惠雄 on 14-7-22.
//  Copyright (c) 2014年 shierlan. All rights reserved.
//

#import "BaseHttpClient.h"
#define TIMEOUT 10000


@implementation BaseHttpClient

static NSString * const BASE_URL = URL_BASE;

+ (instancetype)sharedClient {
    static BaseHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
//[config setHTTPAdditionalHeaders:@{ @"Content-Type" : @"application/x-www-form-urlencoded"}];
        
        
        if([ToolUtil isLogin])
            [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0",@"Cookie":[NSString stringWithFormat:@"JSESSIONID=%@",[ToolUtil getToken]]}];
        else
            [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        

        [config setTimeoutIntervalForRequest:TIMEOUT]; //请求超时设置
        [config setTimeoutIntervalForResource:TIMEOUT]; //读取超时设置
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        [config setURLCache:cache];
        _sharedClient = [[BaseHttpClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL] sessionConfiguration:config];
         _sharedClient.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
        
    });
    
    
    return _sharedClient;
}


/**
 *	@brief	get请求
 *	@param 	params
 */
-(NSURLSessionDataTask *)get :(NSString *) path complete:(void(^)(id response)) complete
{
    NSURLSessionDataTask *_task = [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSHTTPURLResponse *response  =  (NSHTTPURLResponse *)[task response];
        if (response.statusCode == 200) {
            MAIN(^{
                complete(responseObject);
            });
        }
        
        NSLog(@"responseObject=%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MAIN(^{
            complete(nil);
        });
        NSLog(@"error=%@",[error localizedDescription]);
    }];
    
    return _task;
}


/**
 *	@brief	post请求
 *
 *	@param 	params
 */
-(NSURLSessionDataTask *)post :(NSString *) path params:(NSDictionary *)params complete:(void(^)(id response)) complete
{
    NSURLSessionDataTask *_task = [self POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSHTTPURLResponse *response  =  (NSHTTPURLResponse *)[task response];
        if (response.statusCode == 200) {
            MAIN(^{
                complete(responseObject);
            });
        }
        NSLog(@"responseObject=%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MAIN(^{
            complete(nil);
        });
        NSLog(@"error=%@",[error localizedDescription]);
    }];
    
    return _task;
}


/**
 *	@brief	提交表单
 *
 *	@param 	params
 *
 *	@return
 */
-(NSURLSessionDataTask *)upload :(NSString *) path
                          params:(NSDictionary *)params
                         images :(NSArray *) images
                        complete:(void(^)(id response)) complete

{
    NSURLSessionDataTask *_task = [self POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //添加上传内容
        if(images!=nil){
            for(UIImage *eachImage in images){
                NSLog(@"上传图片");
                NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
                long time = (long)[[NSDate date] timeIntervalSince1970] *1000;
                
                if([[params objectForKey:@"businessType"] isEqualToString:@"MemberEntity"])
                {
                    [formData appendPartWithFileData:imageData name:@"portrait"
                                            fileName:[NSString stringWithFormat:@"abc%ld.jpg",time ]
                                            mimeType:@"image/jpeg"];
                }
                else
                {
                    [formData appendPartWithFileData:imageData name:@"contract"
                                            fileName:[NSString stringWithFormat:@"abc%ld.jpg",time ]
                                            mimeType:@"image/jpeg"];
                }
                
                
                
                
            }
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSHTTPURLResponse *response  =  (NSHTTPURLResponse *)[task response];
        if (response.statusCode == 200) {
            MAIN(^{
                complete(responseObject);
            });
        }
        NSLog(@"responseObject=%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MAIN(^{
            complete(nil);
        });
        NSLog(@"error=%@",[error localizedDescription]);
        
    }];
    return _task;
    
}


/**
 *	@brief	上传文件，带进度监控
 *
 *	@param 	params
 */
-(AFHTTPRequestOperation * )uploadWithProgress :(NSString *) path
                                         params:(NSDictionary *)params
                                        images :(NSArray *) images
                                       complete:(void(^)(id response)) complete

{
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request =
    
    [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(images!=nil){
            for(UIImage *eachImage in images){
                NSLog(@"上传图片");
                NSData *imageData = UIImageJPEGRepresentation(eachImage,0.8);
                long time = (long)[[NSDate date] timeIntervalSince1970] *1000;
                [formData appendPartWithFileData:imageData name:@"photo"
                                        fileName:[NSString stringWithFormat:@"abc%ld.jpg",time ]
                                        mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    
    NSLog(@"auth%@",[params objectForKey:@"authenticationId"] );
    NSLog(@"userId%@",[params objectForKey:@"userId"] );
    NSLog(@"content%@",[params objectForKey:@"content"] );
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSLog(@"Success %@", responseObject);
                                         MAIN(^{
                                             complete(responseObject);
                                         });
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Failure %@", error.description);
                                         MAIN(^{
                                             complete(nil);
                                         });
                                     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        if(_delegate!=nil && [_delegate respondsToSelector:@selector(uploadProgress:totalBytesExpectedToWrite:)])
        {
            [_delegate uploadProgress:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
        }
        
        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    // 5. Begin!
    [operation start];
    
    return operation;
    
}

@end
