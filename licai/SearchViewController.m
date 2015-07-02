//
//  SearchViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/6.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    NSArray *items;
}

@synthesize msearchBar,mTableView,hideBtn,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    items = [[NSArray alloc] initWithObjects:@"银行理财",@"公募基金",@"私募基金",@"保险",@"股权众筹",@"信托类",@"资管类",@"债券众筹", nil];
    [msearchBar becomeFirstResponder];
    msearchBar.delegate = self;
    //msearchBar.showsCancelButton=YES;
    [msearchBar setShowsCancelButton:YES animated:NO];
    [msearchBar setBackgroundColor:[UIColor whiteColor]];
    
    msearchBar.returnKeyType = UIReturnKeySearch; //设置按键类型
    msearchBar.enablesReturnKeyAutomatically = NO; //这里设置为无文字就灰色不可
    //[self registerForKeyboardNotifications];
  //  mTableView.touchDelegate = self;
    
    if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //config the cell
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[self getColor:@"#BEBEBE"]];
    return cell;
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

- (IBAction)onClickDismiss:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [msearchBar resignFirstResponder];
   [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

//点击搜索列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyWord = [items objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
    [delegate setRequstURL:URL_SEARCH_KEY keyword:keyWord];
}

//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [msearchBar resignFirstResponder];
    NSString *keyWord = msearchBar.text;
    [self dismissViewControllerAnimated:YES completion:nil];
    if(![keyWord isBlank])
    {
        [delegate setRequstURL:URL_SEARCH_BUTTON keyword:keyWord];
    }else
    {
        [delegate setRequstURL:URL_PRODUCT_LIST keyword:@""];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
//    if([searchText isEqualToString:@""])
//    {
//        self.searchBar.text = @" ";
//    }else
//    {
//        NSString *str = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        self.searchBar.text = str;
//    }
}


//- (void) keyboardWasShown:(NSNotification *) notif
//{
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    
//    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
//    ///keyboardWasShown = YES;
//  //  [searchBar setFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
////    [mTableView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - searchBar.frame.size.height - keyboardSize.height - 44)];
////    [hideBtn setFrame:CGRectMake(0, mTableView.frame.size.height+30, SCREEN_WIDTH, SCREEN_HEIGHT - searchBar.frame.size.height- mTableView.frame.size.height - 20)];
//}
//- (void) keyboardWasHidden:(NSNotification *) notif
//{
//    NSDictionary *info = [notif userInfo];
//    
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
//    // keyboardWasShown = NO;
//  //  [mTableView setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - searchBar.frame.size.height - keyboardSize.height - 30)];
//    
//}

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
//    [msearchBar resignFirstResponder];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [msearchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     [msearchBar resignFirstResponder];
}

@end
