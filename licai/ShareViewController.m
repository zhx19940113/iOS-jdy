//
//  ShareViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ShareViewController.h"
#import "AppDelegate.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize des1Label,des2Label,des3Label,detailsLabel,nameLabel,number1Label,number2Label,number3Label;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initUI
{
    UITapGestureRecognizer* shareFirendRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickShareFriend:)];
    self.wechatImageView.userInteractionEnabled=YES;
    [self.wechatImageView addGestureRecognizer:shareFirendRecognizer];
    
    UITapGestureRecognizer* shareCicleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickShareCicle:)];
    self.wechatFriendImageView.userInteractionEnabled=YES;
    [self.wechatFriendImageView addGestureRecognizer:shareCicleRecognizer];
    
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.shareVc=self;
    
    [self addLine:10 tox:290 y:230 toY:230 lineColor:[UIColor blackColor] mview:self.view];
    
    [self addLine:100
              tox:100
                y:240
              toY:280 lineColor:[UIColor blackColor] mview:self.view];
    
    [self addLine:200
              tox:200
                y:240
              toY:280 lineColor:[UIColor blackColor] mview:self.view];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)setProductBean:(ProductBean *)mBean
{
    self.product=mBean;
    nameLabel.text = mBean.name;
    detailsLabel.text = mBean.shareSubject;
    if([mBean.prodTypeName isEqualToString:@"银行类"] || [mBean.prodTypeName isEqualToString:@""])
    {
        des1Label.text = @"起购金额";
        des2Label.text = @"收益率";
        des3Label.text = @"存续期";
        
        // number1Label.text = mBean.minSubsAmount==nil ?@"" : ;
        
        if(mBean.minSubsAmount >0)
        {
            if(mBean.minSubsAmount>10000)
                number1Label.text = [NSString stringWithFormat:@"%0.2f万", mBean.minSubsAmount/10000];
            else
                number1Label.text = [NSString stringWithFormat:@"%0.2f", mBean.minSubsAmount];
        }
        
        if(mBean.expeAnnuRevnue >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2f", mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            
            number3Label.text = [NSString stringWithFormat:@"%0.2d", mBean.period];
        }
        
        
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"保险类"])
    {
        
        des1Label.text = @"保险类型";
        des2Label.text = @"期限";
        des3Label.text = @"发行公司";
        
        if(mBean.insuranceType !=nil)
        {
            number1Label.text = mBean.insuranceType;
        }
        
        if(mBean.period >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2d", mBean.period];
        }
        
        if(mBean.issuer !=nil)
        {
            number3Label.text = mBean.issuer;
        }
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"公募基金类"])
    {
        des1Label.text = @"认购最低限额";
        des2Label.text = @"基金管理人";
        des3Label.text = @"基金类型";
        
        
        if(mBean.minSubsAmount >0)
        {
            if(mBean.minSubsAmount>10000)
                number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
            else
                number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
        }
        
        if(mBean.fundDirector !=nil)
        {
            number2Label.text = mBean.fundDirector;
        }
        
        if(mBean.issuer !=nil)
        {
            number3Label.text = mBean.issuer;
        }
        
        
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"私募基金类"])
    {
        NSString *fundType = mBean.fundType;
        if([fundType isEqualToString:@"equity"])
        {
            des1Label.text = @"最低认购金额";
            des2Label.text = @"存续期";
            des3Label.text = @"管理人";
            
            if(mBean.minSubsAmount >0)
            {
                if(mBean.minSubsAmount>10000)
                    number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                    number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
            }
            
            if(mBean.period >0)
            {
                number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
            }
            
            if(mBean.fundDirector !=nil)
            {
                number3Label.text = mBean.fundDirector;
            }
        }else if([fundType isEqualToString:@"claim"]){
            des1Label.text = @"预期收益";
            des2Label.text = @"存续期";
            des3Label.text = @"投资方向";
            
            if(mBean.expeAnnuRevnue >0)
            {
                number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
            
            if(mBean.period >0)
            {
                number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
            }
            
            if(mBean.investDirection !=nil)
            {
                number3Label.text = mBean.investDirection;
            }
        }else if([fundType isEqualToString:@"stock"]){
            des1Label.text = @"认购金额";
            des2Label.text = @"管理人";
            des3Label.text = @"最高收益";
            
            if(mBean.minSubsAmount >0)
            {
                if(mBean.minSubsAmount>10000)
                    number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                    number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
                
            }
            
            if(mBean.fundDirector !=nil)
            {
                number2Label.text = mBean.fundDirector;
            }
            
            if(mBean.expeAnnuRevnue >0)
            {
                number3Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
        }else if([fundType isEqualToString:@"exchange"] || [fundType isEqualToString:@"bond"] || [fundType isEqualToString:@"derivative"]){
            des1Label.text = @"认购金额";
            des2Label.text = @"管理人";
            des3Label.text = @"最高收益";
            
            if(mBean.minSubsAmount >0)
            {
                if(mBean.minSubsAmount>10000)
                    number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                    number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
                
            }
            
            if(mBean.fundDirector !=nil)
            {
                number2Label.text = mBean.fundDirector;
            }
            
            if(mBean.expeAnnuRevnue >0)
            {
                number3Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
        }
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"信托类"] || [mBean.prodTypeName isEqualToString:@"资管类"])
    {
        des1Label.text = @"投资方向";
        des2Label.text = @"预期收益";
        des3Label.text = @"存续期";
        
        if(mBean.investDirection !=nil)
        {
            number1Label.text = mBean.investDirection;
        }
        
        if(mBean.expeAnnuRevnue >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            number3Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
        }
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"债权众筹类"])
    {
        //        textView5.setText("预期收益");
        //
        //        textView2.setText(String.valueOf(listViewProductEntitiesList
        //                                         .get(position).getExpeAnnuRevnue()) == "null" ? ""
        //                          : String.valueOf(listViewProductEntitiesList.get(
        //                                                                           position).getExpeAnnuRevnue()));
        //
        //        textView6.setText("存续期");
        //
        //        textView3.setText(String.valueOf(listViewProductEntitiesList
        //                                         .get(position).getPeriod()) == "null" ? "" : String
        //                          .valueOf(listViewProductEntitiesList.get(position)
        //                                   .getPeriod()));
        //
        //        textView7.setText("管理人");
        //
        //        textView4.setText(String.valueOf(listViewProductEntitiesList
        //                                         .get(position).getFundDirector()) == "null" ? ""
        //                          : String.valueOf(listViewProductEntitiesList.get(
        //                                                                           position).getFundDirector()));
        
        des1Label.text = @"预期收益";
        des2Label.text = @"存续期";
        des3Label.text = @"管理人";
        
        if(mBean.expeAnnuRevnue >0)
        {
            number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
        }
        
        if(mBean.fundDirector !=nil)
        {
            number3Label.text = mBean.fundDirector;
        }
    }
    
    if([mBean.prodTypeName isEqualToString:@"股权众筹类"])
    {
        des1Label.text = @"管理人";
        des2Label.text = @"投资方向";
        des3Label.text = @"认购金额";
        
        if(mBean.fundDirector !=nil)
        {
            number1Label.text = mBean.fundDirector;
        }
        
        if(mBean.investDirection !=nil)
        {
            number2Label.text = mBean.investDirection;
        }
        
        if(mBean.minSubsAmount >0)
        {
            if(mBean.minSubsAmount>10000)
                number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
            else
                number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
            
        }
    }
    
    
    
    
    
    
}


-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.2f;
    lineShape.lineCap = kCALineCapRound;
    if(color==nil)
        lineShape.strokeColor = [UIColor whiteColor].CGColor;
    else lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [mview.layer addSublayer:lineShape];
}

@end
