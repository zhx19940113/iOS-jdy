//
//  ChangeNameViewController.h
//  licai
//
//  Created by shuangqi on 15/2/5.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseHttpClient.h"
@protocol onChangeNameProtocol <NSObject>
-(void)onChangeName:(NSString *)name;
@end

@interface ChangeNameViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property(strong,nonatomic) NSString *name;
@property(assign,nonatomic)id<onChangeNameProtocol> delegate;

- (IBAction)onClickSubmit:(id)sender;

@end
