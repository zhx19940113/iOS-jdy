//
//  RegViewController.h
//  licai
//
//  Created by shuangqi on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
#import "WXApi.h"

@interface RegViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bindWechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
@property (weak, nonatomic) IBOutlet UIButton *verBtn;
@property (weak, nonatomic) IBOutlet UITextField *phonefield;
@property (weak, nonatomic) IBOutlet UITextField *verfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;
@property (weak, nonatomic) IBOutlet UITextField *repasswordfield;
@property (nonatomic,strong) NSString *openId;
@property (nonatomic,strong) NSString *unionID;
@property int secondsCountDown;
@property (nonatomic,strong) NSTimer *countDownTimer;

- (IBAction)onClickVer:(id)sender;
- (IBAction)onClickBindWechat:(id)sender;
- (IBAction)onClickReg:(id)sender;
-(void)getNetOpenId:(NSString*)code;


@end
