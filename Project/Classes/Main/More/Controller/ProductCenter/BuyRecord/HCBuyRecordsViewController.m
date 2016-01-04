//
//  HCBuyRecordsViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCBuyRecordsViewController.h"
#import "HCCustomerViewController.h"
#import "HCPaymentViewController.h"
#import "HCLogisticsInfoViewController.h"
#import "HCWaitingDeliverGoodsViewController.h"

#import "HCApplyReissueViewController.h"
#import "HCApplyReturnViewController.h"
#import "HCBuyRecordTableViewCell.h"

#import "HCBuyRecordApi.h"
#import "HCProductIntroductionInfo.h"




@interface HCBuyRecordsViewController ()<HCBuyRecordCellDelegate>
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@end

@implementation HCBuyRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买记录";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    [self requestHomeData];
}

#pragma mark--Delegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordID = @"record";
    HCBuyRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordID];

    cell = [[HCBuyRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
    cell.delegate = self;
    cell.info = self.dataSource[indexPath.section];
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCProductIntroductionInfo *info = self.dataSource[indexPath.section];
    if (info.orderState == 0)//待付款
    {
        //支付
        HCPaymentViewController *VC = [[HCPaymentViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (info.orderState == 1)//订单已取消
    {
        HCPaymentViewController *VC = [[HCPaymentViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    else if (info.orderState == 2)//待发货
    {
        HCWaitingDeliverGoodsViewController *VC = [[HCWaitingDeliverGoodsViewController alloc]init];
        VC.data = @{@"data": info};
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (info.orderState == 3)//已发货
    {
        //物流信息
        HCLogisticsInfoViewController *VC = [[HCLogisticsInfoViewController alloc]init];
        VC.data = @{@"data":info};
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if(info.orderState == 4)//已签收
    {
        //物流信息
        HCLogisticsInfoViewController *VC = [[HCLogisticsInfoViewController alloc]init];
        VC.data = @{@"data":info};
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

#pragma mark----private methods

-(void)handleCustomer
{
    [self.navigationController pushViewController:[HCCustomerViewController new] animated:YES];
}


#pragma mark----HCBuyRecordCellDelegate

-(void)handleApplyReissue:(HCProductIntroductionInfo*)info
{
    HCApplyReissueViewController *VC = [HCApplyReissueViewController new];
    VC.data = @{@"data":info};
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)handleApplyReturn:(HCProductIntroductionInfo*)info
{
    HCApplyReturnViewController *VC = [[HCApplyReturnViewController alloc]init];
    VC.data = @{@"data":info};
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark --- Setter Or  Getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(handleCustomer)];
        _rightItem.title = @"售后";
    }
    return _rightItem;
}


#pragma mark---network
- (void)requestHomeData
{
    HCBuyRecordApi *api = [[HCBuyRecordApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
    _baseRequest = api;
}

@end
