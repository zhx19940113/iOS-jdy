//
//  DisCountViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "DisCountViewController.h"

@interface DisCountViewController ()

@end

@implementation DisCountViewController
{
     NSMutableArray *managerArray;
}
@synthesize codeLabel,mTableView,productId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mTableView.delegate = self;
    mTableView.dataSource = self;
    NSLog(@"id%@",productId);
    [self netGetDiscount];
    
    self.view.layer.shadowOffset = CGSizeMake(0, 0);
    self.view.layer.shadowRadius =0;
    self.view.layer.shadowColor =[UIColor clearColor].CGColor;
    self.view.layer.shadowOpacity =0;
    [self setTableViewHeight];
   
   
}


#pragma  mark--tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(managerArray!=nil)
        return [managerArray count];
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //config the cell
    cell.textLabel.text = @"经理";
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dianhua"]];
    [rightImageView setFrame:CGRectMake(0, 0, 30, 30)];
    cell.accessoryView = rightImageView;
    
    if(managerArray!=nil && [managerArray count]>0)
    {
        Manager *bean = [managerArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@  %@",indexPath.row+1,bean.name,bean.detaAddress];
        //cell.detailTextLabel.text = bean.detaAddress;
        [cell.textLabel setTextColor:[UIColor grayColor]];
    }
    
    return cell;
}


-(void)setTableViewHeight{
//    if(managerArray!=nil){
//        mTableView.frame = CGRectMake(0, mTableView.frame.origin.y, mTableView.frame.size.width, [managerArray count] *40);
//        
//    }else{
//        self.view.frame=CGRectMake(self.view.frame.or.width, <#CGFloat y#>, self.view.frame.size.width, self.view.frame.size.height-mTableView.frame.size.height);
//      mTableView.frame = CGRectMake(0, mTableView.frame.origin.y, mTableView.frame.size.width, 0);
//    }
     //[self.view sizeToFit];
    if(managerArray!=nil && [managerArray count]>0){
        [mTableView setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [mTableView setBackgroundColor:[UIColor clearColor]];
    }
    
    
}

-(void) netGetDiscount
{
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    
    NSString *urlString = URL_PRODUCT_CODE ;
    
    task = [httpClient POST:urlString parameters:
            [ToolUtil getNetCommonParams:[[NSMutableDictionary alloc]  initWithObjectsAndKeys:productId,@"productId", nil]]
                    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (responseDict==nil) {
            [self showTextHUD:@"网络错误"];
        }else{
            NSLog(@"%@",responseDict);
            NSString *code = [responseDict objectForKey:@"couponCode"];
            MAIN(^{
                codeLabel.text = code;
                [self netGetManagers];
            });
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"failure=========%@",[error localizedDescription]);

        
    }];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     Manager *bean = [managerArray objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",bean.telephone]]];
    
    
}

-(void) netGetManagers
{
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL_PRODUCT_MANAGER_LIST ,productId] ;
    
    task = [httpClient POST:urlString parameters:[ToolUtil getNetCommonParams:nil]
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSArray *responseArray = (NSArray *)responseObject;
                        if (responseArray==nil) {
                            [self setTableViewHeight];
                            [self showTextHUD:@"网络错误"];
                        }else{
                            NSLog(@"%@",responseArray);
                            managerArray = [Manager objectArrayWithKeyValuesArray:responseArray];
                            if(managerArray.count==0)
                            self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                            MAIN(^{
                                [mTableView reloadData];
                                [self setTableViewHeight];
                            });

                        }
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        [self setTableViewHeight];
                        NSLog(@"failure=========%@",[error localizedDescription]);
                        
                        
                    }];
    
    
}

@end
