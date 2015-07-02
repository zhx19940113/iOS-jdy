//
//  ProductDesViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ProductDesViewController.h"

@interface ProductDesViewController ()

@end

@implementation ProductDesViewController{
    
    
    UITableView *mTableView;
    
    NSMutableArray *nameKeyArray;
    NSDictionary *product1;
    NSDictionary *product2;
    UILabel *label1;
    UILabel *label2;
    UIImageView *topImageView ;
    UIWebView *footerWebView;
    
}
@synthesize PARAMS_PRODUCT_ID,PARAMS_PRODUCT_TYPE;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBack];
    topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4+60)];
    [topImageView setImage:[UIImage imageNamed:@"user_bg"]];
    
    
    UIImageView *typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/4-70+60, 60, 60)];
    [typeImageView setImage:[UIImage imageNamed:@"type"]];
    
    [topImageView addSubview:typeImageView];
    
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(typeImageView.frame.origin.x+typeImageView.frame.size.width + 30, SCREEN_HEIGHT/4-70+60, SCREEN_WIDTH/3, 40)];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setFont:[UIFont fontWithName:FontWord size:25]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [topImageView addSubview:label1];
    
    UILabel *label1Des = [[UILabel alloc] initWithFrame:CGRectMake(typeImageView.frame.origin.x+typeImageView.frame.size.width + 30, SCREEN_HEIGHT/4-30+60, SCREEN_WIDTH/3, 20)];
    [label1Des setTextAlignment:NSTextAlignmentCenter];
    label1Des.text = @"预计最高收益率";
    [label1Des setFont:[UIFont fontWithName:FontWord size:14]];
    label1Des.textColor = [UIColor whiteColor];
    [topImageView addSubview:label1Des];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width + 25, SCREEN_HEIGHT/4-70+60, SCREEN_WIDTH/3-15, 40)];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setFont:[UIFont fontWithName:FontWord size:25]];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [topImageView addSubview:label2];
    
    UILabel *label2Des = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width + 30, SCREEN_HEIGHT/4-30+60, SCREEN_WIDTH/3-30, 20)];
    label2Des.text = @"起购金额";
    [label2Des setTextAlignment:NSTextAlignmentCenter];
    [label2Des setFont:[UIFont fontWithName:FontWord size:14]];
    label2Des.textColor = [UIColor whiteColor];
    [topImageView addSubview:label2Des];
    
    
    [super addLine:label1.frame.origin.x-10 tox:label1.frame.origin.x-10 y:label1.frame.origin.y+10 toY:label1.frame.origin.y+label1.frame.size.height+10 lineColor:[UIColor whiteColor] mview:topImageView width:1.0f];
    
    [super addLine:label1Des.frame.origin.x + label1Des.frame.size.width+10 tox:label1Des.frame.origin.x + label1Des.frame.size.width+10  y:label1.frame.origin.y+10 toY:label1.frame.origin.y+label1.frame.size.height+10 lineColor:[UIColor whiteColor] mview:topImageView width:1.0f];
    
    mTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusHeight)];
    mTableView.dataSource = self;
    mTableView.delegate = self;
    if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    
    
    
    [mTableView setTableHeaderView:topImageView];
    
    footerWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [[[footerWebView subviews] lastObject] setScrollEnabled:NO];
    footerWebView.delegate = self;
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_BASE,URL_PRODUCT_WEBVIEW,PARAMS_PRODUCT_ID]]];
//    [footerWebView loadRequest:urlRequest];
    [mTableView setTableFooterView:footerWebView];
    
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 0, 28, 28) ;
    [btn1 setImage:[UIImage imageNamed:@"bar_buy"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"bar_buy"] forState:UIControlStateHighlighted];
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 28, 28) ;
    [btn2  setImage:[UIImage imageNamed:@"bar_share"] forState:UIControlStateNormal];
    [btn2  setImage:[UIImage imageNamed:@"bar_share"] forState:UIControlStateHighlighted];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithCustomView:btn1];
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];
    NSArray *rightBtns=[NSArray arrayWithObjects:barBtn1,barBtn2, nil];
    self.navigationItem.rightBarButtonItems = rightBtns;
    
    
    [btn1 addTarget:self action:@selector(onClickBarItem1:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(onClickBarItem2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mTableView];
    [mTableView setDataSource:self];
    [self showHUD:@"加载中"];
    [self netGetTopicList];
    [self addNavBack];
}


- (void)webViewDidFinishLoad:(UIWebView *) webView
{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    footerWebView.frame = newFrame;
    
    
    
    [self setTableViewHeight];
}

#pragma mark--tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [nameKeyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"MyFriendCell");
    static NSString *CellIdentifier = @"ProductDesTableViewIdentifier";
    ProductDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDesTableViewCell" owner:self options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[ProductDesTableViewCell class]]){
                cell = (ProductDesTableViewCell *)oneObject;
            }
        }
    }
    
    if(indexPath.row %2==0)
    {
        cell.backgroundColor = [UIColor whiteColor];
      //  cell.nameLabel.backgroundColor = [UIColor whiteColor];
        //cell.desLabel.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = COLOR_GRAY_LIGHT;
       // cell.nameLabel.backgroundColor = COLOR_GRAY_LIGHT;
       // cell.desLabel.backgroundColor = COLOR_GRAY_LIGHT;
         cell.contentView.backgroundColor = COLOR_GRAY_LIGHT;
    }
    
    NSString *keyStr =  [[[nameKeyArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    cell.nameLabel.text = keyStr;
    if(keyStr!=nil)
    {
        NSString *valueStr = [[nameKeyArray objectAtIndex:indexPath.row] objectForKey:keyStr];
        if(valueStr!=nil)
        {
            if([valueStr isKindOfClass:[NSNumber class]])
            {
                valueStr = [NSString stringWithFormat:@"%@",valueStr];
            }
            
            cell.desLabel.text = valueStr;
            
            
            if([keyStr isEqualToString:@"发行方logo"] || [keyStr isEqualToString:@"产品图片"])
            {
                cell.desLabel.hidden = YES;
                cell.iconImageView.hidden = NO;
                [cell.iconImageView setImageURLStr:[NSString stringWithFormat:@"%@%@",URL_BASE,valueStr] placeholder:nil];
            }else
            {
                cell.desLabel.hidden = NO;
                cell.iconImageView.hidden = YES;
                
            }
            
            
        }
        
        
    }
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

#pragma mark--网络请求
-(void) netGetTopicList
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    NSString *urlString = [URL_PRODUCT_DETAILS stringByAppendingString:[NSString stringWithFormat:@"/%@-%@",PARAMS_PRODUCT_ID,PARAMS_PRODUCT_TYPE]] ;//朋友圈
    
    NSLog(@"url%@",urlString);
    task = [httpClient GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        NSLog(@"jsonaa%@",responstDict);
        if (responstDict==nil) {
            [self showTextHUD:@"网络错误"];
        }else{
            
            product1 = [responstDict objectForKey:@"product1"];
            product2 = [responstDict objectForKey:@"product2"];
            
             if([product1 objectForKey:@"expeAnnuRevnue"]!=nil && ![[product1 objectForKey:@"expeAnnuRevnue"]  isEqualToString:@"null"])
            label1.text = [NSString stringWithFormat:@"%@%%",[product1 objectForKey:@"expeAnnuRevnue"]];
            else label1.text = @"";
            if([product1 objectForKey:@"minSubsAmount"]!=nil && ![[product1 objectForKey:@"minSubsAmount"]  isEqualToString:@"null"])
            {
                if([[product1 objectForKey:@"minSubsAmount"] intValue]>10000)
                 label2.text = [NSString stringWithFormat:@"%0.0f万",[[product1 objectForKey:@"minSubsAmount"] intValue]/10000.0];
                else
                {
                    label2.text = [NSString stringWithFormat:@"%0.0f",[[product1 objectForKey:@"minSubsAmount"] integerValue] /1.0];
                }
            }
            else label2.text = @"";
            
            [self parseJSON];
            if(product1!=nil)
            {
                
                
                
                MAIN((^{
                    [self setTableViewHeight];
                    [mTableView reloadData];
                    [self hideHUD];
                    
                    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_BASE,URL_PRODUCT_WEBVIEW,PARAMS_PRODUCT_ID]]];
                    [footerWebView loadRequest:urlRequest];
                    
                }));
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure=========%@",[error description
                                     ]);
    }];
    
    
    
}

-(void)setTableViewHeight
{
    mTableView.contentSize = CGSizeMake(SCREEN_WIDTH,topImageView.frame.size.height + [nameKeyArray count] * 60 + footerWebView.frame.size.height+130);
}

-(void)parseJSON
{
    
    nameKeyArray = [[NSMutableArray alloc] init];
    [self addFildedItem:YES str:@"产品名称" name:@"name"];
    [self addFildedItem:YES str:@"发行方" name:@"issuer"];
    [self addFildedItem:YES str:@"发行方类型" name:@"issuerTypeName"];
    [self addFildedItem:YES str:@"发行方logo" name:@"issuerLogo"];
    [self addFildedItem:YES str:@"产品图片" name:@"prodImage"];
    
    NSString *prdType = [product1 objectForKey:@"prodTypeCode"];
    
    if([prdType isEqualToString:@"bank"])
    {
        [self addFildedItem:false str:@"认购费" name:@"subsFee"];
        [self addFildedItem:false str:@"产品类型" name:@"prodType"];
        [self addFildedItem:false str:@"委托起始金额" name:@"entrustLimit"];
        [self addFildedItem:false str:@"委托金额递增单" name:@"entrustIncrease"];
    }else if([prdType isEqualToString:@"insurance"])
    {
     //   [self addFildedItem:false str:@"收益类型" name:@"profitType"];
        [self addFildedItem:false str:@"保本类型" name:@"breakEven"];
        [self addFildedItem:false str:@"赎回到账时间" name:@"backDate"];
        [self addFildedItem:false str:@"适用人群" name:@"suitablePeople"];
        
    }else if([prdType isEqualToString:@"pubFunds"])
    {
        
        [self addFildedItem:false str:@"基本简称" name:@"shortName"];
        [self addFildedItem:false str:@"最新净值" name:@"newestWorth"];
        [self addFildedItem:false str:@"累计净值" name:@"totalWorth"];
        [self addFildedItem:false str:@"基金代码" name:@"fundCode"];
        [self addFildedItem:false str:@"预期收益" name:@"expectProfit"];
        [self addFildedItem:false str:@"基金经理" name:@"fundManager"];
        [self addFildedItem:false str:@"成立日期" name:@"createDate"];
        [self addFildedItem:false str:@"首次募集规模" name:@"firstRaise"];
        [self addFildedItem:false str:@"最新基金规模" name:@"newestRaise"];
        [self addFildedItem:false str:@"申赎状态" name:@"applyAtoneStatus"];
        [self addFildedItem:false str:@"申赎状态名称" name:@"applyAtoneTypeName"];
        [self addFildedItem:false str:@"申购费率" name:@"applyRate"];
        [self addFildedItem:false str:@"赎回费率" name:@"atoneRate"];
        [self addFildedItem:false str:@"管理费率" name:@"manageRate"];
        [self addFildedItem:false str:@"投资目标" name:@"investTarget"];
        [self addFildedItem:false str:@"资产组合比例" name:@"captialRate"];
        [self addFildedItem:false str:@"收益分配原则" name:@"profitPrinciple"];
        
        
        
    }else if([prdType isEqualToString:@"priFunds"])
    {
        
        [self addFildedItem:false str:@"基本简称" name:@"shortName"];
         [self addFildedItem:false str:@"单位净值" name:@"unitWorth"];
        [self addFildedItem:false str:@"最新净值" name:@"newestWorth"];
        [self addFildedItem:false str:@"累计净值" name:@"totalWorth"];
        [self addFildedItem:false str:@"成立日期" name:@"createDate"];
        [self addFildedItem:false str:@"开放日" name:@"openDate"];
        [self addFildedItem:false str:@"到期日" name:@"endDate"];
        [self addFildedItem:false str:@"封闭期" name:@"closedPeriod"];
        [self addFildedItem:false str:@"准封闭期限" name:@"standClosedPeriod"];
        [self addFildedItem:false str:@"认购费率" name:@"subsRate"];
        [self addFildedItem:false str:@"管理费率" name:@"manageRate"];
        [self addFildedItem:false str:@"赎回费率" name:@"redemptionRate"];
        [self addFildedItem:false str:@"托管银行" name:@"depositBank"];
        [self addFildedItem:false str:@"浮动管理费率" name:@"unstableRate"];
        [self addFildedItem:false str:@"追加最低认购" name:@"limitBuy"];
        [self addFildedItem:false str:@"发行地区" name:@"pubArea"];
        [self addFildedItem:false str:@"投资策略" name:@"investTactics"];
        [self addFildedItem:false str:@"基金规模" name:@"fundScope"];
        
      
        ///===
        
    }else if([prdType isEqualToString:@"trust"])
    {
        
        
        [self addFildedItem:false str:@"信托类型" name:@"trustType"];
      //  [self addFildedItem:false str:@"收益类型" name:@"profitDistribution"];
        [self addFildedItem:false str:@"发售日期" name:@"saleDate"];
        [self addFildedItem:false str:@"发行地区" name:@"pubArea"];
        [self addFildedItem:false str:@"项目所在地" name:@"projectArea"];
        
    }else if([prdType isEqualToString:@"captManage"])
    {
        
        [self addFildedItem:false str:@"资管类型" name:@"capType"];
     //   [self addFildedItem:false str:@"收益类型" name:@"profitDistribution"];
        [self addFildedItem:false str:@"发售日期" name:@"saleDate"];
        [self addFildedItem:false str:@"发行地区" name:@"pubArea"];
        [self addFildedItem:false str:@"项目所在地" name:@"pubArea"];
    }else if([prdType isEqualToString:@"credit"])
    {
        
        [self addFildedItem:false str:@"借款目的" name:@"borrowPurpose"];
        [self addFildedItem:false str:@"标的总额" name:@"targetTotal"];
        [self addFildedItem:false str:@"还款期限" name:@"repayPeriod"];
        [self addFildedItem:false str:@"还款方式" name:@"ensureType"];
        [self addFildedItem:false str:@"还款协议" name:@"repaymentType"];
        [self addFildedItem:false str:@"借款协议" name:@"borrowProtocol"];
        [self addFildedItem:false str:@"项目所在地" name:@"projectArea"];
    }else if([prdType isEqualToString:@"equity"])
    {
        
        [self addFildedItem:false str:@"借款目的" name:@"borrowPurpose"];
        [self addFildedItem:false str:@"标的总额" name:@"targetTotal"];
        [self addFildedItem:false str:@"还款期限" name:@"repayPeriod"];
        [self addFildedItem:false str:@"保障方式" name:@"ensureType"];
        [self addFildedItem:false str:@"还款方式" name:@"repaymentType"];
        [self addFildedItem:false str:@"借款协议" name:@"borrowProtocol"];
        [self addFildedItem:false str:@"项目所在地" name:@"projectArea"];
    }
    
    
    
    [self addFildedItem:YES str:@"期限" name:@"period"];
    [self addFildedItem:YES str:@"预期年化收益" name:@"expeAnnuRevnue"];
    [self addFildedItem:YES str:@"最低认购金额&起购金额" name:@"minSubsAmount"];
    [self addFildedItem:YES str:@"收益类型名称" name:@"profitTypeName"];
    [self addFildedItem:YES str:@"币种" name:@"currencyTypeName"];
    [self addFildedItem:YES str:@"产品状态" name:@"statusName"];
    
    
    if([product1 objectForKey:@"saleStart"]!=nil && ![[product1 objectForKey:@"saleStart"] isEqual:[NSNull null]] && ![[product1 objectForKey:@"saleStart"]  isEqualToString:@"null"])
    {
        
        [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[product1 objectForKey:@"saleStart"],@"销售开始日期", nil]];
    }
    
    if([product1 objectForKey:@"saleEnd"]!=nil && ![[product1 objectForKey:@"saleEnd"] isEqual:[NSNull null]] && ![[product1 objectForKey:@"saleEnd"]  isEqualToString:@"null"])
    {
        [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[product1 objectForKey:@"saleEnd"],@"销售结束日期", nil]];
    }
    
    [self addFildedItem:YES str:@"参考最高收益" name:@"topGain"];
    
    if([product1 objectForKey:@"profitStart"]!=nil && ![[product1 objectForKey:@"profitStart"] isEqual:[NSNull null]] && ![[product1 objectForKey:@"profitStart"]  isEqualToString:@"null"])
    {

        [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[product1 objectForKey:@"profitStart"],@"收益开始日期", nil]];
    }
    
    if([product1 objectForKey:@"profitEnd"]!=nil && ![[product1 objectForKey:@"profitEnd"] isEqual:[NSNull null]] && ![[product1 objectForKey:@"profitEnd"]  isEqualToString:@"null"])
    {
        [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[product1 objectForKey:@"profitEnd"],@"收益结束日期", nil]];
    }
    
    
    
    
    [self addFildedItem:YES str:@"明细类型" name:@"detailType"];
    [self addFildedItem:YES str:@"基金类型" name:@"fundType"];
    [self addFildedItem:YES str:@"基金管理人" name:@"fundDirector"];
    [self addFildedItem:YES str:@"保险类型" name:@"insuranceType"];
    [self addFildedItem:YES str:@"投资方向" name:@"investDirection"];
    [self addFildedItem:YES str:@"库存" name:@"stock"];
    
    
}


-(void) addFildedItem:(BOOL) isProudct1 str:(NSString *)title name:(NSString *)fieldName
{
    if(isProudct1)
    {
        NSString *value = (NSString *)[product1 objectForKey:fieldName];
        
        if([value isKindOfClass:[NSNumber class]])
        {
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            value = [numberFormatter stringFromNumber:(NSNumber *)value];
        }
        if(value!=nil && ![value isEqualToString:@"null"] && ![value isEqualToString:@""])
            [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:value,title, nil]];
        
    }else
    {
        if(product2!=nil)
        {
            NSString *value =(NSString *)[product2 objectForKey:fieldName];
            if([value isKindOfClass:[NSNumber class]])
            {
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                value = [numberFormatter stringFromNumber:(NSNumber *)value];
            }
            if(value!=nil && ![value isEqualToString:@"null"] && ![value isEqualToString:@""])
                [nameKeyArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:value,title, nil]];
            
        }
        
    }
}


-(void)onClickBarItem1:(id)sender
{
    if(![ToolUtil isLogin])
    {
        LoginViewController *loginV = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navlogin=[[UINavigationController alloc] initWithRootViewController:loginV];
        [self presentViewController:navlogin animated:YES completion:nil];
        return;
        
    }
    else
    {
        DisCountViewController *detailViewController = [[DisCountViewController alloc] init];
        detailViewController.productId = [NSString stringWithFormat:@"%@",[product1 objectForKey:@"ID"]];
        [self presentPopupViewController:detailViewController animationType:0];
    }
}

-(void)onClickBarItem2:(id)sender
{
    Share2ViewController *detailViewController = [[Share2ViewController alloc] init];
    detailViewController.product=self.product;
    [self presentPopupViewController:detailViewController animationType:0];
    
}

@end
