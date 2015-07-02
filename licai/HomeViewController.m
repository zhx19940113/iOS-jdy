//
//  HomeViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    NSInteger seqIndex;
    UIButton *rightBtn;
    UISegmentedControl *segmentedControl;
}
@synthesize userCenterVc,golfVc;



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(![ToolUtil isLogin]){
        if(segmentedControl!=nil && golfVc!=nil)
        {
            segmentedControl.selectedSegmentIndex = 0;
            seqIndex = 0;
            [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            if(userCenterVc)
            {
                [userCenterVc removeFromParentViewController];
            }
            [self.view addSubview:golfVc.view];
            
        }
    }
    else {
        if(userCenterVc!=nil && seqIndex==1 && [ToolUtil isLogin])
        {
         [userCenterVc getUserInfo];
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    userCenterVc = [[UserCenterViewController alloc] init];
    golfVc = [[GolfViewController alloc ] init];
    [golfVc setNavControl:self.navigationController];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"金矿",@"我的",nil];
    //初始化UISegmentedControl
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 33);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor whiteColor];
    
   // segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged]; //添加委托方法
   [self.navigationController.navigationBar.topItem setTitleView:segmentedControl];
    
    
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn addTarget:self action:@selector(onClickSearch:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;

    [self.view addSubview:golfVc.view];
    seqIndex = 0;
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccess) name:NotificationLoginSUCCESS object:nil];
 
}

-(void)onLoginSuccess
{

            if(segmentedControl!=nil && golfVc!=nil)
            {
                [segmentedControl setSelectedSegmentIndex:1];
                if(golfVc)
                {
                    [golfVc removeFromParentViewController];
                }
                userCenterVc.pViewController=self;
                [self.view addSubview:userCenterVc.view];
                [rightBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                [rightBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateHighlighted];
            }

}


-(void) onClickSearch:(id) sender
{
    if(seqIndex==0)
    {

        SearchViewController *searchVc =[[SearchViewController alloc] init];
        searchVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        searchVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        searchVc.delegate = golfVc;
        
        [self presentViewController:searchVc animated:YES completion:^{
            [searchVc.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        }];

       
    }else
    {
       
        MyController *myV = [[MyController alloc] initWithNibName:@"MyController" bundle:nil];
        myV.title = @"我的";
        [self.navigationController pushViewController:myV animated:YES];

    }
  
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    seqIndex = Seg.selectedSegmentIndex;
    
    switch (seqIndex) {
        case 0:
            NSLog(@"点击了0");
            [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
             [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateHighlighted];
            
            if(userCenterVc)
            {
                [userCenterVc removeFromParentViewController];
            }
           
            [self.view addSubview:golfVc.view];
            break;
        case 1:
            
            if(![ToolUtil isLogin])
            {
                LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
                [self presentViewController:navlogin animated:YES completion:nil];
                return;

            }
            [rightBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            [rightBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateHighlighted];
            if(golfVc)
            {
                [golfVc removeFromParentViewController];
            }
            userCenterVc.pViewController=self;
            [userCenterVc getUserInfo];
            [self.view addSubview:userCenterVc.view];
           

             NSLog(@"点击了1");
            break;
        default:
             NSLog(@"点击了default");
            break;
            
    }
    
}


//-(void)showVC1 {
//    if (vc2) {
//        [vc2.view removeFromSuperView];
//    }
//    
//    [self.view addSubView:vc1.view];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
