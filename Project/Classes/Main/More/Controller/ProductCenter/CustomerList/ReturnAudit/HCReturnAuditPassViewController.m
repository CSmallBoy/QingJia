//
//  HCReturnAuditPassViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReturnAuditPassViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

#import "HCCustomerInfo.h"
#import "HCReturnAddressInfo.h"
#import "HCReturnAddressApi.h"

#import "HCInputWaybillNumViewController.h"

@interface HCReturnAuditPassViewController ()<HCShowReasonTableViewCellDelegate>

@property (nonatomic,strong) HCCustomerInfo *info;
@property (nonatomic,assign) CGFloat cellHight;

@property (nonatomic,strong) HCReturnAddressInfo *returnAddressinfo;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation HCReturnAuditPassViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"审核通过";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(1.0);
    _info = self.data[@"data"];
    [self requestHomeData];
}

#pragma mark---UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0)
    {
        static NSString *RecordID = @"WaitReturnAudit";
        HCCustomerTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:RecordID];
        orderCell = [[HCCustomerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        orderCell.info = self.info;
        orderCell.indexPath = indexPath;
        cell = orderCell;
    }
    else if(indexPath.section== 1)
    {
        if (indexPath.row == 0)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"returnReason"];
            cell.textLabel.text = @"补发原因";
            cell.detailTextLabel.text = [HCDictionaryMgr applyReturnReason:self.info.reason];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1)
        {
            HCShowReasonTableViewCell *showCell = [[HCShowReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"show"];
            showCell.delegate = self;
            showCell.info = self.info;
            cell = showCell;
        }
    }
    else if (indexPath.section == 2)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"returnReason"];
        if (indexPath.row == 0)
        {
            if ([self.info.goodsName integerValue] == 0)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"补发内容: M-Talk烫印机"];
            }
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"补发数量: %@",self.info.detailNeedGoodsNum];
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"退货金额:%@元",self.info.orderTotalPrice];
        }
    }
    else
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"returnAddress"];
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"退货地址:%@",self.returnAddressinfo.returnAddress];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"收件人:%@",self.returnAddressinfo.recipient];
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"联系方式:%@",self.returnAddressinfo.phoneNum];
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark--UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : (section == 1) ? 2 : 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        return 200;
    }
    else if (indexPath.section == 1&&indexPath.row == 1)
    {
        return _cellHight;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 3) ? 120 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return (section == 3) ? self.footerView : nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark---HCShowReasonTableViewCellDelegate

-(void)passcellHight:(CGFloat)cellheight
{
    _cellHight = cellheight;
}

#pragma mark---pravite method

-(void)clickWriteBtn
{
    HCInputWaybillNumViewController *inputVC = [[HCInputWaybillNumViewController alloc]init];
    [self.navigationController pushViewController:inputVC animated:YES];
}

#pragma mark--Setter Or Getter

-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
        UIButton *writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        writeBtn.frame = CGRectMake(20, 40, SCREEN_WIDTH-40, 40);
        [writeBtn setTitle:@"填写退货运单号" forState:UIControlStateNormal];
        [writeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [writeBtn setBackgroundColor:[UIColor redColor]];
        [writeBtn addTarget:self action:@selector(clickWriteBtn) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(writeBtn, 2);
        
        [_footerView addSubview:writeBtn];
    }
    return _footerView;
}

#pragma mark - network

- (void)requestHomeData
{
    HCReturnAddressApi *api = [[HCReturnAddressApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCReturnAddressInfo *info)
    {
        if (requestStatus == HCRequestStatusSuccess)
        {
            _returnAddressinfo = info;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
