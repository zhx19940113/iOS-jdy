//
//  SelectHtViewController.m
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "SelectHtViewController.h"

@interface SelectHtViewController ()

@end

@implementation SelectHtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    self.submitBtn.layer.cornerRadius=15.0;
    self.pzBtn.layer.cornerRadius=15.0;
    self.photoBtn.layer.cornerRadius=15.0;
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //添加到集合中
    UIImage * photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    PECropViewController *controller = [[PECropViewController alloc] init];
    
    CGFloat width = photo.size.width;
    CGFloat height = photo.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    controller.keepingCropAspectRatio=YES;
    
    controller.delegate = self;
    controller.image = photo;
    controller.toolbarHidden=YES;
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self.imageView setImage:photo];
    
   // [self presentViewController:nav animated:YES completion:nil];
    // [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - PECropViewControllerDelegate methods

-(void) cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    // [self.navigationController popViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    //[self showTextHUD:@"正在上传您的头像"];
    [self.imageView setImage:croppedImage];
    
    
    //croppedImage = [croppedImage resizedImage:[self scaleSize:croppedImage.size] interpolationQuality:kCGInterpolationMedium];
    NSData *imageData = UIImageJPEGRepresentation(croppedImage, 0.5f);
    NSArray *array = DOCUMENT_PATH;
    double timeStr = [[NSDate date] timeIntervalSince1970];
    [imageData writeToFile:[NSString stringWithFormat:@"%@/%f.jpg",[array objectAtIndex:0],timeStr] atomically:YES];
    // isUploadHeader = YES;
    //对photo进行处理
    //[[MyThread Instance] startUpdatePortrait:UIImageJPEGRepresentation(croppedImage, 0.75f)];
    //[Tool ToastNotification:@"正在上传您的头像" andView:self.view andLoading:YES andIsBottom:NO];
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    //[self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickPhoto:(id)sender {
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)onClickSubmit:(id)sender {
    [self.delegate onSelectImage:self.imageView.image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickPz:(id)sender {
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imgPicker animated:YES completion:nil];
}
@end
