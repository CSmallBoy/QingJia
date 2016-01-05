//
//  HCWaitReissueAuditViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCWaitReissueAuditViewController.h"
#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

#import "HCCustomerInfo.h"
@interface HCWaitReissueAuditViewController ()<HCShowReasonTableViewCellDelegate>
@property (nonatomic,strong) HCCustomerInfo *info;
@property (nonatomic,assign) CGFloat cellHight;
@end

@implementation HCWaitReissueAuditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.title = @"补发审核";
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
            cell.detailTextLabel.text = [HCDictionaryMgr applyReissueReason:self.info.reason];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reissueReason"];
        if (indexPath.row == 0)
        {
            if ([self.info.goodsName integerValue] == 1)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"补发内容: M-Talk标签"];
            }
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"补发数量: %@",self.info.detailNeedGoodsNum];
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
    return (section == 0)?1:2;
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
