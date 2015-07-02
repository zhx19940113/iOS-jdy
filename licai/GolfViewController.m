//
//  GolfViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "GolfViewController.h"

@interface GolfViewController ()

@end

@implementation GolfViewController
{
    NSArray *imageURLs;
    NSMutableArray *productBeans;
    int PAGE;
    NSString *mUrlStr;
    NSString *mKeyword;
}
@synthesize mTableView,navControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    mUrlStr = URL_PRODUCT_LIST;
    PAGE = 1;
    productBeans = [[NSMutableArray alloc] init];
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusHeight)style:UITableViewStyleGrouped];
    [self.mTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.mTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, 150)
                                                          ImageArray:[NSArray arrayWithObjects:
                                                                      [NSString stringWithFormat:@"%@%@%@",URL_BASE,URL_PRODUCT_IMAGE,@"1"],
                                                                      [NSString stringWithFormat:@"%@%@%@",URL_BASE,URL_PRODUCT_IMAGE,@"2"],
                                                                      [NSString stringWithFormat:@"%@%@%@",URL_BASE,URL_PRODUCT_IMAGE,@"3"],
                                                                      nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"",@"",@"", nil]];
    scroller.delegate=self;
   //mTableView.separatorStyle = NO;
    //[mTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:mTableView];
    mTableView.tableHeaderView = scroller;
    mTableView.dataSource = self;
    mTableView.delegate = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
  //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRereshing) name:NotificationTableViewReload object:nil];

    [mTableView headerBeginRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
      //  [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNum"];
        NSString *urlString = mUrlStr;
    if([urlString isEqual:URL_PRODUCT_LIST])
    {
        urlString = [mUrlStr stringByAppendingString:[NSString stringWithFormat:@"/%d",page]] ;
    }else if([urlString isEqual:URL_SEARCH_BUTTON])
    {
    //    httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNumber"];
        [params setObject:mKeyword forKey:@"keyword"];
    }else
    {
       // httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        [params setObject:mKeyword  forKey:@"prodTypeName"];
        [params setObject:[NSString stringWithFormat:@"%d",page] forKey:@"pageNumber"];
       // NSLog(@"3 %@ %@ %@",[mKeyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],urlString,mKeyword);


    }
    

        task = [httpClient POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *responstArray;
             httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
            if([mUrlStr isEqualToString:URL_SEARCH_BUTTON] || [mUrlStr isEqualToString:URL_SEARCH_KEY])
            {
               
                NSData *doubi = responseObject;
                NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
                responstArray = [NSJSONSerialization JSONObjectWithData:[shabi dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            }else
            {
                responstArray = (NSArray *)responseObject;
            }
            NSLog(@"array%@",responstArray);
            if (responstArray==nil) {
                [self showTextHUD:@"网络错误"];
                [mTableView headerEndRefreshing];
                [mTableView footerEndRefreshing];
            }else{
                NSMutableArray *tempProductBeans = (NSMutableArray *)[ProductBean objectArrayWithKeyValuesArray:responstArray];
                
                    if(isRefresh){
                        PAGE =2;
                        [productBeans removeAllObjects];
                        [productBeans addObjectsFromArray:tempProductBeans];
                        
                    }else{
                        PAGE =  PAGE +1;
                        [productBeans addObjectsFromArray:tempProductBeans];
                    }
                    //刷新表格
                    [mTableView reloadData];
                    

                //结束刷新状态
                [mTableView headerEndRefreshing];
                [mTableView footerEndRefreshing];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
             httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
             NSLog(@"failure=========%@",[error description]);
            //结束刷新状态

            [mTableView headerEndRefreshing];
            [mTableView footerEndRefreshing];

            
        }];
    
    
    
}

#pragma mark--图片轮播
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%lu",(unsigned long)index);
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
//    static NSString *CellIdentifier = @"ProductTableViewCell";
//    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil){
//        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
//        for(id oneObject in nib){
//            if([oneObject isKindOfClass:[ProductTableViewCell class]]){
//                cell = (ProductTableViewCell *)oneObject;
//            }
//        }
//    }
    
    static NSString *cellIdentifier=@"ProductTableViewCell";
         BOOL nibsRegistered=NO;
         if (!nibsRegistered) {
                 UINib *nib=[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                 nibsRegistered=YES;
             }
         ProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    NSInteger index =  ((UIButton *)sender).tag;
    ProductBean *bean = [productBeans objectAtIndex:index];
    detailViewController.productId = [NSString stringWithFormat:@"%@",bean.ID];
    [self presentPopupViewController:detailViewController animationType:0];
    }
}

#pragma mark--tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    if(section==0)
        return 0;
    else
    return 2 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     NSInteger section = indexPath.section;
   
    
    ProductDesViewController *prodctVc = [[ProductDesViewController alloc] init];
    prodctVc.navigationItem.title = @"产品详情";
    
    
    if(productBeans!=nil && productBeans.count >0)
    {
        ProductBean *bean = [productBeans objectAtIndex:section];
        prodctVc.PARAMS_PRODUCT_ID = bean.ID;
        prodctVc.PARAMS_PRODUCT_TYPE = bean.issuerType;
        prodctVc.product=bean;
        
    }
    [navControl pushViewController:prodctVc animated:YES];
    
    
}


-(void)setRequstURL:(NSString *) urlStr keyword:(NSString *)keyStr
{
    PAGE = 1;
    mUrlStr = urlStr;
    mKeyword = keyStr;
    [self netGetTopicList:YES];
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
