//
//  HCRefundSuccessViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//退款成功

#import "HCRefundSuccessViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

#import "HCCustomerInfo.h"
@interface HCRefundSuccessViewController ()

@property (nonatomic,strong) HCCustomerInfo *info;

@property (nonatomic,strong) NSArray *RefundWhereaboutsArr;
@end

@implementation HCRefundSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"补发审核";
    self.tableView.tableHeaderView = HCTabelHeadView(1.0);
    _info = self.data[@"data"];
}

#pragma mark---UITableViewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0)
    {
        static NSString *RecordID = @"waitAuditOrder";
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
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reissueReason"];
            cell.textLabel.text = @"补发原因";
            if ([self.info.reason integerValue] == 0)
            {
                cell.detailTextLabel.text = @"标签残缺";
            }
            else if([self.info.reason integerValue] == 1)
            {
                cell.detailTextLabel.text = @"二维码标签扫不出信息";
            }
            else
            {
                cell.detailTextLabel.text = @"其他";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1)
        {
            HCShowReasonTableViewCell *showCell = [[HCShowReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"show"];
            showCell.info = self.info;
            cell = showCell;
        }
    }
    else if (indexPath.section == 2)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reissueReason"];
        if (indexPath.row == 0)
        {
            if ([self.info.goodsName integerValue]== 0)
            {
                cell.textLabel.text = @"补发内容: M-Talk烫印机";
            }
            else  if ([self.info.goodsName integerValue] == 1)
            {
                cell.textLabel.text = @"补发内容: M-Talk标签";
            }
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"补发数量: %@",self.info.detailNeedGoodsNum];
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"退款金额: %@",self.info.orderTotalPrice];
        }
    }
    else if (indexPath.section == 3)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reissueReason"];
        cell.textLabel.text = [NSString stringWithFormat:@"退款去向：%@",self.RefundWhereaboutsArr[[self.info.RefundWhereabouts integerValue]]];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        return 200;
    }
    else if (indexPath.section == 1&&indexPath.row == 1)
    {
        return 120+SCREEN_WIDTH/3;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark ---Setter Or Getter

-(NSArray *)RefundWhereaboutsArr
{
    if (!_RefundWhereaboutsArr) {
        _RefundWhereaboutsArr = @[@"支付宝",@"微信钱包"];
    }
    return _RefundWhereaboutsArr;
}
@end
