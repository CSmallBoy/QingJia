//
//  HCCustomesViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//退货/售后

#import "HCCustomerViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCCustomerInfo.h"
#import "HCCustomerApi.h"


#import "HCWaitReissueAuditViewController.h"
#import "HCReissueAuditPassViewController.h"
#import "HCReissueAuditNotPassViewController.h"
#import "HCRefundSuccessViewController.h"

#import "HCWaitReturnAuditViewController.h"
#import "HCReturnAuditPassViewController.h"
#import "HCReturnAuditNotPassViewController.h"

@interface HCCustomerViewController ()

@end

@implementation HCCustomerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"售后列表";
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self setupBackItem];
    [self requestHomeData];
}

#pragma mark--Delegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordID = @"record";
    HCCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordID];
    cell = [[HCCustomerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HCCustomerInfo *info = self.dataSource[indexPath.section];
    cell.info = info;
    cell.indexPath = indexPath;
    return cell;
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
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCustomerInfo *info = self.dataSource[indexPath.section];
    if ([info.goodsName integerValue] == 1)
    {
        if (info.orderCustomerState == 0)
        {
            HCWaitReissueAuditViewController *VC = [[HCWaitReissueAuditViewController alloc]init];
            VC.title = @"待审核";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(info.orderCustomerState == 1)
        {
            HCReissueAuditPassViewController *VC = [[HCReissueAuditPassViewController alloc]init];
            VC.title = @"审核通过";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(info.orderCustomerState == 2)
        {
            HCReissueAuditNotPassViewController *VC = [[HCReissueAuditNotPassViewController alloc]init];
            VC.title = @"审核不通过";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    else
    {
        if (info.orderCustomerState == 0)
        {
            HCWaitReturnAuditViewController *VC = [[HCWaitReturnAuditViewController alloc]init];
            VC.title = @"待审核";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(info.orderCustomerState == 1)
        {
            HCReturnAuditPassViewController *VC = [[HCReturnAuditPassViewController alloc]init];
            VC.title = @"审核通过";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(info.orderCustomerState == 2)
        {
            HCReturnAuditNotPassViewController *VC = [[HCReturnAuditNotPassViewController alloc]init];
            VC.title = @"审核不通过";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(info.orderCustomerState == 3)
        {
            HCRefundSuccessViewController *VC = [[HCRefundSuccessViewController alloc]init];
            VC.title = @"退款成功";
            VC.data = @{@"data":info};
            [self.navigationController pushViewController:VC animated:YES];
        }
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = CLEARCOLOR;
    return view;
}


#pragma mark---network
- (void)requestHomeData
{
    HCCustomerApi *api = [[HCCustomerApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array)
     {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        else
        {
            [self showHUDError:message];
        }
    }
     ];
    _baseRequest = api;
}

@end
