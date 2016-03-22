//
//  HCMyMtalkShoping.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMyMtalkShoping.h"
#import "HCMtalkMyOrderListController.h"
#import "HCMtalkWaitPayController.h"
#import "HCMtalkWaitReceivedController.h"
#import "HCMtalkAfterSaleController.h"

#import "HCButtonItem.h"

@interface HCMyMtalkShoping ()

@property (nonatomic,strong) UIView *tableHeaderView;
@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) HCButtonItem *waitPayBtn;
@property (nonatomic,strong) HCButtonItem *waitReceived;
@property (nonatomic,strong) HCButtonItem *afterSale;


@end

@implementation HCMyMtalkShoping

- (void)viewDidLoad {
    [super viewDidLoad];
    //---------------------------我的-----------------------------------
    [self setupBackItem];
    self.title = @"我的";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableView];
    

}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // --------------------导航栏透明 -------------------
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clearColor-2"] forBarMetrics:UIBarMetricsDefault];
    //导航条底部黑线去除办法
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    
//    UIImage *image = [UIImage imageNamed:@"clearColor-2"];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.clipsToBounds = YES;

}

-(void)viewWillDisappear:(BOOL)animated
{
    
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundColor:kHCNavBarColor];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeFrame" object:nil];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"isChange"];
//    
//    self.hidesBottomBarWhenPushed = NO;
    
//    UIImage *image = [UIImage imageNamed:@"red3-2"];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.clipsToBounds = NO;


}

#pragma mark --- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 80;
    }
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        static NSString *ID = @"myMtalkNormal";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.textLabel.text = @"我的订单";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, 6, 100, 30)];
            label.text = @"查看全部订单";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 0 && indexPath.row ==1)
    {
        
        
        static NSString *ID = @"myMtalkNormal";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            [cell addSubview:self.centerView];
        }
        return cell;
    }
    else
    {
        static NSString *ID = @"myMtalkNormal";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.textLabel.text = @"收货地址";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90, 6, SCREEN_WIDTH-140, 30)];
            label.text = @"上海市集心路168号1号楼507 123456789";
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:14];
            
            [cell addSubview:label];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row ==0) {
        HCMtalkMyOrderListController *orderVC = [[HCMtalkMyOrderListController alloc]init];
        [self.navigationController pushViewController:orderVC animated:YES];
        
    }
}

#pragma mark --- private mothods

-(void)toWatiVC:(HCButtonItem *)button
{
    HCMtalkWaitPayController *waitPayVC = [[HCMtalkWaitPayController alloc]init];
    [self.navigationController pushViewController:waitPayVC animated:YES];
}

-(void)toWaitReceivedVC
{
    HCMtalkWaitReceivedController *waitReceivedVC = [[HCMtalkWaitReceivedController alloc]init];
    [self.navigationController pushViewController:waitReceivedVC animated:YES];


}

-(void)toAfterSaleVC
{
    HCMtalkAfterSaleController *afterSaleVC = [[HCMtalkAfterSaleController alloc]init];
    [self.navigationController pushViewController:afterSaleVC animated:YES];
}

#pragma mark --- setter Or geter


- (UIView *)tableHeaderView
{
    if(!_tableHeaderView){
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,210)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        imageView.image = IMG(@"2Dbarcode_message_Background");
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH/2-40, 90, 80, 80);
        ViewRadius(button, 40);
        
        [button setBackgroundImage:IMG(@"1") forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, CGRectGetMaxY(button.frame)+10, 80, 30)];
        label.text = @"昵称";
        label.textColor = [UIColor whiteColor];
        label.textAlignment= NSTextAlignmentCenter;
        
        [_tableHeaderView addSubview:imageView];
        [_tableHeaderView addSubview:button];
        [_tableHeaderView addSubview:label];
    }
    return _tableHeaderView;
}



- (UIView *)centerView
{
    if(!_centerView){
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, 80)];
        _centerView.backgroundColor = [UIColor whiteColor];

        [_centerView addSubview: self.waitPayBtn];
        [_centerView addSubview: self.waitReceived];
        [_centerView addSubview: self.afterSale];
    }
    return _centerView;
}


- (HCButtonItem *)waitPayBtn
{
    if(!_waitPayBtn){
        _waitPayBtn = [[HCButtonItem alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH/3-2, 44) WithImageName:@"waitPay" WithImageWidth:40 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"待支付", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        [_waitPayBtn addTarget:self action:@selector(toWatiVC:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _waitPayBtn;
}


- (HCButtonItem *)waitReceived
{
    if(!_waitReceived){
        _waitReceived = [[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 12, SCREEN_WIDTH/3-2, 44) WithImageName:@"waitReceived" WithImageWidth:40 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"待收货", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        
        [_waitReceived addTarget:self action:@selector(toWaitReceivedVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waitReceived;
}


- (HCButtonItem *)afterSale
{
    if(!_afterSale){
       _afterSale = [[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 12, SCREEN_WIDTH/3-2, 44) WithImageName:@"afterSale" WithImageWidth:40 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"售后服务", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:10];
        
        [_afterSale addTarget:self action:@selector(toAfterSaleVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _afterSale;
}


//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
