//
//  SelectHtViewController.h
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"
#import "Define.h"

@protocol SelectImageDelegate <NSObject>
-(void)onSelectImage:(UIImage*)image;
@end

@interface SelectHtViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,PECropViewControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *pzBtn;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,assign) id<SelectImageDelegate> delegate;
- (IBAction)onClickPhoto:(id)sender;
- (IBAction)onClickSubmit:(id)sender;

- (IBAction)onClickPz:(id)sender;
@end
