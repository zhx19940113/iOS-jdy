//
//  Define.h
//  sexbaike
//
//  Created by 钟惠雄 on 13-11-5.
//  Copyright (c) 2013年 钟惠雄. All rights reserved.
//

#ifndef sexbaike_Define_h
#define sexbaike_Define_h

/*******分享相关KEY**********/


// 获取Documents目录路径 NSString *docDir = [paths objectAtIndex:0];
#define DOCUMENT_PATH  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
// 获取Caches目录路径 NSString *cachesDir = [paths objectAtIndex:0];
#define CACHES_PATH  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
// 获取沙盒主目录路径
#define NSHomeDirectory = NSHomeDirectory();
// 获取tmp目录路径
#define NSTemporaryDirectory =  NSTemporaryDirectory();
#define folerName_PHOTO @"photos"

//NSDefault key
#define NSDEFAULT_USERNAME @"username"
#define NSDEFAULT_PASSWORD @"password"
#define NSDEFAULT_JDYCODE @"jdycode"
#define NSDEFAULT_MEMBERID @"memberid"
#define NSDEFAULT_TOKEN @"auth_token"
#define NSDEFAULT_USER_INFO @"user_info"
#define NSDEFAULT_FIRST_LOGIN @"is_first_login"
#define NSDEFAULT_FIRST_START @"is_first_start"
#define NSDEFAULT_IS_PUSH @"is_push"
#define NSDEFAULT_FIRST_START_HOME @"is_first_start_home"

#define NSDEFAULT_BBS_COLUMN  @"bbs_column"
#define NSDEFAULT_LAST_VERSION @"last_version"
#define NSDEFAULT_MAIN_FAMILY_USER @"main_family_user"
//预备期
#define NSDEFAULT_IS_YBQ @"target_is_ybq"
#define NSDEFAULT_START_WEIGHT @"target_start_weight"
#define NSDEFAULT_TARGET_WEIGHT @"target_weight"
#define NSDEFAULT_TARGET_SPEED @"target_speed"

//环信
#define NSDEFAULT_IS_EASE_LOGIN @"ease_login"
//第一次达到目标
#define NSDEFAULT_FIRST_TARGET_TASK @"first_target_task"



//系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//屏幕分辨率
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//-------------------图片类----------------------------
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

//----------------------颜色类---------------------------
#define COLOR_YELLOW        [UIColor colorWithRed:0.89 green:0.53 blue:0.13 alpha:1.0]
#define COLOR_YELLOW_LIGHT  [UIColor colorWithRed:0.99 green:0.58 blue:0.15 alpha:1.0]
#define COLOR_GRAY_LIGHT    [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]
#define COLOR_GRAY_FONT    [UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.0]
#define COLOR_BLUE          [UIColor colorWithRed:0.49 green:0.82 blue:0.98 alpha:1.0]
#define COLOR_BLUE_2          [UIColor colorWithRed:0.13 green:0.73 blue:0.99 alpha:1.0]
#define COLOR_RED          [UIColor colorWithRed:0.99 green:0.06 blue:0.13 alpha:1.0]
#define COLOR_RED_ROSE          [UIColor colorWithRed:0.97 green:0.35 blue:0.53 alpha:1.0]
#define COLOR_PICK          [UIColor colorWithRed:0.82 green:0.51 blue:0.84 alpha:1.0]
#define COLOR_PICK_LINGHT          [UIColor colorWithRed:0.81 green:0.51 blue:0.85 alpha:1.0]
#define COLOR_GREEN          [UIColor colorWithRed:0.14 green:0.78 blue:0.70 alpha:1.0]
#define COLOR_GRAY_1          [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0]



// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


//----------------------颜色类--------------------------

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#define AFTER_MAIN(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),dispatch_get_main_queue(),block)
#define AFTER_BACK(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block)


//拨打电话
#define canTel                 ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])

//打开URL
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])
//------------------字体-------------------------------------
#define FontNumber @"Roboto-Light"
#define FontWord @"Helvetica"
#define FontWordBold @"Helvetica-Bold"
#define FontWordEn @"Helvetica"

//------------------通知-------------------------------------
#define NotificationReachability        @"NotificationReachability"
#define NotificationTableViewReload     @"NotificationTableViewReload"
#define NotificationShowTab    @"NotificationShowTab"
#define NotificationLoginSUCCESS    @"NotificationLoginSUCCESS"
#define NotificationLogoutSUCCESS    @"NotificationLogoutSUCCESS"

//-----------------NSUserDefault----------------------------
#define WRISENAME @"ble_wrise_name"
#define WRISEUUID @"ble_wrise_uuid"
#define WRISECODE @"ble_wrise_code"

//------------------DEBUG------------------------
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#endif
