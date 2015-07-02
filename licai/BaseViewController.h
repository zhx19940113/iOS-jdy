//
//  BaseViewController.h
//  pinche
//
//  Created by 钟惠雄 on 14-3-14.
//  Copyright (c) 2014年 qiyiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "MBProgressHUD.h"
#import "ImageUtil.h"
#define kTabBarHeight 42.0f
#define kStatusHeight 64.0f
#define kStatusBarHeight 20.0f
#define kNavBarHeight 44.0f
#define kMarginWidth 5
#import "NSString+PJR.h"
#import "NSStringUtil.h"
#import "ToolUtil.h"
#import "UIView+Toast.h"
#import "APPConfig.h"
#import "JMWhenTapped.h"
@class LoginViewController;

static char kEventBlockKey;
typedef void (^EventBlock)(NSDictionary* userInfo);

@interface BaseViewController :UIViewController<UITextFieldDelegate>{
    MBProgressHUD *HUD;
}
@property(retain,nonatomic)UIView * _navView;
@property(retain,nonatomic)UIButton *_backBtn;
@property(retain,nonatomic)UILabel *_titleLabel;
@property(retain,nonatomic)UILabel *_rightLabel;
@property(retain,nonatomic)NSString *notificationKey;
@property(retain,nonatomic)NSSet *netTypes;


-(void)enterLoginVc;
-(void)refreshUserInfo;
- (void)showTextDialog:(NSString *)text;
-(void)onClickBack:(id)sender;
-(void)onClickdisMiss:(id)sender showtab:(BOOL) showtab;
-(void)addNavBack;
-(void)setNavTitle:(NSString *)title;


- (UIColor *)getColor:(NSString*)hexColor;
-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color;
-(void)addLineWithWidth:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color width:(float)width;
-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview;
-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview width:(float)width;
-(CGSize)scaleSize:(CGSize)sourceSize;
-(IBAction)hideKeyboard;
-(void)showTextHUD:(NSString *)text;
-(void)showHUD;
-(void)hideHUD;
-(MBProgressHUD *)showHUD:(NSString *)msg;
//设置空数据是否隐藏
-(void) setEmptyHidden:(BOOL)isHidden;
//设置空数据文字
-(void) setEmptyText:(NSString*)text;
//设置空数据位置
-(void) initEmptyViewWithFrame:(CGRect)frame;


//广播事件
-(void) onRegEvent:(NSString*)eventName block:(EventBlock) block;
-(void) sendEvent:(NSString*)eventName data:(NSDictionary*) info;
- (UIImage*) createImageWithColor: (UIColor*) color;

@end
