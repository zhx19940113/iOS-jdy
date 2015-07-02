//
//  UserCenterViewController.m
//  licai
//
//  Created by 钟惠雄 on 15/2/2.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "UserCenterViewController.h"
#import "JMWhenTapped.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController
{
    NSArray *setttingArray1;
    NSArray *setttingArray2;
    NSArray *setttingArray3;
}
@synthesize mTableView,headpic,nameLabel,gradeNumLabel,scoreNumLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    setttingArray1 = [[NSArray alloc]initWithObjects:@"提现      ",@"银行卡",nil];
    setttingArray2 = [[NSArray alloc]initWithObjects:@"我的面值",@"我的面子",@"我的圈子",@"我的订单",nil];
    setttingArray3 = [[NSArray alloc]initWithObjects:@"我的消息",@"设置",nil];
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -kNavBarHeight) style:UITableViewStyleGrouped];
    [mTableView setDataSource:self];
    [mTableView setDelegate:self];
    
    //    mTableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    
    UIView *userBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3+10)];
    UIImageView *imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, userBgView.frame.size.width, userBgView.frame.size.height)];
    [imageBg setImage:[UIImage imageNamed:@"user_bg"]];
    [userBgView addSubview:imageBg];
    mTableView.tableHeaderView = userBgView;
    
    
    UIView *imageBlueBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, userBgView.frame.size.width, userBgView.frame.size.height)];
    [imageBlueBg setBackgroundColor:[UIColor colorWithRed:0.32 green:0.68 blue:1 alpha:0.88]];
    [imageBg addSubview:imageBlueBg];
    
    
    headpic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (SCREEN_HEIGHT/6/2) , 20, SCREEN_HEIGHT/6, SCREEN_HEIGHT/6)];
    //    headpic.layer.borderWidth = 2;
    //    headpic.layer.borderColor = [[UIColor whiteColor] CGColor];
    headpic.layer.masksToBounds = YES;
    headpic.layer.cornerRadius = headpic.frame.size.width/2;
    [headpic setImage:[UIImage imageNamed:@"default_head.jpg"]];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headpic.frame.origin.y +headpic.frame.size.height +10, SCREEN_WIDTH, 35)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:[UIFont fontWithName:FontWord size:20]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setText:@"未命名"];
    [imageBg addSubview:nameLabel];
    
    
    
    UILabel *gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLabel.frame.origin.y + nameLabel.frame.size.height, SCREEN_WIDTH/2-40, 20)];
    UIButton *gradeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, nameLabel.frame.origin.y + nameLabel.frame.size.height, SCREEN_WIDTH/2-40, 20)];
    [gradeLabel setTextColor:[UIColor whiteColor]];
    [gradeLabel setText:@"等级"];
   
    [gradeLabel setTextAlignment:NSTextAlignmentRight];
    [gradeLabel setFont:[UIFont fontWithName:FontWord size:17]];
    [gradeButton addTarget:self action:@selector(onCLickGrade) forControlEvents:UIControlEventTouchUpInside];
    [imageBg addSubview:gradeButton];
    [imageBg addSubview:gradeLabel];
    
    
    gradeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(gradeLabel.frame.origin.x + gradeLabel.frame.size.width +5, nameLabel.frame.origin.y + nameLabel.frame.size.height, 40, 20)];
     UIButton *gradeNumButton = [[UIButton alloc] initWithFrame:CGRectMake(gradeLabel.frame.origin.x + gradeLabel.frame.size.width +5, nameLabel.frame.origin.y + nameLabel.frame.size.height, 40, 20)];
    
    [gradeNumLabel setTextColor:[UIColor yellowColor]];
    [gradeNumLabel setText:@"0"];
    [gradeNumLabel setTextAlignment:NSTextAlignmentLeft];
    [gradeNumLabel setFont:[UIFont fontWithName:FontWord size:17]];
    [gradeNumButton addTarget:self action:@selector(onCLickGrade) forControlEvents:UIControlEventTouchUpInside];
    [imageBg addSubview:gradeNumButton];

    [imageBg addSubview:gradeNumLabel];
    
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 +20, nameLabel.frame.origin.y + nameLabel.frame.size.height, 40, 20)];
    UIButton *scoreButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 +20, nameLabel.frame.origin.y + nameLabel.frame.size.height, 40, 20)];
    [scoreLabel setTextColor:[UIColor whiteColor]];
    [scoreLabel setText:@"积分"];
    [scoreLabel setTextAlignment:NSTextAlignmentLeft];
    [scoreLabel setFont:[UIFont fontWithName:FontWord size:17]];
    
     [scoreButton addTarget:self action:@selector(onCLickScore) forControlEvents:UIControlEventTouchUpInside];
    [imageBg addSubview:scoreButton];

    [imageBg addSubview:scoreLabel];
    
    
    scoreNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x + scoreLabel.frame.size.width +2, scoreLabel.frame.origin.y, 100, 20)];
    UIButton *scoreNumButton = [[UIButton alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x + scoreLabel.frame.size.width +2, scoreLabel.frame.origin.y, 100, 20)];
    [scoreNumLabel setTextColor:[UIColor yellowColor]];
    [scoreNumLabel setText:@"0"];
    [scoreNumLabel setTextAlignment:NSTextAlignmentLeft];
    [scoreNumLabel setFont:[UIFont fontWithName:FontWord size:17]];
    
    
    [scoreNumButton addTarget:self action:@selector(onCLickScore) forControlEvents:UIControlEventTouchUpInside];
    [imageBg addSubview:scoreNumButton];
    
    [imageBg addSubview:scoreNumLabel];
    
    
    UILabel *fgNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, scoreLabel.frame.origin.y, 10, 20)];
    [fgNumLabel setTextColor:[UIColor whiteColor]];
    [fgNumLabel setText:@"/"];
    [fgNumLabel setTextAlignment:NSTextAlignmentLeft];
    [fgNumLabel setFont:[UIFont fontWithName:FontWord size:14]];
    [imageBg addSubview:fgNumLabel];
    
    [self.view addSubview:mTableView];
    
    
    //点击头像
    UITapGestureRecognizer* frogetRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickHead:)];
    headpic.userInteractionEnabled=YES;
    imageBg.userInteractionEnabled=YES;
    [headpic addGestureRecognizer:frogetRecognizer];
    
    [imageBg addSubview:headpic];
    
    
    if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    self.isGetNet=NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    if([ToolUtil isLogin])
    [self  getUserInfo];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onClickHead:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"sssss");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"返回" otherButtonTitles:@"图库",@"拍照", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

-(void) onClickTx:(UITapGestureRecognizer*)recognizer
{
    MyFaceOrderViewController *vc=[[MyFaceOrderViewController alloc] initWithNibName:@"MyFaceOrderViewController" bundle:nil];
    vc.type=WithdrawCashType;
    
    [self.pViewController.navigationController pushViewController:vc animated:YES];
    
}
-(void) onClickJl:(UITapGestureRecognizer*)recognizer
{
    WthdrawCashViewController  *settingVc=[[WthdrawCashViewController alloc] initWithNibName:@"WthdrawCashViewController" bundle:nil];
    [self.pViewController.navigationController pushViewController:settingVc animated:YES];
    
}





- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //获取点击按钮的标题
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"拍照"])
    {
        UIImagePickerController *imgPicker = [UIImagePickerController new];
        imgPicker.delegate = self;
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.pViewController presentViewController:imgPicker animated:YES completion:nil];
    }
    else if([buttonTitle isEqualToString:@"图库"])
    {
        UIImagePickerController *imgPicker = [UIImagePickerController new];
        imgPicker.delegate = self;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.pViewController presentViewController:imgPicker animated:YES completion:nil];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.pViewController dismissViewControllerAnimated:YES completion:nil];
    //添加到集合中
    UIImage * photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    PECropViewController *controller = [[PECropViewController alloc] init];
    
    CGFloat width = photo.size.width;
    CGFloat height = photo.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    controller.keepingCropAspectRatio=YES;
    
    controller.delegate = self;
    controller.image = photo;
    controller.toolbarHidden=YES;
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self.pViewController presentViewController:nav animated:YES completion:nil];
    // [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - PECropViewControllerDelegate methods

-(void) cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    // [self.navigationController popViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    //[self showTextHUD:@"正在上传您的头像"];
    [headpic setImage:croppedImage];
    
    
    //croppedImage = [croppedImage resizedImage:[self scaleSize:croppedImage.size] interpolationQuality:kCGInterpolationMedium];
    NSData *imageData = UIImageJPEGRepresentation(croppedImage, 0.5f);
    NSArray *array = DOCUMENT_PATH;
    double timeStr = [[NSDate date] timeIntervalSince1970];
    [imageData writeToFile:[NSString stringWithFormat:@"%@/%f.jpg",[array objectAtIndex:0],timeStr] atomically:YES];
    // isUploadHeader = YES;
    //对photo进行处理
    //[[MyThread Instance] startUpdatePortrait:UIImageJPEGRepresentation(croppedImage, 0.75f)];
    //[Tool ToastNotification:@"正在上传您的头像" andView:self.view andLoading:YES andIsBottom:NO];
    [self uploadHead];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    //[self.navigationController popViewControllerAnimated:YES];
}




#pragma mark-- 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    
    // cell.imageView.image = [UIImage imageNamed:@"green.png"];
    
    if(indexPath.row==1 && indexPath.section==2)
    {
        
    }
    else
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // accountBalance = "<null>";
    //communitySum = 0;
    // faceSum = "<null>";
    //orderSum = "<null>";
    //sum = "<null>";
    
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    NSUInteger section = [indexPath section];
     [cell.textLabel setTextColor:[self getColor:@"#607078"]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:FontWord size:17]];
    switch (section) {
        case 0:
            cell.textLabel.text = [setttingArray1 objectAtIndex:indexPath.row];
           
            if(indexPath.row==0)
            {
                float accountBalance=0;
                
                if(self.userInfo!=nil)
                {
                    if([self.userInfo objectForKey:@"accountBalance"] && ![[self.userInfo objectForKey:@"accountBalance"] isEqual:[NSNull null]])
                    {
                        accountBalance=[[self.userInfo objectForKey:@"accountBalance"] floatValue];
                    }
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f 提现记录",accountBalance];
                
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString: cell.detailTextLabel.text];
                
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.4 green:0.73 blue:0.98 alpha:1.0] range:NSMakeRange(cell.detailTextLabel.text.length-4,4)];
                
                
                cell.detailTextLabel.attributedText=str;
                
                UITapGestureRecognizer* frogetRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTx:)];
                cell.detailTextLabel.userInteractionEnabled=YES;
                [cell.detailTextLabel addGestureRecognizer:frogetRecognizer];
                
//                cell.detailTextLabel.backgroundColor=[UIColor blackColor];
//                 cell.textLabel.backgroundColor=[UIColor blackColor];
                
              // cell.selectionStyle = UITableViewCellSelectionStyleNone;

                
                
                
//                UITapGestureRecognizer *jiluRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickJl:)];
//                cell.textLabel.userInteractionEnabled=YES;
//                [cell.textLabel addGestureRecognizer:jiluRecognizer];
                
                
                
                
            }
            else if(indexPath.row==1)
            {
                cell.detailTextLabel.text = @"去绑定";
                [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.4 green:0.73 blue:0.98 alpha:1.0]];
                
            }
            break;
        case 1:
            cell.textLabel.text = [setttingArray2 objectAtIndex:indexPath.row];
            if(indexPath.row==2)
            {
                int communitySum=0;
                
                if(self.userInfo!=nil)
                {
                    if([self.userInfo objectForKey:@"communitySum"] && ![[self.userInfo objectForKey:@"communitySum"] isEqual:[NSNull null]] )
                    {
                        communitySum=[[self.userInfo objectForKey:@"communitySum"] floatValue];
                    }
                }
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人",communitySum];
            }
            else if(indexPath.row==0)
            {
                float faceSum=0;
                
                if(self.userInfo!=nil)
                {
                    if([self.userInfo objectForKey:@"sum"] && ![[self.userInfo objectForKey:@"sum"] isEqual:[NSNull null]])
                    {
                        faceSum=[[self.userInfo objectForKey:@"sum"] floatValue];
                    }
                }
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",faceSum];
            }
            else if(indexPath.row==1)
            {
                int sum=0;
                
                if(self.userInfo!=nil)
                {
                    if([self.userInfo objectForKey:@"faceSum"] && ![[self.userInfo objectForKey:@"faceSum"] isEqual:[NSNull null]] )
                    {
                        sum=[[self.userInfo objectForKey:@"faceSum"] floatValue];
                    }
                }
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人",sum];
            }
            else if(indexPath.row==3)
            {
                float orderSum=0;
                
                if(self.userInfo!=nil)
                {
                    if([self.userInfo objectForKey:@"orderSum"] && ![[self.userInfo objectForKey:@"orderSum"] isEqual:[NSNull null]])
                    {
                        orderSum=[[self.userInfo objectForKey:@"orderSum"] floatValue];
                    }
                }
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f",orderSum];
            }
            
            break;
        case 2:
            if(indexPath.row==0)
            {
                
                if(self.userInfo!=nil)
                {
                    long sum=[[self.userInfo objectForKey:@"msgcount"] integerValue];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld条",sum];
                }
            }
            
            cell.textLabel.text = [setttingArray3 objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //    if(indexPath.row==8)
    //    {
    //        NewIntroViewController *newIntroViewConroller = [[NewIntroViewController alloc] init];
    //        newIntroViewConroller.isLook=YES;
    //        [self presentViewController:newIntroViewConroller animated:YES completion:nil];
    //    }
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section) {
        case 0:
            
            if(row==1)
            {
                BankCardListViewController  *settingVc=[[BankCardListViewController alloc] initWithNibName:@"BankCardListViewController" bundle:nil];
                [self.pViewController.navigationController pushViewController:settingVc animated:YES];
                
            }
            else if(row==0)
            {
                [self onClickJl:nil];
            }
            
            break;
        case 1:
            
            if(row==0)
            {
                MyFaceOrderViewController *vc=[[MyFaceOrderViewController alloc] initWithNibName:@"MyFaceOrderViewController" bundle:nil];
                vc.type=FaceType;
                
                [self.pViewController.navigationController pushViewController:vc animated:YES];
                
            }
            else if(row==3)
            {
                MyFaceOrderViewController *vc=[[MyFaceOrderViewController alloc] initWithNibName:@"MyFaceOrderViewController" bundle:nil];
                vc.type=OrderType;
                
                [self.pViewController.navigationController pushViewController:vc animated:YES];
                
            }
            else if(row==1)
            {
                
                
                MyFaceCicleViewController *vc=[[MyFaceCicleViewController alloc] initWithNibName:@"MyFaceCicleViewController" bundle:nil];
                vc.type=FcFaceType;
                
                [self.pViewController.navigationController pushViewController:vc animated:YES];
                
            }
            
            else if(row==2)
            {
                
                
                MyFaceCicleViewController *vc=[[MyFaceCicleViewController alloc] initWithNibName:@"MyFaceCicleViewController" bundle:nil];
                vc.type=FcCicleType;
                
                [self.pViewController.navigationController pushViewController:vc animated:YES];
                
            }
            
            break;
        case 2:
            if(row==1)
            {
                SettingViewController *settingVc=[[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
                settingVc.name=nameLabel.text;
                UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:settingVc];
                [self.pViewController presentViewController:nav animated:YES completion:nil];
            }
            else if(row==0)
            {
                
                
                MyMessageViewController *vc=[[MyMessageViewController alloc] initWithNibName:@"MyMessageViewController" bundle:nil];
                [self.pViewController.navigationController pushViewController:vc animated:YES];
                
            }
            break;
        default:
            break;
    }
    
    
    
}

-(void) uploadHead
{
    NSArray *images  = [NSArray arrayWithObjects:headpic.image, nil];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:[ToolUtil getMemberId] forKey:@"businessKey"];
    [params setValue:@"MemberEntity" forKey:@"businessType"];
    [[BaseHttpClient sharedClient] upload:URL_HEADUPLOAD params:[ToolUtil getNetCommonParams:params] images:images complete:^(id response) {
        //  NSDictionary *responstDict = (NSDictionary *)response;
        [self.pViewController showTextHUD:@"修改成功"];
        [self getUserInfo];
    }];
    
    
}

-(void) getUserInfo
{
    
    if(self.isGetNet)
    return;
    
    self.isGetNet=YES;
    
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    
    
    [httpClient POST:URL_USERINFO parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responstDict = (NSDictionary *)responseObject;
        
        NSLog(@"11%@",responstDict);
        
        if (responstDict==nil) {
            [self.pViewController showTextHUD:@"网络错误"];
        }else{
            
            if(![[responstDict objectForKey:@"name"] isEqual:[NSNull null]])
            {
                nameLabel.text=[responstDict objectForKey:@"name"];
            }
            else nameLabel.text=@"未命名";
        
            
            if(![[responstDict objectForKey:@"rankName"] isEqual:[NSNull null]])
                gradeNumLabel.text=[responstDict objectForKey:@"rankName"];
            if(![[responstDict objectForKey:@"creditBalance"] isEqual:[NSNull null]])
                scoreNumLabel.text=[NSString stringWithFormat:@"%ld",[[responstDict objectForKey:@"creditBalance"] integerValue]];
            
            if(![[responstDict objectForKey:@"portrait"] isEqual:[NSNull null]])
                [headpic setImageWithURL:[NSURL URLWithString:[responstDict objectForKey:@"portrait"]] placeholderImage:[UIImage imageNamed:@"default_head.jpg"]];
            
            self.userInfo=[[NSMutableDictionary alloc] init];
            [self.userInfo addEntriesFromDictionary:responstDict];
            [self getMsgInfo];
            
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // [self.pViewController showTextHUD:STR_NET_ERROR];
        self.isGetNet=NO;
        
    }];
}
-(void) getMsgInfo
{
    BaseHttpClient *httpClient = [BaseHttpClient sharedClient];
    
    httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"error%@",[NSString stringWithFormat:@"%@%@",URL_MSG_NUM,[ToolUtil getMemberId]]);
    [httpClient POST:[NSString stringWithFormat:@"%@%@",URL_MSG_NUM,[ToolUtil getMemberId]] parameters:[ToolUtil getNetCommonParams:nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        NSData *doubi = responseObject;
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        if([shabi isEqualToString:@"false"])
            [self.userInfo setObject:@"0" forKey:@"msgcount"];
        else [self.userInfo setObject:shabi forKey:@"msgcount"];
         self.isGetNet=NO;
        [mTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //[self.pViewController showTextHUD:STR_NET_ERROR];
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        self.isGetNet=NO;
        
        
    }];
}


-(void)onCLickScore
{
    ScoreViewController *gradeVc = [[ScoreViewController alloc] init];
    [self.pViewController presentPopupViewController:gradeVc animationType:0];
}
-(void)onCLickGrade
{
    NSLog(@"点击");
    GradeViewController *gradeVc = [[GradeViewController alloc] init];
    [self.pViewController presentPopupViewController:gradeVc animationType:0];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 0;
    else 
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



@end
