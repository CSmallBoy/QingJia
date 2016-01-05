//
//  HCReissueAuditPassViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//补发审核通过

#import "HCReissueAuditPassViewController.h"
#import "HCCustomerInfo.h"
#import "HCLogisticsInfo.h"
#import "HCLogisticsApi.h"

#import "HCLogisticsInfoTableViewCellSecond.h"

#import "HCCustomerTableViewCell.h"
#import "HCShowReasonTableViewCell.h"

@interface HCReissueAuditPassViewController ()<HCShowReasonTableViewCellDelegate>

@property (nonatomic,strong) HCCustomerInfo *info;
@property (nonatomic,assign) CGFloat cellHight;
@end

@implementation HCReissueAuditPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"审核通过";
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
        if (indexPath.row == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"followInfo"];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"followInfo"];
            cell.textLabel.text = @"补发物流信息";
            cell.detailTextLabel.text = @"XCSCF14242342";
        }
        else
        {
            HCLogisticsInfoTableViewCellSecond *cellS;
            cellS = [tableView dequeueReusableCellWithIdentifier:@"lodisticsInfoSecond"];
            cellS = [[HCLogisticsInfoTableViewCellSecond alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lodisticsInfoSecond"];
            cellS.info = self.dataSource[indexPath.row-1];
            cellS.indexPath = indexPath;
            cell = cellS;
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
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return self.dataSource.count + 1;
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

#pragma mark---network

- (void)requestHomeData
{
    HCLogisticsApi *api = [[HCLogisticsApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array)
     {
         if (requestStatus == HCRequestStatusSuccess)
         {
             [self.dataSource removeAllObjects];
             [self.dataSource addObjectsFromArray:array];
             [self.tableView reloadData];
         }else
         {
             [self showHUDError:message];
         }
     }
     ];
    _baseRequest = api;
}
@end
