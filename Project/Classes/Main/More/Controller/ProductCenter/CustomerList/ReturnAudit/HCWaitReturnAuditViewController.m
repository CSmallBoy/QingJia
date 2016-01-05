//
//  HCWaitReturnAuditViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCWaitReturnAuditViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

#import "HCCustomerInfo.h"
@interface HCWaitReturnAuditViewController ()<HCShowReasonTableViewCellDelegate>

@property (nonatomic,strong) HCCustomerInfo *info;
@property (nonatomic,assign) CGFloat cellHight;

@end

@implementation HCWaitReturnAuditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"退货审核";
    [self setupBackItem];
    self.tableView.tableHeaderView = HCTabelHeadView(1.0);
    _info = self.data[@"data"];
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
    else
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
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0)?1:(section == 1)?2:3;
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
    return 5;
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

@end
