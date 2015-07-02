//
//  MyFaceOrderViewController.m
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "MyFaceOrderViewController.h"

@interface MyFaceOrderViewController ()

@end

@implementation MyFaceOrderViewController
@synthesize headcell;
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
    
    self.datalist=[[NSMutableArray alloc] init];
    [self.headerView initUI];
    [self.headerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    if(self.type==OrderType)
    {
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
        [rightBtn addTarget:self action:@selector(onClickAdd:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setImage:[UIImage imageNamed:@"feedback"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"feedback"] forState:UIControlStateHighlighted];
        
        UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightBtnItem;
    }
    
    switch (self.type) {
        case FaceType:
            self.title=@"我的面值";
            [self.datalist addObject:@{@"row1":@"转发产品",@"row2":@"获取红包",@"row3":@"日期"}];
            [self getNetDataList:URL_USER_FACE_VALUE];
            [self.headerView setLableText:@"0元" andDesc:@"╮(╯▽╰ )╭ 有钱、有面~就是任性！~" ];
            break;
        case OrderType:
            
            
            self.title=@"我的订单";
            [self.datalist addObject:@{@"row1":@"购买产品",@"row2":@"购买金额",@"row3":@"购买日期"}];
            [self getNetDataList:URL_MY_ORDER];
            [self.headerView setLableText:@"0元" andDesc:@"(￣ˇ￣)/购买多多省钱" ];
            break;
        case WithdrawCashType:
            self.title=@"提现记录";
            [self.datalist addObject:@{@"row1":@"提现金额",@"row2":@"提现时间",@"row3":@"提现操作"}];
            [self getNetDataList:URL_MY_RECORD];
             [self.headerView setLableText:@"0元" andDesc:@"O(∩_∩)O钱越多，拿越多，就是这么任性" ];
            break;
        default:
            break;
    }
    
    
    //设置头
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FaceTableViewCell" owner:self options:nil];
    for(id oneObject in nib){
        if([oneObject isKindOfClass:[FaceTableViewCell class]]){
            headcell = (FaceTableViewCell *)oneObject;
        }
    }
    
    
    [headcell.row1 setTextColor:[UIColor colorWithRed:0.93 green:0.42 blue:0.39 alpha:1.0]];
    [headcell.row2 setTextColor:[UIColor colorWithRed:0.93 green:0.42 blue:0.39 alpha:1.0]];
    [headcell.row3 setTextColor:[UIColor colorWithRed:0.93 green:0.42 blue:0.39 alpha:1.0]];
    
    [headcell.bottomLine setHidden:NO];
    
    
    NSDictionary *data=[self.datalist objectAtIndex:0];
    headcell.row1.text=[data objectForKey:@"row1"];
    headcell.row2.text=[data objectForKey:@"row2"];
    headcell.row3.text=[data objectForKey:@"row3"];
    
    [headcell.contentView setFrame:CGRectMake(0, 150, SCREEN_WIDTH, 55)];
    [self.view  addSubview: headcell.contentView];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
    
}



-(void) onClickAdd:(id) sender
{
        OrderFeedBackViewController  *settingVc=[[OrderFeedBackViewController alloc] initWithNibName:@"OrderFeedBackViewController" bundle:nil];
        [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdetify = @"tablecell";
    FaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if(!cell){
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FaceTableViewCell" owner:self options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[FaceTableViewCell class]]){
                cell = (FaceTableViewCell *)oneObject;
            }
        }
        
        if(indexPath.row%2==0)
        {
            [cell setBackgroundColor:[UIColor colorWithRed:0.95 green:0.96 blue:0.98 alpha:1.0]];
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row+2==self.datalist.count)
    {
        [cell.bottomLine setHidden:NO];
    }
    else [cell.bottomLine setHidden:YES];
    
    NSDictionary *data=[self.datalist objectAtIndex:indexPath.row+1];
    
    cell.row1.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"row1"]];
    cell.row2.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"row2"]];
    cell.row3.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"row3"]];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
    
    return cell;
}


-(void) getNetDataList:(NSString*)url
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    
    
    [httpClient POST:url parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        //[self.banks addObjectsFromArray:[responstDic objectForKey:@"data"]];
        
        
        if(responseObject==nil)
        {
            [self showTextHUD:STR_NET_ERROR];
        }
        else
        {
            double sum=0;
            
            NSArray *list;
            
            
            
            switch (self.type) {
                case OrderType:
                list=[responstDict objectForKey:@"data"];
                
                if(![[responstDict objectForKey:@"sum"] isEqual:[NSNull null]])
                {
                    sum=[[responstDict objectForKey:@"sum"] doubleValue];
                }
                
                
                for (NSDictionary *object in list) {
                    [self.datalist addObject:@{@"row1":[object objectForKey:@"name"],@"row2":[NSString stringWithFormat:@"+%@",[object objectForKey:@"investTotal"]],@"row3":[[[object objectForKey:@"create_time"] replaceCharcter:@"-" withCharcter:@"/"] substringToIndex:10]}];
                }
                
               
                
                [self.headerView setCLableText:[NSString stringWithFormat:@"%.2f元",sum]];
                 break;
                case FaceType:
                    //                    time;
                    //                    private String name;
                    //                    private String money;
                    list=[responstDict objectForKey:@"data"];
                    
                    if(![[responstDict objectForKey:@"sum"] isEqual:[NSNull null]])
                    {
                        sum=[[responstDict objectForKey:@"sum"] doubleValue];
                    }
                    
                    
                    for (NSDictionary *object in list) {
                        
                         [self.datalist addObject:@{@"row1":[object objectForKey:@"name"],@"row2":[NSString stringWithFormat:@"+%@",[object objectForKey:@"income"]],@"row3":[[[object objectForKey:@"create_time"] replaceCharcter:@"-" withCharcter:@"/"] substringToIndex:10]}];
                    }
                    
                    
                   
                    [self.headerView setCLableText:[NSString stringWithFormat:@"%.2f元",sum]];
                    
                    break;
                case WithdrawCashType:
                    //                    applyTime = "2015-02-07";
                    //                    finaExamState = 0;
                    //                    servExamState = 0;
                    //                    statuts = "\U63d0\U73b0\U5ba1\U6838\U4e2d";
                    //                    tranAccoState = 0;
                    //                    withdCash = "10.9";
                    
                    list=[responstDict objectForKey:@"list"];
                    
                    if(![[responstDict objectForKey:@"moneySum"] isEqual:[NSNull null]])
                    {
                        sum=[[responstDict objectForKey:@"moneySum"] doubleValue];
                    }
                    
                    
                    for (NSDictionary *object in list) {
                        [self.datalist addObject:@{@"row1":[NSString stringWithFormat:@"+%@",[object objectForKey:@"withdCash"]],@"row2":[[object objectForKey:@"applyTime"] replaceCharcter:@"-" withCharcter:@"/"],@"row3":[object objectForKey:@"statuts"]}];
                    }
                    
                    
                    [self.headerView setCLableText:[NSString stringWithFormat:@"%.2f元",sum]];
                    break;
                default:
                    break;
            }
            
            
            if(list.count==0)
            {
                [headcell.bottomLine setHidden:NO];
            }
            else [headcell.bottomLine setHidden:YES];
            
            
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      //  [self showTextHUD:STR_NET_ERROR];
        NSLog(@"%@",error);
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55;
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
