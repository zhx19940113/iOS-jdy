//
//  AppDelegate.m
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark --生命周期方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.网络小菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //2.监控网络状态
    [self startNetworkMonitoring];
    //3.捕获系统崩溃异常
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    //5.适配简配弹出
    //ONE LINE OF CODE.
    //Enabling keyboard manager(Use this line to enable managing distance between keyboard & textField/textView).
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //向微信注册
    [WXApi registerApp:WX_ID withDescription:@"licai"];
  //  [WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"demo 2.0"];

    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSMutableDictionary *defaultValues=[[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"YES" forKey:NSDEFAULT_FIRST_LOGIN];
    [defaultValues setObject:@"YES" forKey:NSDEFAULT_FIRST_START];
    [defaultValues setObject:@"YES" forKey:NSDEFAULT_FIRST_START_HOME];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
    //是否第一次启动，yes开启介绍页面
    if([ToolUtil isFirstStart]){
        [ToolUtil saveFirstStart:NO];
        IntroViewController *introV = [[IntroViewController alloc] initWithNibName:@"IntroViewController" bundle:nil];
        introV.issetting=NO;
        self.window.rootViewController = introV;
        NSLog(@"第一次启动");
    }else{
        NSLog(@"不是第一次启动");
        
//        LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
//        self.window.rootViewController = navlogin;
        
         HomeViewController *homeV = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
         UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:homeV];
         self.window.rootViewController = navlogin;
        
        
        
    }
    
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark    --网络状态监控

/**
 *	@brief	开始检测网络状态
 */
-(void)startNetworkMonitoring
{
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    //当网络状态改变的时候，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知网络
            case AFNetworkReachabilityStatusNotReachable://没有网络
                NSLog(@"没有网络（断网）");
                // [self showAlertView:@"提示" message:@"网络异常，请检查网络设置！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

#pragma  mark   --异常处理回调
void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://suifeng_89@163.com?subject=bug报告&body=感谢 您的配合!<br><br><br>"
                        
                        "错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] openURL:url];
}
#pragma  mark 微信重写
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}
#pragma end

#pragma WXApiDelegate 代理
-(void) onReq:(BaseReq*)req
{
//    if([req isKindOfClass:[GetMessageFromWXReq class]])
//    {
//        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
//        
//        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
//        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.tag = 1000;
//        [alert show];
//        [alert release];
//    }
//    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
//    {
//        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
//        WXMediaMessage *msg = temp.message;
//        
//        //显示微信传过来的内容
//        WXAppExtendObject *obj = msg.mediaObject;
//        
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
//        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, msg.thumbData.length, msg.messageExt];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
//    else if([req isKindOfClass:[LaunchFromWXReq class]])
//    {
//        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
//        WXMediaMessage *msg = temp.message;
//        
//        //从微信启动App
//        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
//        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
}

-(void) onResp:(BaseResp*)resp
{

//    else if([resp isKindOfClass:[SendAuthResp class]])
//    {
//        SendAuthResp *temp = (SendAuthResp*)resp;
//        
//        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
//    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
//    {
//        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
//        NSMutableString* cardStr = [[[NSMutableString alloc] init] autorelease];
//        for (WXCardItem* cardItem in temp.cardAry) {
//            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%lu\n",cardItem.cardId,cardItem.extMsg,cardItem.cardState]];
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
    
        if([resp isKindOfClass:[SendAuthResp class]])
        {
            SendAuthResp *temp = (SendAuthResp*)resp;
            if(temp.errCode==0)
            [self.regviewController getNetOpenId:temp.code];
        }
       else if([resp isKindOfClass:[SendMessageToWXResp class]])
        {
//            NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//            NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            if(resp.errCode==0)
            {
                [self.shareVc showTextHUD:@"分享成功"];
                [ToolUtil updateShareCount:self.productId];
            }
            else
            {
                 [self.shareVc showTextHUD:@"分享分享取消"];
            }
            
            
            
            
        }
}

@end
