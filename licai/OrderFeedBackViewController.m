//
//  OrderFeedBackViewController.m
//  iweight
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 shierlan. All rights reserved.
//

#import "OrderFeedBackViewController.h"

@interface OrderFeedBackViewController ()

@end

@implementation OrderFeedBackViewController
@synthesize birthdayView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)initUI
{
    [self addNavBack];
  //  self.title=@"反馈";
    self.submitBtn.layer.cornerRadius=15.0;
    self.selectHttBtn.layer.cornerRadius=15.0;
    [self.selectHttBtn setBackgroundColor:[UIColor colorWithRed:0.27 green:0.67 blue:1.0 alpha:1.0]];
    
    
    birthdayView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    birthdayView.delegate = self;
    [self.view addSubview:birthdayView];
    [birthdayView setHidden:YES];
    self.selectDateBtn.titleLabel.text=@"";
    
}

- (IBAction)onClickSubmit:(id)sender {
    if([self verify])
    {
        [self uploadHead];
    }
}

- (IBAction)onClickHt:(id)sender {
    SelectHtViewController *vc=[[SelectHtViewController alloc] initWithNibName:@"SelectHtViewController" bundle:nil];
    vc.delegate=self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (IBAction)onClickDate:(id)sender {
    [birthdayView setHidden:NO];
}

-(void)onSelectImage:(UIImage *)image
{
     NSLog(@"%@",@"回调");
    self.image=image;
}
-(void)onSelectDate:(NSString *)str;
{
    [self.selectDateBtn setTitle:str forState:UIControlStateNormal];
    self.selectDateBtn.titleLabel.text=str;
}

-(void) uploadHead
{
    
    NSArray *images  = [NSArray arrayWithObjects:self.image, nil];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:self.yhmField.text forKey:@"coupon"];
    [params setValue:@"OrderfbEntity" forKey:@"businessType"];
    [params setValue:self.amountField.text forKey:@"buyMoney"];
    [params setValue:self.selectDateBtn.titleLabel.text forKey:@"buyTime"];
    
    [self showHUD:@"正在提交..."];
    [[BaseHttpClient sharedClient] upload:URL_HEADUPLOAD params:[ToolUtil getNetCommonParams:params] images:images complete:^(id response) {
        NSLog(@"%@",response);
        [self hideHUD];
        [self showHUD:@"提交成功"];
        [self onClickBack:nil];
        
    }];
    
    
}

-(BOOL)verify
{
    if([self.amountField.text isBlank])
    {
        [self showTextHUD:@"金额不能为空"];
        return NO;
    }
    else if([self.yhmField.text isBlank])
    {
        [self showTextHUD:@"优惠码不能为空"];
        return NO;
    }
    else if([self.selectDateBtn.titleLabel.text isBlank])
    {
       [self showTextHUD:@"日期不能为空"];
        return NO;
    }
    else if([self.amountField.text doubleValue]<=0)
    {
        [self showTextHUD:@"金额必须大于0"];
       return NO;
    }
    else if(self.image==nil)
    {
        [self showTextHUD:@"必须选择合同"];
        return NO;
    }
    return YES;
}


@end
