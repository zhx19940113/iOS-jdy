//
//  BaseViewController.m
//  pinche
//
//  Created by 钟惠雄 on 14-3-14.
//  Copyright (c) 2014年 qiyiyi. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()
   
@end

#import "AppDelegate.h"
@implementation BaseViewController

@synthesize _navView,_backBtn,_titleLabel,_rightLabel,notificationKey,netTypes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                imageView.hidden=YES;
                
            }
            
        }
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
        
        imageView.image=[self createImageWithColor:[UIColor colorWithRed:0.30 green:0.68 blue:0.99 alpha:1]];
        
        [self.navigationController.navigationBar addSubview:imageView];
        
        [self.navigationController.navigationBar sendSubviewToBack:imageView];
        

    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    netTypes=[[NSSet alloc] initWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",nil];

     self.navigationController.navigationBar.translucent = NO;
    //设置返回按钮颜色
  //  [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    //设置标题颜色
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    //  [barAttrs setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [self.navigationController.navigationBar setTitleTextAttributes:barAttrs];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.27 green:0.67 blue:1.0 alpha:1.0];
   
}

//设置空数据是否隐藏
-(void) setEmptyHidden:(BOOL)isHidden
{
    [[self.view viewWithTag:1000] setHidden:isHidden];
}

//设置空数据文字
-(void) setEmptyText:(NSString*)text
{
    [((UILabel*)[[self.view viewWithTag:1000] viewWithTag:1001]) setText:text];
}
//设置空数据位置
-(void) initEmptyViewWithFrame:(CGRect)frame
{
    
    //初始化空数据视图
    UIView *noDataView=[[UIView alloc] initWithFrame:frame];
    UILabel *notext=[[UILabel alloc] initWithFrame:CGRectMake(0,noDataView.frame.size.height/2+15, noDataView.frame.size.width,20)];
    notext.text=@"无任何消息";
    [notext setTextColor:[UIColor grayColor]];
    [notext setTag:1001];
    [notext setFont:[UIFont systemFontOfSize:13]];
    [notext setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *noimage=[[UIImageView alloc] initWithFrame:CGRectMake(noDataView.frame.size.width/2-45,noDataView.frame.size.height/2-90,90,90)];
    [noimage setImage:[UIImage imageNamed:@"fig11"]];
    [noimage setTag:1002];
    
    [noDataView addSubview:notext];
    [noDataView addSubview:noimage];
    [noDataView setTag:1000];
    [noDataView setHidden:YES];
    [noDataView setBackgroundColor:[UIColor colorWithWhite:0.93 alpha:1.0]];
    [self.view addSubview:noDataView];
  
  
}

-(void)addNavBack
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 24, 50, 50)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];

}

-(void)setNavTitle:(NSString *)title
{
    CGRect rect = CGRectMake(SCREEN_WIDTH/2-100, 0, 150, 44);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:rect];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.navigationItem setTitleView:titleLabel];
}


-(void)showHUD{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在努力加载中...";
}
-(MBProgressHUD *)showHUD:(NSString *)msg {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = msg;
    return HUD;
}
-(void)hideHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showTextHUD:(NSString *)text{
//     AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    HUD = [[MBProgressHUD alloc] initWithWindow:appDelegate.window];
//    [appDelegate.window addSubview:HUD];
//    HUD.labelText = text;
//    HUD.mode = MBProgressHUDModeText;
//    
//    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
//    //    HUD.yOffset = 150.0f;
//    //    HUD.xOffset = 100.0f;
//    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(1.5);
//    } completionBlock:^{
//        [HUD removeFromSuperview];
//        // [HUD release];
//        HUD = nil;
//    }];
  //  [self.view makeToast:text];
    
    
       [self.view makeToast:text duration:1.0 position:[NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width/2, SCREEN_HEIGHT - 100)]];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

-(float )boolLabelLength:(NSString *)strString{
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    CGSize labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(99999, 60)lineBreakMode:NSLineBreakByCharWrapping];
    return labsize.width;
    
}

-(void)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)hideKeyboard{
    [[[UIApplication sharedApplication] keyWindow]endEditing:YES];
}

#pragma mark UITextFieldDelegage
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}


- (void)showTextDialog:(NSString *)text {
    //初始化进度框，置于当前的View当中
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
   // HUD.dimBackground = NO;
    HUD.mode = MBProgressHUDModeText;
    //设置对话框文字
//    HUD.labelText = text;
    HUD.detailsLabelText = text;
    
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(1);
    } completionBlock:^{
        //操作执行完后取消对话框
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}
/**
 *	@brief	添加直线
 *
 *	@param 	x 	<#x description#>
 *	@param 	toX 	<#toX description#>
 *	@param 	y 	<#y description#>
 *	@param 	toY 	<#toY description#>
 *	@param 	color 	<#color description#>
 */
-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.3f;
    lineShape.lineCap = kCALineCapRound;
    if(color==nil)
        lineShape.strokeColor = [UIColor whiteColor].CGColor;
    else lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [self.view.layer addSublayer:lineShape];
}


-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.3f;
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


-(void)addLineWithWidth:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color width:(float)width
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth =width;
    lineShape.lineCap = kCALineCapRound;
    if(color==nil)
        lineShape.strokeColor = [UIColor whiteColor].CGColor;
    else lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [self.view.layer addSublayer:lineShape];
}

-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview width:(float)width
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth =width;
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


-(CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {
        return CGSizeMake(800, 800 * height / width);
    }
    else
    {
        return CGSizeMake(800 * width / height, 800);
    }
}

-(void)enterLoginVc{

    AFTER_MAIN(0.5, ^{
//        [self clear];
//        NSLog(@"enterLoginVc");
//        LoginViewController *loginV = [[LoginViewController alloc] init];
//        UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:loginV];
//        [self presentViewController:navControl animated:YES completion:nil];
    });
   
   
}







- (UIColor *)getColor:(NSString*)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;

}

-(void)onClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark Set Event
//-(void) onRegEvent:(NSString*)eventName block:(EventBlock) block
//{
//     NSLog(@"reg event%@",eventName);
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//   [defaultCenter addObserver:self selector:@selector(onEvent:) name:eventName object:nil];
//   [self setEventBlock:block forKey:&kEventBlockKey];
//   self.notificationKey=eventName;
//    
//}

//- (void)onEvent:(NSNotification *)notification {
//    NSLog(@"go event");
//    NSDictionary * userInfo = [notification userInfo];
//    EventBlock block = objc_getAssociatedObject(self, &kEventBlockKey);
//    if(block)
//    block(userInfo);
//}

//-(void) sendEvent:(NSString*)eventName data:(NSDictionary*) info
//{
//     NSLog(@"send event%@",eventName);
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter postNotificationName:eventName object:self userInfo:info];
//}

#pragma mark -
#pragma mark Set blocks
//- (void)setEventBlock:(EventBlock)block forKey:(void *)blockKey {
//    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
-(void) dealloc
{
    if(notificationKey!=nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationKey object:nil];
         NSLog(@"%@",notificationKey);
    }
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
