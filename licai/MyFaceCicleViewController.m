//
//  MyFaceCicleViewController.m
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "MyFaceCicleViewController.h"

@interface MyFaceCicleViewController ()

@end

@implementation MyFaceCicleViewController
@synthesize heightPickerView;
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
    [self addNavBack];
    [self.headerView initUI];
    [self.headerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    self.dataList=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    self.chartView  = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10,SCREEN_WIDTH-20,SCREEN_HEIGHT-220-kStatusHeight)
                                                    withSource:self
                                                     withStyle:UUChartLineStyle];
    
    [self.chartView showInView:self.lineView];
    
    
    heightPickerView = [[YearPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    heightPickerView.delegate = self;
    [self.view addSubview:heightPickerView];
    [heightPickerView setHidden:YES];
    
    self.yearText.text=[NSString stringWithFormat:@"%ld",[[NSDate date] year]];
    
    
    
    switch (self.type) {
        case FcFaceType:
            self.title=@"我的面子";
            [self getNetDataList:URL_MY_FACE];
            [self.headerView setLableText:@"0人" andDesc:@"(づ￣ 3￣)づ╭❤~脸大~怎么着"];
            break;
        case FcCicleType:
            self.title=@"我的圈子";
            [self.headerView setLableText:@"0人" andDesc:@"(๑ŐдŐ)b你的圈子也倍儿广了吧"];
            [self getNetDataList:URL_MY_COMMUNITY];
            break;
        default:
            break;
    }
    
    
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return [self getXTitles:12];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    return @[self.dataList];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
//- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
//{
//
//    return CGRangeMake(60, 0);;
//}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}



//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return NO;
}



- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"%d月",i+1];
        [xTitles addObject:str];
    }
    return xTitles;
}


-(void) getNetDataList:(NSString*)url
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject: self.yearText.text forKey:@"year"];
    
    [httpClient GET:url parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *list = (NSArray *)responseObject;
        //[self.banks addObjectsFromArray:[responstDic objectForKey:@"data"]];
        
        self.dataList=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        if(responseObject==nil)
        {
            [self showTextHUD:STR_NET_ERROR];
        }
        else
        {
            int sum=0;
            
            NSString *tkey=(self.type==FcFaceType)?@"totol":@"total";
            for (NSDictionary *object in list) {
                [self.dataList setObject:[object objectForKey:tkey] atIndexedSubscript:[[object objectForKey:@"month"] integerValue]-1];
                sum+=[[object objectForKey:tkey] integerValue];
            }
            if (self.chartView) {
                [self.chartView removeFromSuperview];
                self.chartView = nil;
            }
            
            self.chartView  = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10,SCREEN_WIDTH-20,SCREEN_HEIGHT-220-kStatusHeight)
                                                            withSource:self
                                                             withStyle:UUChartLineStyle];
            
            [self.chartView showInView:self.lineView];
            [self.headerView setCLableText:[NSString stringWithFormat:@"%d人",sum]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.dataList=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        
        if (self.chartView) {
            [self.chartView removeFromSuperview];
            self.chartView = nil;
        }
        
        
        
        self.chartView  = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10,SCREEN_WIDTH-20,SCREEN_HEIGHT-220-kStatusHeight)
                                                        withSource:self
                                                         withStyle:UUChartLineStyle];
        
        [self.chartView showInView:self.lineView];
        [self.headerView setCLableText:@"0人"];
        
        
        
        
    }];
}

- (IBAction)onClickSelectYear:(id)sender {
    [heightPickerView setHidden:NO];
    
}
-(void)onSelectYear:(NSString *)str
{
    self.yearText.text=str;
    
    switch (self.type) {
        case FcFaceType:
            [self getNetDataList:URL_MY_FACE];
            break;
        case FcCicleType:
            [self getNetDataList:URL_MY_COMMUNITY];
            break;
        default:
            break;
    }
    
}
@end
