//
//  Share2ViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "Share2ViewController.h"
#import "AppDelegate.h"

@interface Share2ViewController ()

@end

@implementation Share2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer* shareFirendRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickShareFriend:)];
    self.sharefriend.userInteractionEnabled=YES;
    [self.sharefriend addGestureRecognizer:shareFirendRecognizer];
    
    UITapGestureRecognizer* shareCicleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickShareCicle:)];
    self.shareCicle.userInteractionEnabled=YES;
    [self.shareCicle addGestureRecognizer:shareCicleRecognizer];
    
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.shareVc=self;
}

-(void) OnClickShareFriend:(UITapGestureRecognizer*)recognizer
{
    if(![ToolUtil isLogin])
    {
        LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:navlogin animated:YES completion:nil];
        [self dismissPopupViewControllerWithanimationType:0];
        return;
        
    }
    else
        [ToolUtil shareWeChat:WXSceneSession andVc:self andData:self.product];
}

-(void) OnClickShareCicle:(UITapGestureRecognizer*)recognizer
{
    if(![ToolUtil isLogin])
    {
        LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:navlogin animated:YES completion:nil];
        [self dismissPopupViewControllerWithanimationType:0];
        return;
        
    }
    else
        [ToolUtil shareWeChat:WXSceneTimeline andVc:self andData:self.product];
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

@end
