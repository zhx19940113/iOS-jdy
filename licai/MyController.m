//
//  MyController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/9.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "MyController.h"

@interface MyController ()

@end

@implementation MyController
{
    int PAGE;
    NSMutableArray *productBeans;
    NSString *mUrlStr;
    NSString *mKeyword;
}
@synthesize mTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    PAGE = 1;
    mUrlStr = URL_SAVE_LIST;
     productBeans = [[NSMutableArray alloc] init];
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusHeight)style:UITableViewStyleGrouped];
    [self.mTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.mTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self.view addSubview:mTableView];
    mTableView.dataSource = self;
    mTableView.delegate = self;
    [mTableView headerBeginRefreshing];

    [self.navigationController setTitle:@"我的"];
    [self addNavBack];

    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn addTarget:self action:@selector(onClickSearch:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    


}


-(void)onClickSearch:(id)sender
{
    SearchViewController *searchVc =[[SearchViewController alloc] init];
    searchVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    searchVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    searchVc.delegate = self;
    [self presentViewController:searchVc animated:YES completion:^{
        [searchVc.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }];


}

-(void)beginRereshing
{
    [mTableView headerBeginRefreshing];
}

//刷新
-(void)headerRereshing
{
    [self netGetTopicList:YES];
}

//更多
-(void)footerRereshing
{
    [self netGetTopicList:NO];
}


#pragma mark - 网络数据请求
-(void) netGetTopicList:(BOOL)isRefresh
{
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
      httpClient.responseSerializer.acceptableContentTypes = self.netTypes;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    int page = isRefresh ? 1 : PAGE;
    [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNumber"];
    NSString *urlString = mUrlStr;
    if([urlString isEqual:URL_SEARCH_BUTTON])
    {
    //    httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNumber"];
        [params setObject:mKeyword forKey:@"keyword"];
    }else if([urlString isEqualToString:URL_SEARCH_KEY])
    {
      //  httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        [params setObject:mKeyword  forKey:@"prodTypeName"];
        [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNumber"];
        
        
    }

    
    
    task = [httpClient POST:urlString parameters:[ToolUtil getNetCommonParams:params] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *responstArray;
       
        if([mUrlStr isEqualToString:URL_SEARCH_BUTTON] || [mUrlStr isEqualToString:URL_SEARCH_KEY])
        {
            
            NSData *doubi = responseObject;
            NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
            responstArray = [NSJSONSerialization JSONObjectWithData:[shabi dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        }else
        {
            responstArray = (NSArray *)responseObject;
        }
        
        if (responstArray==nil) {
            [self showTextHUD:@"网络错误"];
        }else{
             NSLog(@"json%@",responstArray);
            NSMutableArray *tempProductBeans = (NSMutableArray *)[ProductBean objectArrayWithKeyValuesArray:responstArray];
            
            if(isRefresh){
                   NSLog(@"json%@",@"isRefresh");
                PAGE =2;
                [productBeans removeAllObjects];
                [productBeans addObjectsFromArray:tempProductBeans];
                
            }else{
                NSLog(@"=========");
                PAGE =  PAGE +1;
                [productBeans addObjectsFromArray:tempProductBeans];
            }
            //刷新表格
            [mTableView reloadData];
            
            
            //结束刷新状态
            if(isRefresh)
                [mTableView headerEndRefreshing];
            else
                [mTableView footerEndRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        NSLog(@"failure=========%@",[error description]);
        //结束刷新状态
        if(isRefresh)
            [mTableView headerEndRefreshing];
        else
            [mTableView footerEndRefreshing];
        
    }];
    
    
    
}


#pragma mark--tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    return  1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(productBeans!=nil && [productBeans count]>0)
        return [productBeans count];
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;

    NSLog(@"ProductTableViewCell");
    static NSString *CellIdentifier = @"ProductTableViewCell";
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[ProductTableViewCell class]]){
                cell = (ProductTableViewCell *)oneObject;
            }
        }
    }
    
    
    cell.shareBtn.tag = section;
    cell.discountBtn.tag = section;
    [cell.shareBtn addTarget:self action:@selector(onClickShare:) forControlEvents:UIControlEventTouchUpInside];
    [cell.discountBtn addTarget:self action:@selector(onClickDiscount:) forControlEvents:UIControlEventTouchUpInside];
    if(productBeans!=nil && productBeans.count >0)
    {
        ProductBean *bean = [productBeans objectAtIndex:section];
        [cell setBean:bean];
    }
    
    return cell;
}

-(void)onClickShare:(id)sender
{
    
    NSLog(@"点击");
    if([sender isKindOfClass:[UIButton class]]){
        ShareViewController *shareVC = [[ShareViewController alloc] init];
        [self presentPopupViewController:shareVC animationType:0];
        NSInteger index =  ((UIButton *)sender).tag;
        ProductBean *bean = [productBeans objectAtIndex:index];
        [shareVC setProductBean:bean];
        
    }
    
}

-(void)onClickDiscount:(id)sender
{
    DisCountViewController *detailViewController = [[DisCountViewController alloc] init];
    NSInteger index =  ((UIButton *)sender).tag;
    ProductBean *bean = [productBeans objectAtIndex:index];
    detailViewController.productId = [NSString stringWithFormat:@"%@",bean.ID];
    [self presentPopupViewController:detailViewController animationType:0];
}

#pragma mark--tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 2 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击");
    
    NSInteger section = indexPath.section;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProductDesViewController *prodctVc = [[ProductDesViewController alloc] init];
    prodctVc.navigationItem.title = @"产品详情";
    
    
    if(productBeans!=nil && productBeans.count >0)
    {
        ProductBean *bean = [productBeans objectAtIndex:section];
        prodctVc.PARAMS_PRODUCT_ID = bean.productId;
        prodctVc.PARAMS_PRODUCT_TYPE = bean.issuerType;
        prodctVc.product=bean;
        
    }
    [self.navigationController pushViewController:prodctVc animated:YES];
    
    
}


-(void)setRequstURL:(NSString *) urlStr keyword:(NSString *)keyStr
{
    PAGE = 1;
    mUrlStr = urlStr;
    mKeyword = keyStr;
    [self netGetTopicList:YES];
}


@end
