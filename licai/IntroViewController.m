//

//  IntroViewController.m

//  iweight

//

//  Created by 钟惠雄 on 14-9-3.

//  Copyright (c) 2014年 shierlan. All rights reserved.

//



#import "IntroViewController.h"

@interface IntroViewController ()

@property (nonatomic, strong) UIScrollView* mScrollView ;

@end



@implementation IntroViewController



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [bgImageView setImage:[UIImage imageNamed:@"bg_login"]];
    
    [self.view addSubview:bgImageView];
    
    [self.view addSubview:_mScrollView];
    
    
    
    
    
    
    
    
    
    for (int i =0; i<2; i++) {
        
        UIImageView *setpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [setpImageView setContentMode:UIViewContentModeScaleToFill];
        [setpImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide%d", i+1]]];
        
        
        
        if(i==1)
            
        {
            
            
            
            UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, setpImageView.frame.size.height - 130, SCREEN_WIDTH/3, 40)];
            
            
            [enterBtn setTitle:self.issetting?@"关闭引导":@"马上体验" forState:UIControlStateNormal];
            
            [enterBtn setImage:[UIImage imageNamed:self.issetting?@"show_guide":@"new_start"] forState:UIControlStateNormal];
            
            [enterBtn addTarget:self action:@selector(onClickStart:) forControlEvents:UIControlEventTouchUpInside];
            
            [setpImageView addSubview:enterBtn];
            
            [setpImageView setUserInteractionEnabled:YES];
            
            [setpImageView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.78 blue:0.7 alpha:1]];
            
        }
        
        
        
//        if(i==0)
//            
//            [setpImageView setBackgroundColor:[UIColor colorWithRed:0.11 green:0.63 blue:0.9 alpha:1]];
//        
//        if(i==1)
//            
//            [setpImageView setBackgroundColor:[UIColor colorWithRed:0.57 green:0.84 blue:0.98 alpha:1]];
//        
//        if(i==2)
//            
//            [setpImageView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.47 blue:0.62 alpha:1]];
        
        
        
        
        
        [_mScrollView addSubview:setpImageView];
        
    }
    
    
    
    _mScrollView.pagingEnabled =YES;
    
    [_mScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT)];
    
    
    
    
    
}



- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



-(void)onClickStart:(id)sender

{
    
    NSLog(@"onClickStart");
    
    if(self.issetting)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self presentViewController:navControl animated:YES completion:nil];
    }
}





@end

